import Leaf
import Fluent
import Vapor
import FluentPostgresDriver

public func configure(_ app: Application) async throws {
    let driver = DatabaseConfigurationFactory.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "postgres",
        password: Environment.get("DATABASE_PASSWORD") ?? "postgres",
        database: Environment.get("DATABASE_NAME") ?? "restaurantdb"
    )
    
    app.databases.use(
        driver,
        as: .psql
    )
    app.migrations.add(CreateRestaurant())
    app.migrations.add(CreateReview())
    
    app.views.use(.leaf)

    try routes(app)
}
