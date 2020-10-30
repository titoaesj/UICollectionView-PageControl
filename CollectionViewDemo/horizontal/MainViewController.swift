//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by titoaesj on 29/10/20.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    let maxPage = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCollectionViewCell")
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        
//        let screenSize: CGRect = UIScreen.main.bounds
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
//            layout.estimatedItemSize = CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
        }
        
        self.pageControl.numberOfPages = maxPage
        
        previewBtn.addTarget(self, action: #selector(handleNextPage), for:
                                .touchUpInside)
        previewBtn.tag = 0
        
        nextBtn.addTarget(self, action: #selector(handleNextPage), for:
                            .touchUpInside)
        nextBtn.tag = 1
        
        
    }
    
    @objc func handleNextPage(button: UIButton) {
        
        var indexPath: IndexPath!
        var current = pageControl.currentPage
        
        if button.tag == 0 {
            current -= 1
            if current < 0 {
                current = 0
            }
        } else {
            current += 1
            if current > (maxPage - 1) {
                current = 0
            }
        }
        
        indexPath = IndexPath(item: current, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxPage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ItemCollectionViewCell",
            for: indexPath
        ) as! ItemCollectionViewCell
        cell.update(index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: self.collectionView.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
    
}

