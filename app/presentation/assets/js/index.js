$(document).ready(function ($) {
  $(".table-row").click(function () {
    window.document.location = $(this).data("href");
  });
});

// Get the modal
const modal = document.getElementsByClassName("modal");

// Get the button that opens the modal
const btn = document.getElementsByClassName("myBtn");

// Get the <span> element that closes the modal
const span = document.getElementsByClassName("close");

// When the user clicks on the button, open the modal

btn[0].onclick = function () {
  modal[0].style.display = "block";
};
btn[1].onclick = function () {
  modal[1].style.display = "block";
};
btn[2].onclick = function () {
  modal[2].style.display = "block";
};

span[0].onclick = function () {
  modal[0].style.display = "none";
};

span[1].onclick = function () {
  modal[1].style.display = "none";
};

span[2].onclick = function () {
  modal[2].style.display = "none";
};

// When the user clicks on <span> (x), close the modal
// span.onclick = function () {
//   modal.style.display = "none";
// };

// When the user clicks anywhere outside of the modal, close it
window.onclick = function (event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
};
