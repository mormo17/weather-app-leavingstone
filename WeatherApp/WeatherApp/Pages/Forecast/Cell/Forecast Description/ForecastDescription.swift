//
//  ForecastDescription.swift
//  WeatherApp
//
//  Created by Mariam Ormotsadze on 9/5/21.
//

import UIKit

class ForecastDescription: UITableViewCell {
    static let identifier = "ForecastDescription"
    @IBOutlet weak var weathcerIcon: NSLayoutConstraint!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
