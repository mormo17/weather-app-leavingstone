//
//  ForecastHeader.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import UIKit

class ForecastHeader: UITableViewHeaderFooterView{
    static let identifier = "ForecastHeader"
    
    @IBOutlet weak var weekDay: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    static func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(with model: ForecastHeaderModel){
        weekDay.text = model.getWeekDay
    }
}
