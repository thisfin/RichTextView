//
//  TextVertiRulerView.swift
//  RichTextView
//
//  Created by wenyou on 2017/3/21.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import Cocoa

class TextVerticalRulerView: NSRulerView {
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (textView: NSTextView) {
        super.init(scrollView: textView.enclosingScrollView!, orientation: .verticalRuler)

        needsDisplay = true
        clientView = textView
        ruleThickness = 40
    }

    override func drawHashMarksAndLabels(in rect: NSRect) {
        if let textView = clientView as? NSTextView, let layoutManager = textView.layoutManager {
            let drawLineNumber = { (lineNumberString: String, y: CGFloat) -> Void in
                let attString = NSAttributedString(string: lineNumberString, attributes: [NSFontAttributeName: textView.font!, NSForegroundColorAttributeName: NSColor.colorWithHexValue(0x333333)])
                let x = 35 - attString.size().width
                let relativePoint = self.convert(NSPoint.zero, to: textView)
                attString.draw(at: NSPoint(x: x, y: relativePoint.y + y))
            }

            let visibleGlyphRange = layoutManager.glyphRange(forBoundingRect: textView.visibleRect, in: textView.textContainer!)
            let firstVisibleGlyphCharacterIndex = layoutManager.characterIndexForGlyph(at: visibleGlyphRange.location)

            let newLineRegex = try! NSRegularExpression(pattern: "\n", options: [])
            // The line number for the first visible line
            var lineNumber = newLineRegex.numberOfMatches(in: textView.string!, options: [], range: NSMakeRange(0, firstVisibleGlyphCharacterIndex)) + 1

            var glyphIndexForStringLine = visibleGlyphRange.location

            // Go through each line in the string.
            while glyphIndexForStringLine < NSMaxRange(visibleGlyphRange) {

                // Range of current line in the string.
                let characterRangeForStringLine = (textView.string! as NSString).lineRange(for: NSMakeRange(layoutManager.characterIndexForGlyph(at: glyphIndexForStringLine), 0))
                let glyphRangeForStringLine = layoutManager.glyphRange(forCharacterRange: characterRangeForStringLine, actualCharacterRange: nil)

                var glyphIndexForGlyphLine = glyphIndexForStringLine
                var glyphLineCount = 0

                while (glyphIndexForGlyphLine < NSMaxRange(glyphRangeForStringLine)) {

                    // See if the current line in the string spread across
                    // several lines of glyphs
                    var effectiveRange = NSMakeRange(0, 0)

                    // Range of current "line of glyphs". If a line is wrapped,
                    // then it will have more than one "line of glyphs"
                    let lineRect = layoutManager.lineFragmentRect(forGlyphAt: glyphIndexForGlyphLine, effectiveRange: &effectiveRange, withoutAdditionalLayout: true)

                    if glyphLineCount > 0 {
                        drawLineNumber("-", lineRect.minY)
                    } else {
                        drawLineNumber("\(lineNumber)", lineRect.minY)
                    }

                    // Move to next glyph line
                    glyphLineCount += 1
                    glyphIndexForGlyphLine = NSMaxRange(effectiveRange)
                }

                glyphIndexForStringLine = NSMaxRange(glyphRangeForStringLine)
                lineNumber += 1
            }

            // Draw line number for the extra line at the end of the text
            if layoutManager.extraLineFragmentTextContainer != nil {
                drawLineNumber("\(lineNumber)", layoutManager.extraLineFragmentRect.minY)
            }
        }
    }
}
