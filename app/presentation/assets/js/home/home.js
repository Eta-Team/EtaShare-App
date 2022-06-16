$(document).ready(function ($) {
  $(".table-row").click(function () {
    window.document.location = $(this).data("href");
  });
});

// HOME :
const modal = document.getElementsByClassName("modal");
const btn = document.getElementsByClassName("myBtn");
const span = document.getElementsByClassName("close");

btn[0].onclick = function () {
  modal[0].style.display = "block";
};

span[0].onclick = function () {
  modal[0].style.display = "none";
};
