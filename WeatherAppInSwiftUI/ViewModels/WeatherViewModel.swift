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

enum TemperatureUnit: String, CaseIterable {
    case fahrenheit
    case celsius
}

extension TemperatureUnit {
    
    var title: String {
        switch self {
            case .fahrenheit:
                return "Fahreinheit"
            case .celsius:
                return "Celsius"
        }
    }
}

class WeatherViewModel: ObservableObject {
    
    @Published private var weather: Weather?
    @Published var message: String = ""
    @Published var loadingState: LoadingState = .none
    @Published var temperatureUnit: TemperatureUnit = .fahrenheit
    
    var temperature: String {
        guard let temp = weather?.temp else {
            return "N/A"
        }
        
        switch temperatureUnit {
        
            case .fahrenheit:
                return String(format: "%.0F F", temp.toFahrenheit())
                
            case .celsius:
                return String(format: "%.0F C", temp.toCelsius())
            }
    }
    
    var humidity: String {
        guard let humidity = weather?.humidity else {
            return "N/A"
        }
        return String(format: "%.0F %%", humidity)
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
