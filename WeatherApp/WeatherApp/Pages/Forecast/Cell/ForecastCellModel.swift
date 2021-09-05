//
//  ForecastCellModel.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import Foundation

struct ForecastCellModel{
    
    public var headerModel: ForecastHeaderModel
    public var rowModels: [ForecastViewModel]
    
    init(
        headerModel: ForecastHeaderModel,
        rowModels: [ForecastViewModel]
    ){
        self.headerModel = headerModel
        self.rowModels = rowModels
    }
    
}
