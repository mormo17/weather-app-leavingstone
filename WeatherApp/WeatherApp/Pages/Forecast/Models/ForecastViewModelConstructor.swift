//
//  ForecastViewModelConstructor.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import Foundation

class ForecastViewModelConstructor{
    public static func construct(from item: WeatherForecastData) -> ForecastViewModel{
        return ForecastViewModel(
            date: UInt64(item.dt),
            time: item.dt_txt,
            iconName: item.weather.first!.icon,
            description: item.weather.first!.description,
            temperature: Int(item.main.temp)
        )
    }
}
