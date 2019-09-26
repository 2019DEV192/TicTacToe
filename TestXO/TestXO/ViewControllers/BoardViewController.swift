//
//  BoardViewController.swift
//  TestXO
//
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var boardCollectionView: UICollectionView!
    
    //MARK: private
    private let sectionMinimumSeparator: CGFloat = 1
    private let boardSize: Int = 3
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    //MARK: IBActions
    @IBAction func restartButtonPressed(_ sender: Any) {
        self.resetGame()
    }
    
    //MARK: UI methods
    private func resetGame () {
        initUI()
    }
    
    private func initUI () {
        self.titleLabel.text = ""
        self.boardCollectionView.isUserInteractionEnabled = true
        self.boardCollectionView.reloadData()
    }
    
}

// MARK: - Collection View Datasource
extension BoardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.reuseIdentifier, for: indexPath) as? GridCell else {
            return GridCell()
        }
        cell.config()
        return cell
    }
    
}

// MARK: - Collection View Flow Layout Delegate
extension BoardViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionMinimumSeparator * CGFloat(3 - 1)
        let availableWidth: CGFloat = collectionView.bounds.size.width - paddingSpace
        let sizePerItem: CGFloat = availableWidth / CGFloat(3)
        
        return CGSize(width: sizePerItem, height: sizePerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0,
                            left: 0.0,
                            bottom: 0.0,
                            right: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionMinimumSeparator
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionMinimumSeparator
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GridCell else {
            return false
        }
        if cell.isSelected {
            return false
        }
        return true
    }

}
