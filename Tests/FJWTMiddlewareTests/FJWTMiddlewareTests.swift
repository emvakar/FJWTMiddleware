//
//  FJWTMiddlewareTests
//  FJWTMiddleware
//
//  Created by Emil Karimov on 24.03.2023
//  Copyright © 2023 Emil Karimov. All rights reserved.
//

import XCTest
import XCTVapor
@testable import FJWTMiddleware

final class FJWTMiddlewareTests: XCTestCase {

    static let applicationIdentifier: String = "parlist-1"

    func testFirebaseExpired() throws {
        // creates a new application for testing
        let app = Application(.testing)
        defer { app.shutdown() }

        let token = """
    eyJhbGciOiJSUzI1NiIsImtpZCI6Ijk3OWVkMTU1OTdhYjM1Zjc4MjljZTc0NDMwN2I3OTNiN2ViZWIyZjAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcGFybGlzdC0xIiwiYXVkIjoicGFybGlzdC0xIiwiYXV0aF90aW1lIjoxNjc5NjQ5NjExLCJ1c2VyX2lkIjoiWWNDNEtuVkNQYmNvZTNCWXZMVXdtOHJxMVZ4MiIsInN1YiI6IlljQzRLblZDUGJjb2UzQll2TFV3bThycTFWeDIiLCJpYXQiOjE2Nzk2NDk2MTEsImV4cCI6MTY3OTY1MzIxMSwiZW1haWwiOiJ0ZXN0LXNka0Blc2thcmlhLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0LXNka0Blc2thcmlhLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.H-QLo9M3m78FF5lgWVBTJXJTUcITY2BZ_osKFIXaoPZkwNS2cU4Bq8NW1Yrv1yGVCzqjx0yvUPsL-dtFwwpuWmwcXCA0ymfB7p3zRBAbPMYOn4TplI5KvuKE3d1zt6rLGzu21Xh0pIE3fJk_I57B9iKxdkASjjJ0u1bu4diotuiyjFh8KcKeWkyxmJts3wApjMWekOnGSy-kmimVK5d-NiK_u12pB69c7NpcUbuwbvBDaMLzhViFTKi3q3r9MYWpwteRVKuo0jflO4qz18ldwFUlYPg6UwIo_NmhnpuSqnyomzoZXYBksLdWIDhQ4hjTRUfnDzhV-wfjrNdqqzcNuw
    """

        app.firebaseJwt.applicationIdentifier = FJWTMiddlewareTests.applicationIdentifier

        app.get("test") { req in
            try await req.firebaseJwt.verify().email ?? "none"
        }

        var headers = HTTPHeaders()
        headers.bearerAuthorization = .init(token: token)

        try app.test(.GET, "test", headers: headers) { res in
            print(res.body.string)
            print(res.body.string)
            XCTAssert(res.status == .unauthorized)
            XCTAssert(res.body.string.contains("exp claim verification failed: expired"))
        }
    }

}
