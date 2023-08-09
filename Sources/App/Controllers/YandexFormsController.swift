//
//  YandexFormsController.swift
//  
//
//  Created by Кирилл Тила on 04.02.2023.
//

import Fluent
import Vapor

struct UserAgentMiddleware: AsyncMiddleware {
    
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        guard request.headers.contains(where: { name, value in
            name == "User-Agent" && value == "BotServer_YandexFroms"
        })
        else { throw Abort(.unauthorized) }
        return try await next.respond(to: request)
    }
    
}

final class YandexFormsController: RouteCollection {
    
    private var sockets: [WebSocket] = []
   
    func boot(routes: RoutesBuilder) throws {
        let formsGroup = routes.grouped("\(YandexForm.schema)")
        let protectedGroup = formsGroup.grouped(UserAgentMiddleware())
        protectedGroup.post(use: postHandler)
        protectedGroup.get(use: getAllHandler)
        protectedGroup.get(":formID", use: getHandler)
        protectedGroup.delete(":formID", use: deleteHandler)
        protectedGroup.webSocket { [weak self] rq, ws in
            ws.send("You have been connected to WebSockets")
            self?.addSocket(ws)
        }
    }
    
    private func addSocket(_ socket: WebSocket) {
       sockets.append(socket)
   }
    
    func postHandler(_ req: Request) async throws -> HTTPStatus {
        do {
            let formReq = try req.content.decode(YandexFormRequest.self)
            let form: YandexForm = .init(request: formReq)
            try await form.save(on: req.db)

            if let data = try? JSONEncoder().encode(form) {
                sockets = sockets.filter({ !$0.isClosed })
                sockets.forEach({ $0.send(raw: data, opcode: .binary) })
            }

            return .ok
        } catch {
            if req.body.string == nil {
                req.logger.critical(Logger.Message(stringLiteral: error.localizedDescription))
                throw Abort(.internalServerError, reason: error.localizedDescription)
            }
            throw error
        }

    }
    
    func getAllHandler(_ req: Request) async throws -> [YandexForm] {
        return try await YandexForm.query(on: req.db).all()
    }
    
    func getHandler(_ req: Request) async throws -> YandexForm {
        guard let form = try await YandexForm.find(req.parameters.get("formID"), on: req.db)
        else { throw Abort(.notFound) }
        return form
    }
    
    func deleteHandler(_ req: Request) async throws -> HTTPStatus {
        guard let form = try await YandexForm.find(req.parameters.get("formID"), on: req.db)
        else { throw Abort(.notFound) }
        try await form.delete(on: req.db)
        
        return .ok
    }

}
