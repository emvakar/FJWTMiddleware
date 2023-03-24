//
//  FJWTMiddleware.swift
//  FJWTMiddleware
//
//  Created by Emil Karimov on 24.03.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import JWT
import Vapor

open class FJWTMiddleware: AsyncMiddleware {

    public init() { }

    public func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        _ = try await request.firebaseJwt.verify()
        return try await next.respond(to: request)
    }

}
