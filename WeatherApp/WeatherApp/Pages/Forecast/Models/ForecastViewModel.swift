//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import Foundation

struct ForecastViewModel{
    private let date: UInt64
    private let time: String
    private let iconName: String
    private let description: String
    private let temperature: Int
    
    init(
        date: UInt64,
        time: String,
        iconName: String,
        description: String,
        temperature: Int
    ){
        self.date = date
        self.time = time
        self.iconName = iconName
        self.description = description
        self.temperature = temperature
    }
    
    var getWeekDay: String {
        let dateToConvert = Date(timeIntervalSince1970: TimeInterval(date))
        let formatter = DateFormatter()
        let weekDay = formatter.weekdaySymbols[Calendar.current.component(.weekday, from: dateToConvert) - 1]
        return weekDay
    }
    
    var getTime: String {
        let timeStartIndx = time.index(time.endIndex, offsetBy: -8)
        let timeEndINdx = time.index(time.endIndex, offsetBy: -3)
        let range = timeStartIndx..<timeEndINdx
//        let timeIndex = time.index(time.endIndex, offsetBy: -8)
        return String(time[range])
    }
    
    var isNewDay: Bool {
        return getTime == "00:00"
    }
    
    var getIconName: String { return iconName }
    
    var getDescription: String { return description }
    
    var getTemperature: String { return "\(temperature)°"}
    
}
