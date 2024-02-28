const lift = 32;
const minWindowWidth = 1600;

document.body.onload = () => {
    const postContent = document.getElementsByClassName("post-content")[0];
    const footnotes = document.getElementById("footnotes");
    const fnOl = footnotes.getElementsByTagName("ol")[0];

    const origin = postContent.getBoundingClientRect().top;

    const sidenotes = document.createElement("div");
    sidenotes.id = "sidenotes";
    postContent.appendChild(sidenotes);

    let left = [];
    let right = [];

    for (const li of fnOl.children) {
        const index = li.id.substring(2);

        const aside = document.createElement("aside");
        aside.id = li.id;
        aside.innerHTML = li.innerHTML;

        const textNode = document.createNodeIterator(aside, NodeFilter.SHOW_TEXT).nextNode();
        textNode.textContent = index + ". " + textNode.textContent;

        aside.classList.add("sidenote");

        const ref = document.getElementById("fnref" + index);
        const refTop = ref.getBoundingClientRect().top;

        ref.addEventListener("mouseover", () => aside.classList.add("highlight"));
        ref.addEventListener("mouseout", () => aside.classList.remove("highlight"));

        const targetAbs = Math.max(origin, refTop - lift);

        const leftBottom = left.length > 0 ? left[left.length - 1].getBoundingClientRect().bottom : origin;
        const rightBottom = right.length > 0 ? right[right.length - 1].getBoundingClientRect().bottom : origin;

        const leftPush = Math.max(0, leftBottom - targetAbs);
        const rightPush = Math.max(0, rightBottom - targetAbs);

        if (leftPush < rightPush) {
            aside.classList.add("left");
            aside.style.top = targetAbs - origin + leftPush + "px";
            left.push(aside);
        } else {
            aside.classList.add("right");
            aside.style.top = targetAbs - origin + rightPush + "px";
            right.push(aside);
        }

        sidenotes.appendChild(aside);
    }

    function updateSidenotes() {
        if (window.innerWidth > minWindowWidth) {
            footnotes.remove();
            postContent.appendChild(sidenotes);
        } else {
            sidenotes.remove();
            postContent.appendChild(footnotes);
        }
    }

    window.addEventListener("resize", () => updateSidenotes());
    updateSidenotes();
};