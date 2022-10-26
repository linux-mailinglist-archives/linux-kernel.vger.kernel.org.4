Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1625D60DEFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiJZKpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiJZKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79342C96FA;
        Wed, 26 Oct 2022 03:45:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01E8761E0E;
        Wed, 26 Oct 2022 10:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC30AC433D6;
        Wed, 26 Oct 2022 10:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666781100;
        bh=1TPObzpwDHf1xSWq+Eq1LpF/gZzYn43CSjFeLRjK/U4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgmxHENtbtobdshf5kq+oLVHg+VRW+9ApJFjjGjdKp9iV4L3ZG3R4u32H8ERvprkl
         jXTZ7srY/C6pYmzALoUpKOrQi4XHX1zcLtFIm7Ql6uwUjW4OomRKeWPPr+Vx/NSeyW
         5+1iLgDRAUG4+07sUkmpMZZOiPo7UgkCDqVvhNEXByY1zWkYtezMqGsVp9LvOXShw9
         7D13fKcieNb3QIvZL4+CCWVrYDMjsgtVR2jM51w7CywZ6QDvkRdrwv6ts7hLBi/BW0
         v+SMavVEIsg634921grLtDWvao2fHBnWQzHI0jwssxVxK/4nmde8ifrq3NW6Sa9hSi
         s3Uzcy7krFUcA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Documentation/rv: Add verification/rv man pages
Date:   Wed, 26 Oct 2022 12:44:41 +0200
Message-Id: <320de46ad632099cdbaa24dc6fc690781017ff6f.1666776642.git.bristot@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666776642.git.bristot@kernel.org>
References: <cover.1666776642.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add man pages for the rv command line, using the same scheme we used
in rtla.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/tools/index.rst              |  1 +
 Documentation/tools/rv/Makefile            | 52 ++++++++++++++++++++
 Documentation/tools/rv/common_appendix.rst | 13 +++++
 Documentation/tools/rv/common_ikm.rst      | 21 ++++++++
 Documentation/tools/rv/index.rst           | 24 +++++++++
 Documentation/tools/rv/rv-list.rst         | 39 +++++++++++++++
 Documentation/tools/rv/rv-mon-wip.rst      | 40 +++++++++++++++
 Documentation/tools/rv/rv-mon-wwnr.rst     | 39 +++++++++++++++
 Documentation/tools/rv/rv-mon.rst          | 51 +++++++++++++++++++
 Documentation/tools/rv/rv.rst              | 57 ++++++++++++++++++++++
 tools/verification/rv/Makefile             | 26 +++++++++-
 11 files changed, 361 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/tools/rv/Makefile
 create mode 100644 Documentation/tools/rv/common_appendix.rst
 create mode 100644 Documentation/tools/rv/common_ikm.rst
 create mode 100644 Documentation/tools/rv/index.rst
 create mode 100644 Documentation/tools/rv/rv-list.rst
 create mode 100644 Documentation/tools/rv/rv-mon-wip.rst
 create mode 100644 Documentation/tools/rv/rv-mon-wwnr.rst
 create mode 100644 Documentation/tools/rv/rv-mon.rst
 create mode 100644 Documentation/tools/rv/rv.rst

diff --git a/Documentation/tools/index.rst b/Documentation/tools/index.rst
index 0bb1e61bdcc0..80488e290e10 100644
--- a/Documentation/tools/index.rst
+++ b/Documentation/tools/index.rst
@@ -11,6 +11,7 @@ more additions are needed here:
    :maxdepth: 1
 
    rtla/index
+   rv/index
 
 .. only::  subproject and html
 
diff --git a/Documentation/tools/rv/Makefile b/Documentation/tools/rv/Makefile
new file mode 100644
index 000000000000..ec8713c1b35f
--- /dev/null
+++ b/Documentation/tools/rv/Makefile
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+INSTALL		?= install
+RM		?= rm -f
+RMDIR		?= rmdir --ignore-fail-on-non-empty
+
+PREFIX		?= /usr/share
+MANDIR		?= $(PREFIX)/man
+MAN1DIR		= $(MANDIR)/man1
+
+MAN1_RST	= $(wildcard rv*.rst)
+
+_DOC_MAN1	= $(patsubst %.rst,%.1,$(MAN1_RST))
+DOC_MAN1	= $(addprefix $(OUTPUT),$(_DOC_MAN1))
+
+RST2MAN_DEP	:= $(shell command -v rst2man 2>/dev/null)
+RST2MAN_OPTS	+= --verbose
+
+TEST_RST2MAN = $(shell sh -c "rst2man --version > /dev/null 2>&1 || echo n")
+
+$(OUTPUT)%.1: %.rst
+ifndef RST2MAN_DEP
+	$(info ********************************************)
+	$(info ** NOTICE: rst2man not found)
+	$(info **)
+	$(info ** Consider installing the latest rst2man from your)
+	$(info ** distribution, e.g., 'dnf install python3-docutils' on Fedora,)
+	$(info ** or from source:)
+	$(info **)
+	$(info **  https://docutils.sourceforge.io/docs/dev/repository.html )
+	$(info **)
+	$(info ********************************************)
+	$(error NOTICE: rst2man required to generate man pages)
+endif
+	rst2man $(RST2MAN_OPTS) $< > $@
+
+man1: $(DOC_MAN1)
+man: man1
+
+clean:
+	$(RM) $(DOC_MAN1)
+
+install: man
+	$(INSTALL) -d -m 755 $(DESTDIR)$(MAN1DIR)
+	$(INSTALL) -m 644 $(DOC_MAN1) $(DESTDIR)$(MAN1DIR)
+
+uninstall:
+	$(RM) $(addprefix $(DESTDIR)$(MAN1DIR)/,$(_DOC_MAN1))
+	$(RMDIR) $(DESTDIR)$(MAN1DIR)
+
+.PHONY: man man1 clean install uninstall
+.DEFAULT_GOAL := man
diff --git a/Documentation/tools/rv/common_appendix.rst b/Documentation/tools/rv/common_appendix.rst
new file mode 100644
index 000000000000..f8ffd271d886
--- /dev/null
+++ b/Documentation/tools/rv/common_appendix.rst
@@ -0,0 +1,13 @@
+REPORTING BUGS
+==============
+Report bugs to <linux-kernel@vger.kernel.org>
+and <linux-trace-devel@vger.kernel.org>
+
+LICENSE
+=======
+**rv** is Free Software licensed under the GNU GPLv2
+
+COPYING
+=======
+Copyright \(C) 2022 Red Hat, Inc. Free use of this software is granted under
+the terms of the GNU Public License (GPL).
diff --git a/Documentation/tools/rv/common_ikm.rst b/Documentation/tools/rv/common_ikm.rst
new file mode 100644
index 000000000000..0f206e985c27
--- /dev/null
+++ b/Documentation/tools/rv/common_ikm.rst
@@ -0,0 +1,21 @@
+**-h**, **--help**
+
+        Print this menu and the reactor list.
+
+**-r**, **--reactor** *reactor*
+
+        Enables the *reactor*.
+
+**-s**, **--self**
+
+        When tracing (**-t**), also print the events that happened during the **rv**
+        command itself. If the **rv** command itself generates too many events,
+        the tool might get busy processing its own events.
+
+**-t**, **--trace**
+
+        Trace monitor's events and error.
+
+**-v**, **--verbose**
+
+        Print debug messages.
diff --git a/Documentation/tools/rv/index.rst b/Documentation/tools/rv/index.rst
new file mode 100644
index 000000000000..50f40a3ee256
--- /dev/null
+++ b/Documentation/tools/rv/index.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Runtime verification (rv) tool
+==============================
+
+rv tool provides the interface for a collection of runtime verification
+(rv) monitors.
+
+.. toctree::
+   :maxdepth: 1
+
+   rv
+   rv-list
+   rv-mon
+   rv-mon-wip
+   rv-mon-wwnr
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/tools/rv/rv-list.rst b/Documentation/tools/rv/rv-list.rst
new file mode 100644
index 000000000000..727bd3fbcce9
--- /dev/null
+++ b/Documentation/tools/rv/rv-list.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+rv-list
+=======
+-----------------------
+List available monitors
+-----------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+**rv list** [*OPTIONS*]
+
+DESCRIPTION
+===========
+
+The **rv list** command prints all available monitors. These
+monitors can be enabled using the **rv mon** command.
+
+OPTIONS
+=======
+
+**-h**, **--help**
+
+        Print help menu.
+
+SEE ALSO
+========
+**rv**\(1), **rv-mon**\(1)
+
+Linux kernel *RV* documentation: <https://www.kernel.org/doc/html/latest/trace/rv/index.html>
+
+AUTHOR
+======
+Written by Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
diff --git a/Documentation/tools/rv/rv-mon-wip.rst b/Documentation/tools/rv/rv-mon-wip.rst
new file mode 100644
index 000000000000..27a026f80cb7
--- /dev/null
+++ b/Documentation/tools/rv/rv-mon-wip.rst
@@ -0,0 +1,40 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+rv-mon-wip
+==========
+----------------------------
+Wakeup In Preemptive monitor
+----------------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+**rv mon wip** [*OPTIONS*]
+
+DESCRIPTION
+===========
+
+The wakeup in preemptive (**wip**) monitor is a sample per-cpu monitor that
+verifies if the wakeup events always take place with preemption disabled.
+
+See kernel documentation for further information about this monitor:
+<https://docs.kernel.org/trace/rv/monitor_wip.html>
+
+OPTIONS
+=======
+
+.. include:: common_ikm.rst
+
+SEE ALSO
+========
+**rv**\(1), **rv-mon**\(1)
+
+Linux kernel *RV* documentation: <https://www.kernel.org/doc/html/latest/trace/rv/index.html>
+
+AUTHOR
+======
+Written by Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
diff --git a/Documentation/tools/rv/rv-mon-wwnr.rst b/Documentation/tools/rv/rv-mon-wwnr.rst
new file mode 100644
index 000000000000..18807528c04c
--- /dev/null
+++ b/Documentation/tools/rv/rv-mon-wwnr.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========
+rv-mon-wwnr
+===========
+--------------------------------
+Wakeup While Not Running monitor
+--------------------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+**rv mon wip** [*OPTIONS*]
+
+DESCRIPTION
+===========
+
+The wakeup while not running (**wwnr**) is a per-task sample monitor.
+
+See kernel documentation for further information about this monitor:
+<https://docs.kernel.org/trace/rv/monitor_wwnr.html>
+
+OPTIONS
+=======
+
+.. include:: common_ikm.rst
+
+SEE ALSO
+========
+**rv**\(1), **rv-mon**\(1)
+
+Linux kernel *RV* documentation: <https://www.kernel.org/doc/html/latest/trace/rv/index.html>
+
+AUTHOR
+======
+Written by Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
diff --git a/Documentation/tools/rv/rv-mon.rst b/Documentation/tools/rv/rv-mon.rst
new file mode 100644
index 000000000000..9e6e5db2de57
--- /dev/null
+++ b/Documentation/tools/rv/rv-mon.rst
@@ -0,0 +1,51 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+rv-list
+=======
+-----------------------
+List available monitors
+-----------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+**rv mon** [*-h*] **monitor_name** [*-h*] [*MONITOR OPTIONS*]
+
+DESCRIPTION
+===========
+
+The **rv mon** command runs the monitor named *monitor_name*.
+Each monitor has its own set of options.
+The **rv list** command shows all available monitors.
+
+OPTIONS
+=======
+
+**-h**, **--help**
+
+        Print help menu.
+
+AVAILABLE MONITORS
+==================
+
+The **rv** tool provides the interface for a set of monitors.
+Use the **rv list** command to list all available monitors.
+
+Each monitor has its own set of options.
+See man **rv-mon**-*monitor_name* for details about each specific monitor. Also,
+running **rv mon** **monitor_name** **-h** display the help menu with the available
+options.
+
+SEE ALSO
+========
+**rv**\(1), **rv-mon**\(1)
+
+Linux kernel *RV* documentation: <https://www.kernel.org/doc/html/latest/trace/rv/index.html>
+
+AUTHOR
+======
+Written by Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
diff --git a/Documentation/tools/rv/rv.rst b/Documentation/tools/rv/rv.rst
new file mode 100644
index 000000000000..16c1a3b8e1f7
--- /dev/null
+++ b/Documentation/tools/rv/rv.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==
+rv
+==
+--------------------
+Runtime Verification
+--------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+**rv** *COMMAND* [*OPTIONS*]
+
+DESCRIPTION
+===========
+
+Runtime Verification (**RV**) is a lightweight (yet rigorous) method
+for formal verification with a practical approach for complex systems.
+Instead of relying on a fine-grained model of a system (e.g., a
+re-implementation a instruction level), RV works by analyzing the trace
+of the system's actual execution, comparing it against a formal
+specification of the system behavior.
+
+The **rv** tool provides the interface for a collection of runtime
+verification (rv) monitors.
+
+COMMANDS
+========
+**list**
+
+        List all available monitors.
+
+**mon**
+
+        Run monitor.
+
+OPTIONS
+=======
+**-h**, **--help**
+
+        Display the help text.
+
+For other options, see the man page for the corresponding command.
+
+SEE ALSO
+========
+**rv-list**\(1), **rv-mon**\(1)
+
+Linux kernel *RV* documentation: <https://www.kernel.org/doc/html/latest/trace/rv/index.html>
+
+AUTHOR
+======
+Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
index 1de111ac2641..3d0f3888a58c 100644
--- a/tools/verification/rv/Makefile
+++ b/tools/verification/rv/Makefile
@@ -44,10 +44,20 @@ TARBALL	:=	$(NAME)-$(VERSION).tar.$(CEXT)
 TAROPTS	:=	-cvjf $(TARBALL)
 BINDIR	:=	/usr/bin
 DATADIR	:=	/usr/share
+DOCDIR	:=	$(DATADIR)/doc
 MANDIR	:=	$(DATADIR)/man
 LICDIR	:=	$(DATADIR)/licenses
 SRCTREE	:=	$(or $(BUILD_SRC),$(CURDIR))
 
+# If running from the tarball, man pages are stored in the Documentation
+# dir. If running from the kernel source, man pages are stored in
+# Documentation/tools/rv/.
+ifneq ($(wildcard Documentation/.*),)
+DOCSRC	=	Documentation/
+else
+DOCSRC	=	$(SRCTREE)/../../../Documentation/tools/rv/
+endif
+
 LIBTRACEEVENT_MIN_VERSION = 1.5
 LIBTRACEFS_MIN_VERSION = 1.3
 
@@ -100,13 +110,13 @@ rv: $(OBJ)
 	$(CC) -o rv $(LDFLAGS) $(OBJ) $(LIBS)
 
 .PHONY: install
-install:
+install: doc_install
 	$(MKDIR) -p $(DESTDIR)$(BINDIR)
 	$(INSTALL) rv -m 755 $(DESTDIR)$(BINDIR)
 	$(STRIP) $(DESTDIR)$(BINDIR)/rv
 
 .PHONY: clean tarball
-clean:
+clean: doc_clean
 	@test ! -f rv || rm rv
 	@test ! -f $(TARBALL) || rm -f $(TARBALL)
 	@rm -rf *~ $(OBJ) *.tar.$(CEXT)
@@ -115,5 +125,17 @@ tarball: clean
 	rm -rf $(NAME)-$(VERSION) && mkdir $(NAME)-$(VERSION)
 	echo $(VERSION) > $(NAME)-$(VERSION)/VERSION
 	cp -r $(DIRS) $(FILES) $(NAME)-$(VERSION)
+	mkdir $(NAME)-$(VERSION)/Documentation/
+	cp -rp $(SRCTREE)/../../../Documentation/tools/rv/* $(NAME)-$(VERSION)/Documentation/
 	tar $(TAROPTS) --exclude='*~' $(NAME)-$(VERSION)
 	rm -rf $(NAME)-$(VERSION)
+
+.PHONY: doc doc_clean doc_install
+doc:
+	$(MAKE) -C $(DOCSRC)
+
+doc_clean:
+	$(MAKE) -C $(DOCSRC) clean
+
+doc_install:
+	$(MAKE) -C $(DOCSRC) install
-- 
2.37.3

