package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"strings"
	"strconv"
)

func one(arr []string) int {
	var i int
	arr_length := len(arr)
	arr = append(arr, arr[0])
	for v := 0; v < arr_length; v++ {
		if arr[v] == arr[v + 1] {
			temp_int, _ := strconv.Atoi(arr[v])
			i = i + temp_int
		}
	}
  return i
}

func two(arr []string) int {
	i := 0
	arr_len := len(arr)
	mid := (arr_len / 2)
	for v := 0; v <= mid; v++ {
		mid_index := (v + mid) % arr_len
		if arr[v] == arr[mid_index] {
			temp_int, _ := strconv.Atoi(arr[v])
			i = i + (temp_int * 2)
		}
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