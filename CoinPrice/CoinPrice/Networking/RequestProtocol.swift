//
//  RequestProtocol.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 8/3/24.
//

import Foundation
import Alamofire

typealias JSONString = String
typealias RequestMethod = HTTPMethod

protocol RequestProtocol: AnyObject {
    associatedtype ResponseType: ResponseProtocol
    associatedtype ParametersType: Encodable
    var apiPath: String { get }
    var apiVersion: UInt { get }
    var method: RequestMethod { get }
    var result: Result<ResponseType>? { get set }

    var parameters: ParametersType { get set }

    func getBody() throws -> Data
}

extension RequestProtocol {
    func getBody() throws -> Data {
        return try JSONEncoder().encode(parameters)
    }
}

struct NoParameters: Codable {

}
