//
//  main.swift
//  ReallyBigInt
//
//  Created by Martin Mumford on 4/8/15.
//  Copyright (c) 2015 Runemark. All rights reserved.
//

import Foundation

let sub = ReallyBigInt(num:36) - ReallyBigInt(num:36)
println("sub: \(sub.shortString())")

//let big_1847 = ReallyBigInt(numString:"1847")
//
//let big_1 = ReallyBigInt(mag:0)
//let big_10 = ReallyBigInt(mag:1)
//let big_100 = ReallyBigInt(mag:2)
//let big_1K = ReallyBigInt(mag:3)
//let big_100T = ReallyBigInt(mag:14)
//
//let really_big = ReallyBigInt(numString:"912347893461798657182192792")
//let mind_bogglingly_big = ReallyBigInt(numString:"329847279832649170895791082371098")
//
//let now_thats_just_rediculous_big = ReallyBigInt(numString:"90823479081273498720891748726597816597868756923784658728456978236459763978456978628718478902740897089271039847120893740892708927803972893729871029837490827349821730489218746287932698723649817637861897408974089708236879649578672854872903847592813740892748023067812693748329127349871230894718923740616597823657982634957824897142893708912374086786435789274958792314710892347734001293809128309128407985729385729847190809180918230981029380912391749879836984236598728768471974917394018975981657865789234658147589027409837418912436784356843275098750897231849702893146872136789643587623489572390847234087")
//
//let big_addition = really_big + mind_bogglingly_big
//let rediculous_addition = mind_bogglingly_big + now_thats_just_rediculous_big
//
//println("1847: \(big_1847.shortString())")
//println("100T: \(big_100T.shortString())")
//println("Large Number Addition: \(big_addition.shortString())")
//println("Rediculously Large Number Addition: \(rediculous_addition.shortString())")
//
//var unfathomably_big_string = ""
//for _ in 0..<10000
//{
//    unfathomably_big_string += "9"
//}
//
//var unthinkably_big_string = ""
//for _ in 0..<10000
//{
//    unthinkably_big_string += "1"
//}
//
//let just_to_prove_the_point = ReallyBigInt(numString:unfathomably_big_string) + ReallyBigInt(numString:unthinkably_big_string)
//
//println("Unfathomably Big: \(just_to_prove_the_point.shortString())")

