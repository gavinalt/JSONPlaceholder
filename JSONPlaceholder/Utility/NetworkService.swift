//
//  NetworkService.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/23/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

enum NetworkError: Error {
  case connectionError
  case invalidURL
  case serverError
  case invalidResponse(Int)
  case requestError(Error?)
  case parseError(Error?)
  case unknownError
}

final class NetworkService {
  let urlSession: URLSession

  init() {
    urlSession = URLSession(configuration: .default)
  }

  init(_ session: URLSession) {
    urlSession = session
  }

  func loadJSONData<T: Decodable>(type: T.Type,
                                  url: String,
                                  params: [String: String]?,
                                  completion: @escaping (Result<T, NetworkError>) -> Void) {
    guard let url = URL(string: url) else {
      completion(.failure(.invalidURL))
      return
    }
    loadJSONData(type: type, url: url, params: params, completion: completion)
  }

  func loadJSONData<T: Decodable>(type: T.Type,
                                  url: URL,
                                  params: [String: String]?,
                                  completion: @escaping (Result<T, NetworkError>) -> Void) {
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = params
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//      guard let response = response as? HTTPURLResponse else {
//        completion(.failure(.serverError))
//        return
//      }
//
//      guard 200 ..< 300 ~= response.statusCode else {
//        completion(.failure(.invalidResponse(response.statusCode)))
//        return
//      }

      guard let data = data else {
        completion(.failure(.requestError(error)))
        return
      }

      do {
        let decoder = JSONDecoder()
        let typedObject: T = try decoder.decode(T.self, from: data)
        completion(.success(typedObject))
      } catch let error {
        completion(.failure(.parseError(error)))
      }
    }

    dataTask.resume()
  }
}
