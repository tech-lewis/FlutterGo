//
//  MultiCollectionDemoViewController.swift
//  WanTongTian
//
//  Created by sjty on 2020/8/3.
//  Copyright © 2020 liujing. All rights reserved.
//

import UIKit

protocol MultiCollectionDemoViewControllerDelegate: NSObjectProtocol {
    func waterfallViewController(_ viewController: MultiCollectionDemoViewController, scrollViewDidScroll scrollView: UIScrollView)
}

class MultiCollectionDemoViewController: MultiTabChildPageViewController {

    var collectionViewTopPadding: CGFloat = 0
    var beginPoint: CGPoint = CGPoint.zero // 记录开始滑动的起始点
    weak var delegate: MultiCollectionDemoViewControllerDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
//        let viewHeight: CGFloat = UIScreen.main.bounds.size.height - 88 - 50
//        let frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: viewHeight)
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    //MARK: - Private Property
    private var toIndex: Int = 0
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configSubviews()
    }
    
    deinit {
        print("ZFCollectionDemoViewController")
    }
    
    //MARK: - Public Mehtods
    
    //MARK: - Override FCCommonTabChildViewController
    override var offsetY: CGFloat {
        set {
            collectionView.contentOffset = CGPoint(x: 0, y: newValue)
        }
        get {
            return collectionView.contentOffset.y
        }
    }
    
    override var isCanScroll: Bool {
        didSet{
            if isCanScroll {
                collectionView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: false)
            }
        }
    }
    
    override func getScrollView() -> UIScrollView? {
        return collectionView
    }

    //MARK: - Data
    public func loadData() {
      
      collectionView.reloadData()
        
    }

    private func loadMoreData() {
        
    }
    
    //MARK: - Private Mehtods
    private func configSubviews() {
      self.view.backgroundColor = .randomColor
        collectionView.backgroundColor = .randomColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: NSStringFromClass(ItemCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
      collectionView.layout.add { (make) in
        make.leading().top().trailing().bottom().equal(view)
      }
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
      collectionView.reloadData()
      
    }
    
}
extension MultiCollectionDemoViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        beginPoint = scrollView.contentOffset
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.commonTabChildViewController(self, scrollViewDidScroll: scrollView)
        delegate?.waterfallViewController(self, scrollViewDidScroll: scrollView)
    }
}

extension MultiCollectionDemoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ItemCell.self), for: indexPath) as? ItemCell {
            cell.configView(color: .randomColor)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: (UIScreen.main.bounds.size.width - 40) / 2, height: 200.0)
        return size
    }
}


extension UIColor {
    //返回随机颜色
    class var randomColor: UIColor {
        get
        {
            let red = CGFloat(arc4random() % 256) / 255.0
            let green = CGFloat(arc4random() % 256) / 255.0
            let blue = CGFloat(arc4random() % 256) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

extension MultiCollectionDemoViewController {
 
  class ItemCell: UICollectionViewCell {
      
      func configView(color: UIColor?) {
          colorView.backgroundColor = color
      }
      
      private lazy var colorView: UIView = {
          var colorView = UIView()
          return colorView
      }()
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          initViews()
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      override func prepareForReuse() {
          super.prepareForReuse()
          colorView.backgroundColor = .clear
      }
      
      private func initViews() {
          self.contentView.backgroundColor = .white
          self.contentView.addSubview(colorView)
        colorView.layout.add { (make) in
          make.leading().top().trailing().bottom().equal(contentView)
        }
      }
  }
  
}
