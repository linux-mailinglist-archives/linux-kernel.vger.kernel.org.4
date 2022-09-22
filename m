Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8860D5E6D37
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiIVUmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiIVUmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:42:02 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FFA2BE00;
        Thu, 22 Sep 2022 13:42:00 -0700 (PDT)
Received: from meer.lwn.net (unknown [IPv6:2601:281:8300:73::5f6])
        by ms.lwn.net (Postfix) with ESMTPA id 2E284845;
        Thu, 22 Sep 2022 20:42:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2E284845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663879320; bh=hbXxi/o9yXRSMapz7jMNxcodnhQ4mcFG1KalhkuX7Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjLMNb2qPbsA5ZboTItlvj7IxLkOdDjgyq2wh9jRKn+3E5J8bxq8c5JWAy/ioI5JP
         FGUNXBKcQpl9LoHQLDQ6pgNiv1emPWb3J+cKHMoGgFPvYaKR6PO6yDLi32G6Z5hO3k
         3K8S4UtZ1Al5oxppmjl7r8lwVG+2/5zfwuDMiXciFTnT1p4Ize5UARXj7WaHRgE9/N
         Tfv/0GtdPgMSjWtNVL/04+7jrFOiJZsMlWJH0Iy9Gs9NzW4b+zuKYNoi9OPN4HiscH
         VpZ+rNxtmo5qi/y0lb5V1VZQJp05JouqutsogRoO+dK5N139M3ISea9YTcfDV0bKGS
         AWKaZSLqBHYdQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 2/7] docs: Rewrite the front page
Date:   Thu, 22 Sep 2022 14:41:33 -0600
Message-Id: <20220922204138.153146-3-corbet@lwn.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220922204138.153146-1-corbet@lwn.net>
References: <20220922204138.153146-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The front page is the entry point to the documentation, especially for
people who read it online.  It's a big mess of everything we could think to
toss into it.  Rewrite the page with an eye toward simplicity and making it
easy for readers to get going toward what they really want to find.

This is only a beginning, but it makes our docs more approachable than
before.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/index.rst          | 150 +++++++++++--------------------
 Documentation/subsystem-apis.rst |  58 ++++++++++++
 2 files changed, 111 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/subsystem-apis.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 4737c18c97ff..e0b593486e7d 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -18,131 +18,88 @@ documents into a coherent whole.  Please note that improvements to the
 documentation are welcome; join the linux-doc list at vger.kernel.org if
 you want to help out.
 
-Licensing documentation
------------------------
+Working with the development community
+--------------------------------------
 
-The following describes the license of the Linux kernel source code
-(GPLv2), how to properly mark the license of individual files in the source
-tree, as well as links to the full license text.
-
-* :ref:`kernel_licensing`
-
-User-oriented documentation
----------------------------
-
-The following manuals are written for *users* of the kernel — those who are
-trying to get it to work optimally on a given system.
+The essential guides for interacting with the kernel's development
+community and getting your work upstream.
 
 .. toctree::
-   :maxdepth: 2
-
-   admin-guide/index
-   kbuild/index
-
-Firmware-related documentation
-------------------------------
-The following holds information on the kernel's expectations regarding the
-platform firmwares.
+   :maxdepth: 1
 
-.. toctree::
-   :maxdepth: 2
+   process/development-process
+   process/submitting-patches
+   Code of conduct <process/code-of-conduct>
+   maintainer/index
+   All development-process docs <process/index>
 
-   firmware-guide/index
-   devicetree/index
 
-Application-developer documentation
------------------------------------
+Internal API manuals
+--------------------
 
-The user-space API manual gathers together documents describing aspects of
-the kernel interface as seen by application developers.
+Manuals for use by developers working to interface with the rest of the
+kernel.
 
 .. toctree::
-   :maxdepth: 2
-
-   userspace-api/index
+   :maxdepth: 1
 
+   core-api/index
+   driver-api/index
+   subsystem-apis
+   Locking in the kernel <locking/index>
 
-Introduction to kernel development
-----------------------------------
+Development tools and processes
+-------------------------------
 
-These manuals contain overall information about how to develop the kernel.
-The kernel community is quite large, with thousands of developers
-contributing over the course of a year.  As with any large community,
-knowing how things are done will make the process of getting your changes
-merged much easier.
+Various other manuals with useful information for all kernel developers.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
-   process/index
-   dev-tools/index
+   process/license-rules
    doc-guide/index
+   dev-tools/index
+   dev-tools/testing-overview
    kernel-hacking/index
    trace/index
-   maintainer/index
    fault-injection/index
    livepatch/index
 
 
-Kernel API documentation
-------------------------
+User-oriented documentation
+---------------------------
 
-These books get into the details of how specific kernel subsystems work
-from the point of view of a kernel developer.  Much of the information here
-is taken directly from the kernel source, with supplemental material added
-as needed (or at least as we managed to add it — probably *not* all that is
-needed).
+The following manuals are written for *users* of the kernel — those who are
+trying to get it to work optimally on a given system and application
+developers seeking information on the kernel's user-space APIs.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
+
+   admin-guide/index
+   The kernel build system <kbuild/index>
+   admin-guide/reporting-issues.rst
+   User-space tools <tools/index>
+   userspace-api/index
+
+
+Firmware-related documentation
+------------------------------
+The following holds information on the kernel's expectations regarding the
+platform firmwares.
+
+.. toctree::
+   :maxdepth: 1
+
+   firmware-guide/index
+   devicetree/index
 
-   driver-api/index
-   core-api/index
-   locking/index
-   accounting/index
-   block/index
-   cdrom/index
-   cpu-freq/index
-   fb/index
-   fpga/index
-   hid/index
-   i2c/index
-   iio/index
-   isdn/index
-   infiniband/index
-   leds/index
-   netlabel/index
-   networking/index
-   pcmcia/index
-   power/index
-   target/index
-   timers/index
-   spi/index
-   w1/index
-   watchdog/index
-   virt/index
-   input/index
-   hwmon/index
-   gpu/index
-   security/index
-   sound/index
-   crypto/index
-   filesystems/index
-   mm/index
-   bpf/index
-   usb/index
-   PCI/index
-   scsi/index
-   misc-devices/index
-   scheduler/index
-   mhi/index
-   peci/index
 
 Architecture-agnostic documentation
 -----------------------------------
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    asm-annotations
 
@@ -150,7 +107,7 @@ Architecture-specific documentation
 -----------------------------------
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    arch
 
@@ -163,9 +120,8 @@ of the documentation body, or may require some adjustments and/or conversion
 to ReStructured Text format, or are simply too old.
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
-   tools/index
    staging/index
 
 
diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
new file mode 100644
index 000000000000..af65004a80aa
--- /dev/null
+++ b/Documentation/subsystem-apis.rst
@@ -0,0 +1,58 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Kernel subsystem documentation
+==============================
+
+These books get into the details of how specific kernel subsystems work
+from the point of view of a kernel developer.  Much of the information here
+is taken directly from the kernel source, with supplemental material added
+as needed (or at least as we managed to add it — probably *not* all that is
+needed).
+
+**Fixme**: much more organizational work is needed here.
+
+.. toctree::
+   :maxdepth: 1
+
+   driver-api/index
+   core-api/index
+   locking/index
+   accounting/index
+   block/index
+   cdrom/index
+   cpu-freq/index
+   fb/index
+   fpga/index
+   hid/index
+   i2c/index
+   iio/index
+   isdn/index
+   infiniband/index
+   leds/index
+   netlabel/index
+   networking/index
+   pcmcia/index
+   power/index
+   target/index
+   timers/index
+   spi/index
+   w1/index
+   watchdog/index
+   virt/index
+   input/index
+   hwmon/index
+   gpu/index
+   security/index
+   sound/index
+   crypto/index
+   filesystems/index
+   mm/index
+   bpf/index
+   usb/index
+   PCI/index
+   scsi/index
+   misc-devices/index
+   scheduler/index
+   mhi/index
+   peci/index
-- 
2.37.2

