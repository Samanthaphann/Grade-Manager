//
//  main.swift
//  Grade Management
//
//  Created by StudentAM on 1/31/24.
//

import Foundation
import CSV

import Foundation
import CSV

var studentNames: [String] = []
var studentGrades: [[String]] = []
var finalGrades: [Double] = []
var indexStored: Int = 0

do {
    let stream = InputStream(fileAtPath: "/Users/studentam/Desktop/names.csv")
    
    let csv = try CSVReader(stream: stream!)
    
    while let row = csv.next() {
        manageData(row)
    }
} catch {
    print("There was an error trying to read the file")
}

func manageData( _ studentInfo: [String]){
    var tempGrades: [String] = []
    for i in studentInfo.indices{
        if i == 0{
            studentNames.append(studentInfo[0])
        }else{
            tempGrades.append(studentInfo[i])
        }
    }
    studentGrades.append(tempGrades)
    calculateFinalGrade(tempGrades)
}

mainMenu()

func mainMenu(){
    print("Welcome to the Grade Manager!\n",
          "What would you like to do? (Enter the number):\n",
          "1. Display grade of a single student \n",
          "2. Display all grades for a student \n",
          "3. Display all grades of ALL students \n",
          "4. Find the average grade of the class \n",
          "5. Find the average grade of an assignment \n",
          "6. Find the lowest grade in the class \n",
          "7. Find the highest grade of the class \n",
          "8. Filter students by grade range \n",
          "9. Quit \n"
    )
    
    if let userPick = readLine() {
        if userPick == "1"{
            singleGrade()
        } else if userPick == "2"{
            allGrade()
        } else if userPick == "3"{
            allStudentsGrade()
        } else if userPick == "4"{
            averageClass()
        } else if userPick == "5"{
            averageAssigment()
        } else if userPick == "6"{
            lowestGrade()
        } else if userPick == "7"{
            highestGrade()
        } else if userPick == "8"{
            filterGrade()
        } else if userPick == "9"{
            quit()
        }
    }
        
}
    
func singleGrade() {
    var indexStored = 0
    print("Enter student name to display their grade:")
    if let userPick = readLine(){
        let indexStored = findStudent(userPick)
        print("\(userPick)'s grade in the class is \(finalGrades[indexStored])")
    }
    mainMenu()
}
    
func findStudent(_ userPick: String)-> Int {
    //go through the students name and grabs it if matched
    //.lowercased make sure that it's not case sensitive
    for i in studentNames.indices{
        if userPick.lowercased() == studentNames[i].lowercased(){
            return i
        }
    }
    return -1
//            print("\(userPick)'s grade in the class is \(finalGrades[indexStored])")
}
    
func calculateFinalGrade(_ tempGrades: [String]){
    //create a variable for the sum of all numbers. Double lets you can input decimals
    var sum: Double = 0
        
    //goes through each of the grades in the list
    for eachGrade in tempGrades{
        if let studentGrades = Double(eachGrade){
            //if it matches then add it to the total sum
            sum += studentGrades
        }
    }
    finalGrades.append(sum/Double(tempGrades.count))
}
    

    
func allGrade() {
    print("Enter student name to display all grades:")
    if let userPick = readLine() {
        displayAllGrades(userPick)
    }
}
    
func displayAllGrades(_ userPick: String) {
    var found = false
        
    //for loop so if the student name is typed in, it grabs the input of that student is inputed
    for i in 0..<studentNames.count {
        let name = studentNames[i]
        //.lowercased makes it not case sensitive
        if name.lowercased() == userPick.lowercased() {
            //It prints ot the studnets
            print("\(userPick)'s grades: \(studentGrades[i])")
            found = true
        }
    }
    if found {

    }else {
        print("Student not found.")
    }
    mainMenu()
}
    
    
    
func allStudentsGrade() {
    // Iterate through each student using array indices
    for i in 0..<studentNames.count {
        let name = studentNames[i]
        let grades = studentGrades[i]
        print("\(name)'s grades: \(grades)")
    }
    mainMenu()
}

func averageClass(){
    calculateAverage()

}
    
func calculateAverage() {
    //create var to store the sum
    var sum: Double = 0
    //for loop to go through each grade
    for grade in finalGrades{
        sum += grade
    }
    //divide the sum of all grades by the number of students grade
    let classAverage = sum / Double(finalGrades.count)
    //round the decimal place to the hundreths place
    let roundedAverage = (classAverage * 100).rounded()/100
    //print the class average
    print("The class average is:\(roundedAverage)")
    mainMenu()
}

    
func averageAssigment(){
    print("What assignment would you like to get the average of? (1-10)")
    //create variable to store the sum
    //grab the user input
    //convert the user input into a integer
    //loop through the 2d array
    //use a for each loop
    //grab the specific assignment from each row and store it inside of sum
    //create a variable to store the average, set it equal to the sum/finalGrades.count
    //print out the average grade
    var sum: Double = 0
    if let userPick = readLine(), let assignmentNum = Int(userPick){
        for row in studentGrades{
            if let grade = Double(row[assignmentNum - 1]) {
                //grabs specific assignments and stores it inside of sum
                sum += grade
            }
            
        }
        //find the average
        let average = sum / Double(finalGrades.count)
        //rounds the average to the hundrets place
        let rounded = (average * 100).rounded()/100
        print("The average for assignment \(assignmentNum) is \(rounded)")
    }
    mainMenu()
}


func lowestGrade(){
    //create a variable for the lowest index
    var lowestIndex = 0
    //create a for loop to find the lowest Grade
    for i in 1...finalGrades.count - 1{
        if finalGrades[lowestIndex] > finalGrades[i]{
            lowestIndex = i
        }
    }
    //grab the students name
    let lowestStudent = studentNames[lowestIndex]
    //grabs the lowest grade
    let lowestGrade = finalGrades[lowestIndex]
    print("\(lowestStudent) has the lowest grade with the grade of \(lowestGrade)")
    mainMenu()
}
    
func highestGrade(){
    //create a variable for the highest index
    var highestIndex = 0
    //create a for loop to find the highest Grade
    for i in 1...finalGrades.count - 1{
        if finalGrades[highestIndex] < finalGrades[i]{
            highestIndex = i
        }
    }
    let highestStudent = studentNames[highestIndex]
    let highestGrade = finalGrades[highestIndex]
    print("\(highestStudent) has the highest grade with the grade of \(highestGrade)")
    mainMenu()
}
    
func filterGrade() {
    print("Enter the low range you would like to input")
    //inputs the low range number in
    if let filterLowRange = readLine(), let lowRange = Double(filterLowRange) {
        print("Enter the high range you would like to use")
        //inputs the high range number in
        if let filterHighRange = readLine(), let highRange = Double(filterHighRange) {
            //for loop to go through each student
            for i in finalGrades.indices {
                let rangeStudent = finalGrades[i]
                //checks if the student is in the range inputted
                if rangeStudent >= lowRange && rangeStudent <= highRange {
                    //if student is in range it prints out the name and grade
                    if i < studentNames.count {
                        print("Student: \(studentNames[i]), Grade: \(rangeStudent)")
                    }
                }
            }
            print()
        }
    }
    mainMenu()
}


func quit(){
print("Have a great rest of your day!")
}

