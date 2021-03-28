# item_of_the_day

A package which determines what item should be showcased on given days.

Given json of the form

```json
{
    "order": [
        "item1",
        "item2",
        "item3",
    ],
    "startDate": 1588636800000
}
```

`IItemOfTheDayService.init()` will deserialize this object, while `IItemOfTheDayService.today` will then return the item valid for today.

Note that all ids should not contain spaces, and they will be removed if needed. startDate is expected to be a utc timestamp in milliseconds.
