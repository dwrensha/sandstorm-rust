extern crate capnpc;

fn main() {
    capnpc::CompilerCommand::new()
        .src_prefix("schema")
        .file("schema/supervisor.capnp")
        .file("schema/util.capnp")
        .file("schema/powerbox.capnp")
        .file("schema/identity.capnp")
        .file("schema/activity.capnp")
        .file("schema/grain.capnp")
        .file("schema/web-session.capnp")
        .file("schema/ip.capnp")
        .file("schema/email.capnp")
        .file("schema/web-publishing.capnp")
        .file("schema/sandstorm-http-bridge.capnp")
        .file("schema/api-session.capnp")
        .run()
        .expect("compiling");
}
