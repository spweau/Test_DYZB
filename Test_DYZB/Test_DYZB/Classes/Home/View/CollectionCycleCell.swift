//
//  CollectionCycleCell.swift
//  Test_DYZB
//
//  Created by Spweau on 2017/2/25.
//  Copyright © 2017年 sp. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: 控件属性
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    
    // MARK: 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconURL)
        }
    }

}
