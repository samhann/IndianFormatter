import UIKit

var list = ["","One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Eleven","Twelve","Thirteen","Fourteen","Fifteen","Sixteen","Seventeen","Eighteen","Nineteen","Twenty"]

var tens :[String] = ["Zero","Ten","Twenty","Thirty","Forty","Fifty","Sixty","Seventy","Eighty","Ninety"]

var extractNumbers = [2,1,2,2]
var suffixes = ["","Hundred","Thousand","Lakh"]
var separators = ["","",",",","]
var oneCrore = 10000000
func twoDigitToString(theNum : Int)->String
{
    if (abs(theNum) < 20) {
        return list[theNum]
    }
    else {
        let first = tens[theNum/10]
        let second = list[theNum % 10]
        
        if(second != ""){
            return first + " " + second
        }
        
        return first
    }
}



func extract(var theNum : Int,var numToExtract:Int)->Int
{
    var result = 0
    var power = 1
    
    while(numToExtract > 0) {
        result += (theNum % 10)*power
        theNum /= 10
        power *= 10
        numToExtract--
    }
    return result
}


func fullNumberToString(var number: Int) -> String
{
    if(number == 0){
        return "Zero"
    }
    
    if(number >= oneCrore) {
        return fullNumberToString(number/oneCrore) + " Crore " + fullNumberToString(number % oneCrore)
    }
    
    var retStrings :[String] = []
    var prevExtracted = -1
    
    for (index,num) in extractNumbers.enumerate() {
        let extracted = extract(number,numToExtract: num)
        
        number /= Int(pow(10.0, Double(num)))
        if(extracted != 0) {
            var string = twoDigitToString(extracted)
            
            if suffixes[index] != "" {
                string += " " + suffixes[index]
            }
            
            if retStrings.count == 1 && prevExtracted == 0 {
                string += " And "
            }
            else if index > 0{
                string += " \(separators[index])"
            }
            
            prevExtracted = index
            retStrings.append(string)
            
        }
    }
    
    print(retStrings)
    retStrings = retStrings.reverse()
    
    return retStrings.joinWithSeparator("")
}

func numToString(let number : Int)->String
{
    return ((number < 0) ? "Minus " : "") + fullNumberToString(abs(number))
}

func numToCurrencyString(let rupees : Int , let paise : Int , let suffix:String , let rupeeString : String = "Rupees")->String
{
    var components : [String] = []
    if rupees != 0 || paise == 0{
        components.append(rupeeString)
        components.append(numToString(rupees))
    }
    if paise != 0 {
        if rupees != 0 {
            components.append("And")
        }
        components.append(numToString(paise) + (paise == 1 ? " Paisa" : " Paise"))
        
    }
    components.append(suffix)
    return components.joinWithSeparator(" ")
}

extension NSNumberFormatter
{
    static func indianStringFromNumber(let number : NSNumber)->String
    {
        return numToString(number.integerValue)
    }
    
    static func longCurrencyStringFromRupees(let number : Int,let paise : Int)->String
    {
        
        return numToCurrencyString(number, paise: paise, suffix: "Only")
    }
    
    static func shortCurrencyStringFromRupees(let number : Int,let paise : Int)->String
    {
        
        return numToCurrencyString(number, paise: paise, suffix: "")
    }
    
}