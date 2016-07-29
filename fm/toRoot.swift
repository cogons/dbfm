
//
//  toRoot.swift
//  fm
//
//  Created by Cogons on 16/7/30.
//  Copyright © 2016年 Cogons. All rights reserved.
//

import UIKit

class toRoot: UIStoryboardSegue {
    override func perform () {
        let src = self.sourceViewController as UIViewController
        let dst = self.destinationViewController as UIViewController
        src.navigationController!.popToRootViewControllerAnimated(true)
    }
}
