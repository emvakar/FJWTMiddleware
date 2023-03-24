//
//  Request+FJWT.swift
//  FJWTMiddleware
//
//  Created by Emil Karimov on 24.03.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Vapor

extension Request {
    
    public var firebaseJwt: FJWT { .init(request: self) }
    
    public struct FJWT {
        
        let request: Request
        
        public func verify(applicationIdentifier: String? = nil) async throws -> FJWTPayload {
            guard let token = request.headers.bearerAuthorization?.token else {
                request.logger.error("Request is missing JWT bearer header.")
                throw Abort(.unauthorized)
            }
            return try await verify(token, applicationIdentifier: applicationIdentifier)
        }
        
        public func verify(_ message: String, applicationIdentifier: String? = nil) async throws -> FJWTPayload {
            try await verify([UInt8](message.utf8), applicationIdentifier: applicationIdentifier)
        }
        
        public func verify<Message>(_ message: Message, applicationIdentifier: String? = nil) async throws -> FJWTPayload where Message: DataProtocol {
            
            let signers = try await request.application.firebaseJwt.signers(on: request)
            
            let token = try signers.verify(message, as: FJWTPayload.self)

            if let applicationIdentifier = applicationIdentifier ?? request.application.firebaseJwt.applicationIdentifier {
                try token.audience.verifyIntendedAudience(includes: applicationIdentifier)
            }
            return token
        }
        
    }

}
