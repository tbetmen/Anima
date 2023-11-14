//
//  APIServiceConfig.swift
//  Anima
//
//  Created by Muhammad M. Munir on 13/11/23.
//

import Foundation

public protocol APIServiceConfigInterface {
    var baseURL: String { get }
    var headers: [String: String] { get }
    var queryParams: [String: String] { get }
}

public struct APIServiceConfig: APIServiceConfigInterface {
    public let baseURL: String
    public let headers: [String: String]
    public let queryParams: [String: String]
    
    public init(
        baseURL: String,
        headers: [String: String] = [:],
        queryParams: [String: String] = [:]
    ) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParams = queryParams
    }
}

public extension APIServiceConfig {
    static func createNinja() -> APIServiceConfig {
        APIServiceConfig(
            baseURL: APIConfig.Ninja.animals
        )
    }
    
    static func createPexels() -> APIServiceConfig {
        APIServiceConfig(
            baseURL: APIConfig.Pexels.search
        )
    }
}
