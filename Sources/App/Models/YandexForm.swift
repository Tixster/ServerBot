//
//  YandexForm.swift
//  
//
//  Created by Кирилл Тила on 04.02.2023.
//

import Fluent
import Vapor

final class YandexForm: Model, Content {
    static var schema: String = "yandex-forms"

    @ID var id: UUID?
    
    @Field(key: "name") var name: String
    @Field(key: "gender") var gender: String
    @Field(key: "age") var age: String
    @Field(key: "timeZone") var timeZone: String
    @Field(key: "email") var email: String
    @Field(key: "telegram") var telegram: String
    @Field(key: "discord") var discord: String
    @Field(key: "timeWork") var timeWork: String
    @Field(key: "teamRole") var teamRole: String
    @Field(key: "experience") var experience: String
    @Field(key: "exampleWork") var exampleWork: String
    @Field(key: "genres") var genres: String
    @Field(key: "about") var about: String
    @Field(key: "from") var from: String
    @Field(key: "ourWokrRead") var ourWokrRead: String
    @Field(key: "reasonTo") var reasonTo: String
    @Field(key: "reasonFrom") var reasonFrom: String
    @Timestamp(key: "created_at", on: .create, format: .iso8601) var createDate: Date?

    @Field(key: "editorTest") var editorTest: String
    @Field(key: "translatorEnTest") var translatorEnTest: String
    @Field(key: "translatorJpTest") var translatorJpTest: String
    @Field(key: "typesetterTest") var typesetterTest: String
    @Field(key: "redrawTest") var redrawTest: String

    convenience init(request: YandexFormRequest) {
        self.init()
        self.name = request.name
        self.gender = request.gender
        self.age = request.age
        self.telegram = request.telegram
        self.timeZone = request.timeZone
        self.email = request.email
        self.discord = request.discord
        self.timeWork = request.timeWork
        self.teamRole = request.teamRole
        self.experience = request.experience
        self.exampleWork = request.exampleWork ?? ""
        self.genres = request.genres
        self.about = request.about
        self.from = request.from
        self.reasonTo = request.reasonTo
        self.reasonFrom = request.reasonFrom
        self.ourWokrRead = request.ourWokrRead
        self.editorTest = request.editorTest ?? ""
        self.translatorEnTest = request.translatorEnTest ?? ""
        self.translatorJpTest = request.translatorJpTest ?? ""
        self.typesetterTest = request.typesetterTest ?? ""
        self.redrawTest = request.redrawTest ?? ""
    }
    
}

struct YandexFormRequest: Content {
    let name: String
    let gender: String
    let age: String
    let timeZone: String
    let email: String
    let telegram: String
    let discord: String
    let timeWork: String
    let teamRole: String
    let experience: String
    let exampleWork: String?
    let genres: String
    let about: String
    let from: String
    let ourWokrRead: String
    let reasonTo: String
    let reasonFrom: String
    let editorTest: String?
    let translatorEnTest: String?
    let translatorJpTest: String?
    let typesetterTest: String?
    let redrawTest: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Ваше имя/ник"
        case gender = "Ваш пол"
        case age = "Возраст (16+)"
        case timeZone = "Часовой пояс"
        case email = "Ваш email"
        case telegram = "Ссылка на ваш профиль в Telegram"
        case discord = "Ваш логин Discord в формате «Name#????»"
        case timeWork = "Сколько часов в неделю готовы уделять работе?"
        case teamRole = "Роль в команде"
        case experience = "Опыт"
        case exampleWork = "Приложите ссылку на примеры работ"
        case genres = "С какими жанрами хотели бы работать?"
        case about = "Немного о себе"
        case from = "Как узнали о нас?"
        case ourWokrRead = "Какие из наших переводов читали/читаете?"
        case reasonTo = "Почему именно мы?"
        case reasonFrom = "Почему ушли из прошлой команды?"
        case editorTest = "Тест на редактора"
        case translatorEnTest = "Тест на переводчика с английского"
        case translatorJpTest = "Тест на переводчика с японского"
        case typesetterTest = "Тест на верстальщика"
        case redrawTest = "Тест на ретушёра"
    }
    
}
