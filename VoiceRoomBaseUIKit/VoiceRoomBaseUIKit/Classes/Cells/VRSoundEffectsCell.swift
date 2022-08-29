//
//  VRSoundEffectsCell.swift
//  VoiceRoomBaseUIKit
//
//  Created by 朱继超 on 2022/8/26.
//

import UIKit
import ZSwiftBaseLib

public class VRSoundEffectsCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    private var images = ["app1","soul"]
    
    var item: VRRoomMenuBarEntity? {
        willSet {
            if newValue != nil {
                DispatchQueue.main.async { self.refresh(item: newValue!) }
            }
        }
    }
    
    lazy var background: UIView = {
        UIView(frame: CGRect(x: 20, y: 15, width: ScreenWidth-40, height: self.frame.height - 15)).backgroundColor(.white).cornerRadius(20)
    }()
    
    lazy var effectName: UILabel = {
        UILabel(frame: CGRect(x: 20, y: 17.5, width: self.background.frame.width - 40, height: 20)).textColor(UIColor(0x156EF3)).font(.systemFont(ofSize: 16, weight: .semibold))
    }()
    
    lazy var effectDesc: UILabel = {
        UILabel(frame: CGRect(x: 20, y: self.effectName.frame.maxY+4, width: self.effectName.frame.width, height: 60)).font(.systemFont(ofSize: 13, weight: .regular)).textColor(UIColor(0x3C4267)).numberOfLines(0)
    }()
    
    lazy var line: UIView = {
        UIView(frame: CGRect(x: 20, y: self.effectDesc.frame.maxY+6, width: self.effectDesc.frame.width, height: 1)).backgroundColor(UIColor(0xF6F6F6))
    }()
    
    lazy var customUsage: UILabel = {
        UILabel(frame: CGRect(x: 20, y: self.effectDesc.frame.maxY+10, width: 200, height: 15)).font(.systemFont(ofSize: 11, weight: .regular)).textColor(UIColor(0xD8D8D8)).text("Current Customer Usage")
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 20, height: 20)
        return layout
    }()
    
    lazy var iconList: UICollectionView = {
        UICollectionView(frame: CGRect(x: 20, y: self.customUsage.frame.maxY+5, width: self.effectName.frame.width, height: 20), collectionViewLayout: self.flowLayout).delegate(self).dataSource(self).registerCell(VRIconCell.self, forCellReuseIdentifier: "VRIconCell").showsVerticalScrollIndicator(false).showsHorizontalScrollIndicator(false).isUserInteractionEnabled(false)
    }()
    
    lazy var chooseSymbol: UIImageView = {
        UIImageView(frame: CGRect(x: self.background.frame.width-32, y: self.frame.height-31, width: 32, height: 31)).image(UIImage("check")!).contentMode(.scaleAspectFit)
    }()

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.contentView.addSubview(self.background)
        self.background.addSubViews([self.effectName,self.effectDesc,self.line,self.customUsage,self.iconList,self.chooseSymbol])
        self.iconList.isScrollEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension VRSoundEffectsCell {
    
    static func items() -> [VRRoomMenuBarEntity] {
        var items = [VRRoomMenuBarEntity]()
        do {
            for dic in [["title":"Social Chat","detail":"This scenario focuses on echo cancellation, noise reduction in a multi-person chat setting, creating a quiet chat atmosphere","selected":true],["title":"Karaoke","detail":"The scene deals with the coordination of your voice and the musical accompaniment through high sound quality and echo cancellation to ensure the best karaoke experience","selected":false],["title":"SGaming Buddy","detail":"This scene focuses on the coordination of human voice and in-game sound during live,ractive game sessions","selected":false]] {
                let data = try JSONSerialization.data(withJSONObject: dic, options: [])
                let item = try JSONDecoder().decode(VRRoomMenuBarEntity.self, from: data)
                items.append(item)
            }
        } catch {
            assert(false, "\(error.localizedDescription)")
        }
        return items
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VRIconCell", for: indexPath) as? VRIconCell
        cell?.imageView.image = UIImage(self.images[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    
    private func refresh(item: VRRoomMenuBarEntity) {
        self.effectName.text = item.title
        self.effectDesc.text = item.detail
        self.chooseSymbol.isHidden = !item.selected
        self.background.frame = CGRect(x: 20, y: 15, width: ScreenWidth-40, height: self.frame.height - 15)
        self.effectName.frame = CGRect(x: 20, y: 15, width: self.background.frame.width-40, height: 22)
        self.effectDesc.frame = CGRect(x: 20, y: self.effectName.frame.maxY+4, width: self.effectName.frame.width, height: VRSoundEffectsList.heightMap[item.title] ?? 60)
        self.line.frame = CGRect(x: 20, y: self.effectDesc.frame.maxY+6, width: self.effectDesc.frame.width, height: 1)
        self.customUsage.frame = CGRect(x: 20, y: self.effectDesc.frame.maxY+10, width: 200, height: 15)
        self.iconList.frame = CGRect(x: 20, y: Int(self.customUsage.frame.maxY)+5, width: self.images.count*20+10*(self.images.count-1), height: 20)
        self.chooseSymbol.frame = CGRect(x: self.background.frame.width-32, y: self.background.frame.height-31, width: 32, height: 31)
    }
}

public class VRIconCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)).contentMode(.scaleAspectFill)
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
}
