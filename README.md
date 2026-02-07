## General Information

This exercise is divided into two parts:
- **Part 1 (Required)**: Create a bill splitting calculator with a single screen
- **Part 2 (Optional)**: Add persistence and additional features

---

# Part 1: Bill Splitting Calculator (Required)

Create a SwiftUI application that calculates how to split a restaurant bill among multiple people, including tip.

---

## 1.1 Project Setup

### Objective
Create a new SwiftUI project and set up the basic structure.

### Requirements
- [ ] Create a new Xcode project called "SplitBill"
- [ ] Select SwiftUI as the interface

---

## 1.2 Input Controls

### Objective
Create the input section where users enter bill information.

### Requirements
- [ ] Add a `TextField` for entering the total bill amount
  - [ ] Must only accept numeric input (use `.keyboardType(.decimalPad)`)
  - [ ] Add a placeholder text (e.g., "Enter bill total")
- [ ] Add a `Picker` with `.segmented` style for tip percentage
  - [ ] Options: 0%, 10%, 15%, 20%
- [ ] Add a `Stepper` for the number of people
  - [ ] Minimum: 1 person
  - [ ] Maximum: 10 people
  - [ ] Display the current number of people as text

### Hints
- For the TextField with currency, you can use a simple String binding and convert to Double when calculating
- Use `@State` for each input value
- The Picker needs an array of tip options: `[0, 10, 15, 20]`

---

## 1.3 Person Cards

### Objective
Display a card for each person showing their share of the bill.

### Requirements
- [ ] For each person, display a card that shows:
  - [ ] Person number (e.g., "Person 1", "Person 2")
  - [ ] **Total amount** to pay
  - [ ] **Bill portion** (amount from the bill, before tip)
  - [ ] **Tip portion** (amount from the tip only)
- [ ] Cards must update automatically when any input changes
- [ ] Number of cards must match the number of people selected
- [ ] If there are 3 people, show 3 cards; if 5 people, show 5 cards

### Hints
- Use `ForEach(0..<numberOfPeople, id: \.self)` to generate the cards
- Create a separate `View` struct for the card (e.g., `PersonCard`)
- Use computed properties for calculations:
  ```swift
  var tipAmount: Double {
      // total bill * tip percentage / 100
  }
  
  var totalWithTip: Double {
      // total bill + tip amount
  }
  
  var perPersonTotal: Double {
      // total with tip / number of people
  }
  ```
- Format currency using `String(format: "%.2f", amount)` or a `NumberFormatter`
<img width="477" height="907" alt="Captura de pantalla 2026-02-07 a la(s) 12 52 54 p m" src="https://github.com/user-attachments/assets/34d8cd59-4c59-48d0-a520-ec9d6e51cf34" />

---

## 1.4 Visual Design

### Objective
Make the app visually clear and easy to use.

### Requirements
- [ ] Use appropriate spacing and padding
- [ ] Group related elements with clear visual hierarchy
- [ ] Cards should be visually distinct (use background color, rounded corners, or shadows)
- [ ] Labels should clearly indicate what each value represents
- [ ] Use a `ScrollView` to allow scrolling when there are many cards

### Hints
- Use `VStack` and `HStack` to organize your layout
- Consider using `Section` or `GroupBox` for grouping
- `.background()` with `.cornerRadius()` creates nice card effects

---

## 1.5 Code Organization

### Objective
Write clean, organized, and maintainable code.

### Requirements
- [ ] Extract the person card into its own `View` struct
- [ ] Use meaningful variable names
- [ ] Add comments for complex calculations
- [ ] No hardcoded strings for repeated text (use constants if needed)

---

## Expected Visual Layout

```
┌─────────────────────────────────────┐
│  Bill Total                         │
│  ┌─────────────────────────────────┐│
│  │ $ 120.00                        ││
│  └─────────────────────────────────┘│
│                                     │
│  Tip Percentage                     │
│  ┌───────┬───────┬───────┬───────┐ │
│  │  0%   │  10%  │  15%  │  20%  │ │
│  └───────┴───────┴───────┴───────┘ │
│                                     │
│  Number of People            - 3 +  │
│                                     │
│  ┌─────────────────────────────────┐│
│  │ Person 1                        ││
│  │ Total: $46.00                   ││
│  │ Bill: $40.00 | Tip: $6.00       ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │ Person 2                        ││
│  │ Total: $46.00                   ││
│  │ Bill: $40.00 | Tip: $6.00       ││
│  └─────────────────────────────────┘│
│  ┌─────────────────────────────────┐│
│  │ Person 3                        ││
│  │ ...                             ││
│  └─────────────────────────────────┘│
└─────────────────────────────────────┘
```

---

# Part 2: Extra Features (Optional)

Complete these features if you finish Part 1 early.

---

## 2.1 Bills List with Navigation

### Objective
Create a list of saved bills with navigation to create and edit them.

### Requirements
- [ ] Create a main screen with a `List` showing all saved bills
- [ ] Each list row should display:
  - [ ] Date of the bill
  - [ ] Total amount
  - [ ] Number of people
- [ ] Add a "+" button in the toolbar to create a new bill
- [ ] Tapping a bill should navigate to the detail/edit screen
- [ ] Use `NavigationStack` and `NavigationLink`

### Hints
- Create a `Bill` model struct
- Create a `BillListView` as your new main view
- The detail view is your existing calculator, modified to edit a bill

---

## 2.2 JSON Persistence

### Objective
Save bills to a JSON file so they persist between app launches.

### Requirements
- [ ] Create a `Bill` model that conforms to `Codable` and `Identifiable`
- [ ] Save the bills array to a JSON file in the Documents directory
- [ ] Load bills from the JSON file when the app starts
- [ ] Save automatically when a bill is added or modified

### Suggested Data Model
```swift
struct Bill: Codable, Identifiable {
    let id: UUID
    var date: Date
    var total: Double
    var tipPercentage: Int
    var numberOfPeople: Int
    var people: [Person]
}

struct Person: Codable, Identifiable {
    let id: UUID
    var name: String
    var hasPaid: Bool
}
```

### Hints
- Use `JSONEncoder` and `JSONDecoder`
- Use `FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first`
- Check if the file exists before trying to load

---

## 2.3 Payment Tracking

### Objective
Track which people have paid their share.

### Requirements
- [ ] Add a button or toggle to each person's card to mark as "Paid"
- [ ] When marked as paid, the card should visually indicate it (e.g., checkmark, green color, strikethrough)
- [ ] When **all** people have paid:
  - [ ] Show a "✅ Fully Paid" indicator on the detail screen
  - [ ] Show a "Paid" badge in the list view
- [ ] The payment status must be saved in the JSON
<img width="477" height="907" alt="Captura de pantalla 2026-02-07 a la(s) 12 53 35 p m" src="https://github.com/user-attachments/assets/8faf01da-3f81-425c-a1b0-e6298da686d8" />

---

## Suggested Project Structure

```
SplitBill/
├── SplitBillApp.swift
├── Models/
│   └── Bill.swift
├── Services/
│   └── BillStorageService.swift (for Part 2)
├── Views/
│   ├── BillCalculatorView.swift
│   ├── PersonCardView.swift
│   ├── BillListView.swift (for Part 2)
│   └── ContentView.swift
└── Preview Content/
```
