//
//  TopUrbanCollectionViewCell.swift
//  TravelDestinationApp
//
//  Created by SDC-USER on 21/11/25.
//

import UIKit

class TopUrbanCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var urbanImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(destination: Destination){
        urbanImageView.image = UIImage(named: destination.imagePath)
    }
}
