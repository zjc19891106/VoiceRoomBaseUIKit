//
//  VRRoomMenuBar.swift
//  Pods-VoiceRoomBaseUIKit_Example
//
//  Created by 朱继超 on 2022/8/24.
//

import UIKit
import ZSwiftBaseLib

public final class VRRoomMenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var selectClosure: ((IndexPath) -> ())?
    
    static let menusMap = [["title":"All(2)","selected":true],["title":"Chat Room(1)","selected":false],["title":"Spatial Audio Mode Room(1)","selected":false]]

    private var indicatorImage = UIImage()
    
    private var indicatorFrame = CGRect.zero
    
    var dataSource = [VRRoomMenuBarEntity]() {
        willSet {
            DispatchQueue.main.async { self.menuList.reloadData() }
        }
    }
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 30
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    lazy var menuList: UICollectionView = {
        UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), collectionViewLayout: self.flowLayout).delegate(self).dataSource(self).showsHorizontalScrollIndicator(false).showsVerticalScrollIndicator(false).registerCell(VRRoomMenuBarCell.self, forCellReuseIdentifier: "VRRoomMenuBarCell").backgroundColor(.clear)
    }()
    
    lazy var indicator: UIImageView = {
        UIImageView(frame: self.indicatorFrame).contentMode(.scaleAspectFit).image(self.indicatorImage)
    }()
    
    var widthMap: Dictionary<String,CGFloat>? = [:]
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect,items: [VRRoomMenuBarEntity],indicatorImage: UIImage,indicatorFrame: CGRect) {
        self.init(frame: frame)
        self.indicatorFrame = indicatorFrame
        self.dataSource.append(contentsOf: items)
        self.indicatorImage = indicatorImage
        self.addSubview(self.menuList)
        self.menuList.addSubview(self.indicator)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension VRRoomMenuBar {
    
    static var entities: [VRRoomMenuBarEntity] {
        var items = [VRRoomMenuBarEntity]()
        do {
            for map in VRRoomMenuBar.menusMap {
                let data = try JSONSerialization.data(withJSONObject: map, options: [])
                let item = try JSONDecoder().decode(VRRoomMenuBarEntity.self, from: data)
                items.append(item)
            }
        } catch {
            assert(false, "\(error.localizedDescription)")
        }
        return items
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VRRoomMenuBarCell", for: indexPath) as? VRRoomMenuBarCell
        cell?.item = self.dataSource[safe: indexPath.row]
        if cell?.item?.selected == true, cell != nil {
            self.indicatorMove(cell!)
        }
        return cell!
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let item = self.dataSource[safe: indexPath.row] {
            let width = item.title.z.sizeWithText(font: item.selected == true ? VRRoomMenuBarCell.selectedFont:VRRoomMenuBarCell.normalFont, size: CGSize(width: 999, height: 18)).width
            return CGSize(width: width, height: self.frame.height)
        } else {
            return .zero
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.dataSource.forEach { $0.selected = false }
        let item = self.dataSource[safe: indexPath.row] ?? VRRoomMenuBarEntity()
        item.selected = !item.selected
        self.menuList.scrollToItem(at: indexPath, at: .right, animated: true)
        self.menuList.reloadData()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VRRoomMenuBarCell", for: indexPath) as? VRRoomMenuBarCell {
            self.indicatorMove(cell)
        }
        if self.selectClosure != nil {
            self.selectClosure!(indexPath)
        }
    }
    
    func indicatorMove(_ cell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.35) {
            self.indicator.center = CGPoint(x: cell.center.x, y: self.indicator.center.y)
        }
    }
}
