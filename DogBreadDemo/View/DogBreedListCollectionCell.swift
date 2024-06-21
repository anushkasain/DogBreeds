//
//  DogBreedListCollectionCell.swift
//  DogBreadDemo
//
//  Created by Anushka Sain on 21/06/24.
//

import UIKit

class DogBreedListCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var innerContentView: UIView!
    
    override func draw(_ rect: CGRect) {
        innerContentView.backgroundColor = UIColor.white
        innerContentView.layer.cornerRadius = 10.0
        innerContentView.layer.borderWidth = 1.0
        innerContentView.layer.borderColor = UIColor.gray.cgColor
        innerContentView.layer.masksToBounds = true
    }
    func prepareView(title: String){
        labelTitle.text = title.capitalized
    }
}
