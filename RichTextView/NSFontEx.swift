//
//  NSFontEx.swift
//  RichTextView
//
//  Created by wenyou on 2017/3/21.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import Cocoa

extension NSFont {
    // 打印系统所支持字体
    static func printAllFontName() {
        NSFontManager.shared().availableFontFamilies.forEach { (fontName) in
            NSLog(fontName)
        }
    }
}
