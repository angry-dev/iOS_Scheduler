//
//  Controller.swift
//  Scheduler
//
//  Created by 전혜성 on 2022/02/02.
//

import Foundation

class Controller {
    static var shared = Controller()
    
    private init() { }
    
    let now = Date() // 현재 날짜
    let calendar = Calendar.current
    var formatter = DateFormatter()
    var components = DateComponents()
    var weeks = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0 // 해당 월이 며칠까지 있는지
    var weekdayAdding = 0 // 시작일

    func calculate() {
        var year = formatter.dateFormat = "yyyy"
        var month = formatter.dateFormat = "MM"
        
    }
    
}
