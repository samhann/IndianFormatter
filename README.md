IndianFormatter
===================



A number formatter to format numbers in the Indian format on iOS.

    NSNumberFormatter.indianStringFromNumber(NSNumber(int: 1001)) // "Ten Thousand And One "
    NSNumberFormatter.longCurrencyStringFromRupees(2500,paise: 53) // "Rupees Two Thousand ,Five Hundred  And Fifty Three Paise Only"