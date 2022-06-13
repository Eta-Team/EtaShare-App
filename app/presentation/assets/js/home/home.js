$(document).ready(function ($) {
  $(".table-row").click(function () {
    window.document.location = $(this).data("href");
  });
});

// HOME :
const modal0 = document.getElementById("modal0");
const btn0 = document.getElementById("myBtn0");
const span0 = document.getElementById("close0");

btn0.onclick = function () {
  modal0.style.display = "block";
};
span0.onclick = function () {
  modal0.style.display = "none";
};
