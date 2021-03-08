//
//  MultiTabPageViewController.swift
//  WanTongTian
//
//  Created by sjty on 2020/8/3.
//  Copyright © 2020 liujing. All rights reserved.
//

import UIKit
import Foundation
import ApplicationKit

@objc protocol MultiTabPageDelegate: NSObjectProtocol {
  // 横向collectionView滑动
  func multiTabPageViewController(_ viewController: MultiTabPageViewController, pageScrollViewDidScroll scrollView: UIScrollView)
  func multiTabPageViewController(_ viewController: MultiTabPageViewController, pageScrollViewDidEndDecelerating scrollView: UIScrollView)
  func multiTabPageViewController(_ viewController: MultiTabPageViewController, pageScrolllViewDidEndScrollingAnimation scrollView: UIScrollView)
  // mainScrollView 滑动
  func multiTabPageViewController(_ viewController: MultiTabPageViewController, mainScrollViewDidScroll scrollView: UIScrollView)
  // 向外部要tab child vc
  func multiTabPageViewController(_ viewController: MultiTabPageViewController, childViewController index: Int) -> MultiTabChildPageViewController?
  // 子列表将要显示
  @objc optional func multiTabPageViewController(_ viewController: MultiTabPageViewController, willDisplay index: Int)
  // 子列表显示
  @objc optional func multiTabPageViewController(_ viewController: MultiTabPageViewController, displaying index: Int)
  // 子列已经显示
  @objc optional func multiTabPageViewController(_ viewController: MultiTabPageViewController, didEndDisplaying index: Int)
}

class MultiTabPageViewController: UIViewController {
  
  // MARK: - Public Preproty
  weak var delegate: MultiTabPageDelegate?
  
  public var tableHeaderView: UIView?
  
  public var mainTableViewGroups: [TableSectionGroup] = [] {
    didSet {
      self.updateUI()
    }
  }
//  {
//    didSet {
//      server.tableView.tableHeaderView = tableHeaderView
//    }
//  }
  
  let server = TableServer()
  // MARK: - Private Preproty
  lazy var mainTableView: MultiTabTableView = {
    let mainTableView = MultiTabTableView(frame: .zero, style: .grouped)
    mainTableView.bounces = true
    mainTableView.backgroundColor = Color.background
    mainTableView.showsVerticalScrollIndicator = false
    return mainTableView
  }()
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.backgroundColor = Color.background
    collectionView.register(MultiTabItemCell.self, forCellWithReuseIdentifier: NSStringFromClass(MultiTabItemCell.self))
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.isPagingEnabled = true
    return collectionView
  }()
  
  private var tabView: UIView!
  private var tabCount: Int = 0
  private var currentIndex: Int = 0
  private var titleBarHeight: CGFloat = 0.0
  private var bottomBarHeight: CGFloat = 0.0
  private var isHiddenHeaderView: Bool = false
  //记录刚开始时的偏移量
  private var startOffsetX: CGFloat = 0
  // 缓存所有的子列表，避免重复向调用方去索要
  private var childVCDic: [Int: MultiTabChildPageViewController] = [:]
  // 判断是否点击title来滚动页面
  private var mIsClickTitle: Bool = false
  // 页面的高度偏移量
  private var offsetHeight: CGFloat = 0
  
  /// 初始化方法
  /// - Parameters:
  ///   - tabCount: tab数量
  ///   - tabView: tab视图
  ///   - titleBarHeight: titleBar的高度
  init(tabCount: Int, tabView: UIView, titleBarHeight: CGFloat, bottomBarHeight: CGFloat) {
    super.init(nibName: nil, bundle: nil)
    self.tabCount = tabCount
    self.tabView = tabView
    self.titleBarHeight = titleBarHeight
    self.bottomBarHeight = bottomBarHeight
  }
  
  
  /// 初始化方法
  /// - Parameters:
  ///   - tabCount: tab数量
  ///   - headerView: 头部视图
  ///   - tabView: tab视图
  ///   - titleBarHeight: titleBar的高度
  ///   - defaultIndex: 可选参数，默认显示的子tab的索引，默认显示第一个
  ///   - isHiddenHeaderView: 可选参数，是否隐藏头部视图，默认显示
  ///   - offsetHeight: 可选参数，主视图的偏移量，默认 = 0
  init(tabCount: Int, headerView: UIView, tabView: UIView, titleBarHeight: CGFloat, bottomBarHeight: CGFloat, defaultIndex: Int = 0, isHiddenHeaderView: Bool = false, offsetHeight: CGFloat = 0) {
    super.init(nibName: nil, bundle: nil)
    self.tabCount = tabCount
    self.tabView = tabView
    self.titleBarHeight = titleBarHeight
    self.bottomBarHeight = bottomBarHeight
    if defaultIndex < tabCount, defaultIndex >= 0 {
      self.currentIndex = defaultIndex
    }
    self.isHiddenHeaderView = isHiddenHeaderView
    self.offsetHeight = offsetHeight
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
//  var isHeaderViewHidden: Bool = false {
//    didSet {
//      if isHeaderViewHidden {
//        mainTableView.contentOffset = CGPoint(x: 0, y: headerView.frame.height - titleBarHeight)
//      }
//    }
//  }
  
  var isHorizontalScrollEnable: Bool = true {
    didSet {
      self.collectionView.isScrollEnabled = isHorizontalScrollEnable
    }
  }
  
  var isBounces: Bool = false {
    didSet {
      self.mainTableView.bounces = isBounces
    }
  }
  
  public func move(to: Int, animated: Bool) {
    self.currentIndex = to
    mIsClickTitle = true
    view.isUserInteractionEnabled = false
    collectionView.scrollToItem(at: IndexPath.init(row: to, section: 0), at: .centeredHorizontally, animated: false)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
      self.view.isUserInteractionEnabled = true
      self.mainTableView.isScrollEnabled = true
      self.collectionView.isScrollEnabled = true
    }
  }
  
  // 处理右滑退出手势冲突问题
  public func handlePopGestureRecognizer(navi: UINavigationController) {
    if let popGestureRecognizer = navi.interactivePopGestureRecognizer {
      collectionView.panGestureRecognizer.require(toFail: popGestureRecognizer)
    }
  }
  
  public func resetChildViewControllers(tabCount: Int) {
    // 清空原来的父控制器
    childVCDic.forEach { (dic: (key: Int, value: MultiTabChildPageViewController)) in
      dic.value.removeFromParent()
    }
    mainTableView.scrollViewWhites?.removeAll()
    self.childVCDic.removeAll()
    self.tabCount = tabCount
    self.collectionView.reloadData()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configViews()
    if #available(iOS 11.0, *) {
      mainTableView.contentInsetAdjustmentBehavior = .never
    } else {
      automaticallyAdjustsScrollViewInsets = false
    }
    
    updateUI()
    
  }
  
  // 此方法是为了防止框架使用方（父view）的frame有改变时本view的frame无法同步改变
  override func viewDidLayoutSubviews() {
    
    super.viewDidLayoutSubviews()
    
    collectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - titleBarHeight - tabView.frame.height)
    mainTableView.tableFooterView = collectionView
    collectionView.reloadData()
    
//    mainTableView.frame = view.bounds
//    mainTableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - self.offsetHeight)
//    mainTableView.contentSize = CGSize(width: 0, height: mainTableView.frame.height + headerView.frame.height)
//    tabView.frame.origin.y = headerView.frame.maxY
//    collectionView.frame.origin.y = tabView.frame.maxY
//    collectionView.frame.size = CGSize(width: view.frame.width, height: mainTableView.contentSize.height - tabView.frame.maxY)
//    if self.isHiddenHeaderView {
//      mainTableView.contentOffset = CGPoint(x: 0, y: headerView.frame.height - titleBarHeight)
//      self.isHiddenHeaderView = false
//    }
  }
  
  private func configViews() {
    
    server.tableView = mainTableView
    server.scrollViewDelegate = self
    if let headerView = tableHeaderView {
      server.tableView.tableHeaderView = headerView
    }
    //    server.tableView.tableHeaderView = BannerHeaderView()
    server.tableView.separatorStyle = .none
    view.addSubview(mainTableView)
    mainTableView.layout.add { (make) in
      make.leading().top().trailing().bottom().equal(view)
    }
    collectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - titleBarHeight - bottomBarHeight - tabView.frame.height)
    mainTableView.tableFooterView = collectionView
    
  }
  
  func updateUI() {
    
//    var dataModel = HomeDataModel()
//
//    let menuCell = ReuseItem(HomeMenuCell.self)
//    let bulletinCell = ReuseItem(HomeBulletinCell.self)
//    let imageCell = ReuseItem(HomeBigAdvertismentCell.self)
//    let specialCell = ReuseItem(HomeProductSpecialCell.self)
//    let activityCell = ReuseItem(HomeActivityCell.self)
//    let topiceCell = ReuseItem(HomeTopicCell.self)
//    let rankingCell = ReuseItem(HomwRankingCell.self)
//    let brandCell = ReuseItem(HomeBrandCell.self)
//    let sectionCell = ReuseItem(HomeSectionCell.self)
//
//    var groups: [TableSectionGroup] = []
//
//    var bulletinGroup = TableSectionGroup()
//    bulletinGroup.items.append(TableCellItem(bulletinCell))
//    groups.append(bulletinGroup)
//
//    var menuGroup = TableSectionGroup()
//    menuGroup.items.append(TableCellItem(menuCell, data: dataModel.categorys))
//    groups.append(menuGroup)
//
//    dataModel.advertis.forEach { (item) in
//
//      var advGroup = TableSectionGroup(header: TableSectionItem(height: 10))
//      advGroup.items.append(TableCellItem(imageCell, data: item.imageURL, height: (App.shared.screen.width - 30) * 78 / 345))
//      groups.append(advGroup)
//
//    }
//
//    var specialGroup = TableSectionGroup(header: TableSectionItem(height: 10))
//    specialGroup.items.append(TableCellItem(specialCell))
//    groups.append(specialGroup)
//
//    var activityGroup = TableSectionGroup(header: TableSectionItem(height: 10))
//    activityGroup.items.append(TableCellItem(activityCell))
//    groups.append(activityGroup)
//
//    var topicGroup = TableSectionGroup(header: TableSectionItem(height: 10))
//    topicGroup.items.append(TableCellItem(topiceCell))
//    groups.append(topicGroup)
//
//    var rankingGroup = TableSectionGroup(header: TableSectionItem(height: 10))
//    rankingGroup.items.append(TableCellItem(rankingCell))
//    groups.append(rankingGroup)
//
//    var brandGroup = TableSectionGroup()
//
//    let brandSectionData = HomeSectionCell.DataModel(title: "品牌精选") {
//      let viewController = BrandViewControler()
//      Presenter.push(viewController)
//    }
//
//    brandGroup.items.append(TableCellItem(sectionCell, data: brandSectionData))
//    brandGroup.items.append(TableCellItem(brandCell))
//    groups.append(brandGroup)
    
    var groups = mainTableViewGroups
    
    if tabView.frame.height > 1 {
      let segmentGroup = TableSectionGroup(header: TableSectionItem(tabView, height: tabView.frame.height))
      groups.append(segmentGroup)
    }
    
    
    server.update(groups)
    
    if let header = mainTableView.es.base.header {
      mainTableView.bringSubviewToFront(header)
    }
    
  }
  
  // 预取，暂定预取前1和后1
  private func prefetchChildVC(currentIndex: Int) {
    let preIndex = max(0, currentIndex - 1)
    let afterIndex = min(tabCount - 1, currentIndex + 1)
    if self.childVCDic[preIndex] == nil {
      getChildVC(index: preIndex)
    }
    if self.childVCDic[afterIndex] == nil {
      getChildVC(index: afterIndex)
    }
  }
  
  private func getChildVC(index: Int) {
    if let childVC = delegate?.multiTabPageViewController(self, childViewController: index) {
      self.addChild(childVC)
      childVC.scrollDelegate = self
      childVCDic[index] = childVC
      if let scrollView = childVC.getScrollView() {
        mainTableView.scrollViewWhites?.insert(scrollView)
      }
    }
  }
  
}

extension MultiTabPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: UIScreen.main.bounds.width, height: collectionView.bounds.size.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tabCount
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var resultCell = UICollectionViewCell()
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MultiTabItemCell.self), for: indexPath) as? MultiTabItemCell {
      if let childVC = self.childVCDic[indexPath.row] {
        cell.configView(view: childVC.view)
        resultCell = cell
      } else {
        if let vc = delegate?.multiTabPageViewController(self, childViewController: indexPath.row) {
          self.addChild(vc)
          vc.scrollDelegate = self
          childVCDic[indexPath.row] = vc
          if let scview = vc.getScrollView() {
            mainTableView.scrollViewWhites?.insert(scview)
          }
          cell.configView(view: vc.view)
          resultCell = cell
        }
      }
      
    }
    if indexPath.row < tabCount {
      delegate?.multiTabPageViewController?(self, displaying: indexPath.row)
    }
    return resultCell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.row < tabCount {
      delegate?.multiTabPageViewController?(self, willDisplay: indexPath.row)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.row < tabCount {
      delegate?.multiTabPageViewController?(self, didEndDisplaying: indexPath.row)
    }
  }
  
}

extension MultiTabPageViewController: MultiTabChildPageDelegate {
  
  func commonTabChildViewController(_ viewController: MultiTabChildPageViewController, scrollViewDidScroll scrollView: UIScrollView) {
    if mainTableView.contentOffset.y < collectionView.frame.minY - titleBarHeight - tabView.frame.height - bottomBarHeight - 0.5 {
      let child = childVCDic[currentIndex]
      child?.offsetY = 0
    }
  }
}

extension MultiTabPageViewController: UIScrollViewDelegate {
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    mainTableView.isScrollEnabled = true
    collectionView.isScrollEnabled = true
    self.mIsClickTitle = false
    self.startOffsetX = scrollView.contentOffset.x
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    mainTableView.isScrollEnabled = true
    collectionView.isScrollEnabled = true
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    mainTableView.isScrollEnabled = true
    collectionView.isScrollEnabled = true
    currentIndex = collectionView.indexPathsForVisibleItems.first?.row ?? 0
    if scrollView == collectionView {
      delegate?.multiTabPageViewController(self, pageScrollViewDidEndDecelerating: scrollView)
    }
  }
  
  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    mainTableView.isScrollEnabled = true
    collectionView.isScrollEnabled = true
    if scrollView == collectionView {
      delegate?.multiTabPageViewController(self, pageScrolllViewDidEndScrollingAnimation: scrollView)
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView == mainTableView {
      mainTableView.isScrollEnabled = true
      collectionView.isScrollEnabled = false
      if currentIndex < tabCount {
        if let child = childVCDic[currentIndex] {
          if child.offsetY > 0 || scrollView.contentOffset.y >= collectionView.frame.minY - titleBarHeight {
            scrollView.contentOffset = CGPoint(x: 0, y: collectionView.frame.minY - titleBarHeight - tabView.frame.height)
          } else {
            childVCDic.forEach { (dic: (key: Int, value: MultiTabChildPageViewController)) in
              dic.value.offsetY = 0
            }
          }
        }
      }
      mainTableView.bounces = scrollView.contentOffset.y < 10
      delegate?.multiTabPageViewController(self, mainScrollViewDidScroll: mainTableView)
    } else if scrollView == collectionView {
      mainTableView.isScrollEnabled = false
      collectionView.isScrollEnabled = true
      if !mIsClickTitle {
        delegate?.multiTabPageViewController(self, pageScrollViewDidScroll: scrollView)
      }
    }
  }
}

