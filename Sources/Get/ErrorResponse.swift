//
//  ErrorResponse.swift
//  Alpha
//
//  Created by Thanos Bellos on 15/2/22.
//

import Foundation


enum APIManagerError: Error {
  case network(reason: String)
  case apiProvidedError(reason: String)
  case unexpectedResponse(reason: String)
  case authCouldNot(reason: String)
  case authLost(reason: String)
  case notAuthorized(reason: String)
  case objectSerialization(reason: String)
  case internalServerError(reason: String)
  case unavailableService(reason: String)
}

struct ErrorResponse: Decodable {
  let message: String
  let errors: [ResourceError]

  func friendlyErrors() -> String {
    return "\(message): \((errors.map { $0.fieldError() }).joined(separator: "\n"))"
  }
}

struct ResourceError: Decodable {
  let resource: String
  let field: String
  let code: String

  func fieldError() -> String {
    return "\(resource) - \(field): \(code)"
  }
}

struct ApiTokenError: Decodable {
  let error: String
  let errorDescription: String

  enum CodingKeys: String, CodingKey {
    case error = "error"
    case errorDescription = "error_description"
  }
}

struct DeviseErrors: Decodable {
  let errors: DeviseError

  struct DeviseError: Decodable {
    let email: [String]?

    func localizedError() -> String {
      return "Email ".localizedLowercase + (email?.first ?? "not found".localizedLowercase)
    }
  }
}
