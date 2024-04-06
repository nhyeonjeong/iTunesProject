//
//  BaseViewController.swift
//  iTunes
//
//  Created by 남현정 on 2024/04/06.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function) // self는 컨트롤러 인스턴스
        view.backgroundColor = .white

    }
    
}
