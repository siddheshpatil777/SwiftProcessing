import Foundation
import UIKit

/// Useful functions for common math calculations
public protocol Calculation {
    /// Constrains a value between a minimum and maximum value.
    /// - Parameters:
    ///   - n: number to constrain
    ///   - low: minimum limit
    ///   - high: maximum limit
    func constrain(_ n: CGFloat, _ low: CGFloat, _ high: CGFloat) -> CGFloat
    
    /// Calculates the distance between two points
    /// - Parameters:
    ///   - x1: x-coordinate of the first point
    ///   - y1: y-coordinate of the first point
    ///   - x2: x-coordinate of the second point
    ///   - y2: y-coordinate of the second point
    func distance(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) -> CGFloat
    
    /// Calculates a number between two numbers at a specific increment
    /// - Parameters:
    ///   - start: first value
    ///   - stop: second value
    ///   - amt: amount to interpolate between the two values
    func lerp(_ start: CGFloat, _ stop: CGFloat, _ amt: CGFloat) -> CGFloat
    
    /// Calculates the magnitude (or length) of a vector
    /// - Parameters:
    ///   - a: first value
    ///   - b: second value
    func mag(_ a: CGFloat, _ b: CGFloat) -> CGFloat
    
    /// Re-maps a number from one range to another.
    /// - Parameters:
    ///   - value: the incoming value to be converted
    ///   - start1: lower bound of the value's current range
    ///   - stop1: upper bound of the value's current range
    ///   - start2: lower bound of the value's target range
    ///   - stop2: upper bound of the value's target range
    ///   - withinBounds: constrain the value to the newly mapped range (Optional)
    func map(_ value: CGFloat, _ start1: CGFloat, _ stop1: CGFloat, _ start2: CGFloat, _ stop2: CGFloat, _ withinBounds: Bool) -> CGFloat
    
    /// Determines the largest value in a sequence of numbers, and then returns that value
    /// - Parameter array: Numbers to compare
    func max(_ array: [CGFloat]) -> CGFloat
    
    
    /// Determines the smallest value in a sequence of numbers, and then returns that value
    /// - Parameter array: Numbers to compare
    func min(_ array: [CGFloat]) -> CGFloat
    
    /// Normalizes a number from another range into a value between 0 and 1.
    /// - Parameters:
    ///   - num: incoming value to be normalized
    ///   - start: lower bound of the value's current range
    ///   - stop: upper bound of the value's current range
    func norm(_ num: CGFloat, _ start: CGFloat, _ stop: CGFloat) -> CGFloat
    
    /// Squares a number (multiplies a number by itself).
    /// - Parameter num: number to square
    /// - Returns: squared number
    func sq(_ num: CGFloat) -> CGFloat
    
}

extension Sketch: Calculation {

    public func constrain(_ n: CGFloat, _ low: CGFloat, _ high: CGFloat) -> CGFloat {
        return Swift.min(Swift.max(n, low), high)
    }

    public func distance(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) -> CGFloat {
        let distanceSquared = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)
        return sqrt(distanceSquared)
    }

    public func lerp(_ start: CGFloat, _ stop: CGFloat, _ amt: CGFloat) -> CGFloat {
        return start + ((stop - start) * amt)
    }

    public func mag(_ a: CGFloat, _ b: CGFloat) -> CGFloat {
        return distance(0, 0, a, b)
    }

    public func map(_ value: CGFloat, _ start1: CGFloat, _ stop1: CGFloat, _ start2: CGFloat, _ stop2: CGFloat, _ withinBounds: Bool = true) -> CGFloat {
        let newval = (value - start1) / (stop1 - start1) * (stop2 - start2) + start2
        if !withinBounds {
          return newval
        }
        if start2 < stop2 {
          return self.constrain(newval, start2, stop2)
        } else {
          return self.constrain(newval, stop2, start2)
        }
    }

    public func max(_ array: [CGFloat]) -> CGFloat {
        return array.max() ?? 0
    }

    public func min(_ array: [CGFloat]) -> CGFloat {
        return array.min() ?? 0
    }

    public func norm(_ num: CGFloat, _ start: CGFloat, _ stop: CGFloat) -> CGFloat {
        return self.map(num, start, stop, 0, 1)
    }
    
    public func sq(_ num: CGFloat) -> CGFloat {
        return pow(num, 2)
    }
}
