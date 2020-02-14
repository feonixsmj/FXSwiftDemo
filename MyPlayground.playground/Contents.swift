import UIKit

var str = "Hello, playground"

func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

//函数指针
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    //返回一个函数
    return addOne
}
var ss = makeIncrementer()
ss(7)

//函数作为参数
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

//------------------------------------------
func aaa(list : [Int], condition: (Int) -> Bool) -> Bool{
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func less(number: Int) -> Bool {
    return number < 5
}

var nums = [20,10,4,5,6]

aaa(list: nums, condition: less)
//------------------------------------------
let vc : UIViewController;

//两数之和
/*
给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

示例:

给定 nums = [2, 7, 11, 15], target = 9

因为 nums[0] + nums[1] = 2 + 7 = 9
所以返回 [0, 1]
 */
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    
    var index = 0
    var dict = [Int:Int]()
    for value in nums {

        if (dict.keys.contains(target-value)) {
            let index1 = dict[target-value]
            
            return [index1!, index];
        }
        dict[value] = index
        index += 1
    }
    return [1,2]
}

print(INT_MAX)
twoSum([3,2,4], 6)

func removeDuplicates(_ nums: inout [Int]) -> Int {
    if nums.count == 0 {
        return 0
    }
    
    var i = 0
    for j in 1..<nums.count {
        if nums[j] != nums[i] {
            i += 1
            nums[i] = nums[j]
        }
    }
    return i + 1
}

func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    
}

func list(_ numberArr: [Int]) -> Int{
    
    var numberArr = numberArr
    
    numberArr .removeFirst()
    

    if let first = numberArr.first {
        print(first)
    }
    
    let hello : String?
    print(hello)
    
    
    return numberArr.first!
}

list([1,2,3,4])








