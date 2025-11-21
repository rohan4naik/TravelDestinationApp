//
//  ViewController.swift
//  TravelDestinationApp
//
//  Created by SDC-USER on 21/11/25.
//

import UIKit

class ViewController: UIViewController {
    
    var destinationsResponse = DestinationsResponse()
    var topMountainDestination: [Destination] = []
    var topBeachDestination: [Destination] = []
    var topUrbanDestination: [Destination] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
        collectionView.register(UINib(nibName: "HeaderViewCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "header_cell")
       
        // get all mountain,beach,urban destination
        topMountainDestination = destinationsResponse.destinations(for: .mountains)
        
        topBeachDestination = destinationsResponse.destinations(for: .beach)
        
        topUrbanDestination = destinationsResponse.destinations(for: .urban)
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        collectionView.dataSource = self
    }

    func generateLayout()-> UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout { section, env in
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind:"header", alignment: .top)
            
            if section == 0{
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 10,
                    bottom: 0,
                    trailing: 10
                )
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(300))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
                //group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                
                
                section.boundarySupplementaryItems = [header]
                
                return section
            } else if section == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
            
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 10,
                    trailing: 0
                )
                
                section.boundarySupplementaryItems = [header]
                
                return section
            } else{
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                let section = NSCollectionLayoutSection(group: group)
                // section.orthogonalScrollingBehavior = .groupPagingCentered

                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 10,
                    trailing: 0
                )
                
                section.boundarySupplementaryItems = [header]
                return section
            }
        }
        return layout
    }
    
    func registerCells(){
        collectionView.register(UINib(nibName: "TopBeachCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "beach_cell")
        
        collectionView.register(UINib(nibName: "TopMountainCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "mountain_cell")
        
        collectionView.register(UINib(nibName: "TopUrbanCollectionViewCell", bundle: nil),
        forCellWithReuseIdentifier: "urban_cell")
    }
}

extension ViewController : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "beach_cell", for: indexPath) as! TopBeachCollectionViewCell
            let destination = topBeachDestination[indexPath.row]
            cell.configureCell(destination : destination)
            return cell
        }
        else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mountain_cell", for: indexPath) as! TopMountainCollectionViewCell
            let destination = topMountainDestination[indexPath.row]
            cell.configureCell(destination : destination)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "urban_cell", for: indexPath) as! TopUrbanCollectionViewCell
        let destination = topUrbanDestination[indexPath.row]
        cell.configureCell(destination : destination)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView =
        collectionView.dequeueReusableSupplementaryView(ofKind: "header",withReuseIdentifier: "header_cell",for: indexPath) as! HeaderViewCollectionReusableView
        if indexPath.section == 0{
            headerView.configure(text: "Top Beaches")
            //HeaderViewCollectionReusableView.headerLabel.text = "Top Beaches"
        } else if indexPath.section == 1 {
            headerView.configure(text: "Top Moutains")
            
        } else {
            headerView.configure(text: "Top Urban")
        }
        return headerView
    }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if section == 0 {
                return topBeachDestination.count
            }
            else if section == 1 {
                return topMountainDestination.count
            }
            
            return topUrbanDestination.count
        }
        
    }

