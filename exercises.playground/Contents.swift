import UIKit

//შევქმნათ Class Book.
//Properties: bookID(უნიკალური იდენტიფიკატორი Int), String title, String author, Bool isBorrowed.
//Designated Init.

class Book{
    let bookID = UUID()
    var title: String
    var author: String
    var isBorrowed: Bool
    
    init(title: String,
         author: String,
         isBorrowed: Bool = false)
    {
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }
    //Method რომელიც ნიშნავს წიგნს როგორც borrowed-ს.
    func MarkAsBorrowed(){
        if isBorrowed{
            print("Book is already borrowed:))")
        }
        else{
            isBorrowed = true
        }
    }
    //Method რომელიც ნიშნავს წიგნს როგორც დაბრუნებულს.
    func ChangeStatus(){
        if isBorrowed == false{
            print("Book is not borrowed :)")
        }
        else{
            isBorrowed = false
        }
    }
    
    func Print() -> String{
        return "Id: \(bookID), title: \(title), author: \(author), isBorrowed \(isBorrowed)"
    }
}

//შევქმნათ Class Owner

//Properties: ownerId(უნიკალური იდენტიფიკატორი Int), String name, Books Array სახელით borrowedBooks.
//Designated Init.
//Method რომელიც აძლევს უფლებას რომ აიღოს წიგნი ბიბლიოთეკიდან.
//Method რომელიც აძლევს უფლებას რომ დააბრუნოს წაღებული წიგნი

class Owner{
    let ownerId = UUID()
    var name: String
    var borrowedBooks: [Book]
    
    init(name: String){
        self.name = name
        borrowedBooks = []
    }
    //Method რომელიც აძლევს უფლებას რომ აიღოს წიგნი ბიბლიოთეკიდან.
    func CheckPermision(book: Book)->Bool{
        if book.isBorrowed == false{
            book.MarkAsBorrowed()
            borrowedBooks.append(book)
            return true
        }
        else{
            return false
        }
    }
    ////Method რომელიც აძლევს უფლებას რომ დააბრუნოს წაღებული წიგნი
    func ReturnBookToLibrary(book: Book)->Bool{
        if book.isBorrowed == true{
            book.ChangeStatus()
            var Id = GetBookId(boo: book)
            if Id != -1{
                borrowedBooks.remove(at: Id)
                return true
            }
        }
        return false
    }
    
    func GetBookId(boo: Book)->Int{
        for i in 0 ... borrowedBooks.count{
            if boo.bookID == borrowedBooks[i].bookID{
                return i
            }
        }
        return -1
    }
    
    func Print() -> String{
        return "ownerId: \(ownerId), name: \(name)"
    }
}

//შევქმნათ Class Library
//Properties: Books Array, Owners Array.
//Designated Init.
class Library{
    var BooksArray: [Book]
    var OwnersArray: [Owner]
    
    init(){
        BooksArray = []
        OwnersArray = []
    }
    ////Method წიგნის დამატება, რათა ჩვენი ბიბლიოთეკა შევავსოთ წიგნებით.
    func AddBook(book: Book){
        BooksArray.append(book)
        print("Added successfully, book id: \(book.bookID)")
    }
    //Method რომელიც ბიბლიოთეკაში ამატებს Owner-ს.
    func AddOwner(owner: Owner){
        OwnersArray.append(owner)
        print("Added successfully, owner id: \(owner.ownerId)")
    }
    //Method რომელიც პოულობს და აბრუნებს ყველა ხელმისაწვდომ წიგნს.
    func GetAllByStatus() -> [Book]{
        var arr: [Book] = []
        for i in BooksArray{
            if i.isBorrowed == false{
                arr.append(i)
            }
        }
        return arr
    }
    //Method რომელიც პოულობს და აბრუნებს ყველა წაღებულ წიგნს.
    func GetAllBorrowed() -> [Book]{
        var arr: [Book] = []
        for i in BooksArray{
            if i.isBorrowed{
                arr.append(i)
            }
        }
        return arr
    }
    //Method რომელიც ეძებს Owner-ს თავისი აიდით თუ ეგეთი არსებობს.
    func GetOwnerById(Id: UUID) -> Owner?{
        for i in OwnersArray{
            if i.ownerId == Id{
                return i
            }
        }
        return nil
    }
    
    //Method რომელიც ეძებს წაღებულ წიგნებს კონკრეტული Owner-ის მიერ.
    func OwnersBorrowedBooks(owner: Owner) -> [Book]?{
      
        var userId = GetUserId(own: owner)
        if userId != nil{
            return owner.borrowedBooks
        }
        return nil
    }
    
    func GetUserId(own: Owner) -> UUID? {
        for i in OwnersArray {
            if i.ownerId == own.ownerId{
                return i.ownerId
            }
        }
        return nil
    }
    
    //Method რომელიც აძლევს უფლებას Owner-ს წააღებინოს წიგნი თუ ის თავისუფალია.
     
    func GivePermision(owner: Owner, boo: Book)
    -> Bool{
        if GetBookId(book: boo) == false{
            return false
        }
        if GetUserId(own: owner) == nil{
            return false
        }
        var status = owner.CheckPermision(book: boo)
        return status
    }
    
    //vamowmeb tu arsebobs aseti wigni bibliotekashi
    func GetBookId(book: Book) -> Bool{
        for i in BooksArray{
            if i.bookID == book.bookID{
                return true
            }
        }
        return false
    }
}

//შევქმნათ რამოდენიმე წიგნი და რამოდენიმე Owner-ი, შევქმნათ ბიბლიოთეკა.

var book1 = Book(title: "მზე მთვარე და პურის ყანა, მანუშაკა მელოდება", author: "თეიმურაზ ბაბლუანი")
var book2 = Book(title: "როგორ გავხდი ის ვინც ვარ", author: "მიშელ ობამა")
var book3 = Book(title: "მექანიკური ფორთოხალი", author: "ენტონი ბერჯენსი")

var owner1 = Owner(name: "რაისა ბადალ")
var owner2 = Owner(name: "ნიკოლა ბერჯენსი")
var owner3 = Owner(name: "ტომ ჰარდი")
var owner4 = Owner(name: "ანჯელინა ჯოლი")
var owner5 = Owner(name: "კენი")

//დავამატოთ წიგნები და Owner-ები ბიბლიოთეკაში

var PublicLibrary = Library()
PublicLibrary.AddBook(book: book1)
PublicLibrary.AddBook(book: book2)
PublicLibrary.AddBook(book: book3)
PublicLibrary.AddOwner(owner: owner1)
PublicLibrary.AddOwner(owner: owner2)
PublicLibrary.AddOwner(owner: owner3)
PublicLibrary.AddOwner(owner: owner4)
PublicLibrary.AddOwner(owner: owner5)

//წავაღებინოთ Owner-ებს წიგნები და დავაბრუნებინოთ რაღაც ნაწილი.

PublicLibrary.GivePermision(owner: owner1, boo: book1)
//shevamowmot tu sheecvala wigns statusi
print(book1.isBorrowed)
PublicLibrary.GivePermision(owner: owner1, boo: book2)
PublicLibrary.GivePermision(owner: owner2, boo: book3)
//raxan waghebulia mesame wigni es pirovneba veghar waighebs da shesabamisad funqcia abrunebs false
PublicLibrary.GivePermision(owner: owner2, boo: book3)
owner1.ReturnBookToLibrary(book: book1)
//raxan daabruna dabechdavs false
print(book1.isBorrowed)
print("---------------------------------")

//დავბეჭდოთ ინფორმაცია ბიბლიოთეკიდან წაღებულ წიგნებზე
var bookarr: [Book] = PublicLibrary.GetAllBorrowed()
for i in bookarr
{
    print(i.Print())
}
print("---------------------------------")

//დავბეჭდოთ ინფორმაცია ხელმისაწვდომ წიგნებზე
var booklist: [Book] = PublicLibrary.GetAllByStatus()
for i in booklist{
    print(i.Print())
}
print("---------------------------------")

// გამოვიტანოთ წაღებული წიგნები კონკრეტულად ერთი Owner-ის მიერ.
if let ownersbook = PublicLibrary.OwnersBorrowedBooks(owner: owner1) {
    for book in ownersbook {
        print(book.Print())
    }
}

//შექმენით კლასი გამონათქვამების გენერატორი, სადაც განმარტავთ გამონათქვამს-ს რომელიც იქნება სტრინგებისგან შემდგარი კოლექცია. შექმენით მეთოდი სადაც დააბრუნებთ შერჩევითად სხვადასხვა ჯოუქს და დაბეჭდავთ მას, ასევე ჩაამატეთ მეთოდი, რომელიც ჩასვამს ან ამოაკლებს გამონათქვამს სიიდან. მოცემული გაქვთ “ქილერ” გამონათქვამების სია:
//დავინახე თუ არა მივხვდი, რომ – ” დევიღუპე. ”
//ისეთი აფერისტია, რომ ბანკომატებიც კი აძლევენ ფულს ვალად
//სულის ტკივილამდე ვტკივილობ….
//იმედის შუქი ჩამიქრა ვინმემ ასანთი მათხოვეთ
//არავინაა უნიკალური…მე არავინ ვარ…ე.ი უნიკალური ვარ
//ფულის წვიმა რომ მოდიოდეს ნისიების რვეული დამეცემა თავზე
//თქვენ მოჰკალით ძერა?
//ბებიააა... ბებია... ოლია მათხოვარი მევიდა...
//მზე აღარ ამოდის ჩაგვიჭრეს

class StringGenerator{
    var randomJoke: [String]
    
    init(){
        randomJoke = []
    }
    
    func AddJoke(str: String) -> Bool {
        if randomJoke.contains(str){
            return false
        }
        else{
            randomJoke.append(str)
            return true
        }
    }
    
    func DeleteJoke(str: String) -> Bool{
        if randomJoke.contains(str){
            if let ind = randomJoke.firstIndex(of: str){
                randomJoke.remove(at: ind)
                return true
            }
        }
            return false
    }
    
    func GetRandomString() -> String{
        var rng = SystemRandomNumberGenerator()
        let randInd = rng.next(upperBound: UInt(randomJoke.count))
        return randomJoke[Int(randInd)]
    }
}

print("--------------------")
var randgenerator = StringGenerator()
randgenerator.AddJoke(str: "დავინახე თუ არა მივხვდი, რომ –  დევიღუპე.")
randgenerator.AddJoke(str: "ისეთი აფერისტია, რომ ბანკომატებიც კი აძლევენ ფულს ვალად")
randgenerator.AddJoke(str: "სულის ტკივილამდე ვტკივილობ…")

print(randgenerator.GetRandomString())
