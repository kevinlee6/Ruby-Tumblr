const closeButton = document.querySelector(".close-button"),
      flashPanel = document.querySelector(".flash");

closeButton.addEventListener("click", e => {
    e.preventDefault();

    flashPanel.classList.add("hide");
});