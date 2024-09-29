//
//  BannersView.swift
//  Restaraunt Menu
//
//  Created by Никита Козловский on 29.09.2024.
//

import UIKit

final class BannersView: UIView {
    
    private var banners = [String]()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.dataSource = self
        collectionView.register(BannersCell.self, forCellWithReuseIdentifier: BannersCell.reuseID)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(bannersString: [String]) {
        banners = bannersString
        collectionView.reloadData()
        print(bannersString)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let compositionalLayout = UICollectionViewCompositionalLayout(section: createPromotionsView())
        return compositionalLayout
    }
    
    private func createPromotionsView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        let rowHeight = NSCollectionLayoutDimension.fractionalHeight(1)
        let rowSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: rowHeight)
        
        let row = NSCollectionLayoutGroup.horizontal(layoutSize: rowSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: row)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
        
    }
}

extension BannersView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(banners)
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: BannersCell = collectionView.dequeueReusableCell(withReuseIdentifier: BannersCell.reuseID, for: indexPath) as? BannersCell else { return UICollectionViewCell() }
        
        print(banners)
        let banner = banners[indexPath.row]
        cell.configure(string: banner)
        return cell
    }
    
    
}