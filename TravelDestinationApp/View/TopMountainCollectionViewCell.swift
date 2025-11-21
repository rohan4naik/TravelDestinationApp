//
//  TopMountainCollectionViewCell.swift
//  TravelDestinationApp
//
//  Created by SDC-USER on 21/11/25.
//

import UIKit

class TopMountainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mountainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(destination: Destination){
        mountainImageView.image = UIImage(named: destination.imagePath)
    }
}
