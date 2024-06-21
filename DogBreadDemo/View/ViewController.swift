//
//  DogBreedController.swift
//
//
//  Created by Anushka Sain on 20/06/24.
//  Copyright © 2024 DesarrolloManzana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataViewModel = DogBreedListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    
    func initViewModel(){
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
        dataViewModel.showError = {
            DispatchQueue.main.async { self.showAlert("Ups, something went wrong.") }
        }
        dataViewModel.showLoading = {
            DispatchQueue.main.async { self.activityIndicator.startAnimating() }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
        }
        dataViewModel.fetchDogsBreedListFromApi()
    }
    
    @IBAction func favouriteButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "FavouriteDogViewController") as? FavouriteDogViewController else {
            fatalError("FavouriteDogViewController not exists in Main Storyboard")
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogBreedListCollectionCell", for: indexPath) as? DogBreedListCollectionCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.labelTitle.tag = indexPath.row
        cell.prepareView(title: dataViewModel.breedName(for: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2-10, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTitle = self.dataViewModel.breedName(for: indexPath.item)
        let vm = DogBreedImagesVM(selecteddogBreedTitle: selectedTitle)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DogBreedController") as? DogBreedController else {
            fatalError("DogBreedController not exists in Main Storyboard")
        }
        vc.initViewModel(viewModel:  vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
