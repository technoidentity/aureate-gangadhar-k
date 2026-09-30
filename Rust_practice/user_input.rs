use std::io;
fn main(){
    let mut input =String::new();
    println!("user input");
    io::stdin().read_line(&mut input).unwrap();
   // let n: i32 = input.trim().parse().unwrap();
   println!("{}",input);


}
