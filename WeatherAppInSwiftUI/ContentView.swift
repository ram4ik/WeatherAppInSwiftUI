//
//  ContentView.swift
//  WeatherAppInSwiftUI
//
//  Created by ramil on 13.08.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var weatherVM: WeatherViewModel
    @State private var city: String = ""
    @AppStorage("APIKEY") var apiKey: String = ""
    
    init(weatherVM: WeatherViewModel = WeatherViewModel()) {
        self.weatherVM = weatherVM
    }
    
    var body: some View {
        VStack {
            TextField("Search", text: $city, onEditingChanged: {_ in }) {
                self.weatherVM.fetchWeather(city: self.city, apiKey: self.apiKey)
            }.textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Your API Key", text: $apiKey)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer()
            if self.weatherVM.loadingState == .loading {
                Text("Loading...")
            } else if self.weatherVM.loadingState == .success {
                WeatherView(weatherVM: self.weatherVM)
            } else if self.weatherVM.loadingState == .failed {
                Text(self.weatherVM.message)
            }
            Spacer()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let vmNone = WeatherViewModel()
        vmNone.loadingState = .none
        
        let vmSuccess = WeatherViewModel()
        vmSuccess.loadingState = .success
        
        let vmLoading = WeatherViewModel()
        vmLoading.loadingState = .loading
        vmLoading.message = "Loading..."
        
        let vmFailed = WeatherViewModel()
        vmFailed.loadingState = .failed
        vmFailed.message = "Unable to find the weather"
        
        return Group {
            ContentView(weatherVM: vmNone)
            ContentView(weatherVM: vmSuccess)
            ContentView(weatherVM: vmLoading)
            ContentView(weatherVM: vmFailed)
        }
    }
}

struct WeatherView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(self.weatherVM.temperature)")
                .font(.largeTitle)
                .foregroundColor(Color.white)
            Text("\(self.weatherVM.humidity)")
                .foregroundColor(Color.white)
                .opacity(0.7)
            Picker(selection: self.$weatherVM.temperatureUnit, label: Text("Select a Unit")) {
                ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                    Text(unit.title)
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
        .padding()
        .frame(width: 300, height: 150)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 8.0, style: .continuous))
    }
}
