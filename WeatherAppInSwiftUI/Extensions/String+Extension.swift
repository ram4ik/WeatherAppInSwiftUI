//
//  String+Extension.swift
//  WeatherAppInSwiftUI
//
//  Created by ramil on 13.08.2020.
//

import Foundation

extension String {
    
    func escape() -> String? {
        
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}
