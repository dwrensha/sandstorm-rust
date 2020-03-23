# Sandstorm - Personal Cloud Sandbox
# Copyright (c) 2014 Sandstorm Development Group, Inc. and contributors
# All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

@0xeb014c0c3413cbfb;

$import "/capnp/c++.capnp".namespace("sandstorm");

using WebSession = import "web-session.capnp";
using IpAddress = import "ip.capnp".IpAddress;

interface ApiSession @0xc879e379c625cdc7 extends(WebSession.WebSession) {
  # A special case of WebSession but for APIs. It doesn't provide much other
  # than a unique type id that we can identify ApiSessions with

  struct Params {
    # Normally, we strip the remote address from requests, since most applications shouldn't need
    # it.  However, for those that benefit from it (like analytics), clients can opt into passing
    # their IP on to the backend by adding an "X-Sandstorm-Passthrough: address" header to their
    # request.  This would be a privacy leak for WebSession, since the grain can give the client
    # scripts which would send the header, but ApiSession requires a user action, so it's safe
    # here.
    remoteAddress @0 :IpAddress;
  }

  struct PowerboxTag {
    # A tag used for PowerboxDescriptors describing HTTP APIs. Such descriptors should typically
    # indicate `ApiSession` as the requested interface and use PowerboxTag to specify what API is
    # expected (so, the tag ID is ApiSession's ID, but the tag value is an ApiSession.PowerboxTag).
    #
    # Usually, this tag is used to request APIs implemented by internet services external to
    # Sandstorm. However, a Sandstorm grain may advertise itself as supporting a compatible API
    # to the Powerbox, and if so the Powerbox will allow the user to select that grain for such
    # requests. Note that publishing an `ApiSession` has nothing to do with `UiView` or Sandstorm's
    # normal HTTP API support.
    #
    # Requests of this type trigger the HTTP driver, such that the powerbox UI will display a
    # special flow for connecting to external web services. The Powerbox will also surface other
    # grains that advertise their ability to handle these requests under the usual matching rules.
    # This struct is carefully designed such that the usual Powerbox query rules make sense for
    # performing such queries.
    #
    # If you make a Powerbox request containing multiple PowerboxDescriptors describing HTTP APIs,
    # the HTTP driver will offer the user a choice among the options. This can make sense for, say,
    # allowing the user to choose from multiple popular servers implementing the same protocol, or
    # to choose whether or not to grant the app optional permissions (OAuth scopes). The HTTP
    # driver will return a capability with a descriptor matching one of the requested descriptors
    # which best-describes the user's choice.

    canonicalUrl @0 :Text;
    # The standard URL at which this service is found. Use this especially for traditional SaaS
    # services. For example, you might request "https://api.github.com" to request access to the
    # GitHub API.
    #
    # If you include a path in the URL, requests will automatically be prefixed with that path. You
    # should usually include enough path components to identify a specific product and version, but
    # usually not specific collection types within that product. For example, you would request the
    # Google Calendar API version 2 as "https://apidata.googleusercontent.com/caldav/v2". However,
    # you would not normally request "https://api.github.com/users" because "GitHub users" is not
    # considered a separate API but rather one part of the overall GitHub API. Note that
    # `canonicalUrl` should never end with a '/', because a '/' is added implicitly to separate
    # the API URL from the individual request's path.
    #
    # The HTTP driver will present `canonicalUrl` as a strong suggestion to the user. However, the
    # user is always allowed to substitute a different URL instead, causing requests to be
    # redirected to some other service. This is the user's choice. In cases where the app does not
    # trust the user, the app will need to defend itself against the possibility that the user
    # connects it to a malicious server.
    #
    # The Powerbox will also offer matches published by other grains using the usual query matching
    # rules. That is, a grain may advertise that it can handle queries for HTTP APIs with a
    # particular `canonicalUrl`, indicating that the grain offers ApiSession capabilities
    # implementing a compatible protocol.
    #
    # TODO(soon): How do we request a standard protocol that doesn't have a canonical URL, like
    #     WebDAV? Does any of ApiSession.PowerboxTag even make sense in this case?
    # TODO(soon): How do we request a single resource with a particular MIME type? Probably should
    #     be a separate interface, which http-bridge can implement...

    struct OAuthScope {
      name @0 :Text;
    }

    oauthScopes @1 :List(OAuthScope);
    # List of OAuth scopes required by the requesting app. OAuth APIs usually publish a list
    # of "scope" names representing permissions that can be requested. For example, see:
    #
    #     https://developer.github.com/v3/oauth/#scopes
    #
    # When this list is present (even if empty), it indicates that the requested API requires
    # OAuth-based authentication. The HTTP driver will guide the user through connecting their
    # Sandstorm account to the remote service and requesting the appropriate permissions.
    #
    # The Sandstorm project maintains an ad hoc mapping of hostnames to OAuth endpoints allowing
    # the HTTP driver to automatically determine what kind of OAuth request to make for a given
    # `canonicalUrl`. For example, if `canonicalUrl` is `https://api.github.com`, the HTTP driver
    # will initiate a Github OAuth handshake. For any URL under apidata.googleusercontent.com, the
    # driver will initiate a Google OAuth handshake. Etc. Unfortunately, it is not possible to
    # make OAuth requests to endpoints not on the list. However, we welcome pull requests to add
    # new endpoints, large or small.
    #
    # Sandstorm grains offering compatible APIs may wish to list the OAuth scopes they support.
    # Powerbox matching rules state that when a Powerbox query and potential matching descriptor
    # both contain a field of list-of-struct type, then they are treated as sets, and the match
    # must advertise a superset of the request. Therefore, if you list OAuth scopes when
    # publishing, then only requests for a subset of these will lead to your offer being listed in
    # the Powerbox. Often, offers will want to leave `oauthScopes` null, which will cause the scope
    # list to be ignored for matching purposes (always match).

    authentication @2 :Text;
    # If not null, indicates that this endpoint is expected to need old-fashion authentication.
    # The field contains a text string naming the type of authentication. Currently there is only
    # one type recognized: "basic", meaning HTTP Basic Auth. Specifying this instructs the HTTP
    # driver to prompt the user for a username and password.
    #
    # Note that even if this isn't specified, the HTTP driver will probe the target server to see
    # if it demands authentication and, if so, will prompt the user for a password anyway. Thus
    # this is only needed in cases where the target server supports both authenticated and
    # unauthenticated use and thus the probe will not notice the need for authentication.
    #
    # When publishing support of HTTP APIs to the Powerbox, you should usually leave this field
    # null, so that it is not considered for matching.
  }
}
