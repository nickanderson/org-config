;;; packages.el --- org-config layer packages file for Spacemacs.
  ;;
  ;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
  ;;
  ;; Author: Nick Anderson <nick.anderson@northern.tech>
  ;; URL: https://github.com/syl20bnr/spacemacs
  ;;
  ;; This file is not part of GNU Emacs.
  ;;
  ;;; License: GPLv3

  ;;; Commentary:

  ;; See the Spacemacs documentation and FAQs for instructions on how to implement
  ;; a new layer:
  ;;
  ;;   SPC h SPC layers RET
  ;;
  ;;
  ;; Briefly, each package to be installed or configured by this layer should be
  ;; added to `org-config-packages'. Then, for each package PACKAGE:
  ;;
  ;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
  ;;   function `org-config/init-PACKAGE' to load and initialize the package.

  ;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
  ;;   define the functions `org-config/pre-init-PACKAGE' and/or
  ;;   `org-config/post-init-PACKAGE' to customize the package as it is loaded.

  ;;; Code:

  (defconst org-config-packages
    '(
      ob-async
      ox-jira
      org-timeline
      org-jira

      (org-jira
       :location (recipe
                  :fetcher github
                  :repo "ahungry/org-jira"
                  :branch"master"))
      )
    "The list of Lisp packages required by the org-config layer.

  Each entry is either:

  1. A symbol, which is interpreted as a package to be installed, or

  2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
      name of the package to be installed or loaded, and KEYS are
      any number of keyword-value-pairs.

      The following keys are accepted:

      - :excluded (t or nil): Prevent the package from being loaded
        if value is non-nil

      - :location: Specify a custom installation location.
        The following values are legal:

        - The symbol `elpa' (default) means PACKAGE will be
          installed using the Emacs package manager.

        - The symbol `local' directs Spacemacs to load the file at
          `./local/PACKAGE/PACKAGE.el'

        - A list beginning with the symbol `recipe' is a melpa
          recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

  (defun org-config/init-ob-async ()
    (use-package ob-async
      ;; Some configuration goes here, however nothing relating to company
      ;; since this function may be called even if company is not installed!
      ))

  (defun org-config/init-ox-jira ()
    (use-package ox-jira
      ;; Some configuration goes here, however nothing relating to company
      ;; since this function may be called even if company is not installed!
      ))

  (defun org-config/init-org-timeline ()
    (use-package org-timeline
      :defer t
      ;; Some configuration goes here, however nothing relating to company
      ;; since this function may be called even if company is not installed!
      ))

  (defun org-config/init-org-jira ()
    (use-package org-jira
      :defer t
      ;; Some configuration goes here, however nothing relating to company
      ;; since this function may be called even if company is not installed!
      ))

(defun org-config/init-org-jira ()
  (use-package org-jira
    :defer t
    :init
    (progn
      (spacemacs/declare-prefix-for-mode 'org-mode "mj" "jira")
      (spacemacs/declare-prefix-for-mode 'org-mode "mjp" "projects")
      (spacemacs/declare-prefix-for-mode 'org-mode "mji" "issues")
      (spacemacs/declare-prefix-for-mode 'org-mode "mjs" "subtasks")
      (spacemacs/declare-prefix-for-mode 'org-mode "mjc" "comments")
      (spacemacs/declare-prefix-for-mode 'org-mode "mjt" "todos")
      (spacemacs/set-leader-keys-for-major-mode 'org-mode
        "jpg" 'org-jira-get-projects
        "jib" 'org-jira-browse-issue
        "jig" 'org-jira-get-issues
        "jih" 'org-jira-get-issues-headonly
        "jif" 'org-jira-get-issues-from-filter-headonly
        "jiF" 'org-jira-get-issues-from-filter
        "jiu" 'org-jira-update-issue
        "jiw" 'org-jira-progress-issue
        "jir" 'org-jira-refresh-issue
        "jic" 'org-jira-create-issue
        "jik" 'org-jira-copy-current-issue-key
        "jsc" 'org-jira-create-subtask
        "jsg" 'org-jira-get-subtasks
        "jcu" 'org-jira-update-comment
        "jtj" 'org-jira-todo-to-jira)
      )
    ))

  ;;; packages.el ends here
