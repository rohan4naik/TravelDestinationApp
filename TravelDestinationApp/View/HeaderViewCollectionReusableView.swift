//
//  HeaderViewCollectionReusableView.swift
//  TravelDestinationApp
//
//  Created by SDC-USER on 21/11/25.
//

import UIKit

class HeaderViewCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(text: String){
        headerLabel.text = text
    }
}
