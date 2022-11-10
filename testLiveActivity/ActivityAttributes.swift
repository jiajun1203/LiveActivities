//
//  ActivityAttributes.swift
//  Test_LiveActivities
//
//  Created by Mr.C on 2022/11/8.
//

import Foundation
import ActivityKit

struct PizzaDeliveryAttributes: ActivityAttributes {
    public typealias PizzaDeliveryStatus = ContentState

    public struct ContentState: Codable, Hashable {
        var driverName: String
        var deliveryTimer: ClosedRange<Date>
    }

    var numberOfPizzas: Int
    var totalAmount: String
    var orderNumber: String
}


//struct PizzaAdAttributes: ActivityAttributes {
//    public typealias PizzaAdStatus = ContentState
//
//    public struct ContentState: Codable, Hashable {
//        var adName: String
//        var showTime: Date
//    }
//    var discount: String
//}
