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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let button = UIButton(type: .contactAdd).frame(CGRect(x: 100, y: 100, width: 100, height: 100)).addTargetFor(self, action: #selector(test), for: .touchUpInside)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func test() {
        
        let vc = VRRoomsViewController.init()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }

}

