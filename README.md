# CountryPickerTextfield

TextField with country selection on left allowing to add country context to a UITextField.

## ⬇️ Installation

### Cocoapods

Add my personal repo to your Podfile:

```ruby
source 'https://github.com/jarnal/PodsRepository.git'
```

Add the following line to your Podfile::

```ruby
pod "CountryPickerTextfield"
```

Soon il will be directly available in cocoapods repo.

## 📲 Example

This framework was built using [Playground Driven Development](https://medium.com/flawless-app-stories/playground-driven-development-in-swift-cf167489fe7b).

Compile `CountryPickerTextfieldFramework` target for `Generic iOS Device` first.
Compile it for at least one simulator device if you want to use it in playground.

Enjoy 🎉 !

## 🔦 How does it work ?

```swift

// If you want to use user locale language as default country just instantiate:
let countryPickerTextField = CountryPickerTextField()

// You can force the language by setting 'forceRegionTo' in constructor:
let countryPickerTextField = CountryPickerTextField(forceRegionTo: "FR")

// You can choose the type of label that you want to display next to country flag by setting buttonTitleMode:
let countryPickerTextField = CountryPickerTextField(forceRegionTo: "ES", buttonTitleMode: .iso_code)
```

Or you can just inherit from CountryPickerTextField in Storyboard.

## 👂 Events

If you subclass CountryPickerTextField you have access to multiple events where you can add custom logic:

```swift

func userDidChangeInputMode(inputView: UIView?, inputAccessoryView: UIView?) {...}

func didStartPickingCountry(){...}

func didEndPickingCountry(){...}

func didSelectCountry(_ country: CountryCode) {...}
```

## 💅 Customize

💣 You can exlude countries from the list:

```
textField.exclude(countryCodes: ["FR"])
```

💯 You can prioritize some countries to display on top of the list:

```
textField.prioritize(countryCodes: ["ES", "DE"])
```

👌 Or you can simply pass the countries that you want to display:

```
textField.include(countryCodes: ["ES", "FR", "DE"])
```

🎨 You can customize the color of the flag button label:

```swift
textField.buttonTextColor = UIColor.myColor
```

🎨 You can customize the color of the input accessory view buttons:

```swift
textField.toolbarTintColor = UIColor.myColor
```

## 🗣 Discussion

The framework is based mostly on `CountryContextable` protocol and have just a little bit of boilerplate inside `CountryPickerTextfield`.

This allow to add the feature to a class that already inherits from UITextField.

Composition FTW 🎉 !

If you have a suggestion or any ideas to improve this project, email me at jonathan.arnal89@gmail.com.
