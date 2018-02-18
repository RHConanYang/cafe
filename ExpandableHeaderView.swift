////
////  ExpandableHeaderView.swift
////  cafe
////
////  Created by 楊仁翰 on 2017/7/31.
////  Copyright © 2017年 Renhen Yang. All rights reserved.
////
//import UIKit
//
//
//protocol ExpandableHeaderViewDelegate {
//    func toggleSection(header: ExpandableHeaderView, section: Int)
//}
//
//class ExpandableHeaderView: UITableViewHeaderFooterView {
//    var delegate: ExpandableHeaderViewDelegate?
//    var section: Int!
//
//    override init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
//        let cell = gestureRecognizer.view as! ExpandableHeaderView
//        delegate?.toggleSection(header: self, section: cell.section)
//    }
//
//    func customInit(title: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
//        self.textLabel?.text = title
//        self.section = section
//        self.delegate = delegate
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.textLabel?.textColor = UIColor.white
//        self.contentView.backgroundColor = UIColor.lightGray
//    }
//
//    /*
//     // Only override draw() if you perform custom drawing.
//     // An empty implementation adversely affects performance during animation.
//     override func draw(_ rect: CGRect) {
//     // Drawing code
//     }
//     */
//
//}
//
