// struct Person{
//     name: String,
//     age: u32,
// }
// fn main(){
//     let person = Person {
//         name: String::from ("Gangadhar"),
//         age: 22,
//     };
//     println!("{}",person.name);
//     println!("{}",person.age);
// }

struct Rectangle{
    width: u32,
    height: u32,
}

fn main(){
    let rectangle = Rectangle{
        width:10,
        height:15,
    };
    println!("{}",rectangle.width * rectangle.height);
}
