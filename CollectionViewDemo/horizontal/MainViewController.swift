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
    @IBOutlet weak var pageControlCustom: ScrollingPageControl!
    
    let maxPage = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCollectionViewCell")
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        self.pageControl.numberOfPages = maxPage
        self.previewBtn.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        self.previewBtn.tag = 0
        self.nextBtn.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        self.nextBtn.tag = 1
        
        
        self.pageControlCustom.pages = maxPage
        
        
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
        
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControlCustom.selectedPage = Int(page)
    }
    
}

extension MainViewController : ScrollingPageControlDelegate {
    
    func viewForDot(at index: Int) -> UIView? {
        guard index == 0 else { return nil }
        let view = TriangleView()
        view.isOpaque = false
        return view
    }
    
}

