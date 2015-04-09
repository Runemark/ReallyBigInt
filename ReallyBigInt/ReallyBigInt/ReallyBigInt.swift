//
//  BigInt.swift
//  Idle
//
//  Created by Martin Mumford on 4/7/15.
//  CC0 (Public Domain License) 2015. Do literally anything you want with this code.
//  Buy me a root beer: www.runemark.com/rootbeer/

import Foundation

// TODO, change this to a STRUCT instead of a CLASS
class ReallyBigInt {
    
    
    
    // NOTE: the digits array runs from right to left (reverse normal).
    // EXAMPLE: The number 1820 would fill the digits array thusly: [0,2,8,1]
    
    
    
    
    // TODO, possibly change this to a [UInt8] array for efficiency
    var digits = [Int]()
    var positive = true
    
    // Initialize with a String (for really, really large numbers)
    convenience init(numString:String)
    {
        self.init()
        
        for character in reverse(Array(numString))
        {
            if (character == "-")
            {
                positive = false
            }
            else
            {
                let digit = String(character).toInt()
                if (digit != nil)
                {
                    digits.append(digit!)
                }
            }
        }
    }
    
    // Initialize with an Int (for numbers that fit into an Int anyways)
    convenience init(num:Int)
    {
        self.init()
        
        var tempNum = num
        if (num < 0)
        {
            positive = false
            tempNum = num * -1
        }
        
        while (tempNum >= 10)
        {
            let digit = tempNum % 10
            tempNum = tempNum / 10
            digits.append(digit)
        }
        
        digits.append(tempNum)
    }
    
    // Initialize with an order of magnitude (10^mag), only supports positive magnitudes
    convenience init(mag:Int)
    {
        self.init()
        
        for magIndex in 0..<mag
        {
            digits.append(0)
        }
        
        digits.append(1)
    }
    
    init()
    {
        
    }
    
    func length() -> Int
    {
        return digits.count
    }
    
    // Returns the most significant three digits of the short form {(123 in 123K), (12.3 in 12.3K), (1.23 in 1.23K)}
    func threeDigitValue() -> Double
    {
        let hDig = length()-1
        
        var threeDigitValue = 0.00
        
        switch hDig
        {
            case 0:
                threeDigitValue = Double(digits[0])
                break
            case 1:
                threeDigitValue = Double(digits[1]*10 + digits[0])
                break
            default:
                
                let position = hDig % 3
                
                switch position
                {
                case 0:
                    threeDigitValue = Double(digits[hDig]) + Double(digits[hDig-1])*0.10 + Double(digits[hDig-2])*0.01
                    break
                case 1:
                    threeDigitValue = Double(digits[hDig])*10.0 + Double(digits[hDig-1]) + Double(digits[hDig-2])*0.10
                    break
                default:
                    threeDigitValue = Double(digits[hDig])*100 + Double(digits[hDig-1])*10.0 + Double(digits[hDig-2])
                    break
                }
                
                break
        }
        
        if (!positive)
        {
            threeDigitValue = threeDigitValue * -1
        }
        
        return threeDigitValue
    }
    
    // A 3-Digit string representation of any number
    func shortString() -> String
    {
        // Determine the magnitude of the highest digit
        let hDig = length()-1
        
        // The highest magnitude determines the modifier (M,B,T,Qu,etc.)
        var modifier = ""
        
        if (hDig < 3)
        {
            // no modifier
        }
        else if (hDig < 6)
        {
            modifier = "K"
        }
        else if (hDig < 9)
        {
            modifier = "M"
        }
        else if (hDig < 12)
        {
            modifier = "B"
        }
        else if (hDig < 15)
        {
            modifier = "T"
        }
        else if (hDig < 18)
        {
            modifier = "Qu"
        }
        else if (hDig < 21)
        {
            modifier = "Qi"
        }
        else if (hDig < 24)
        {
            modifier = "Sx"
        }
        else if (hDig < 27)
        {
            modifier = "Sp"
        }
        else if (hDig < 30)
        {
            modifier = "Oc"
        }
        else if (hDig < 33)
        {
            modifier = "No"
        }
        else if (hDig < 36)
        {
            modifier = "Dc"
        }
        else if (hDig < 39)
        {
            modifier = "UnDc"
        }
        else if (hDig < 42)
        {
            modifier = "DuDc"
        }
        else if (hDig < 45)
        {
            modifier = "TrDc"
        }
        else if (hDig < 48)
        {
            modifier = "QuDc"
        }
        else if (hDig < 51)
        {
            modifier = "QiDc"
        }
        else if (hDig < 54)
        {
            modifier = "SxDc"
        }
        else if (hDig < 56)
        {
            modifier = "SpDc"
        }
        else if (hDig < 60)
        {
            modifier = "OcDc"
        }
        else if (hDig < 63)
        {
            modifier = "NoDc"
        }
        else if (hDig < 66)
        {
            modifier = "Vg"
        }
        else
        {
            // Too large for standard naming conventions, use scientific notation
            modifier = "e\(hDig)"
            // This digit may/maynot be a few digits off (TODO: VERIFY)
        }
        
        // Determine which of the three positions the most significant bit is held
        // ...,ABC,ABC,ABC,...
        
        var numeralValue = ""
        
        switch hDig
        {
        case 0:
            numeralValue = "\(digits[0])"
            break
        case 1:
            numeralValue = "\(digits[1])\(digits[0])"
            break
        default:
            
            let position = hDig % 3
            
            switch position
            {
            case 0:
                numeralValue = "\(digits[hDig]).\(digits[hDig-1])\(digits[hDig-2])"
                break
            case 1:
                numeralValue = "\(digits[hDig])\(digits[hDig-1]).\(digits[hDig-2])"
                break
            default:
                numeralValue = "\(digits[hDig])\(digits[hDig-1])\(digits[hDig-2])"
                break
            }
            
            break
        }
        
        let sign = (positive) ? "" : "-"
        return sign + numeralValue + modifier
    }
}

/////////////////////////////////////////////////////////////////////////////////////
// OPERATORS
/////////////////////////////////////////////////////////////////////////////////////

func == (left:ReallyBigInt, right:ReallyBigInt) -> Bool
{
    if (left.positive != right.positive)
    {
        return false
    }
    
    if (left.length() > right.length())
    {
        return false
    }
    else if (left.length() < right.length())
    {
        return false
    }
    else
    {
        // Compare digit-by-digit, from the highest to the lowest
        for highestDigitIndex in reverse(0..<left.length())
        {
            let leftDigit = left.digits[highestDigitIndex]
            let rightDigit = right.digits[highestDigitIndex]
            
            if (leftDigit > rightDigit)
            {
                return false
            }
            else if (leftDigit < rightDigit)
            {
                return false
            }
        }
        
        return true
    }
}


/// CONTINUE SUPPORTING NEGATIVE OPERATIONS AT THIS POINT
// WARXING: CONTINUE, TODO


func > (left:ReallyBigInt, right:ReallyBigInt) -> Bool
{
    if (left.length() > right.length())
    {
        return true
    }
    else if (left.length() < right.length())
    {
        return false
    }
    else
    {
        // Compare digit-by-digit, from the highest to the lowest
        for highestDigitIndex in reverse(0..<left.length())
        {
            let leftDigit = left.digits[highestDigitIndex]
            let rightDigit = right.digits[highestDigitIndex]
            
            if (leftDigit > rightDigit)
            {
                return true
            }
            else if (leftDigit < rightDigit)
            {
                return false
            }
        }
        
        return false
    }
}

func >= (left:ReallyBigInt, right:ReallyBigInt) -> Bool
{
    if (left.length() > right.length())
    {
        return true
    }
    else if (left.length() < right.length())
    {
        return false
    }
    else
    {
        // Compare digit-by-digit, from the highest to the lowest
        for highestDigitIndex in reverse(0..<left.length())
        {
            let leftDigit = left.digits[highestDigitIndex]
            let rightDigit = right.digits[highestDigitIndex]
            
            if (leftDigit > rightDigit)
            {
                return true
            }
            else if (leftDigit < rightDigit)
            {
                return false
            }
        }
        
        return true
    }
}

func < (left:ReallyBigInt, right:ReallyBigInt) -> Bool
{
    if (left.length() < right.length())
    {
        return true
    }
    else if (left.length() > right.length())
    {
        return false
    }
    else
    {
        // Compare digit-by-digit, from the highest to the lowest
        for highestDigitIndex in reverse(0..<left.length())
        {
            let leftDigit = left.digits[highestDigitIndex]
            let rightDigit = right.digits[highestDigitIndex]
            
            if (leftDigit < rightDigit)
            {
                return true
            }
            else if (leftDigit > rightDigit)
            {
                return false
            }
        }
        
        return false
    }
}

func <= (left:ReallyBigInt, right:ReallyBigInt) -> Bool
{
    if (left.length() < right.length())
    {
        return true
    }
    else if (left.length() > right.length())
    {
        return false
    }
    else
    {
        // Compare digit-by-digit, from the highest to the lowest
        for highestDigitIndex in reverse(0..<left.length())
        {
            let leftDigit = left.digits[highestDigitIndex]
            let rightDigit = right.digits[highestDigitIndex]
            
            if (leftDigit < rightDigit)
            {
                return true
            }
            else if (leftDigit > rightDigit)
            {
                return false
            }
        }
        
        return true
    }
}

// Addition is done exactly like in grade school, using the old-fashioned manual "carry the one" method
func + (left:ReallyBigInt, right:ReallyBigInt) -> ReallyBigInt
{
    let bufferLength = max(left.length(), right.length())+1
    var carryBuffer = Array<Bool>(count:bufferLength, repeatedValue:false)
    
    var result = ReallyBigInt()
    
    for index in 0..<bufferLength
    {
        var leftDigit = 0
        var rightDigit = 0
        
        if (index < left.digits.count)
        {
            leftDigit = left.digits[index]
        }
        
        if (index < right.digits.count)
        {
            rightDigit = right.digits[index]
        }
        
        let carryBit = (carryBuffer[index]) ? 1 : 0
        let digitSum = leftDigit + rightDigit + carryBit
        var remainder = digitSum
        
        if (digitSum > 9)
        {
            // carry the one
            carryBuffer[index+1] = true
            remainder = digitSum - 10
        }
        
        if !(remainder == 0 && index == bufferLength-1)
        {
            result.digits.append(remainder)
        }
    }
    
    return result
}

func - (left:ReallyBigInt, right:ReallyBigInt) -> ReallyBigInt
{
    let bufferLength = max(left.length(), right.length())
    var carryBuffer = Array<Bool>(count:bufferLength, repeatedValue:false)
    
    if (right > left)
    {
        var result = right - left
        result.positive = false
        return result
    }
    else
    {
        var result = ReallyBigInt()
        
        for index in 0..<bufferLength
        {
            var leftDigit = 0
            var rightDigit = 0
            
            if (index < left.length())
            {
                leftDigit = left.digits[index]
            }
            if (index < right.length())
            {
                rightDigit = right.digits[index]
            }
            
            if (carryBuffer[index])
            {
                leftDigit -= 1
            }
            
            if (leftDigit >= rightDigit)
            {
                // simply subtract
                result.digits.append(leftDigit - rightDigit)
            }
            else
            {
                carryBuffer[index+1] = true
                result.digits.append(leftDigit+10 - rightDigit)
            }
        }
        
        // Eliminate any trailing zeroes
        var digitIndex = bufferLength-1
        var digit = result.digits[digitIndex]
        while (digit == 0 && digitIndex > 0)
        {
            result.digits.removeLast()
            
            digitIndex--
            
            digit = result.digits[digitIndex]
        }
        
        return result
    }
}

infix operator  += { associativity left precedence 140 }
func += (inout left:ReallyBigInt, right:ReallyBigInt) {
    left = left + right
}

/////////////////////////////////////////////////////////////////////////////////////