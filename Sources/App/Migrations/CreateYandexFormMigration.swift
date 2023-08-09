//
//  CreateYandexFormMigration.swift
//  
//
//  Created by Кирилл Тила on 04.02.2023.
//

import Fluent
import Vapor

struct CreateYandexFormMigration: AsyncMigration {
    
    func prepare(on database: Database) async throws {
        try await database.schema(YandexForm.schema)
            .id()
            .field("name", .string, .required)
            .field("gender", .string, .required)
            .field("age", .string, .required)
            .field("timeZone", .string, .required)
            .field("email", .string, .required)
            .field("telegram", .string, .required)
            .field("discord", .string, .required)
            .field("timeWork", .string, .required)
            .field("teamRole", .string, .required)
            .field("experience", .string, .required)
            .field("exampleWork", .string, .required)
            .field("genres", .string, .required)
            .field("about", .string, .required)
            .field("from", .string, .required)
            .field("ourWokrRead", .string, .required)
            .field("reasonTo", .string, .required)
            .field("reasonFrom", .string, .required)
            .field("editorTest", .string)
            .field("translatorEnTest", .string)
            .field("translatorJpTest", .string)
            .field("typesetterTest", .string)
            .field("redrawTest", .string)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(YandexForm.schema).delete()
    }
    
}

struct CreateYandexFormMigration2: AsyncMigration {

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = .init(identifier: .iso8601)
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return formatter
    }()

    func prepare(on database: Database) async throws {
        try await database.schema(YandexForm.schema)
            .field("created_at", .string, .sql(.default(Self.dateFormatter.string(from: Date()))))
            .update()
    }

    func revert(on database: Database) async throws {
        try await database.schema(YandexForm.schema)
            .deleteField("created_at")
            .update()
    }

}
