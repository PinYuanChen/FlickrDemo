//
//  SearchViewController.swift
//  FlickrDemo
//
//  Created by 陳品元 on 2020/4/13.
//  Copyright © 2020 ChenPinYuan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tfKeyword: UITextField!
    @IBOutlet weak var tfPerPageNum: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tfKeyword.placeholder = "欲搜尋內容"
        tfPerPageNum.placeholder = "每頁呈現數量"
        tfKeyword.delegate = self
        tfPerPageNum.delegate = self
        tfKeyword.becomeFirstResponder()
        btnSearch.setTitle("搜尋", for: .normal)
        btnSearch.isUserInteractionEnabled = false
    }
    
    func dismissKeyBoard() {
        self.view.endEditing(false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyBoard()
    }
    
    @IBAction func didPressedSearchBtn(_ sender: Any) {
        print("press")
    }
}

extension SearchViewController: UITextFieldDelegate {
   //https://stackoverflow.com/questions/34941069/enable-a-button-in-swift-only-if-all-text-fields-have-been-filled-out
}
