//
//  PaymentBalanceViewController.swift
//  XueGuanYi
//
//  Created by mark on 2020/10/14.
//  Copyright © 2020 广州飞进信息科技有限公司. All rights reserved.
//
import ApplicationKit
typealias  FinshSelectBlock = (_ packageId: Int) ->Void
class PaymentBalanceViewController: UIViewController {
	private let server = TableServer()
	private var dataModel = PackageDataModel()
	private let tableFooterView = UIView()
	private var currentPackageId: Int? = nil
	private let titleLabel = UILabel() // 底部标题label
	private let priceLaebl = UILabel() // 底部价格标签
	private let payButton = GradientButton(type: .custom)
	private let bottomView = BottomContainerView()
	private var payMethod: Payment.Method?
	private var selectPackageId: Int?
	private var selectBlock: FinshSelectBlock?
	//private let agreementView = RegisterAgreementCheckView()
	override func viewDidLoad() {
		super.viewDidLoad()
	 
		setupUI()
		loadData()
		
		
	}
	
	
	
	func loadData() {
			updateUI()
	}
}

// MARK: - Public
extension PaymentBalanceViewController {
	
}

// MARK: - Setup
private extension PaymentBalanceViewController {
	
	func setupUI() {
		
		navigationView.setup(title: "我的账户")
		navigationView.showBack()
		navigationView.addRight(title: "余额明细", target: self, action: #selector(clickCheckBalance))
		
		view.backgroundColor = .white
		
		server.tableView.showsVerticalScrollIndicator = false
		server.tableView.backgroundColor = Color.white
		server.tableView.separatorStyle = .none
//    server.tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
		server.isDeselectAutomatically = false
		view.addSubview(server.tableView)
		server.tableView.layout.add { (make) in
			make.top().equal(navigationView).bottom()
			make.leading().trailing().equal(view)
		}
		
		
		view.addSubview(bottomView)
		bottomView.backgroundColor = Color.background
		bottomView.layout.add { (make) in
			make.top().equal(server.tableView).bottom()
			make.leading().bottom().trailing().equal(view)
		}
		
		payButton.setTitle("确认充值", for: .normal)
		payButton.setTitleColor(.white, for: .normal)
		payButton.titleLabel?.font = Font.pingFangSCSemibold(15)
		payButton.addTarget(self, action: #selector(clickPay), for: .touchUpInside)
		bottomView.contentView.addSubview(payButton)
		payButton.layout.add { (make) in
			make.leading().top().bottom().trailing().equal(bottomView.contentView)
			make.height(49)
		}
	}
	
	func updateUI() {
		//priceLaebl.text = "￥11111111111"
		//    footerView.frame = 240)
		selectBlock = {[weak self] (packageID) in
			//当前选择DebugLog(self?.currentPackageId)
			//DebugLog("当前\(self) 选择套餐\(packageID)")
			self?.currentPackageId = packageID
			
		}
		let priceCell = ReuseItem(PaymentBalanceDetailHeaderCell.self)
		let textCell = ReuseItem(PaymentBalancePackageTitleCell.self)
		// 在这里写一个CollectionView
		let sudokuCell = ReuseItem(PaymentBalanceDetailPriceSelectionViewCell.self)
		let noticeTextCell = ReuseItem(PaymentBalanceTableFooterView.self)
		var group = TableSectionGroup()
		group.items.append(TableCellItem(priceCell))
		group.items.append(TableCellItem(textCell, data: createTitleItem()))
		group.items.append(TableCellItem(sudokuCell, data: self.dataModel.balanceItems, accessoryData: selectBlock))
//    group.items.append(TableCellItem(textCell, data: createTitleItemRemarked()))
		group.items.append(TableCellItem(noticeTextCell))
		server.update([group])
		
	}
	
	func createTitleItem() -> LeftAndRightTextViewItem {
		var item = LeftAndRightTextViewItem()
		item.leftFont = Font.pingFangSCSemibold(15)
		item.leftColor = Color.textOfDeep
		item.leftText = "充值"
		item.leftInsets.bottom = 10
		return item
	}
	
	func createTitleItemRemarked() -> LeftAndRightTextViewItem {
		
		var item = LeftAndRightTextViewItem()
		item.leftFont = Font.pingFangSCSemibold(15)
		item.leftColor = Color.textOfDeep
		item.leftText = "充值说明："
		item.leftInsets.bottom = 10

		return item
	}
}

// MARK: - Action
private extension PaymentBalanceViewController {
 
	@objc func clickPay(_ sender: UIButton) {
		// let viewController = CoursePaySuccessViewController()
		// Presenter.push(viewController)
		// 当前选择了套餐ID
		guard self.currentPackageId != nil else {
			self.hud.showMessage(message: "请选择一个充值套餐")
			return
		}

		
		
		
		
	}
	@objc func clickCheckBalance() {
		Presenter.push(PaymentBalanceRecordsDetailViewController())
//    Presenter.push(SettingPaymentPasswordViewController())
	}
	
}

// MARK: - Utiltiy
private extension PaymentBalanceViewController {
	
}
