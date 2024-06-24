//
//  FavouriteDogViewController.swift
//  DogBreadDemo
//
//  Created by Anushka Sain on 20/06/24.
//

import UIKit

class FavouriteDogViewController: UIViewController {
    
    @IBOutlet weak var emptyFavouriteMessage: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    
    let favouriteVM = FavouriteVM()
    let tableView = UITableView()
    let transparentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTableView(frames: filterButton.frame)
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        showTableView(frames: filterView.frame)
    }
    
    func prepareView(){
        favouriteVM.reloadCollectionView = {
            if self.favouriteVM.favDogsImagesList.count == 0 {
                self.collectionView.isHidden = true
                self.emptyFavouriteMessage.isHidden = false
                self.emptyFavouriteMessage.text = "Favourite list is empty"
                self.filterView.isHidden = true
            }else{
                self.collectionView.isHidden = false
                self.filterView.isHidden = false
                self.emptyFavouriteMessage.isHidden = true
                self.collectionView.reloadData()
            }
        }
        filterView.addBorder(corenrRadius: 10, borderWidth: 1, borderColor: UIColor.gray)
        favouriteVM.retriveAllDogsBreedFromUserDefault()
    }
    
    /// Add Dropdown Table
    /// - Parameter frames: it will take  filters frame
    func addTableView(frames: CGRect) {
        transparentView.backgroundColor = UIColor.clear
        transparentView.frame = self.view.frame
        self.view.addSubview(transparentView)
        tableView.register(UINib(nibName: "DropdownTableViewCell", bundle: nil), forCellReuseIdentifier: "DropdownTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        let tableVeiwHeight = (favouriteVM.getFilterList().count > 3) ? 120.0 : CGFloat(favouriteVM.getFilterList().count) * tableView.rowHeight
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: tableVeiwHeight)
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        tableView.separatorStyle = .none
        tableView.layer.borderColor = UIColor.systemGray5.cgColor
        tableView.layer.borderWidth = 1.0
        
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        filterLabel.text = favouriteVM.getFilterList()[0]
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(self.hideTableView))
        transparentView.addGestureRecognizer(tapgesture)
        tableView.isHidden = true
        transparentView.isHidden = true
    }
    
    private func showTableView(frames: CGRect) {
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: 200, height: tableView.frame.height)
        tableView.isHidden = false
        transparentView.isHidden = false
    }
    
    
    @objc private func hideTableView() {
        tableView.isHidden = true
        transparentView.isHidden = true
    }
    
    
}
extension FavouriteDogViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteVM.favDogsImagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogBreedCollectionViewCell", for: indexPath) as? DogBreedCollectionViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        cell.prepareView(imgString: favouriteVM.dogBreedImage(for: indexPath.item), isSelect: true)
        cell.favouriteButton.tag = indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3-10, height: 100)
    }
}

extension FavouriteDogViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteVM.getFilterList().count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownTableViewCell", for: indexPath) as? DropdownTableViewCell else {
            fatalError("DropdownTableViewCell not exists ")
        }
        cell.titleLabel.text = favouriteVM.getFilterList()[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filterLabel.text = favouriteVM.getFilterList()[indexPath.row]
        favouriteVM.filterDataOnDogBreed(title: favouriteVM.getFilterList()[indexPath.row])
        self.collectionView.reloadData()
        hideTableView()
    }
    
    
}
