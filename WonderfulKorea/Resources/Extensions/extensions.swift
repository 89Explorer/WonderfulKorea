//
//  extensions.swift
//  WonderfulKorea
//
//  Created by 권정근 on 9/12/24.
//

import Foundation

// MARK: - 문자열에서 괄호와 괄호 안에 내용을 제거
extension String {
    func removingParentheses() -> String {
        return self.replacingOccurrences(of: "\\s*[\\(\\[].*?[\\)\\]]", with: "", options: .regularExpression)
    }
}
