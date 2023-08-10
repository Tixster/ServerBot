
import Foundation
import Vapor

// MARK: - DiscordEmbed
struct DiscordWebhook: Codable, Content {
    let content: String
    var tts: Bool = false
    let embeds: [DiscordEmbed]
    let username: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case content, tts, embeds, username
        case avatarURL = "avatar_url"
    }
}

extension DiscordWebhook {

    init(response: YandexForm) {
        self.init(content: "<@&333701416042364929>\n**О кандидате:**\n\(response.about)",
                  embeds: [.init(description: Self.createDescription(from: response),
                                 fields: [
                                    .init(name: "Тест на редактора", value: response.editorTest),
                                    .init(name: "Тест на переводчика с английского", value: response.translatorEnTest),
                                    .init(name: "Тест на переводчика с японского", value: response.translatorJpTest),
                                    .init(name: "Тест на верстальщика", value: response.typesetterTest),
                                    .init(name: "Тест на ретушёра", value: response.redrawTest),
                                 ],
                                 author: .init(name: response.name),
                                 title: response.teamRole,
                                 timestamp: DateFormatter.isoFormatter.string(from: response.createDate ?? Date()),
                                 color: 13962252)
                  ],
                  username: "Новая заявка в команду",
                  avatarURL: "https://i.imgur.com/fPW76ZX.jpg")
    }

    static func createDescription(from form: YandexForm) -> String {
        let gender = "**Пол:**\n" + form.gender + "\n"
        let age = "**Возраст:**\n" + form.age + "\n"
        let timeZone = "**Часовой пояс:**\n" + form.timeZone + "\n"
        let email = "**E-Mail:**\n" + form.email + "\n"
        let telegram = "**Telegram:**\n" + form.telegram + "\n"
        let discord = "**Discord:**\n" + form.discord + "\n"
        let timeWork = "**Готов работать часов в неделю:**\n" + form.timeWork + "\n"
        let exampleWork = "**Пример работы:**\n" + form.exampleWork + "\n"
        let genres = "**Предпочитаемые жанры:**\n" + form.genres + "\n"
        let from = "**Как узнали о нас?:**\n" + form.from + "\n"
        let reasonFrom = "**Почему ушли из прошлой команды?:\n** " + form.reasonFrom + "\n"
        return gender + age + timeZone + email + telegram + discord + timeWork + exampleWork + genres + from + reasonFrom
    }

}

// MARK: - Embed
struct DiscordEmbed: Codable {
    let description: String
    let fields: [DiscordField]
    let author: DiscordAuthor
    let title, timestamp: String
    let color: Int
}

// MARK: - Author
struct DiscordAuthor: Codable {
    let name: String
}

// MARK: - Field
struct DiscordField: Codable {
    let name, value: String
}
