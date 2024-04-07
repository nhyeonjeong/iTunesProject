//
//  DetailViewController.swift
//  iTunes
//
//  Created by 남현정 on 2024/04/08.
//

import UIKit

final class DetailViewController: BaseViewController {

    var musicData: Music? = nil
    
    private let mainView = DetailView()
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
}
extension DetailViewController {
    private func configureView() {
        print(#function)
        guard let data = musicData else {
            return
        }
        mainView.upgradeView(data)
        
    }
}
