
// MARK: - Setup
private extension LessonPackageListViewController {
  
  func setupUI() {
    
    navigationView.isHidden = true
    
    view.backgroundColor = Color.background
    
    server.emptyContentView = EmptyView.create()
    server.tableView.showsVerticalScrollIndicator = false
    server.tableView.backgroundColor = Color.background
    server.tableView.separatorStyle = .none
    view.addSubview(server.tableView)
    server.tableView.layout.add { (make) in
      make.leading().top().trailing().equal(view)
      make.bottom().equal(view).safeBottom()
    }
    
  }
  
  func updateUI() {
   
    let statusCell = ReuseItem(StatusCell.self)
    let textCell = ReuseItem(TextCell.self)
    let spaceCell = ReuseItem(TableSpaceCell.self)
    let opeartionCell = ReuseItem(OperationCell.self)
    let progressCell = ReuseItem(ProgressCell.self)
    
    var groups: [TableSectionGroup] = []
    
    (0...5).forEach { (index) in
      
      var group = TableSectionGroup()
      group.header.height = 15
      group.items.append(TableCellItem(statusCell, selected: {
        
        let viewController = LessonPackageDetailViewController()
        Presenter.push(viewController)
        
      }))
      
      group.items.append(TableCellItem(progressCell, selected: {
        
        let viewController = LessonPackageDetailViewController()
        Presenter.push(viewController)
        
      }))
      group.items.append(TableCellItem(textCell, data: LessonPackageListViewController.TextCell.DataModel(title: "课时包类型", content: "试听课"), selected: {
        
        let viewController = LessonPackageDetailViewController()
        Presenter.push(viewController)
        
      }))
      group.items.append(TableCellItem(textCell, data: LessonPackageListViewController.TextCell.DataModel(title: "课时包课数", content: "1课时"), selected: {
        
        let viewController = LessonPackageDetailViewController()
        Presenter.push(viewController)
        
      }))
      group.items.append(TableCellItem(textCell, data: LessonPackageListViewController.TextCell.DataModel(title: "课时包价格", contentAttributed: NSAttributedString(string: String(format: "¥%.2f", 9.9), attributes: [NSAttributedString.Key.foregroundColor: Color.textOfRed])), selected: {
        
        let viewController = LessonPackageDetailViewController()
        Presenter.push(viewController)
        
      }))
      
      if index % 2 == 0 {
        
        group.items.append(TableCellItem(opeartionCell, selected: {
          
          let viewController = LessonPackageDetailViewController()
          Presenter.push(viewController)
          
        }))
        
      }else {
      
        group.items.append(TableCellItem(spaceCell, data: TableSpaceCellItem(backgroundColor: Color.background, spaceColor: .white, spaceHeight: 10, spaceInsets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15), corners: [.bottomLeft, .bottomRight], cornerSize: CGSize(width: 5, height: 5))))
        
      }
      
      groups.append(group)
      
    }
    
    server.update(groups)
    
  }
  
}
