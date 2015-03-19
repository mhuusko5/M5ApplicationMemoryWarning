# M5ApplicationMemoryWarning

Memory warning notification that works on iOS *and Mac*.

## Usage

```objective-c
[NSNotificationCenter.defaultCenter addObserverForName:kM5ApplicationDidReceiveMemoryWarningNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
  NSLog(@"Received memory warning!");        
}];
```
