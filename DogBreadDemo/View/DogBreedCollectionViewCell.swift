//
//  DogBreedCollectionViewCell.swift
//   
//
//  Created by Anushka Sain on 20/06/24.
//  Copyright © 2024 DesarrolloManzana. All rights reserved.
//

import UIKit
import SDWebImage

class DogBreedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var innerContentView: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var dogBreadImgView: UIImageView!
    var favUnfavButtonCallBackAction: ((_ isSelect: Bool, _ index: Int) -> ())?

    
    override func draw(_ rect: CGRect) {
        innerContentView.backgroundColor = UIColor.white
        innerContentView.layer.cornerRadius = 10.0
        innerContentView.layer.borderWidth = 1.0
        innerContentView.layer.borderColor = UIColor.gray.cgColor
        innerContentView.layer.masksToBounds = true
    }
    func prepareView(imgString: String, isSelect: Bool){
        dogBreadImgView.sd_setImage(with:  URL(string: imgString), placeholderImage: UIImage(named: "placeholder"))
        favouriteButton.isSelected =  isSelect
    }
    
    @IBAction func favUnfavButtonAction(_ sender: UIButton) {
        favouriteButton.isSelected =  !favouriteButton.isSelected
        favUnfavButtonCallBackAction?(favouriteButton.isSelected, sender.tag)
    }
}
