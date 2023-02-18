var coll = document.getElementsByClassName("collapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var content = this.nextElementSibling;
    if (content.style.maxHeight){
      content.style.maxHeight = null;
    } else {
      content.style.maxHeight = content.scrollHeight + "px";
      var parent_content = content.parentElement.parentElement;
      parent_content.style.maxHeight = (parent_content.scrollHeight + content.scrollHeight) + "px";
      var grandparent_content = parent_content.parentElement.parentElement;
      grandparent_content.style.maxHeight = (grandparent_content.scrollHeight + content.scrollHeight) + "px";
    }
  });
}

