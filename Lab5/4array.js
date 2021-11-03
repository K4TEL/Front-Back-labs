
function createArray() {
    var len = document.querySelector("input");
    return Array.from({length: len.value}, 
        () => Math.floor(Math.random() * 100));
};

function minmax(arr) {
    return Math.min.apply(null, arr) + Math.max.apply(null, arr);
};

function calculate() {
    var list = document.getElementById("list");
    list.innerHTML = "Масив: ";

    var arr = createArray();
    arr.forEach((item) => {
        list.innerHTML += item + " ";
    });

    var sum = document.getElementById("sum");
    sum.innerHTML = 'Сума мінімального та максимального: ' + minmax(arr);

    var sorted = document.getElementById("sorted");
    sorted.innerHTML = "Відсортований масив: ";

    var quick = quicksort(arr);
    quick.forEach((item) => {
        sorted.innerHTML += item + " ";
    });
};

function quicksort(arr) {
    if (arr.length <= 1) {
      return arr;
    }
  
    var pivot = arr[0];
    
    var left = []; 
    var right = [];
  
    for (var i = 1; i < arr.length; i++) {
      arr[i] < pivot ? left.push(arr[i]) : right.push(arr[i]);
    }
  
    return quicksort(left).concat(pivot, quicksort(right));
  };