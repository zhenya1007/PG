;;; Bootstrap ProofGeneral's autoloads.
;; The code in package.el will not look in sub-directories of "the package directory" (c.f. `package-generate-autoloads')
;; , so it needs a little help from the code below to find ProofGeneral's autoloads.

(defconst PG-autoloads-base-dir
  (file-name-directory
   (if load-in-progress load-file-name
     buffer-file-name)))

(defconst PG-autoloads-from-subdirs-file
  (expand-file-name "PG-subdirs-autoloads-generated.el" PG-autoloads-base-dir))

(defun PG-bootstrap-subdirs-autoloads ()
  (unless (file-exists-p PG-autoloads-from-subdirs-file)
      (let ((generated-autoload-file PG-autoloads-from-subdirs-file))
        (dolist (name (directory-files-recursively PG-autoloads-base-dir "" t))
          (when (file-directory-p name)
            (update-directory-autoloads name))))))

;; The forms below will be evaluated when this file is loaded.
;; It should be loaded from pkg-autoloads (due to the `require' that's marked with an "autoload cookie below"), and it should only be loaded once per Emacs session (due to the `provide' that appears below)
(PG-bootstrap-subdirs-autoloads)
(load (expand-file-name "generic/proof-site" PG-autoloads-base-dir) t t)
(with-demoted-errors "Error in ProofGeneral's autoloads: %s"
  (load PG-autoloads-from-subdirs-file t t))
(makunbound 'PG-autoloads-base-dir)
(makunbound 'PG-autoloads-from-subdirs-file)
(fmakunbound 'PG-bootstrap-subdirs-autoloads)

(provide 'PG-autoloads-bootstrapped)

;;; Idea copied from AUCTeX package:
;; ensure that loading autoloads file also loads this file
;;;###autoload (require 'PG-autoloads-bootstrapped "PG-bootstrap-subdirs-autoloads")
