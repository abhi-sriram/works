<!doctype html>
<html lang="en">
   <head>
      
   </head>
   <body >

    <input style="width: 300px;height:40px" type="number" min="0" max="250000" placeholder="Enter a number between 0 and 250000" id="getNumber">
    <input type="submit"  onClick="checkNumberIsSquare()">
    <p id="showOutput"></p>

    <script>
        let arr = [];
        for (let i = 0; i < 500; i++) {
            arr.push(i**2);
        }

        function binary_search(num){
            let low = 0;
            let high = 499;
            let mid = 0;
            while(low<= high){
                mid = Math.floor((low+high)/2);
                if(arr[mid]<num){
                    low = mid+1;
                }
                else if(arr[mid]>num){
                    high = mid-1;
                }
                else{
                    return mid;
                }
            }
            return -1;
        }
        
        function checkNumberIsSquare(){
            let number = document.getElementById('getNumber').value;
            if(number>250000){
                document.getElementById('showOutput').innerHTML = 'You should enter value between 0 and 250000';
            }else{
                
                let find = binary_search(number);
                if(find==-1){
                    document.getElementById('showOutput').innerHTML = 'Enterd number '+number+" is not a square";
                }else{
                    document.getElementById('showOutput').innerHTML = 'Enterd number '+number+" is square";
                }
            }
        }
    </script>
      
   </body>
</html>

