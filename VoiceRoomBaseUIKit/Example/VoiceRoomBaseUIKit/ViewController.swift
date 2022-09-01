//
//  ViewController.swift
//  VoiceRoomBaseUIKit
//
//  Created by zjc19891106 on 08/24/2022.
//  Copyright (c) 2022 zjc19891106. All rights reserved.
//

import UIKit
import VoiceRoomBaseUIKit
import ZSwiftBaseLib

class ViewController: UIViewController {
    var i = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let bg = UIImageView(frame: self.view.frame).image(UIImage(named: "bg03")!)
        self.view.addSubview(bg)
        let button = UIButton(type: .contactAdd).frame(CGRect(x: 100, y: 100, width: 100, height: 100)).addTargetFor(self, action: #selector(test), for: .touchUpInside)
        self.view.addSubview(button)
        let chat = VoiceRoomChatView(frame: CGRect(x: 0, y: ScreenHeight - CGFloat(ZBottombarHeight) - 220 - 60, width: ScreenWidth, height:220))
        self.view.addSubview(chat)
        let gift = VoiceRoomGiftView(frame: CGRect(x: 0, y: chat.frame.minY - (ScreenWidth/9.0*2)-10, width: ScreenWidth/3.0*2, height: ScreenWidth/9.0*2)).backgroundColor(.clear).tag(111)
        self.view.addSubview(gift)
        let toolBar = VoiceRoomChatBar(frame: CGRect(x: 0, y: chat.frame.maxY+10, width: ScreenWidth, height: 50))
        self.view.addSubview(toolBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func test() {
//        if let g = self.view.viewWithTag(111) as? VoiceRoomGiftView {
//            g.giftList.scrollToRow(at: IndexPath(row: i, section: 0), at: .bottom, animated: true)
//            self.i += 1
//        }
//        let vc = VRRoomsViewController.init()
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        self.present(nav, animated: true)
    }

}

