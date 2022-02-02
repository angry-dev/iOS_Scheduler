//
//  ViewController.swift
//  Scheduler
//
//  Created by 전혜성 on 2022/02/01.
//

import UIKit

class ViewController: UIViewController {
    
    let now = Date()
    var cal = Calendar.current
    let dateFormatter = DateFormatter()
    var components = DateComponents()
    var weeks: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    var days: [String] = []
    var daysCountInMonth = 0 // 해당 월이 며칠까지 있는지
    var weekdayAdding = 0 // 시작일
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currentYearMonth: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.reloadData()
        
        dateFormatter.dateFormat = "yyyy년M월" // 월 표시 포맷 설정
        components.year = cal.component(.year, from: now)
        components.month = cal.component(.month, from: now)
        components.day = 1
        let firstDayOfMonth = cal.date(from: components)
        let firstWeekday = cal.component(.weekday, from: firstDayOfMonth!) // 해당 수로 반환이 됩니다. 1은 일요일 ~ 7은 토요일
        var a = dateFormatter.string(from: firstDayOfMonth!)
        daysCountInMonth = cal.range(of: .day, in: .month, for: firstDayOfMonth!)!.count
        weekdayAdding = 2 - firstWeekday // 이 과정을 해주는 이유는 예를 들어 2020년 4월이라 하면 4월 1일은 수요일 즉, 수요일이 달의 첫날이 됩니다.  수요일은 component의 4 이므로 CollectionView에서 앞의 3일은 비울 필요가 있으므로 인덱스가 1일부터 시작할 수 있도록 해줍니다. 그래서 2 - 4 해서 -2부터 시작하게 되어  정확히 3일 후부터 1일이 시작하게 됩니다.
        
        for day in weekdayAdding...daysCountInMonth {
            if day < 1 { // 1보다 작을 경우는 비워줘야 하기 때문에 빈 값을 넣어준다.
                days.append("")
            } else {
                days.append(String(day))
            }
            
        }
    
        currentYearMonth.text = a.description
        print(days)
        print(weeks)
        
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
            
        case 0:
            
            return 7 // 요일의 수는 고정

        default:
            
            return days.count
            
        }
        
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DateCollectionViewCell
        
        switch indexPath.section{
            
        case 0:
            
            cell.dateNum.text = weeks[indexPath.row] // 요일
            print(weeks[indexPath.row].description)
        default:
            
            cell.dateNum.text = days[indexPath.row]
            print(days[indexPath.row].description)
            
        }
        
        if indexPath.row % 7 == 0 { // 일요일

                    cell.dateNum.textColor = .red

                } else if indexPath.row % 7 == 6 { // 토요일

                    cell.dateNum.textColor = .blue

                } else { // 월요일 좋아(평일)

                    cell.dateNum.textColor = .black

                }

        
        return cell
    }
    
}



