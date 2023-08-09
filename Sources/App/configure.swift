import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "rest_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "rest_password",
        database: Environment.get("DATABASE_NAME") ?? "rest_database"
    ), as: .psql)
    
    app.migrations.add(CreateYandexFormMigration())
    app.migrations.add(CreateYandexFormMigration2())
    
    try app.autoMigrate().wait()

    // register routes
    try routes(app)
}
