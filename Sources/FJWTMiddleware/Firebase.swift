//
//  Firebase.swift
//  FJWTMiddleware
//
//  Created by Emil Karimov on 24.03.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import Vapor

public struct Firebase: Codable {

    public let identities: [String: [String]]
    public let sign_in_provider: String

}
