// 获取网络图片的宽高

func getImageSize(withUrl url: String) -> CGSize {
  
  var size = CGSize(width: 1, height: 1)
  if let cacheSize = imageSizes[url] {
    size = cacheSize
    return size
  }
  
  if let resourceUrl = URL(string: url) {
   
    KingfisherManager.shared.retrieveImage(with: resourceUrl, options: nil, progressBlock: nil) { (image, error, _, _) in
      
      if let image = image {
        self.imageSizes[url] = image.size
        size = image.size
        self.updateUI()
        
      }
      
    }
    
  }
  
  return size
  
}
//
import UIKit
import ApplicationKit
import JXSegmentedView

class MyCourseViewController: UIViewController {
  
  var segmentedDataSource = JXSegmentedTitleDataSource()
  let segmentedView = JXSegmentedView()
  lazy var pageView: JXSegmentedListContainerView! = {
      return JXSegmentedListContainerView(dataSource: self)
  }()
  
  private let allCourseListView = MyCourseListViewController()
  private let salesCourseListView = MyCourseListViewController()
  private let removeCourseListView = MyCourseListViewController()
  private let reviewingCourseListView = MyCourseListViewController()
  private let rejectCourseListView = MyCourseListViewController()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    allCourseListView.listType = .all
    salesCourseListView.listType = .sales
    removeCourseListView.listType = .removed
    reviewingCourseListView.listType = .reviewing
    rejectCourseListView.listType = .reject
    setupUI()
    
  }
  
}

// MARK: - Public
extension MyCourseViewController {
  
}

// MARK: - Setup
private extension MyCourseViewController {
  
  func setupUI() {
    
    navigationView.setup(title: "我的课程")
    navigationView.showBack()

    segmentedDataSource.isTitleColorGradientEnabled = true
    segmentedDataSource.titleSelectedFont = Font.pingFangSCMedium(14)
    segmentedDataSource.titleSelectedColor = Color.textOfDeep
    segmentedDataSource.titleNormalFont = Font.pingFangSCMedium(14)
    segmentedDataSource.titleNormalColor = Color.textOfLight
    segmentedDataSource.titles = ["全部", "上架", "下架", "审核中", "审核不通过"]
    
    segmentedView.listContainer = pageView
    segmentedView.frame.size.height = 37
    segmentedView.backgroundColor = .white
    segmentedView.dataSource = segmentedDataSource
    
    let indicators = JXSegmentedIndicatorLineView()
    indicators.indicatorColor = Color.textOfDeep
    indicators.indicatorWidth = 25
    indicators.indicatorHeight = 2
    indicators.verticalOffset = 5
    segmentedView.indicators = [indicators]
    
    view.addSubview(segmentedView)
    segmentedView.layout.add { (make) in
      make.top().equal(navigationView).bottom()
      make.leading().trailing().equal(view)
      make.height(44)
    }
    
    let lineView = UIView()
    lineView.backgroundColor = Color.grayBackground
    view.addSubview(lineView)
    lineView.layout.add { (make) in
      make.top().equal(segmentedView).bottom()
      make.leading().trailing().equal(view)
      make.height(1)
    }
    
    view.addSubview(pageView)
    pageView.layout.add { (make) in
      make.top().equal(lineView).bottom()
      make.leading().trailing().equal(view)
      make.bottom().equal(view).safeBottom()
    }
    
  }
  
  func updateUI() {
    
  }
  
}

// MARK: - Action
private extension MyCourseViewController {
 
  @objc func clickEdit(_ sender: UIButton) {
    
    let viewController = HistoryEditViewController()
    Presenter.push(viewController)
    
  }
  
}

// MARK: - Utiltiy
private extension MyCourseViewController {
  
}

extension MyCourseViewController: JXSegmentedListContainerViewDataSource {
  
  func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
    return segmentedDataSource.titles.count
  }
  
  func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
    if index == 0 {
      return allCourseListView.jxListView
    }
    if index == 1 {
      return salesCourseListView.jxListView
    }
    if index == 2 {
      return removeCourseListView.jxListView
    }
    if index == 3 {
      return reviewingCourseListView.jxListView
    }
    if index == 4 {
      return rejectCourseListView.jxListView
    }
    return allCourseListView.jxListView
    
  }
  
}

