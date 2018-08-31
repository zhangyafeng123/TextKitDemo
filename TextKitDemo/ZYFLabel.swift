//
//  ZYFLabel.swift
//  TextKitDemo
//
//  Created by 张亚峰 on 2018/8/31.
//  Copyright © 2018年 zhangyafeng. All rights reserved.
//

import UIKit

/// 使用 TextKit 接管 label 的底层实现 - '绘制' textStorage 的文本内容
/// 使用正则表达式过滤 URL
/// 交互
/// - UILabel 默认不能实现垂直顶部对齐，使用 TextKit 可以
class ZYFLabel: UILabel {
    
    /// 构造函数
    ///
    /// - Parameter frame: frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareTextSystem()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareTextSystem()
    }
    
    /// 绘制文本
    /// - 在 iOS 中绘制工作类似于 油画 似的，后绘制的内容，会把之前绘制的内容覆盖!
    /// - Parameter rect: rect
    override func drawText(in rect: CGRect) {
        let range = NSRange(location: 0, length: textStorage.length)
        //绘制背景
        //layoutManager.drawBackground(forGlyphRange: range, at: CGPoint())
        // glyphs 绘制 字形
        layoutManager.drawGlyphs(forGlyphRange: range, at: CGPoint())
        //会覆盖
        //layoutManager.drawBackground(forGlyphRange: range, at: CGPoint())
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 指定绘制文本的区域
        textContainer.size = bounds.size
    }
    
    /// 属性文本存储
    private lazy var textStorage = NSTextStorage()
    
    /// 负责文本 ‘字形’ 布局
    private lazy var layoutManager = NSLayoutManager()
    
    /// 设定文本绘制的范围
    private lazy var textContainer = NSTextContainer()
}

// MARK: - 设置 textkit 核心对象
private extension ZYFLabel {
    
    /// 准本文本系统
    func prepareTextSystem()  {
        //1.准备文本内容
        prepareTextContent()
        //2.设置对象的关系
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
    }
    
    /// 准备文本内容 - 使用 textStorage 接管 label 的内容
    func prepareTextContent()  {
        if let attributedText = attributedText {
            textStorage.setAttributedString(attributedText)
        } else if let text = text {
            textStorage.setAttributedString(NSAttributedString(string: text))
        } else {
            textStorage.setAttributedString(NSAttributedString(string: ""))
        }
        //遍历范围数组，设置 url 文字的属性
        for r in urlRanges ?? [] {
            textStorage.addAttributes([NSAttributedStringKey.foregroundColor : UIColor.red, NSAttributedStringKey.backgroundColor: UIColor.green], range: r)
        }
    }
    
}

// MARK: - 正则表达式函数
private extension ZYFLabel {
    
    /// 返回 textStorage 中的 URL range 数组
    var urlRanges: [NSRange]? {
        //1.正则表达式
        let pattern = "[a-zA-Z]*://[a-zA-Z0-9/\\.]*"
        
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        //2.多重匹配
        let matches = regx.matches(in: textStorage.string, options: [], range: NSRange(location: 0, length: textStorage.length))
        //3.遍历数组，生成 range 的数组
        var ranges = [NSRange]()
        
        for m in matches {
            ranges.append(m.range(at: 0))
        }
        
        return ranges
        
    }
    
    
}


















