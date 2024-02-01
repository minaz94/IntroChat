//
//  IntroductionTableViewCell.swift
//  IntroChat
//
//  Created by Mina on 1/31/24.
//

import UIKit

class IntroductionTableViewCell: UITableViewCell {

    @IBOutlet weak var introductionLabel: UILabel!
    
    func configureFor(introduction: String) {
        introductionLabel.text = introduction
    }

}
