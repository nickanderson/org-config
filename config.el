(with-eval-after-load 'org

(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
(setq org-crypt-key "9274E588E866A10B713C9CCD9EB3AD425D1CCC11")

;; BEGIN org niceities
(setq org-tags-match-list-sublevels 'indented)
(setq org-startup-indented t)
(setq org-startup-with-inline-images t)

;; Familiar zooming with Ctrl+ and Ctrl-
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

(setq org-insert-heading-respect-content t)
(setq org-id-link-to-org-use-id t)
(setq org-id-track-globally t)
;; END org niceities

(setq org-journal-dir "~/org/journal/")
(setq org-journal-file-format "%Y-%m-%d")
(setq org-journal-date-prefix "#+TITLE: ")
(setq org-journal-date-format "%A, %B %d %Y")
(setq org-journal-time-prefix "* ")
(setq org-journal-time-format "")
(setq org-want-todo-bindings t)

;; TODO Keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "IN_PROGRESS(i)" "|" "DONE(d)")
              (sequence "WAITING(w@/)" "DELEGATED(D)" "HOLD(h@/)" "|" "CANCELLED(c@/)"))))

;; This conflicts with the evil key bindings in spacemacs, instead of using the old speedcommands, use =, T T= when inside org mode.
;;(setq org-use-fast-todo-selection t)
;;(setq org-use-speed-commands t)

;; Link abbreviations http://orgmode.org/manual/Link-abbreviations.html#Link-abbreviations
;; This makes it easy to create links in org files to common urls
;; Note: The actual link is not stored in the text, only when rendered
;; Usage: [[zendesk:2753]] or [[redmine:7481][My text]]
(setq org-link-abbrev-alist
      '(
        ("cfe-func" . "https://docs.cfengine.com/docs/master/reference-functions-")
        ("zendesk" . "https://cfengine.zendesk.com/agent/tickets/")
        ("redmine" . "https://dev.cfengine.com/issues/")
        ("core-pr" . "https://github.com/cfengine/core/pull/")
        ("mpf-pr" . "https://github.com/cfengine/masterfiles/pull/")
        ("core-commit" . "https://github.com/cfengine/core/commit/")
        ("mpf-commit" . "https://github.com/cfengine/masterfiles/commit/")
        ("jira" . "https://tracker.mender.io/browse/")))

(defvar my/org-meeting-template-generic "* %u %^{Meeting about} %^g
CREATED: %U

%?

** Notes


" "Meeting Template - Generic")

(defvar my/org-meeting-template-customer-status "* %u Status Check-in
%^{CUSTOMER}pCREATED: %U

%?

*Attendees:*
  - Nick Anderson
  -

** Info
- Current versions running:
- Next planned upgrade:
- Upcoming platform changes:

** Notes

" "Meeting Template - Customer Status Check-in")

(defvar my/org-meeting-template-grooming "* %u Meeting About CFEngine Grooming :internal_meeting:
CREATED: %U
%?
*Agenda:*
- [[https://tracker.mender.io/issues/?filter=11300][Review New customer issues]]
- [[https://tracker.mender.io/secure/RapidBoard.jspa?rapidView=34][Review Progress on CFEngine Epics]]
- [[https://tracker.mender.io/issues/?filter=11205][Review Understanding of Next Bugs]]
- [[https://tracker.mender.io/secure/RapidBoard.jspa?rapidView=11&view=planning&epics=visible][Review CFEngine PM Backlog]]

** Notes

" "Meeting Template - Grooming")

;; BEGIN Capture Templates
    ;; I picked up this neat trick from the Venerable Sacha Chua
    (defvar my/org-meeting-template-planning "* %u Meeting About CFEngine Planning   %^G
CREATED: %U

*Agenda:*
 - Demos
 - Review work in progress
 - Review newly registered issues

** Demos


" "Meeting Template - Planning")

    (defvar my/org-meeting-template-standup "* %u CFEngine Standup  :internal_meeting:
CREATED: %U

** Aleksei
** Igor
** Ole
** Vratislav
** Nils 
** Craig
** Nick

" "Meeting Template - Standup")

    (defvar my/org-meeting-template "* %u %^{Meeting About ...}   %^G
CREATED: %U

*Attendees:*

 - [X] Nick Anderson
 - [ ] %?


*Agenda:*
 -
 -

*Notes:*


" "Meeting Template")

    (defvar my/org-contact-capture-template "* %(org-contacts-template-name)
CREATED: %U
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:END:")


    (defvar my/org-respond-email-capture-template "** TODO [#B] Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n\n")

    (defvar my/org-capture-support "** TODO [#A] [[zendesk:%^{ISSUE}]]: %^{DESCRIPTION} %^G\n\n%?\n")
    (defvar my/org-capture-jira "** TODO [#B] [[jira:%^{ISSUE}]]: %^{DESCRIPTION} %^G\n\n%?\n")


    (defvar my/org-daily-review-capture-template "* %u\n\n%?\n")

;; Configure custom capture templates
(setq org-capture-templates
      `(;; Note the backtick here, it's required so that the defvar based tempaltes will work!
        ;;http://comments.gmane.org/gmane.emacs.orgmode/106890

        ("t" "To-do" entry (file+headline "~/org/refile.org" "Tasks")
         "** TODO %^{Task Description}\nCreated From: %a\n%?\n\n" :clock-in t :clock-resume t :append t)

        ("s" "Support" entry (file+headline "~/org/refile.org" "Tasks")
         ,my/org-capture-support :clock-in t :clock-resume t :append t)

        ("j" "Jira" entry (file+headline "~/org/refile.org" "Tasks")
         ,my/org-capture-jira :clock-in t :clock-resume t :append t)

        ("w" "Web site" entry
         (file "~/org/websites.org")
         "* %a :website:\n\n%U %?\n\n%:initial" :append t)

        ("r" "Respond to Email" entry (file+headline "~/org/refile.org" "Tasks")
         ,my/org-respond-email-capture-template :clock-in t :clock-resume t :append t)

        ("c" "Contact" entry (file "~/org/x-files.org") ,my/org-contact-capture-template :append t)
        ("d" "Daily Review" entry (file "~/org/daily_reviews.org") ,my/org-daily-review-capture-template :clock-in t :clock-resume t :append t)

        ("m" "Meetings" )
        ("ms" "Meeting - Standup" entry (file "~/org/cfengine/meetings.org" )
         ,my/org-meeting-template-standup :clock-in t :clock-resume t :append t :empty-lines-after 1)
        ("mc" "Meeting - Customer Status Check-in" entry (file "~/org/cfengine/meetings.org" )
         ,my/org-meeting-template-customer-status :clock-in t :clock-resume t :append t :empty-lines-after 1)
        ("mg" "Meeting - Grooming" entry (file "~/org/cfengine/meetings.org" )
         ,my/org-meeting-template-grooming :clock-in t :clock-resume t :append t :empty-lines-after 1)
        ("mp" "Meeting - Planning/Review" entry (file "~/org/cfengine/meetings.org" )
         ,my/org-meeting-template-planning :clock-in t :clock-resume t :append t :empty-lines-after 1)
        ("mm" "Meeting - Generic" entry (file "~/org/cfengine/meetings.org" )
         ,my/org-meeting-template-generic :clock-in t :clock-resume t :append t :empty-lines-after 1)
        ))
;; END Capture templates
;; Use UUIDs to identify each speicifc entry
(add-hook 'org-capture-prepare-finalize-hook 'org-id-get-create)

(setq org-src-fontify-natively t)

(setq org-src-tab-acts-natively t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (shell . t) ; Works for sh, shell, bash
   ;; (python . t)
   ;; (ruby . t)
   ;; (ditaa . t)
   ;; (http . t)
   ;; (plantuml . t)
   ;; (perl . t))
   ))

;; This is no longer needed. It's handled by the cfengine layer automatically if
;; it sees the org layer is also used.
;; https://github.com/syl20bnr/spacemacs/pull/11528
;; (when (configuration-layer/layer-usedp 'cfengine)
;;   ;;(require 'ob-cfengine3) ;; I have problems with capture templates if I don't
;;   ;; use this before capturing or require it.

;;   (append org-babel-load-languages
;;           '((cfengine3 . t)))
;;   )

;; BEGIN exports
;; Disable exporting subscripts (I use a lot of underscores, and they are never for subscript)
(setq org-export-with-sub-superscripts nil)

(when (configuration-layer/package-usedp 'ox-jira)
  (add-to-list 'org-export-backends 'jira))

(when (configuration-layer/layer-usedp 'markdown)
  (add-to-list 'org-export-backends 'md))

;; END exports

;; BEGIN Publishing
(setq org-publish-project-alist
      '(
        ("journal"
         :base-directory "~/org/journal/"
         :base-extension ""
         :publishing-directory "~/journal/"
         :recursive t
         :publishing-function org-html-publish-to-pdf
         :headline-levels 1
         :autopreamble nil)
        ("cfengine-html"
         :base-directory "~/org/cfengine/"
         :base-extension "org"
         :publishing-directory "~/CFEngine/Google Drive/nicks_org"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :autopreamble t
         :eval "never-export")
        ("cfengine-org"
         :base-directory "~/org/cfengine/"
         :base-extension "org"
         :publishing-directory "~/CFEngine/Google Drive/nicks_org"
         :recursive t
         :publishing-function org-org-publish-to-org
         :headline-levels 4
         :autopreamble t)
        ("cfengine-pdf"
         :base-directory "~/org/cfengine/"
         :base-extension "org"
         :publishing-directory "~/CFEngine/Google Drive/nicks_org"
         :recursive nil
         :publishing-function org-latex-publish-to-pdf
         :headline-levels 4
         :autopreamble t)
        ("cfengine-txt"
         :base-directory "~/org/cfengine/"
         :base-extension "org"
         :publishing-directory "~/CFEngine/Google Drive/nicks_org"
         :recursive t
         :publishing-function org-ascii-publish-to-utf8
         :headline-levels 4
         :autopreamble t)

        ))
;; END Publishing
;; BEGIN org-agenda configuration

(setq org-agenda-span 'day)

(setq org-agenda-files
      '("~/org" "~/org/cfengine" "~/org/cfengine/customers" "~/.org-jira"))
;; It's hard to see them (at least with the default color). Also this is a
;; reccomended change to speed up the agenda (not that it's too slow for me).
(setq org-agenda-dim-blocked-tasks nil)
(setq org-agenda-prefix-format '"%b")
;; END org-agenda configuration

(when (configuration-layer/package-used-p 'org-timeline)
  (require 'org-timeline)
  (add-hook 'org-agenda-finalize-hook 'org-timeline-insert-timeline :append)
  )

;; BEGIN clocking configuration
(setq spaceline-org-clock-p t)
(setq org-clock-idle-time 15)
(setq org-time-clocksum-format (quote (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)))
;; END clocking configuration

(setq org-download-method 'attach)

)
