//
//  JacketRegressionModel.swift
//  MorningBird
//
//  The idea with the linear regression is to get the X data (avgTemp) and Y data
//  (ordinal values, 0 == No, 1 == Yes for jacketWorn), and then make a basic equation.
//  If the result of plugging the new estimate into the equation is > 0.5 rounded down,
//  the recommendation to wear a jacket will be "No". If result < 0.5, the recommendation
//  will be "Yes".
//
//
//  Created by Janessa Tran on 9/5/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation
import CoreData

class JacketRegressionModel {

    var avgTemp: [Double] = [75, 80, 63, 82, 69, 68]
    var jacketWorn: [Double] = [0, 0, 1, 0, 1, 1]
    public var recommendationFunction: ((Double) -> Double)

    // pass the user's data for avgTemp and jacketWorn
    init(avgTemp: [Double], jacketWorn: [Double]) {
        self.avgTemp = avgTemp
        self.jacketWorn = jacketWorn
        recommendationFunction = JacketRegressionModel.linearRegression(avgTemp, jacketWorn)
    }

    // Reduce sums up the elements in the array,
    // then we divide by the number of elements to get the avg
    class func average(_ input: [Double]) -> Double {
        return input.reduce(0, +) / Double(input.count)
    }

    class func multiply(_ a: [Double], _ b: [Double]) -> [Double] {
        return zip(a,b).map(*)
    }

    // Returns a function describing the line of best fit based on the data
    class func linearRegression(_ xs: [Double], _ ys: [Double]) -> (Double) -> Double {
        let sum1 = average(multiply(ys, xs)) - average(xs) * average(ys)
        let sum2 = average(multiply(xs, xs)) - pow(average(xs), 2)
        let slope = sum1 / sum2
        let intercept = average(ys) - slope * average(xs)
        return { x in intercept + slope * x }
    }

}
