//
//  ForecastHeader.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import UIKit

class ForecastHeader: UITableViewCell {
    static let identifier = "ForecastHeader"
    
    @IBOutlet weak var weekDay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(with model: ForecastViewModel){
        setUpHeader(title: model.getWeekDay)
    }
    
    private func setUpHeader(title: String){
        weekDay.text = title
    }
}
