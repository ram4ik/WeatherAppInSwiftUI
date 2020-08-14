//
//  WeatherViewModel.swift
//  WeatherAppInSwiftUI
//
//  Created by ramil on 13.08.2020.
//

import Foundation

enum LoadingState {
    case none
    case loading
    case success
    case failed
    
}

class WeatherViewModel: ObservableObject {
    
    @Published private var weather: Weather?
    @Published var message: String = ""
    @Published var loadingState: LoadingState = .none
    
    var temperature: Double {
        guard let temp = weather?.temp else {
            return 0.0
        }
        return temp
    }
    
    var humidity: Double {
        guard let humidity = weather?.humidity else {
            return 0.0
        }
        return humidity
    }
    
    func fetchWeather(city: String, apiKey: String) {
        
        guard let city = city.escape() else {
            DispatchQueue.main.async {
                self.message = "City is incorrect"
            }
            
            return
        }
        
        self.loadingState = .loading
        
        WeatherService().getWeather(city: city, apiKey: apiKey) { result in
            switch result {
            
                case .success(let weather):
                    DispatchQueue.main.async {
                        self.weather = weather
                        self.loadingState = .success
                    }

                case .failure(_ ):
                    DispatchQueue.main.async {
                        self.message = "Unable to find the weather"
                        self.loadingState = .failed
                    } 
            }
        }
    }
}
