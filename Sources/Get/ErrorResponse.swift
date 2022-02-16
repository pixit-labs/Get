//
//  ErrorResponse.swift
//  Alpha
//
//  Created by Thanos Bellos on 15/2/22.
//

import Foundation

public enum APIManagerError: Error {
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

public struct ErrorResponse: Decodable {
  let message: String
  let errors: [ResourceError]

  public func friendlyErrors() -> String {
    return "\(message): \((errors.map { $0.fieldError() }).joined(separator: "\n"))"
  }
}

public struct ResourceError: Decodable {
  let resource: String
  let field: String
  let code: String

  public func fieldError() -> String {
    return "\(resource) - \(field): \(code)"
  }
}

public struct ApiTokenError: Decodable {
  let error: String
  let errorDescription: String

  enum CodingKeys: String, CodingKey {
    case error = "error"
    case errorDescription = "error_description"
  }
}

public struct DeviseErrors: Decodable {
  let errors: DeviseError

  struct DeviseError: Decodable {
    let email: [String]?

    public func localizedError() -> String {
      return "Email ".localizedLowercase + (email?.first ?? "not found".localizedLowercase)
    }
  }
}
