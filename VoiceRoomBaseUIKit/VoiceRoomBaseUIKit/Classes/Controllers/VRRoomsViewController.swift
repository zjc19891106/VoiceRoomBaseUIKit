//
//  VRRoomsViewController.swift
//  Pods-VoiceRoomBaseUIKit_Example
//
//  Created by 朱继超 on 2022/8/24.
//

import UIKit
import ZSwiftBaseLib

let bottomSafeHeight = safeAreaExist ? 33:0

public final class VRRoomsViewController: VRBaseViewController {
    
    lazy var background: UIImageView = {
        UIImageView(frame: self.view.frame).image(UIImage("roomList")!)
    }()
    
    lazy var menuBar: VRRoomMenuBar = {
        VRRoomMenuBar(frame: CGRect(x: 20, y: ZNavgationHeight, width: ScreenWidth-40, height: 35), items: VRRoomMenuBar.entities, indicatorImage: UIImage("fline")!,indicatorFrame: CGRect(x: 0, y: 35 - 2, width: 18, height: 2)).backgroundColor(.clear)
    }()
    
    lazy var empty: VREmptyView = {
        VREmptyView(frame: CGRect(x: 0, y: self.menuBar.frame.maxY, width: ScreenWidth, height: ScreenHeight - self.menuBar.frame.maxY - 10 - CGFloat(ZBottombarHeight) - 30), title: "No Chat Room yet", image: nil)
    }()
    
    lazy var roomList: VRRoomListView = {
        VRRoomListView(frame: CGRect(x: 0, y: self.menuBar.frame.maxY+10, width: ScreenWidth, height: ScreenHeight - self.menuBar.frame.maxY - 10 - CGFloat(ZBottombarHeight) - 30), style: .plain)
    }()
    
    lazy var create: VRRoomCreateView = {
        VRRoomCreateView(frame: CGRect(x: 0, y: self.roomList.frame.maxY - 50, width: ScreenWidth, height: 72)).image(UIImage("blur")!).backgroundColor(.clear)
    }()
    
    let avatar = UIButton {
        UIButton(type: .custom).frame(CGRect(x: ScreenWidth - 70, y: ZNavgationHeight - 40, width: 50, height: 30)).backgroundColor(.clear)
        UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30)).image(UIImage("avatar")!).contentMode(.scaleAspectFit)
        UIImageView(frame: CGRect(x: 38, y: 9, width: 12, height: 12)).image(UIImage("arrow_right")!).contentMode(.scaleAspectFit)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubViews([self.background,self.empty,self.menuBar,self.roomList,self.create])
        self.view.bringSubviewToFront(self.navigation)
        self.navigation.title.text = "Agora Chat Room"
        self.navigation.addSubview(self.avatar)
        self.avatar.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        self.create.action = { [weak self] in
            self?.navigationController?.pushViewController(VRCreateRoomViewController.init(), animated: true)
        }
    }
    

}

extension VRRoomsViewController {
        
    public override var backImageName: String { "" }
    
    @objc func editProfile() {
        self.navigationController?.pushViewController(VRUserProfileViewController.init(), animated: true)
    }
    
}
