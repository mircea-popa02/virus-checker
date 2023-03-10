import virus_total;
import db_conn;
import std.stdio;
import vibe.vibe;
import requests;
import fluentasserts.vibe.request;
import fluent.asserts;

import vibe.d;
import std.algorithm.mutation;
import std.conv;
import std.digest;
import std.digest.sha;
import std.json;
import std.range;
import std.stdio;
import vibe.data.bson;
import requests;

void main()
{
    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    auto dbClient = DBConnection("root", "example", "mongo", "27017", "testing");
    auto virusTotalAPI = new VirusTotalAPI(dbClient);

    auto router = new URLRouter;
    router.registerRestInterface(virusTotalAPI);
    settings.bindAddresses = ["0.0.0.0"];

    router.get("/", &landingpage);
    router.get("/login", &loginpage);
    router.get("/register", &registerpage);
    router.get("/urls", &urls);
    router.get("/files", &files);
    router.get("/profile", &profile);

    listenHTTP(settings, router);

    logInfo("Please open http://127.0.0.1:8080/ in your browser.");
    runApplication();
}

void loginpage(HTTPServerRequest req, HTTPServerResponse res)
{
    render!("templates/signin.html")(res);
}

void profile(HTTPServerRequest req, HTTPServerResponse res)
{
    render!("templates/profile.html")(res);
}

void files(HTTPServerRequest req, HTTPServerResponse res)
{
    render!("templates/files.html")(res);
}

void registerpage(HTTPServerRequest req, HTTPServerResponse res)
{
    render!("templates/register.html")(res);
}

void urls(HTTPServerRequest req, HTTPServerResponse res)
{
    render!("templates/urls.html")(res);
}

void landingpage(HTTPServerRequest req, HTTPServerResponse res)
{
    render!("templates/landingpage.html")(res);
}
