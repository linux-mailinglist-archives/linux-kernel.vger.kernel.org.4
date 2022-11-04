Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A1C618D48
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 01:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKDAja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 20:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKDAj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:39:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D052364DA;
        Thu,  3 Nov 2022 17:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OkQNKqkfavtForcjEuuBaRJfLTSFHSzqb/CrBkj5a8Q=; b=LR22d5IsZT/MCQQpOPdm4j86Cl
        nGGAn5wwFkpMqpYNyU7C4dkMNX48QU/jWlWCE2G/apBtzeUWfm5SEs3RueWBP2Bcb5B7Cm0J7tvWK
        MyXuNB/2bvyST+qxkjslnCrx06V905sb0YN7VvQYgs/ps654XtvUWfsqD3PpZdwTG3wGG2AYMMsaA
        9wroyp76QKalTYZz664FizpVeULG6yP8vL8HBujrQZgDLWdRizVvQznx8g3hZ/9R7Lm0YY9vHnVbq
        ZGr9oaH2Gh3jgXNnvf9nFfAb/aSTQcZUOESmG2VsQk0AFTWIy+RidId1nZjFkQuVNrJUWbX9ktSAu
        AEMBR0hg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqkk6-006vfB-HT; Fri, 04 Nov 2022 00:39:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] sysfs: update Documentation
Date:   Thu,  3 Nov 2022 17:39:21 -0700
Message-Id: <20221104003921.31616-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make editing corrections and updates to sysfs.rst:

- spell "sysfs" consistently (vs. "Sysfs")
- align field names in a struct
- fix some punctuation and grammar
- list more /sys top-level subdirectories
- change 'fuse.txt' to 'fuse.rst' (although I don't see where the
  example is)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 Documentation/filesystems/sysfs.rst |   41 +++++++++++++++-----------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff -- a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -12,10 +12,10 @@ Mike Murphy <mamurph@cs.clemson.edu>
 :Original:   10 January 2003
 
 
-What it is:
-~~~~~~~~~~~
+What it is
+~~~~~~~~~~
 
-sysfs is a ram-based filesystem initially based on ramfs. It provides
+sysfs is a RAM-based filesystem initially based on ramfs. It provides
 a means to export kernel data structures, their attributes, and the
 linkages between them to userspace.
 
@@ -43,7 +43,7 @@ userspace. Top-level directories in sysf
 ancestors of object hierarchies; i.e. the subsystems the objects
 belong to.
 
-Sysfs internally stores a pointer to the kobject that implements a
+sysfs internally stores a pointer to the kobject that implements a
 directory in the kernfs_node object associated with the directory. In
 the past this kobject pointer has been used by sysfs to do reference
 counting directly on the kobject whenever the file is opened or closed.
@@ -55,7 +55,7 @@ Attributes
 ~~~~~~~~~~
 
 Attributes can be exported for kobjects in the form of regular files in
-the filesystem. Sysfs forwards file I/O operations to methods defined
+the filesystem. sysfs forwards file I/O operations to methods defined
 for the attributes, providing a means to read and write kernel
 attributes.
 
@@ -72,8 +72,8 @@ you publicly humiliated and your code re
 An attribute definition is simply::
 
     struct attribute {
-	    char                    * name;
-	    struct module		*owner;
+	    char                    *name;
+	    struct module           *owner;
 	    umode_t                 mode;
     };
 
@@ -138,7 +138,7 @@ __ATTR_WO(name):
 		 assumes a name_store only and is restricted to mode
                  0200 that is root write access only.
 __ATTR_RO_MODE(name, mode):
-	         fore more restrictive RO access currently
+	         for more restrictive RO access; currently
                  only use case is the EFI System Resource Table
                  (see drivers/firmware/efi/esrt.c)
 __ATTR_RW(name):
@@ -207,7 +207,7 @@ IOW, they should take only an object, an
 
 
 sysfs allocates a buffer of size (PAGE_SIZE) and passes it to the
-method. Sysfs will call the method exactly once for each read or
+method. sysfs will call the method exactly once for each read or
 write. This forces the following behavior on the method
 implementations:
 
@@ -221,7 +221,7 @@ implementations:
   be called again, rearmed, to fill the buffer.
 
 - On write(2), sysfs expects the entire buffer to be passed during the
-  first write. Sysfs then passes the entire buffer to the store() method.
+  first write. sysfs then passes the entire buffer to the store() method.
   A terminating null is added after the data on stores. This makes
   functions like sysfs_streq() safe to use.
 
@@ -237,7 +237,7 @@ Other notes:
 - Writing causes the show() method to be rearmed regardless of current
   file position.
 
-- The buffer will always be PAGE_SIZE bytes in length. On i386, this
+- The buffer will always be PAGE_SIZE bytes in length. On x86, this
   is 4096.
 
 - show() methods should return the number of bytes printed into the
@@ -253,7 +253,7 @@ Other notes:
   through, be sure to return an error.
 
 - The object passed to the methods will be pinned in memory via sysfs
-  referencing counting its embedded object. However, the physical
+  reference counting its embedded object. However, the physical
   entity (e.g. device) the object represents may not be present. Be
   sure to have a way to check this, if necessary.
 
@@ -295,8 +295,12 @@ The top level sysfs directory looks like
     dev/
     devices/
     firmware/
-    net/
     fs/
+    hypervisor/
+    kernel/
+    module/
+    net/
+    power/
 
 devices/ contains a filesystem representation of the device tree. It maps
 directly to the internal kernel device tree, which is a hierarchy of
@@ -317,15 +321,18 @@ span multiple bus types).
 
 fs/ contains a directory for some filesystems.  Currently each
 filesystem wanting to export attributes must create its own hierarchy
-below fs/ (see ./fuse.txt for an example).
+below fs/ (see ./fuse.rst for an example).
+
+module/ contains parameter values and state information for all
+loaded system modules, for both builtin and loadable modules.
 
-dev/ contains two directories char/ and block/. Inside these two
+dev/ contains two directories: char/ and block/. Inside these two
 directories there are symlinks named <major>:<minor>.  These symlinks
 point to the sysfs directory for the given device.  /sys/dev provides a
 quick way to lookup the sysfs interface for a device from the result of
 a stat(2) operation.
 
-More information can driver-model specific features can be found in
+More information on driver-model specific features can be found in
 Documentation/driver-api/driver-model/.
 
 
@@ -335,7 +342,7 @@ TODO: Finish this section.
 Current Interfaces
 ~~~~~~~~~~~~~~~~~~
 
-The following interface layers currently exist in sysfs:
+The following interface layers currently exist in sysfs.
 
 
 devices (include/linux/device.h)
