//
//  NetworkService.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 8/3/24.
//

import Foundation
import Alamofire

class NetworkService {
    enum NetworkServiceError: Error {
        case failToInitURL
        case failToParseAPIError
        case oauthTokenExpiredError
        case requestFailed
    }

    static let shared = NetworkService()
    
    var manager: Session = getSession()

    private static func getSession() -> Session {
        let manager = Session(configuration: URLSessionConfiguration.default,
                              interceptor: Interceptor())
        return manager
    }

    func sendRequest<T: RequestProtocol>(request: T, completion: @escaping(Result<T.ResponseType>) -> Void) {
        let urlRequest: URLRequest
        do {
            urlRequest = try createRequest(request: request)
        } catch {
            print(error)
            completion(Result.error(error))
            return
        }

        let request = manager.request(urlRequest).validate()
            .responseString(completionHandler: { (responseString) in
                print(responseString)
            })
            .validate(statusCode: 200..<600).validate({ (_, _, data) -> Request.ValidationResult in
                guard let _ = data else {
                    return Request.ValidationResult.failure(NetworkService.NetworkServiceError.failToParseAPIError)
                }
                return Request.ValidationResult.success(())

            }).responseString(completionHandler: { res in
                print("API: \(urlRequest.url!) -> \(res)")

            }).responseData { (dataResponse) in
                switch dataResponse.result {
                case .success(let data):
                    print(data.toUTF8String())
                    do {
                        let result = try self.parseResponse(request: request, data: data)
                        request.result = result
                        return completion(result)
                    } catch {
                        print(error)
                        return completion(Result.error(error))
                    }
                case .failure(let error):
                    print(error)
                    return completion(Result.error(error))
                }
            }
        request.cURLDescription(calling: { (curl) in
            print("\nREST Request: \(curl)\n")
        })
    }

    fileprivate func createRequest<T: RequestProtocol>(request: T) throws -> URLRequest {
        let endPoint = Constants.endpoint
        let fullURLPath = "\(endPoint)/v\(request.apiVersion)/\(request.apiPath)"
        print("Request to url : \(fullURLPath)")
        let body: Data
        do {
            body = try request.getBody()
        } catch {
            print(error)
            throw error
        }
        print(body.toUTF8String())

        guard let url = URL(string: fullURLPath) else {
            throw NetworkServiceError.failToInitURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(Constants.coinAPIKey, forHTTPHeaderField: "x-access-token")
        if T.ParametersType.self != NoParameters.self || request.method != .get {
            urlRequest.httpBody = body
        }
        return urlRequest
    }

    fileprivate func parseResponse<T: RequestProtocol>(request: T, data: Data) throws -> Result<T.ResponseType> {
        let responseStatus: ResponseStatus
        responseStatus = try JSONDecoder().decode(ResponseStatus.self, from: data)
        if responseStatus.isSuccess {
            let response = try JSONDecoder().decode(T.ResponseType.self, from: data)
            let result = Result.success(responseStatus, response)
            return result
        } else {
            var response: T.ResponseType?
            do {
                response = try JSONDecoder().decode(T.ResponseType.self, from: data)
            } catch {
                print(error)
            }
            let result = Result.notSuccess(responseStatus, response)
            return result
        }
    }
}
