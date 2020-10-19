//
//  PackageDataModel.swift
//


import JSONKit

class PackageDataModel {
	//BalanceItem
	var balanceItems: [RechargeItem] = []
	var jsonArray: [JSON] = []
	var currentSelected: Int? = 0
	
	func update(with json:JSON) {
		self.balanceItems = json["packages"].map({ RechargeItem(list: $0.json) })
		self.jsonArray = json["packages"].map({ $0.json })
	}
}

//
//  RechargeItem.swift
//  HappyOnigiri
//
//  Created by Willima Lee on 11/07/2017.



import ApplicationKit
import JSONKit

struct RechargeItem: ItemListable {
	
	/// 充值产品ID
	public var id: Int? = 0
	/// 产品类型
	public var productID: String?
	/// 价格
	public var price: Double = 0
	/// iOS显示的值
	public var iosvalue: Int?
	/// 数量
	public var count: Int = 0
	/// 赠送的数量
	public var exCount: Int = 0
	/// 是否是首充
	public var isFirst: Bool = true
	
	init() {}
	
	init(list json: JSON) {
		
		self.price = json["price"] ?? 0.0
		//self.productID = json[""] // 产品ID
		self.iosvalue = json["iosvalue"]
		self.id = json["id"] ?? 0
	}
	
	
}
