//
//  ListViewController.swift
//  IntellectiveTrainingPlatform
//  带有HeaderView表头的空白列表 有上拉下拉刷新
//  Created by mac on 12.10.20.
//
import UIKit
import ApplicationKit
class ListViewController: UIViewController {
	let server = TableServer()
	let filterController = DormitoryBuildingFilterController()
	private let contentView = UIView() //headerView相关的
	private let leftView = UIView()
	private let rightView = UIView()
	private let leftCornerImageView = UIImageView()
	private let rightCornerImageView = UIImageView()
	private let leftLabel = UILabel()
	private let rightLabel = UILabel()
	private let backgroundView = UIImageView()
	
	// dataModel
	private var dataModel = ListDataModel<DormitoryBuildingInfoItem>()
	//headerView update
	private var actualCheckInCountLabel: UILabel? = nil
	/// 今日应到人数显示的Label
	private var absentCheckInCountLabel: UILabel? = nil
	override func viewDidLoad()
	{
			super.viewDidLoad()
			setupUI()
			// Do any additional setup after loading the view.
			//updateUI()
		
			setupListView(autoLoad: true, canRefresh: true, canLoadMore: true, hasLoadingView: true)
	}
}


extension ListViewController: ViewControllerListable {
	// 加载网络数据
	var listController: UIViewController { return self }
	 
	 var listView: UIScrollView { return self.server.tableView }
	 // 处理分页的情况
	 var listDataModel: DataModelListable { return self.dataModel }
	 
	 func loadData(_ isNext: Bool, completion handle: @escaping () -> Void) {
		 // 加载数据
		 var parameters = self.dataModel.parameters(isNext)
		#warning("修改参数")
		parameters["platform"] = "3" //iOS 平台固定
		API.dormitoryList.query(parameters).headerField(API.tokenParameters).request { (res) in
			// response
			self.dataModel.update(with: res["data"])
			self.updateUI()
			handle()
		}
		
	}
}
/// Setup
extension ListViewController {
	func setupUI() {
		view.backgroundColor = Color.rgb(r: 248, g: 248, b: 248)
		// navBar
		navigationView.setup(title: "宿舍签到统计")
		navigationView.addRight(image: "nav_filter", target: self, action: #selector(clickFilter))
//    navigationView.setContentHeight(88)
		navigationView.showBack()
		//设置
		server.isDeselectAutomatically = false
		let emptyView = EmptyContentView(style: .default)
		//emptyView.offsetY = -150
		emptyView.backgroundColor = Color.background
		server.emptyContentView = emptyView
		//server.emptyContentView = CourseListEmptyView.createView()
		
		/*
		如果list列表包含选择某一项的操作（如支付方法的选择）必须用到这个属性
		但是push列表跳转一定要保证server.isDeselectAutomatically为false，让列表能正常跳转到详情页面
		*/
		// server.isDeselectAutomatically
		server.tableView.backgroundColor = .white
		server.tableView.showsVerticalScrollIndicator = false
		server.tableView.separatorStyle = .none
		server.tableView.separatorColor = Color.grayBackground
		server.tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
		view.addSubview(server.tableView)
		server.tableView.layout.add { (make) in
			make.top(App.shared.navigationBar.height+App.shared.statusBar.height).leading().trailing().bottom().equal(view)
		}
		#warning("判断当前的角色 是否为部门管理人员")
		//guard User.current.client == .teacher else {return}
		 guard ShortcutManager.shared.currentRole.markName == .department else {return}
		server.tableView.tableHeaderView = setupHeaderUI()
	}
	func setupHeaderUI() -> UIView {
		let headerView = UIView(frame: CGRect(x: 0, y: 0, width: App.shared.screen.width, height: 125))
		contentView.backgroundColor = Color.background
		contentView.frame = CGRect(x: 0, y: 0, width: App.shared.screen.width, height: 120)
		headerView.addSubview(contentView)

		let space: CGFloat = 9.0
		let margin: CGFloat = 15.0
		leftView.backgroundColor = .white
		leftView.clipsToBounds = true
		leftView.layer.cornerRadius = 5.0
		contentView.addSubview(leftView)
		leftView.layout.add { (make) in
			make.height(90)
			make.width((App.shared.screen.width-space-margin*2.0)*0.5)
			make.top(15).leading(15).equal(contentView)
		}
		
		leftCornerImageView.contentMode = .scaleToFill
		leftCornerImageView.image = UIImage(named: "checkin_corner_l")
		leftView.addSubview(leftCornerImageView)
		leftCornerImageView.layout.add { (make) in
			make.width(45).height(50)
			make.bottom(5).trailing(-8).equal(leftView)
		}
		
		actualCheckInCountLabel = leftLabel
		leftLabel.textAlignment = .left
		leftLabel.textColor = Color.rgb(r: 56, g: 62, b: 90)
		leftLabel.font = Font.dinProBold(30)
		leftView.addSubview(leftLabel)
		leftLabel.layout.add { (make) in
			make.top(15).leading(15).equal(leftView)
		}

		let leftHintLabel = UILabel()
		leftHintLabel.text = "今日实到人数"
		leftHintLabel.font = Font.pingFangSCMedium(12)
		leftHintLabel.textColor = Color.textLightGray
		leftHintLabel.textAlignment = .left
		leftView.addSubview(leftHintLabel)
		leftHintLabel.layout.add { (make) in
			make.left(15.0).equal(leftView)
			make.top(5).equal(leftLabel).bottom()
		}

		rightView.backgroundColor = .white
		rightView.clipsToBounds = true
		rightView.layer.cornerRadius = 5.0
		contentView.addSubview(rightView)
		rightView.layout.add { (make) in
			make.height(90)
			make.width((App.shared.screen.width-space-margin*2.0)*0.5)
			make.top(15).trailing(-15).equal(contentView)
		}

		rightCornerImageView.contentMode = .scaleToFill
		rightCornerImageView.image = UIImage(named: "checkin_corner_r")
		rightView.addSubview(rightCornerImageView)
		rightCornerImageView.layout.add { (make) in
			make.width(45).height(50)
			make.bottom(5).trailing(-8).equal(rightView)
		}
		absentCheckInCountLabel = rightLabel
		rightLabel.textAlignment = .left
		rightLabel.textColor = Color.rgb(r: 56, g: 62, b: 90)
		rightLabel.font = Font.dinProBold(30)
		rightView.addSubview(rightLabel)
		rightLabel.layout.add { (make) in
			make.top(15).leading(15).equal(rightView)
		}
		
		let rightHintLabel = UILabel()
		rightHintLabel.text = "今日应到人数"
		rightHintLabel.font = Font.pingFangSCMedium(12)
		rightHintLabel.textColor = Color.textLightGray
		rightHintLabel.textAlignment = .left
		rightView.addSubview(rightHintLabel)
		rightHintLabel.layout.add { (make) in
			make.left(15.0).equal(rightView)
			make.top(5).equal(rightLabel).bottom()
		}
		
		
		
		
		
		return headerView
	}
	
	// 更新头部的数据
	func updateHeaderUI(count: Int, absentCount: Int) {
		guard actualCheckInCountLabel != nil, absentCheckInCountLabel != nil else { return }
		// 都存在的时候设置人数
		actualCheckInCountLabel?.text = "\(count)"
		absentCheckInCountLabel?.text = "\(absentCount)"
	}
	func updateUI() {
		// 更新头部的数据
		updateHeaderUI(count: 10, absentCount: 100)
		
		// 更新网络数据
		let indexCell = ReuseItem(DormitoryInfoCell.self)
		var groups: [TableSectionGroup] = []
		var group = TableSectionGroup()
		let dormitoryData = self.dataModel.list
		let dormitoryNames = ["宿舍楼1", "宿舍楼2", "宿舍楼3", "宿舍楼4", "宿舍楼5", "宿舍楼6", "宿舍楼7", "宿舍楼8"]
		dormitoryNames.enumerated().forEach { (index, value) in
			group.items.append(TableCellItem(indexCell, data: value, accessoryData: value, selected: {
				// 按下跳转详情
				let detailVC = DormitoryDataStatisticsDetailViewController()
//        detailVC.title = dormitoryNames[index]
				detailVC.navigationView.setup(title: value, backgroundColor: .white)
				detailVC.navigationView.showBack()
				Presenter.push(detailVC)
			}))
		}

		//groups.append(group)
		server.update(groups)
		
		
	}
}
extension ListViewController {
	//  Action
	@objc func clickFilter() {
		//filterController.show()
		let s = DismissDemoViewController()
		s.soureViewControllerHandleBlock = {[weak self] in
			//
			Presenter.push(UITableViewController())
		}
		
		let nav = UINavigationController(rootViewController: s)
		nav.modalPresentationStyle = .custom
		Presenter.present(nav)
		
	}
}

extension ListViewController {
	
}