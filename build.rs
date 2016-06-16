extern crate capnpc;

fn main() {
    ::capnpc::compile("schema",
                      &["schema/grain.capnp",
                        "schema/util.capnp",
			            "schema/web-session.capnp",
                        "schema/ip.capnp",
                        "schema/email.capnp",
                        "schema/web-publishing.capnp",
                        "schema/sandstorm-http-bridge.capnp"]
    ).expect("compiling");
}
