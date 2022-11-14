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
        var driverStatus : Int //1待接单， 2配送中 3已完成
        var deliveryTimer: ClosedRange<Date>
    }

    var numberOfPizzas: Int
    var totalAmount: String
    var orderNumber: String
}
