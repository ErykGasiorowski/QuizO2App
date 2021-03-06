//
//  TargetType+Base.swift
//  QUIZ_O2_WPPILOT
//
//  Created by Eryk Gasiorowski on 03/04/2022.
//

import Foundation

import Foundation
import Moya

// MARK: TargetType base configuration
extension TargetType {
    
    var baseURL: URL {
        let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "BASE URL") as? String ?? ""
        //"http://quiz.o2.pl/api/v1/quiz"
        //Bundle.main.object(forInfoDictionaryKey: "BASE URL") as? String ?? ""
        return URL(string: baseUrlString)!
    }
    
    var headers: [String: String]? {
        return getHeaders()
    }
    
    var sampleData: Data { return Data() }
    
}

// MARK: TargetType helpers
extension TargetType {
    
    static private var baseHeaders: [String: String] {
        return [
            HTTPHeader.accept.rawValue: "application/json",
            HTTPHeader.contentType.rawValue: "application/json"
        ]
    }
    
    public func getHeaders() -> [String: String]? {
        return Self.baseHeaders
    }
    
    public func requestParameters(parameters: [String: Any]) -> Task {
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }
    
    public func multipartData(from parameters: [String: Any], rootKey: String? = nil) -> [MultipartFormData] {
        return parameters.map { (key: String, value: Any) -> [MultipartFormData]? in
            return formData(from: value, key: key, rootKey: rootKey)?.compactMap { $0 }
            }.compactMap { $0 }.flatMap { $0 }
    }
    
    private func formData(from value: Any, key: String, rootKey: String? = nil) -> [MultipartFormData]? {
        var name = key
        if let rootKey = rootKey {
            name = "\(rootKey)[\(key)]" // uses the rootkey if present, otherwise every param goes separate.
        }
        
        if let value = value as? Data {
            return [MultipartFormData(provider: .data(value), name: name)]
        } else if let dictionary = value as? [String: Any] {
            let values = dictionary
                .map { formData(from: $0.value, key: $0.key, rootKey: rootKey) }
                .compactMap { $0 }
                .flatMap { $0 }
            return values
        } else if let data = "\(value)".data(using: String.Encoding.utf8, allowLossyConversion: false) {
            return [MultipartFormData(provider: .data(data), name: name)]
        }
        return nil
    }
}
