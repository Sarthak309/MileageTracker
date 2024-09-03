# Mileage Tracker iOS App

## Overview

This is a Mileage Tracker iOS app built using Swift and SwiftUI. The app allows users to track their bike's mileage by inputting the current kilometers, the amount of petrol in liters, and the date of entry. The app calculates the mileage based on the distance covered since the last entry and stores this information along with each entry. The mileage is then displayed in a list format with options to delete entries.

## Features

- Add entries with current kilometers, petrol in liters, and date.
- Calculate mileage based on the previous entry and current input.
- Display a list of entries with mileage, kilometers, petrol, and date.
- Swipe to delete entries with a delete animation.
- "Done" button on the keyboard to dismiss it.
- Visual feedback for mileage comparison (improved mileage, equal, or reduced).

## Tech Stack

- **Frontend**: Swift, SwiftUI
- **Data Storage**: UserDefaults (via `@AppStorage`)

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/mileage-tracker-ios.git
   cd mileage-tracker-ios
   ```
   
2. **Open the Project**
   ```bash
   open MileageTracker.xcodeproj
   ```

3. **Run the App**

   Select the target device or simulator and click the Run button in Xcode.

## Usage

1. **Adding an Entry**

    - Enter the current kilometer reading from your odometer.
    - Enter the amount of petrol in liters.
    - Select the date for the entry.
    - Tap "Add Entry" to save the entry.


2. **Viewing Entries**

    - The list of entries will display the kilometers, petrol, mileage, and date.
    - The mileage is calculated based on the distance covered since the last entry.


3. **Deleting Entries**

    - Swipe left on an entry to reveal a delete button.
    - Tap the delete button to remove the entry.


## Data Model

### MileageEntry
  - **id**: Unique identifier for the entry.
  - **date**: Date of the entry (format: DD/MM/YYYY).
  - **kilometers**: Current kilometers.
  - **petrolLiters**: Amount of petrol in liters.
  - **mileageData**: Mileage information.
    
### Mileage Data
  - **mileage**: Calculated mileage (kmpl).
  - **mileageComparisonFromPrevMileage**: Comparison status with the previous entry (more, equal, less).

  
## Contributing
Contributions are welcome! Please fork the repository and submit a pull request with your changes.


## Contact
For any questions or suggestions, please reach out to agrawal.sarthak87@gmail.com .

   
