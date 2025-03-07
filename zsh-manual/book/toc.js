// Populate the sidebar
//
// This is a script, and not included directly in the page, to control the total size of the book.
// The TOC contains an entry for each page, so if each page includes a copy of the TOC,
// the total size of the page becomes O(n**2).
class MDBookSidebarScrollbox extends HTMLElement {
    constructor() {
        super();
    }
    connectedCallback() {
        this.innerHTML = '<ol class="chapter"><li class="chapter-item expanded "><a href="The-Z-Shell-Manual.html"><strong aria-hidden="true">1.</strong> The Z Shell Manual</a></li><li class="chapter-item expanded "><a href="Introduction.html"><strong aria-hidden="true">2.</strong> Introduction</a></li><li class="chapter-item expanded "><a href="Roadmap.html"><strong aria-hidden="true">3.</strong> Roadmap</a></li><li class="chapter-item expanded "><a href="Invocation.html"><strong aria-hidden="true">4.</strong> Invocation</a></li><li class="chapter-item expanded "><a href="Files.html"><strong aria-hidden="true">5.</strong> Files</a></li><li class="chapter-item expanded "><a href="Shell-Grammar.html"><strong aria-hidden="true">6.</strong> Shell Grammar</a></li><li class="chapter-item expanded "><a href="Redirection.html"><strong aria-hidden="true">7.</strong> Redirection</a></li><li class="chapter-item expanded "><a href="Command-Execution.html"><strong aria-hidden="true">8.</strong> Command Execution</a></li><li class="chapter-item expanded "><a href="Functions.html"><strong aria-hidden="true">9.</strong> Functions</a></li><li class="chapter-item expanded "><a href="Jobs-&-Signals.html"><strong aria-hidden="true">10.</strong> Jobs &amp; Signals</a></li><li class="chapter-item expanded "><a href="Arithmetic-Evaluation.html"><strong aria-hidden="true">11.</strong> Arithmetic Evaluation</a></li><li class="chapter-item expanded "><a href="Conditional-Expressions.html"><strong aria-hidden="true">12.</strong> Conditional Expressions</a></li><li class="chapter-item expanded "><a href="Prompt-Expansion.html"><strong aria-hidden="true">13.</strong> Prompt Expansion</a></li><li class="chapter-item expanded "><a href="Expansion.html"><strong aria-hidden="true">14.</strong> Expansion</a></li><li class="chapter-item expanded "><a href="Parameters.html"><strong aria-hidden="true">15.</strong> Parameters</a></li><li class="chapter-item expanded "><a href="Options.html"><strong aria-hidden="true">16.</strong> Options</a></li><li class="chapter-item expanded "><a href="Shell-Builtin-Commands.html"><strong aria-hidden="true">17.</strong> Shell Builtin Commands</a></li><li class="chapter-item expanded "><a href="Zsh-Line-Editor.html"><strong aria-hidden="true">18.</strong> Zsh Line Editor</a></li><li class="chapter-item expanded "><a href="Completion-Widgets.html"><strong aria-hidden="true">19.</strong> Completion Widgets</a></li><li class="chapter-item expanded "><a href="Completion-System.html"><strong aria-hidden="true">20.</strong> Completion System</a></li><li class="chapter-item expanded "><a href="Completion-Using-compctl.html"><strong aria-hidden="true">21.</strong> Completion Using compctl</a></li><li class="chapter-item expanded "><a href="Zsh-Modules.html"><strong aria-hidden="true">22.</strong> Zsh Modules</a></li><li class="chapter-item expanded "><a href="Calendar-Function-System.html"><strong aria-hidden="true">23.</strong> Calendar Function System</a></li><li class="chapter-item expanded "><a href="TCP-Function-System.html"><strong aria-hidden="true">24.</strong> TCP Function System</a></li><li class="chapter-item expanded "><a href="Zftp-Function-System.html"><strong aria-hidden="true">25.</strong> Zftp Function System</a></li><li class="chapter-item expanded "><a href="User-Contributions.html"><strong aria-hidden="true">26.</strong> User Contributions</a></li></ol>';
        // Set the current, active page, and reveal it if it's hidden
        let current_page = document.location.href.toString().split("#")[0];
        if (current_page.endsWith("/")) {
            current_page += "index.html";
        }
        var links = Array.prototype.slice.call(this.querySelectorAll("a"));
        var l = links.length;
        for (var i = 0; i < l; ++i) {
            var link = links[i];
            var href = link.getAttribute("href");
            if (href && !href.startsWith("#") && !/^(?:[a-z+]+:)?\/\//.test(href)) {
                link.href = path_to_root + href;
            }
            // The "index" page is supposed to alias the first chapter in the book.
            if (link.href === current_page || (i === 0 && path_to_root === "" && current_page.endsWith("/index.html"))) {
                link.classList.add("active");
                var parent = link.parentElement;
                if (parent && parent.classList.contains("chapter-item")) {
                    parent.classList.add("expanded");
                }
                while (parent) {
                    if (parent.tagName === "LI" && parent.previousElementSibling) {
                        if (parent.previousElementSibling.classList.contains("chapter-item")) {
                            parent.previousElementSibling.classList.add("expanded");
                        }
                    }
                    parent = parent.parentElement;
                }
            }
        }
        // Track and set sidebar scroll position
        this.addEventListener('click', function(e) {
            if (e.target.tagName === 'A') {
                sessionStorage.setItem('sidebar-scroll', this.scrollTop);
            }
        }, { passive: true });
        var sidebarScrollTop = sessionStorage.getItem('sidebar-scroll');
        sessionStorage.removeItem('sidebar-scroll');
        if (sidebarScrollTop) {
            // preserve sidebar scroll position when navigating via links within sidebar
            this.scrollTop = sidebarScrollTop;
        } else {
            // scroll sidebar to current active section when navigating via "next/previous chapter" buttons
            var activeSection = document.querySelector('#sidebar .active');
            if (activeSection) {
                activeSection.scrollIntoView({ block: 'center' });
            }
        }
        // Toggle buttons
        var sidebarAnchorToggles = document.querySelectorAll('#sidebar a.toggle');
        function toggleSection(ev) {
            ev.currentTarget.parentElement.classList.toggle('expanded');
        }
        Array.from(sidebarAnchorToggles).forEach(function (el) {
            el.addEventListener('click', toggleSection);
        });
    }
}
window.customElements.define("mdbook-sidebar-scrollbox", MDBookSidebarScrollbox);
