//
//  WeatherService.swift
//  WeatherAppInSwiftUI
//
//  Created by ramil on 13.08.2020.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

class WeatherService {
    
    func getWeather(city: String, apiKey: String, completion: @escaping (Result<Weather?, NetworkError>) -> Void) {
        
        guard let url = URL.urlForWeather(city, apiKey) else {
            
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse.main))
            } else {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
}
