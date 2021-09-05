//
//  ForecastDescription.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import UIKit

class ForecastDescription: UITableViewCell {
    static let identifier = "ForecastDescription"
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    static func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    public func configure(str: String){
        time.text = "Ragaca"
//        timeLabel = UILabel(coder: str)
        //temperatureLabel.text = str
    }
    
}
