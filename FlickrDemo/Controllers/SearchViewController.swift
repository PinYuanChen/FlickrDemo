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
        [tfKeyword, tfPerPageNum].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
    }
    
    func setupUI() {
        self.title = "搜尋輸入頁"
        tfKeyword.placeholder = "欲搜尋內容"
        tfPerPageNum.placeholder = "每頁呈現數量"
        tfKeyword.becomeFirstResponder()
        btnSearch.setTitle("搜尋", for: .normal)
        setBtn(false)
    }
    
    func dismissKeyBoard() {
        self.view.endEditing(false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyBoard()
    }
    
    func setBtn(_ enable:Bool) {
        btnSearch.isEnabled = enable
        btnSearch.backgroundColor = enable ? .blue : .lightGray
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        guard
            let keyword = tfKeyword.text, !keyword.isEmpty,
            let perPage = tfPerPageNum.text, !perPage.isEmpty
        else {
            setBtn(false)
            return
        }
        setBtn(true)
    }
    
    @IBAction func didPressedSearchBtn(_ sender: Any) {
        let resultCollectionVC = storyboard?.instantiateViewController(identifier: "ResultCollectionViewController") as! ResultCollectionViewController
        guard
            let keyword = tfKeyword.text,
            let perPage = tfPerPageNum.text
        else {
            return
        }
        resultCollectionVC.keyword = keyword
        resultCollectionVC.perPage = perPage
        self.navigationController?.pushViewController(resultCollectionVC, animated: true)
    }
}

