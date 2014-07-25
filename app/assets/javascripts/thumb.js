// $(document).ready(function(){

// var imageLoader = document.getElementById('note_photo');
//     imageLoader.addEventListener('change', handleImage, false);
// var canvas = document.getElementById('photo_canvas');
// var ctx = canvas.getContext('2d');


// function handleImage(e){
//     var reader = new FileReader();
//     reader.onload = function(event){
//         var img = new Image();
//         var imgx = 75;
//         var imgy = 75;
//         img.onload = function(){
//             if (img.height > img.width) {
//                 imgx = 75 * img.width / img.height;
//             } else {
//                 imgy = 75 * img.height / img.width;
//             }
//             canvas.width = 75;
//             canvas.height = 75;
//             ctx.drawImage(img,0,0, imgx, imgy);
//         }
//         img.src = event.target.result;
//     }
//     reader.readAsDataURL(e.target.files[0]);     
// }

    
// });