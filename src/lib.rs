// Copyright (c) 2014-2016 Sandstorm Development Group, Inc.
// Licensed under the MIT License:
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#[macro_use]
extern crate capnp;

pub mod util_capnp {
  include!(concat!(env!("OUT_DIR"), "/util_capnp.rs"));
}

pub mod powerbox_capnp {
    include!(concat!(env!("OUT_DIR"), "/powerbox_capnp.rs"));
}

pub mod identity_capnp {
    include!(concat!(env!("OUT_DIR"), "/identity_capnp.rs"));
}

pub mod activity_capnp {
    include!(concat!(env!("OUT_DIR"), "/activity_capnp.rs"));
}

pub mod grain_capnp {
  include!(concat!(env!("OUT_DIR"), "/grain_capnp.rs"));
}

pub mod web_session_capnp {
  include!(concat!(env!("OUT_DIR"), "/web_session_capnp.rs"));
}

pub mod ip_capnp {
  include!(concat!(env!("OUT_DIR"), "/ip_capnp.rs"));
}

pub mod email_capnp {
  include!(concat!(env!("OUT_DIR"), "/email_capnp.rs"));
}

pub mod web_publishing_capnp {
  include!(concat!(env!("OUT_DIR"), "/web_publishing_capnp.rs"));
}

pub mod sandstorm_http_bridge_capnp {
  include!(concat!(env!("OUT_DIR"), "/sandstorm_http_bridge_capnp.rs"));
}
