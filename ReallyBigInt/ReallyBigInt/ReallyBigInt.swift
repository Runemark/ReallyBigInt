//
//  BigInt.swift
//  Idle
//
//  Created by Martin Mumford on 4/7/15.
//  CC0 (Public Domain License) 2015. Do literally anything you want with this code.
//  Buy me a root beer: www.runemark.com/rootbeer/

import Foundation

// TODO, change this to a STRUCT instead of a CLASS
class BigInt {
    
    
    
    // NOTE: the digits array runs from right to left (reverse normal).
    // EXAMPLE: The number 1820 would fill the digits array thusly: [0,2,8,1]
    
    
    
    
    // TODO, possibly change this to a [UInt8] array for efficiency
    var digits = [Int]()
    
    // Initialize with a String (for really, really large numbers)
    convenience init(numString:String)
    {
        self.init()
        
        for character in reverse(Array(numString))
        {
            let digit = String(character).toInt()
            if (digit != nil)
            {
                digits.append(digit!)
            }
        }
    }
    
    // Initialize with an Int (for numbers that fit into an Int anyways)
    convenience init(num:Int)
    {
        self.init()
        
        var tempNum = num
        while (tempNum >= 10)
        {
            let digit = tempNum % 10
            tempNum = tempNum / 10
            digits.append(digit)
        }
        
        digits.append(tempNum)
    }
    
    // Initialize with an order of magnitude (10^mag)
    convenience init(mag:Int)
    {
        self.init()
        
//        for magIndex in 0..<mag
//        {
//            
//        }
    }
    
    init()
    {
        
    }
    
    func length() -> Int
    {
        return digits.count
    }
    
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
        
        return numeralValue + modifier
    }
}

/////////////////////////////////////////////////////////////////////////////////////
// OPERATORS
/////////////////////////////////////////////////////////////////////////////////////

func == (left:BigInt, right:BigInt) -> Bool
{
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

func > (left:BigInt, right:BigInt) -> Bool
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

func >= (left:BigInt, right:BigInt) -> Bool
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

func < (left:BigInt, right:BigInt) -> Bool
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

func <= (left:BigInt, right:BigInt) -> Bool
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
func + (left:BigInt, right:BigInt) -> BigInt
{
    let bufferLength = max(left.length(), right.length())+1
    var carryBuffer = Array<Bool>(count:bufferLength, repeatedValue:false)
    
    var result = BigInt()
    
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

infix operator  += { associativity left precedence 140 }
func += (inout left:BigInt, right:BigInt) {
    left = left + right
}

/////////////////////////////////////////////////////////////////////////////////////