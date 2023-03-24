# FJWTMiddleware
This project is built upon an existing [vapor-firebase-jwt-middleware](https://github.com/barisatamer/vapor-firebase-jwt-middleware.git) repository, which has not been maintained for a long time and has not merged my pull requests. Due to this, I decided to create my own repository for this project, starting with the codebase of the unsupported one.

<p align="center">
<a href="http://vapor.codes">
<img src="https://img.shields.io/badge/Vapor-4-F6CBCA.svg" alt="Vapor Version">
</a>
<a href="https://swift.org">
<img src="http://img.shields.io/badge/swift-5.7-brightgreen.svg" alt="Swift 5.7">
</a>
<a href="LICENSE">
<img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
</a>
</p>

## Description 🎧

FJWTMiddleware is middleware for server applications based on Vapor Framework. This project provides JSON Web Token (JWT) authentication using Firebase Authentication as the authentication provider.

To use this middleware, you need to create a Firebase project and add its configuration data to the server settings. In addition, you need to configure routes in the Vapor application that will be protected by authentication, and then add the middleware to provide JWT verification.

After successful JWT verification, the application can obtain user data from the token and use it for its purposes.

This project provides a ready-made solution for JWT authentication using Firebase, which simplifies the development of server applications based on Vapor Framework and reduces the time and effort required to implement an authentication system.

## Installation 📦

To include it in your package, add the following to your `Package.swift` file.

```swift
let package = Package(
    name: "Project",
    dependencies: [
        ...
        .package(name: "FJWTMiddleware", url: "https://github.com/emvakar/vapor-fjwt-middleware.git", from: "1.0.0"),
        ],
        targets: [
            .target(name: "App", dependencies: [
                .product(name: "FJWTMiddleware", package: "FJWTMiddleware"),
                ... 
             ])
        ]
    )
```

## Usage 🚀
1. **Configure Project ID**
```swift
app.firebaseJwt.applicationIdentifier = <YOUR_FIREBASE_PROJECT_ID>
```
2. **Import header files**

```swift
import FJWTMiddleware
```

3. **Adding Middleware to a Routing Group**
```swift
let group = router.grouped(FJWTMiddleware())
group.get("welcome") { req in
return "Hello, world!"
}
```

## References
- [Verifying Firebase ID Tokens](https://firebase.google.com/docs/auth/admin/verify-id-tokens?authuser=1)

