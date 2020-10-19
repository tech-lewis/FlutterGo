//
//  BuildingInfoItem.swift
//  IntellectiveTrainingPlatform
//
//  Created by mark on 2020/10/17.
//
import ApplicationKit
import JSONKit
// 宿舍楼的信息
struct DataItem: ItemListable {
	var id: String?
	
	/// 宿舍楼的名字
	var name: String?
	
	/// 实际到达的人数
	var actualCount: Int? = 0
	
	/// 应该到达的人数
	var count: Int? = 0
	
	var createTime: String?
	
	init(list json: JSON) {
		self.id = json[""]
		self.name = json[""]
		self.actualCount = json[""]
		self.count = json[""]
		self.createTime = json[""]
	}
}

// PackageModel??
// CONFIRM TableCellItemUpdatable