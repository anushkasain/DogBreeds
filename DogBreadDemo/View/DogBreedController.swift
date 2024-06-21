//
//  DogBreedController.swift
//
//
//  Created by Anushka Sain on 20/06/24.
//  Copyright © 2024 DesarrolloManzana. All rights reserved.
//

import UIKit

class DogBreedController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dogBreadCollectionView: UICollectionView!
    
    var dataViewModel: DogBreedImagesVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func initViewModel(viewModel: DogBreedImagesVM){
        self.dataViewModel = viewModel
        dataViewModel?.reloadCollectionView = {
            DispatchQueue.main.async { self.dogBreadCollectionView.reloadData() }
        }
        dataViewModel?.showError = {
            DispatchQueue.main.async { self.showAlert("Ups, something went wrong.") }
        }
        dataViewModel?.showLoading = {
//            DispatchQueue.main.async { self.activityIndicator.startAnimating() }
        }
        dataViewModel?.hideLoading = {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
        }
        dataViewModel?.fetchBreedImagesFromApi()
    }
    
    
}

extension DogBreedController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataViewModel?.numberOfCells ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogBreedCollectionViewCell", for: indexPath) as? DogBreedCollectionViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.prepareView(imgString: dataViewModel?.dogBreedImage(for: indexPath.item) ?? "", isSelect: dataViewModel?.dogBreedIsSelect(on: indexPath.item) ?? false)
        cell.favouriteButton.tag = indexPath.item
        cell.favUnfavButtonCallBackAction = {[weak self]  (isSelect, index) in
            print("favouriteButton.isSelected::", isSelect)
            self?.dataViewModel?.favOrUnFavUpdateInDogBreed(index: index, isSelect: isSelect)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2-10, height: 150)
    }
}
