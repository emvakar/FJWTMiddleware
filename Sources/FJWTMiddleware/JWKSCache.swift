//
//  JWKSCache.swift
//  FJWTMiddleware
//
//  Created by Emil Karimov on 24.03.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import JWT
import Vapor

/// A thread-safe and atomic class for retrieving JSON Web Key Sets which honors the
/// HTTP `Cache-Control`, `Expires` and `Etag` headers.
public typealias JWKSCache = EndpointCache<JWKS>
