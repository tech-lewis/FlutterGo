//
//  ModifyPaymentPasswordConfirmViewController.swift
//
//  XueGuanYi

import UIKit
import ApplicationKit
class ModifyPaymentPasswordConfirmViewController: UIViewController {
  enum uiType {
    case smsView
    case settingView
    case confirmView
  }
//  private let confirmButton = UIButton(type: .custom)
  
  private let headerTitleLabel = UILabel()
  private let tipsTextLabel = UILabel()
  public  var currentSmsCode: String? = nil
//  public var step: uiType? = .settingView
  public var firstInputPasscode: String?
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupUI()
    self.updateUI()
  }
}


private extension ModifyPaymentPasswordConfirmViewController {

  func updateUI() {
    headerTitleLabel.text = "请再次输入，以确认密码"
    tipsTextLabel.text = ""
    //DebugLog("第一次设置的密码为\(self.firstInputPasscode)")
    
  }
  @objc func clickConfirm(_ sender: Any) {
    
    self.view.endEditing(true)
    
//    guard Tips.judg(currentPassword: self.currentInputView.content) else { return }
//    guard Tips.judg(newPassword: self.newInputView.content) else { return }
//
//    var paramter: [String : Any] = [:]
//    paramter["oldPassword"] = self.currentInputView.content?.md5
//    paramter["newPassword"] = self.newInputView.content?.md5
  }
}

private extension ModifyPaymentPasswordConfirmViewController {
  
  func setupUI() {
    
    self.view.backgroundColor = .white
    self.navigationView.setup(title: "支付设置")
    self.navigationView.showBack()
    var width:CGFloat = App.shared.screen.width-30.0
    
    let payPassWordView = ModifyPaymentPasswordConfirmViewController.payPasscodeView(frame: CGRect(x: 0, y: 0, width: width, height: 50))
    payPassWordView.firstPassword = firstInputPasscode
    payPassWordView.updataUI()
    payPassWordView.borderColor = .gray
    payPassWordView.starColor   = Color.textOfBlack
    payPassWordView.input()
    if let code = currentSmsCode {
      payPassWordView.currentSmsCode = code
    }

    
    
    // header titleLabel
    headerTitleLabel.textColor = Color.textOfBlack
    headerTitleLabel.textAlignment = .center
    headerTitleLabel.font = Font.pingFangSCSemibold(23)
    view.addSubview(headerTitleLabel)
    headerTitleLabel.layout.add { (make) in
      make.centerX().top(89+App.shared.navigationBar.maxY).equal(self.view)
    }
    let inputView = UIView()
    inputView.backgroundColor = .white
    self.view.addSubview(inputView)
    inputView.layout.add { (make) in
      make.width(301).height(50)
      make.centerX().equal(view)
      make.top(58).equal(headerTitleLabel).bottom()
    }
    inputView.addSubview(payPassWordView)
    
    
    tipsTextLabel.textColor = Color.textOfBlack
    tipsTextLabel.textAlignment = .center
    tipsTextLabel.font = Font.pingFangSCSemibold(14)
    view.addSubview(tipsTextLabel)
    tipsTextLabel.layout.add { (make) in
      make.centerX().top(15).equal(self.headerTitleLabel)
    }
  }
  
}
// PaypasswordView
extension ModifyPaymentPasswordConfirmViewController {
  class payPasscodeView: UIView {
      private var lenght:Int = 6 {
          didSet{
              updataUI()
          }
      }
      var currentSmsCode: String?
      private var star: String = "●"
      public var starColor: UIColor = UIColor.cyan {
          didSet {
              squareArray.forEach { (label) in
                  label.textColor = starColor
              }
          }
      }
      
      public var borderColor: UIColor = UIColor.black {
          didSet {
              squareArray.forEach { (label) in
  //                label.layer.borderColor = borderColor.cgColor
              }
          }
      }
      
      public var borderWidth: CGFloat = 1 {
          didSet {
              squareArray.forEach { (label) in
  //                label.layer.borderWidth = borderWidth
  //                label.layer.masksToBounds = borderWidth > 0
              }
              
          }
      }
      
      var side:       CGFloat!
      
      var password:   String = ""
      
      var squareArray = [UILabel]()
      
      var space:      CGFloat!
      
      var textField:  UITextField = UITextField()
      var firstPassword: String?
      
      var tempArrat   = [String]()
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          updataUI()
      }
      
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          updataUI()
      }
      
      //weak var delegate: payPasscodeViewDelegate?
      
      func updataUI(){
          for view in self.subviews{
              view.removeFromSuperview()
          }
          side  = self.frame.height
          space = (self.frame.width - (CGFloat(lenght) * side)) / CGFloat(lenght - 1)
          for index in 0..<lenght{
            
            var width:CGFloat = App.shared.screen.width-30.0
            width = width/6
            
            let label = UILabel(frame: CGRect(x: (side) * CGFloat(index) , y: 0, width: width, height: side))
            label.layer.masksToBounds = true
            label.textAlignment = .center
            //label.layer.borderColor = UIColor.gray.cgColor
  //          label.layer.borderWidth = 1
            
            let borderColor = UIColor.gray
            if index == 0 {
              label.rightBorder(width: 1.0, borderColor: borderColor)
              label.leftBorder(width: 1.0, borderColor: borderColor)
              label.topBorder(width: 1.0, borderColor: borderColor)
              label.bottomBorder(width: 1.0, borderColor: borderColor)
            }
            else if index > 0 {
              label.rightBorder(width: 1.0, borderColor: borderColor)
              label.topBorder(width: 1.0, borderColor: borderColor)
              label.bottomBorder(width: 1.0, borderColor: borderColor)

            }
            squareArray.append(label)
            //squareArray.last?.rightBorder(width: 1.0, borderColor: borderColor)
          }
          for square in squareArray {
              self.addSubview(square)
          }
          
          textField.keyboardType = .numberPad
          textField.delegate = self
          self.addSubview(textField)
      }
      
      func input() {
          textField.becomeFirstResponder()
      }
      
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          textField.becomeFirstResponder()
      }
  }
}

extension ModifyPaymentPasswordConfirmViewController.payPasscodeView:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        password = ""
        squareArray.forEach { (label) in
            label.text = ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        /// 处理删除逻辑
        if string == "" {
            if password == ""{/// 密码已经为空
                return true
            }else if password.count == 1{
                password = ""
            }else{
                password = String(password[..<password.index(password.endIndex, offsetBy: -1)])
            }
        }else{
            password += string
        }
        
        /// 填充密码框
        for index in 0..<squareArray.count{
            
            if index < password.count {
                squareArray[index].text = "●"
            }else{
                squareArray[index].text = ""
            }
            
        }
        /// 完成输入
        if password.count >= lenght {
          textField.resignFirstResponder()
          textField.text = password
          // entryComplete password
          if let code = firstPassword {
            if password.isEqual(code) == false {
              Presenter.currentPresentedController?.hud.showMessage(message: "两次密码设置不一致")
            } else {
              DebugLog("11111+\(code)+++++++\(currentSmsCode)")
            }
          }
          if let str = firstPassword, let code = currentSmsCode {
            if password.isEqual(str) {
              // 相同设置密码
              #warning("setting")
              
              var parameters = ["payPassword": password.md5]
              parameters["mobileCode"] = code
              API.modifyPayPassword.body(parameters).headerField(API.tokenParameters).request { (response) in
                //res
                //guard
                guard response["result"] != 1 else {
                  return
                }
                Presenter.currentPresentedController?.hud.showMessage(message: "修改成功")
              }
            } else {
              Presenter.currentPresentedController?.hud.showMessage(message: "两次密码设置不一致")
            }
          }
          self.endEditing(true)
          return false
        }
        
        return true
    }
}
