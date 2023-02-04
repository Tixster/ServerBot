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

    @Field(key: "editorTest") var editorTest: String
    @Field(key: "translatorEnTest") var translatorEnTest: String
    @Field(key: "translatorJpTest") var translatorJpTest: String
    @Field(key: "typesetterTest") var typesetterTest: String
    @Field(key: "redrawTest") var redrawTest: String
    
}
