import Fluent
import Vapor

func routes(_ app: Application) throws {

    app.get("hello") { req async -> String in
        "Hello, world! 2222"
    }

    try app.register(collection: YandexFormsController())
}
