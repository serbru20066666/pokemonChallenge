//
//  NetworkerMockFailure.swift
//  PokeChallenge
//
//  Created by Bruno Cárdenas on 22/03/25.
//
import Combine
@testable import PokeChallenge
import PokeNetworkingCore
import Foundation

class NetworkerMockFailure: NetworkerProtocol {
    func get<T>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> where T: Decodable {
        return Fail(error: NetworkError.invalidURL)
            .eraseToAnyPublisher()
    }

    func getData(url: URL, headers: Headers) -> AnyPublisher<Data, URLError> {
        return Fail(error: URLError(.badURL))
            .eraseToAnyPublisher()
    }
}
