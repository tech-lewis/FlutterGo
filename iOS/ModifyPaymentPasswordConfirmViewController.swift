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

// push --> modal
import UIKit
import ApplicationKit
class PaymentPaypasswordSmsAuthViewController: UIViewController, SPayPassWordViewDelegate {
  func entryComplete(password: String) {
    // 完成输入 检查验证码是否正确
    if let phoneNumber = User.current.phoneNumber {
      var params = ["mobile": phoneNumber]
      params["code"] = password
      API.checkPaymentPasswordSmsAuth.query(params).headerField(API.tokenParameters).request { (res) in
        //response
        //self.hud.showMessage(message: res["msg"])
        let isCheckSmsCode:Bool = res["data"]["flag"] ?? false
        print(isCheckSmsCode)
        if isCheckSmsCode == false {
          self.hud.showMessage(message: "错误的验证码")
        }
        guard isCheckSmsCode == true else {
          //self.hud.showMessage(message: "错误的验证码")
          return
        }
        // 允许发送短信 跳转修改
        ////Presenter.push(CoursePaySuccessViewController())
          let vc = SettingPaymentPasswordViewController() //重设支付密码的界面
          vc.currentSmsCode = password
        #warning("Presenter的问题")
        if self.course != nil {
          vc.soureViewControllerHandleBlock = {[weak self] in
            let successController = CoursePaySuccessViewController()
            successController.course = self?.course
            Presenter.push(successController)
          }
        } else {
          guard let viewController = Presenter.currentNavigationController?.viewControllers.first(where: { $0.isKind(of: SettingViewController.self) }) else {
            Presenter.pop()
            return
          }
          // 跳转回设置页面
          Presenter.pop(to: viewController)
        }
          
        vc.modalPresentationStyle = .fullScreen
        Presenter.present(vc)
        
      }
    }
  }
  
  // 当前课程
  public  var course: CourseItem?
//  private let confirmButton = UIButton(type: .custom)
  private let sendSmsButton = UIButton()
  private let topLabel = UILabel()
  private var payView: SPayPassWordView?
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
    self.updateUI()
  }
}

//extension ModifyPasswordViewController: SPayPassWordViewDelegate{
//  //  func entryComplete() {}
//}

private extension PaymentPaypasswordSmsAuthViewController {

  @objc func clickModifyPwdButton(_ sender: UIButton) {
    var time = 60
    let codeTimer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
    codeTimer.schedule(deadline: .now(), repeating: .milliseconds(1000))
    codeTimer.setEventHandler {
        time = time - 1
        DispatchQueue.main.async {
          sender.isEnabled = false
        }
        if time < 0 {
            codeTimer.cancel()
            DispatchQueue.main.async {
                sender.isEnabled = true
                sender.setTitle("重新发送", for: .normal)
            }
            return
        }
        
        DispatchQueue.main.async {
            sender.setTitle("\(time)S", for: .normal)
        }
        
    }
    
    if #available(iOS 10.0, *) {
      codeTimer.activate()
    } else {
      // Fallback on earlier versions
      codeTimer.resume()
    }

    
    
    if let phoneNumber = User.current.phoneNumber {
      let params = ["mobile": phoneNumber]
      API.sendChangePaymentPasswordSmsCode.query(params).headerField(API.tokenParameters).request { (res) in
        //response
        guard res["result"] == 1 else { return }
        // 发送短信成功
      }
    }
  }
  @objc func clickConfirm(_ sender: Any) {
    
    self.view.endEditing(true)
    
//    guard Tips.judg(currentPassword: self.currentInputView.content) else { return }
//    guard Tips.judg(newPassword: self.newInputView.content) else { return }
//
//    var paramter: [String : Any] = [:]
//    paramter["oldPassword"] = self.currentInputView.content?.md5
//    paramter["newPassword"] = self.newInputView.content?.md5
//    var parm: [String: String] = ["platform": "3"]
//    API.checkPaymentBalance.query(parm).headerField(API.tokenParameters).request { (res) in
//      print("当前帐号余额明细\(res)");
//    }
  }
}

private extension PaymentPaypasswordSmsAuthViewController {
  func updateUI() {
    
    if let phoneNumber = User.current.phoneNumber {
      topLabel.text = "验证码将发送到您的手机号\n\(phoneNumber)"
    }
    
  }
  
  func setupUI() {
    self.view.backgroundColor = .white
    self.navigationView.setup(title: "支付设置")
    self.navigationView.showBack()
    let payPassWordView = SPayPassWordView(frame: CGRect(x: 0, y: 0, width: 220, height: 55))
    payPassWordView.lenght = 4
    payPassWordView.borderColor = Color.rgb(r: 219, g: 219, b: 219)
    payPassWordView.borderRadius = 10
    payPassWordView.starColor   = Color.black
    payPassWordView.input()
    payPassWordView.delegate = self
    self.payView = payPassWordView
    topLabel.textAlignment = .center
    topLabel.textColor = Color.black
    topLabel.numberOfLines = 2
    topLabel.font = Font.pingFangSCSemibold(17)
    view.addSubview(topLabel)
    topLabel.layout.add { (make) in
      make.centerX().equal(view)
      make.hugging(axis: .vertical)
      make.centerX().top(89+App.shared.navigationBar.maxY).equal(view)
    }
    
    let inputView = UIView()
    inputView.backgroundColor = .white
    self.view.addSubview(inputView)
    inputView.layout.add { (make) in
      make.width(221).height(55)
      make.centerX().equal(view)
      make.top(267).equal(view)
    }
    
    inputView.addSubview(payPassWordView)
    sendSmsButton.setTitle("发送验证码", for: .normal)
    sendSmsButton.setTitleColor(Color.textOfBlue, for: .normal)
    sendSmsButton.titleLabel?.font = Font.pingFangSCMedium(15)
    sendSmsButton.layer.masksToBounds = true
    sendSmsButton.layer.cornerRadius = 17
    sendSmsButton.layer.borderWidth = 1.0
    sendSmsButton.addTarget(self, action: #selector(clickModifyPwdButton(_:)), for: .touchDown)
    sendSmsButton.layer.borderColor = Color.textOfBlue.cgColor
    view.addSubview(sendSmsButton)
    sendSmsButton.layout.add { (make) in
      make.width(100).height(34)
      make.trailing(8).top(15+55).equal(inputView)
    }
    
//    self.confirmButton.setBackgroundImage(UIImage(named: "mine_shadow_button_bg"), for: .normal)
//    self.confirmButton.setBackgroundImage(UIImage(named: "mine_shadow_button_bg"), for: .highlighted)
//    self.confirmButton.setTitle("", for: .normal)
//    self.confirmButton.setTitleColor(.white, for: .normal)
//    self.confirmButton.titleLabel?.font = Font.system(16, isBold: true)
//    self.confirmButton.addTarget(self, action: #selector(clickConfirm(_:)), for: .touchUpInside)
//    self.view.addSubview(self.confirmButton)
//
//    self.confirmButton.layout.add { (make) in
//      make.top(100).equal(inputView).bottom()
//      make.leading(-3).trailing(3).equal(view)
//    }
  }
}


// 密码设置页面的逻辑处理 设置完毕
if let phoneNumber = User.current.phoneNumber {
  var params = ["mobile": phoneNumber]
  params["code"] = password
  API.checkPaymentPasswordSmsAuth.query(params).headerField(API.tokenParameters).request { (res) in
    //response
    //self.hud.showMessage(message: res["msg"])
    let isCheckSmsCode:Bool = res["data"]["flag"] ?? false
    print(isCheckSmsCode)
    if isCheckSmsCode == false {
      self.hud.showMessage(message: "错误的验证码")
    }
    guard isCheckSmsCode == true else {
      //self.hud.showMessage(message: "错误的验证码")
      return
    }
    // 允许发送短信 跳转修改
    ////Presenter.push(CoursePaySuccessViewController())
      let vc = SettingPaymentPasswordViewController() //重设支付密码的界面
      vc.currentSmsCode = password
    #warning("Presenter的问题")
    if self.course != nil {
      vc.soureViewControllerHandleBlock = {[weak self] in
        let successController = CoursePaySuccessViewController()
        successController.course = self?.course
        Presenter.push(successController)
      }
    } else {
      guard let viewController = Presenter.currentNavigationController?.viewControllers.first(where: { $0.isKind(of: SettingViewController.self) }) else {
        Presenter.pop()
        return
      }
      // 跳转回设置页面
      Presenter.pop(to: viewController)
    }
      
    vc.modalPresentationStyle = .fullScreen
    Presenter.present(vc)
    
  }
}

