//
//  TextViewController.swift
//  RichTextView
//
//  Created by wenyou on 2017/3/20.
//  Copyright © 2017年 wenyou. All rights reserved.
//

import Cocoa
import SnapKit


class TextViewController: NSViewController, NSTextViewDelegate {
    var rulerView: TextVerticalRulerView!

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.orange.cgColor
        view.frame = NSRect(origin: .zero, size: AppDelegate.windowSize)

        let scrollView = NSScrollView(frame: CGRect(origin: .zero, size: AppDelegate.windowSize))
        scrollView.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        view.addSubview(scrollView)

        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true

        scrollView.rulersVisible = true
        scrollView.hasVerticalRuler = true

        let textView = NSTextView(frame: CGRect(origin: .zero, size: scrollView.frame.size))
        textView.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        scrollView.documentView = textView

        textView.delegate = self
        textView.font = NSFont(name: "PT Mono", size: Constants.hostInfoFontSize)
        textView.textColor = NSColor.colorWithHexValue(0x333333)
//        textView.isRulerVisible = true
        textView.backgroundColor = .white
//        textView.usesRuler = true
        textView.isEditable = true
        textView.isSelectable = true
        textView.usesFontPanel = false // 禁掉右键菜单中的字体选择
        textView.menu = nil // 禁掉右键菜单
//        textView.string = "hahahahahhahahahahhahahahahhahahahahhahahahahhahahahahhahahahah\n1\n2\n3\n4\n5\n6\n7\n8\n8\n8\n8"
//        textView.string = "1hahaj"

        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = true
        textView.minSize = NSMakeSize(0, scrollView.contentSize.height)
        textView.maxSize = NSMakeSize(CGFloat(Float.greatestFiniteMagnitude), CGFloat(Float.greatestFiniteMagnitude))
        textView.textContainer?.containerSize = NSMakeSize(CGFloat(Float.greatestFiniteMagnitude), CGFloat(Float.greatestFiniteMagnitude))
//                textView.textContainer?.containerSize = NSMakeSize(scrollView.contentSize.width, CGFloat(Float.greatestFiniteMagnitude))
        textView.textContainer?.widthTracksTextView = false
        textView.textContainer?.heightTracksTextView = false
        textView.textContainerInset = .zero
//        textView.defaultParagraphStyle = {
//            let style = NSMutableParagraphStyle()
////            style.lineHeightMultiple = 45
////            style.maximumLineHeight = 45
////            style.minimumLineHeight = 45
////            style.lineSpacing = 8
//            return style
//        }()

        textView.layoutManager?.typesetter = WYTypesetter()

        textView.postsFrameChangedNotifications = true
        rulerView = TextVerticalRulerView(textView: textView) //TextVerticalRulerView(scrollView: scrollView, orientation: .verticalRuler)
        scrollView.verticalRulerView = rulerView

//        textView.enclosingScrollView?.hasVerticalScroller = true


//        scrollView.contentView.addSubview(textView)

//        textView.enclosingScrollView?.verticalRulerView = NSRulerView.init(scrollView: textView.enclosingScrollView, orientation: .verticalRuler)
//        textView.enclosingScrollView?.hasVerticalRuler = true
//        textView.isRulerVisible = true




//        scrollView.addSubview(textView)
//        scrollView.con

        NotificationCenter.default.addObserver(self, selector: #selector(TextViewController.selectorFrameDidChange(_:)), name:.NSViewFrameDidChange, object: textView)
        NotificationCenter.default.addObserver(self, selector: #selector(TextViewController.selectorTextDidChange(_:)), name:.NSTextDidChange, object: textView)
    }

    func selectorFrameDidChange(_ sender: NSTextView) {
        rulerView.needsDisplay = true
    }

    func selectorTextDidChange(_ sender: NSTextView) {
        rulerView.needsDisplay = true
    }

    // MARK: - NSTextViewDelegate
}
