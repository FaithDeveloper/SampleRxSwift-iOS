//
//  ViewController.swift
//  RxSwiftSutdy
//
//  Created by 신규찬 on 2018. 5. 2..
//  Copyright © 2018년 kcs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let emilEmptyObserve = emailTextField.rx.text
            .map{
                $0?.isEmpty
            }
//        // emailEmptyObserve을 설정할 때 주석을 풀면 됩니다. 필드의 값이 없으면 빨강색을 배경색으로 세팅합니다.
//            .subscribe(onNext: {
//                self.emailTextField.backgroundColor = $0! ? UIColor.red : UIColor.white
//            }, onError: nil, onCompleted: nil, onDisposed: nil)
        let passwordEmptyObser = passwordTextField.rx.text
            .map{
                $0?.isEmpty
            }
        let _ = Observable
            .combineLatest(emilEmptyObserve, passwordEmptyObser) {
            return ($0, $1)
            }
            .subscribe(onNext: { (tuple) in
                //tuple로 위에 정의한 observe 값을 기준으로 비교하여 설정합니다.
                let buttonTitle: String = {
                    switch tuple {
                    case (true, true):
                        return "이메일/패스워드를 입력하세요."
                    case (true, _):
                        return "이메일을 입력하세요"
                    case (_, true):
                        return "패스워드를 입력하세요"
                    default:
                        return "로그인하기"
                    }
                }()
                self.registerButton.setTitle(buttonTitle, for: .normal)
                self.registerButton.backgroundColor = tuple.0! || tuple.1! ? UIColor.gray : UIColor.blue
            }, onError: nil, onCompleted: nil, onDisposed: {print("onDisposed")})
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

