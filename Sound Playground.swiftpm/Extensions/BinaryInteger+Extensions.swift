//
//  BinaryInteger+Extensions.swift
//  
//
//  Created by Helloyunho on 2023/04/14.
//

import Foundation

infix operator %%: MultiplicationPrecedence

func %%<T: BinaryInteger>(lhs: T, rhs: T) -> T {
    return (lhs % rhs + rhs) % rhs
}
