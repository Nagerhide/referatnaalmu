
#Swift and Scala use external servers, so there banned

#Compile all languages
gcc -O3 -lm Codes/C.c -o Codes/C
rustc Codes/Rust.rs -o Codes/Rust
fpc Codes/Pascal.pas
go build -o Codes/Go Codes/Go.go 
kotlinc Codes/Kotlin.kt -include-runtime -d Codes/Kotlin.jar
ghc Codes/Haskell.hs -o Codes/Haskell
csc Codes/C#.cs

for i in {1..10}; do
	
	#Test all languages

	time ./Codes/C < "Tests/t_${i}.in" > output
	time ./Codes/Rust < "Tests/t_${i}.in" > output
	time ./Codes/Pascal < "Tests/t_${i}.in" > output
	time ./Codes/Go < "Tests/t_${i}.in" > output
	time java -jar Codes/Kotlin.jar < "Tests/t_${i}.in" > output
	time lua Codes/Lua.lua < "Tests/t_${i}.in" > output
	time dart run Codes/Dart.dart < "Tests/t_${i}.in" > output
	time python3 Codes/Python.py < "Tests/t_${i}.in" > output
	time node Codes/Javascript.js < "Tests/t_${i}.in" > output
	time ruby Codes/ruby.rb < "Tests/t_${i}.in" > output
	time php Codes/PHP.php < "Tests/t_${i}.in" > output
	time ./Codes/Haskell < "Tests/t_${i}.in" > output
	time java Codes/Java.java < "Tests/t_${i}.in" > output
	time elixir Codes/elixir.exs < "Tests/t_${i}.in" > output
	time mono C#.exe < "Tests/t_${i}.in" > output
	time Rscript Codes/simulation.R < "Tests/t_${i}.in" > output

done
