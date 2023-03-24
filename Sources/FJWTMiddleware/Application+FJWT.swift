//
//  Application+FJWT.swift
//  FJWTMiddleware
//
//  Created by Emil Karimov on 24.03.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import JWT
import Vapor

extension Application {
    
    public var firebaseJwt: FJWT {
        .init(application: self)
    }
    
    public struct FJWT {
        
        let application: Application
        
        public var jwks: EndpointCache<JWKS> {
            self.storage.jwks
        }

        /// Firebase project id
        public var applicationIdentifier: String? {
            get {
                self.storage.applicationIdentifier
            }
            nonmutating set {
                self.storage.applicationIdentifier = newValue
            }
        }

        public func signers(on request: Request) async throws -> JWTSigners {
            let requests = try await jwks.get(on: request).get()
            let signers = JWTSigners()
            try signers.use(jwks: requests)
            return signers
        }
        
        private struct Key: StorageKey, LockKey {
            typealias Value = Storage
        }

        private final class Storage {
            
            let jwks: EndpointCache<JWKS>
            var applicationIdentifier: String?
            var gSuiteDomainName: String?
            
            init() {
                self.jwks = .init(uri: "https://www.googleapis.com/service_accounts/v1/jwk/securetoken@system.gserviceaccount.com")
                self.applicationIdentifier = nil
                self.gSuiteDomainName = nil
            }
        }
        
        private var storage: Storage {
            if let existing = self.application.storage[Key.self] {
                return existing
            } else {
                let lock = self.application.locks.lock(for: Key.self)
                lock.lock()
                defer { lock.unlock() }
                if let existing = self.application.storage[Key.self] {
                    return existing
                }
                let new = Storage()
                self.application.storage[Key.self] = new
                return new
            }
        }
    }
}
