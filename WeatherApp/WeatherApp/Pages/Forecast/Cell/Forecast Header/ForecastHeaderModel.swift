//
//  ForecastHeaderModel.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import Foundation

struct ForecastHeaderModel{
    private let weekDay: String
    
    init(weekDay: String) { self.weekDay = weekDay }
    
    var getWeekDay: String { return weekDay.uppercased() }
}
