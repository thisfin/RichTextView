//
//  TextVertiRulerView.swift
//  RichTextView
//
//  Created by wenyou on 2017/3/21.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import Cocoa

class TextVerticalRulerView: NSRulerView {
    private let padding: CGFloat = 5 // 页面左右边距

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init (textView: NSTextView) {
        super.init(scrollView: textView.enclosingScrollView!, orientation: .verticalRuler)

        needsDisplay = true
        clientView = textView
    }

    override func drawHashMarksAndLabels(in rect: NSRect) {
        if let textView = clientView as? NSTextView, let layoutManager = textView.layoutManager {
            // textView 内容高度
//            let contentHeight = layoutManager.usedRect(for: textView.textContainer!).size.height
            let contentHeight = layoutManager.boundingRect(forGlyphRange: NSMakeRange(0, (textView.string?.characters.count)!), in: textView.textContainer!).size.height
            // 内容高度 / 行高
            let lineCount = Int(round(contentHeight / ((textView.font?.ascender)! + abs((textView.font?.descender)!) + (textView.font?.leading)!)))

            // 计算行号左侧差
            let bitDifference = { (lineNumber: Int) -> Int in
                return "\(lineCount)".characters.count - "\(lineNumber)".characters.count
            }

            // 绘制行号
            let drawLineNumber = { (lineNumber: Int, y: CGFloat) -> Void in
                let attString = NSAttributedString(string: "\(lineNumber)",
                                                   attributes: [NSFontAttributeName: textView.font!, NSForegroundColorAttributeName: NSColor.colorWithHexValue(0x333333)])
                let x = self.padding + NSString(string: "8").size(withAttributes: [NSFontAttributeName: textView.font!]).width * CGFloat(bitDifference(lineNumber))
                let relativePoint = self.convert(NSPoint.zero, to: textView)
                let descender = abs((textView.font?.descender)!) // 底部间距 http://ksnowlv.blog.163.com/blog/static/21846705620142325349309/
                attString.draw(at: NSPoint(x: x, y: 0 - relativePoint.y + y - descender))
//                NSLog("\(lineNumber) \(0 - relativePoint.y + y - descender)")
            }

            // 可显示区域文字
            let visibleGlyphRange = layoutManager.glyphRange(forBoundingRect: textView.visibleRect, in: textView.textContainer!)
            // 可显示第一个字符的index
            let firstVisibleGlyphCharacterIndex = layoutManager.characterIndexForGlyph(at: visibleGlyphRange.location)
            // 换行正则
            let newLineRegex = try! NSRegularExpression(pattern: "\n", options: [])
            // 可显示第一行的行号
            var lineNumber = newLineRegex.numberOfMatches(in: textView.string!, options: [], range: NSMakeRange(0, firstVisibleGlyphCharacterIndex)) + 1

            // 可显示物理行 字符index
            var glyphIndexForStringLine = visibleGlyphRange.location

            // Go through each line in the string.
            while glyphIndexForStringLine < NSMaxRange(visibleGlyphRange) {

                // 当前物理行 range
                let characterRangeForStringLine = (textView.string! as NSString).lineRange(for: NSMakeRange(layoutManager.characterIndexForGlyph(at: glyphIndexForStringLine), 0))
                let glyphRangeForStringLine = layoutManager.glyphRange(forCharacterRange: characterRangeForStringLine, actualCharacterRange: nil)

                var effectiveRange = NSMakeRange(0, 0)
                let lineRect = layoutManager.lineFragmentRect(forGlyphAt: glyphIndexForStringLine,
                                                              effectiveRange: &effectiveRange,
                                                              withoutAdditionalLayout: true)
                drawLineNumber(lineNumber, lineRect.minY)


//                var glyphIndexForGlyphLine = glyphIndexForStringLine
//                var glyphLineFirst = true
//
//                while (glyphIndexForGlyphLine < NSMaxRange(glyphRangeForStringLine)) {
//
//                    // See if the current line in the string spread across
//                    // several lines of glyphs
//                    var effectiveRange = NSMakeRange(0, 0)
//
//                    // Range of current "line of glyphs". If a line is wrapped,
//                    // then it will have more than one "line of glyphs"
//                    let lineRect = layoutManager.lineFragmentRect(forGlyphAt: glyphIndexForGlyphLine,
//                                                                  effectiveRange: &effectiveRange,
//                                                                  withoutAdditionalLayout: true)
//                    drawLineNumber(glyphLineFirst ? lineNumber : 0, lineRect.minY)
////                    NSLog("\(lineRect.minY) \(baselineLocation) \(originOffset)")
//                    glyphLineFirst = false
//
//                    // Move to next glyph line
//                    glyphIndexForGlyphLine = NSMaxRange(effectiveRange)
//                }

                glyphIndexForStringLine = NSMaxRange(glyphRangeForStringLine)
                lineNumber += 1
            }

            // Draw line number for the extra line at the end of the text 在文本结尾绘制额外行的行号(貌似最后一行为\n时调用)
            if layoutManager.extraLineFragmentTextContainer != nil {
                drawLineNumber(lineNumber, layoutManager.extraLineFragmentRect.minY)
            }

            // 调整宽度
            ruleThickness = CGFloat(String(lineCount).characters.count) * NSString.init(string: "8").size(withAttributes: [NSFontAttributeName: textView.font!]).width + padding * 2
//            NSLog("%d \(lineNumber)", String(lineNumber).characters.count)
            NSLog("\(contentHeight) \(lineCount) \(ruleThickness)")
        }
    }
}
