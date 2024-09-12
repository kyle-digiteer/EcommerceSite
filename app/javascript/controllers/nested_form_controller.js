import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["add_item", "template"];
  static values = { index: String };

  add_association(e) {
    e.preventDefault();
    var content = this.templateTarget.innerHTML.replace(
      new RegExp(this.indexValue, "g"),
      new Date().getTime()
    );
    this.add_itemTarget.insertAdjacentHTML("beforebegin", content);
  }

  remove_association(e) {
    e.preventDefault();

    let item = e.target.closest(".nested-fields");
    item.querySelector("input[name*='_destroy']").value = 1;
    item.style.display = "none";
  }
}
