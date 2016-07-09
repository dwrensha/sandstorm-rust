extern crate capnpc;

fn main() {
    ::capnpc::compile("schema",
                      &["schema/util.capnp",
                        "schema/powerbox.capnp",
                        "schema/identity.capnp",
                        "schema/activity.capnp",
                        "schema/grain.capnp",
			            "schema/web-session.capnp",
                        "schema/ip.capnp",
                        "schema/email.capnp",
                        "schema/web-publishing.capnp",
                        "schema/sandstorm-http-bridge.capnp"]
    ).expect("compiling");
}
