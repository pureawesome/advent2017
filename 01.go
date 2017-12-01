package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strings"
	"strconv"
	// "reflect"
)

func one(arr []string) int {
	var i int
	var x string
	for v := 0; v <= len(arr); v++ {
		if arr[0] == arr[1] {
			temp_int, _ := strconv.Atoi(arr[0])
			i = i + temp_int
		}
		x, arr = arr[0], arr[1:]
		arr = append(arr, x)
	}
  return i
}

func two(arr []string) int {
	var i int
	var x string
	mid := len(arr) / 2
	for v := 0; v <= len(arr); v++ {
		if arr[0] == arr[mid] {
			temp_int, _ := strconv.Atoi(arr[0])
			i = i + temp_int
		}
		x, arr = arr[0], arr[1:]
		arr = append(arr, x)
	}
  return i
}


func main() {
  input, err := ioutil.ReadFile("01.txt")
  if err != nil {
		log.Fatal(err)
	}

	data := string(input)
	arr := strings.Split(data, "")

	
  one := one(arr)
	fmt.Println(one)
	two := two(arr)
	fmt.Println(two)
}