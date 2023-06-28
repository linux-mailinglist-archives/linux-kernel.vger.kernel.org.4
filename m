Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE8D7407B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjF1Bku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjF1Bks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:40:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F011310FF;
        Tue, 27 Jun 2023 18:40:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A62461F889;
        Wed, 28 Jun 2023 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687916445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R8eZSeaid4Vp+UUwa4Su10+SxmbF9o4RkDKmIHyrq1k=;
        b=FdIWOCCu8d0heDRxTDSgsw17HrW5TB9N4Vu25H6WvXDQKXSnKKEoKEtVxOhRZ14WCoNgXx
        +XwXph8f3hdDQUrI4TfR6APpSK+5520VjhO558wk9inl0IFe/v8aSHd0dR41Nn+B5zi+4W
        F80xitXcC8kkY/3lbusJj773rNRZbNE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 222D1138E8;
        Wed, 28 Jun 2023 01:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2CyrBJ2Pm2TpLQAAMHmgww
        (envelope-from <ailiop@suse.com>); Wed, 28 Jun 2023 01:40:45 +0000
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 2/2] docs: update ocfs2-devel mailing list address
Date:   Wed, 28 Jun 2023 03:34:37 +0200
Message-Id: <20230628013437.47030-3-ailiop@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230628013437.47030-1-ailiop@suse.com>
References: <20230628013437.47030-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ocfs2-devel mailing list has been migrated to the kernel.org
infrastructure, update all related documentation pointers to reflect the
change.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 Documentation/ABI/obsolete/o2cb       |  4 ++--
 Documentation/ABI/removed/o2cb        |  4 ++--
 Documentation/ABI/stable/o2cb         |  4 ++--
 Documentation/ABI/testing/sysfs-ocfs2 | 12 ++++++------
 Documentation/filesystems/dlmfs.rst   |  2 +-
 Documentation/filesystems/ocfs2.rst   |  2 +-
 fs/ocfs2/Kconfig                      |  6 +++---
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/obsolete/o2cb b/Documentation/ABI/obsolete/o2cb
index fe7e45e17bc7..8f39b596731d 100644
--- a/Documentation/ABI/obsolete/o2cb
+++ b/Documentation/ABI/obsolete/o2cb
@@ -1,11 +1,11 @@
 What:		/sys/o2cb
 Date:		Dec 2005
 KernelVersion:	2.6.16
-Contact:	ocfs2-devel@oss.oracle.com
+Contact:	ocfs2-devel@lists.linux.dev
 Description:	Ocfs2-tools looks at 'interface-revision' for versioning
 		information. Each logmask/ file controls a set of debug prints
 		and can be written into with the strings "allow", "deny", or
 		"off". Reading the file returns the current state.
 		Was renamed to /sys/fs/u2cb/
 Users:		ocfs2-tools. It's sufficient to mail proposed changes to
-		ocfs2-devel@oss.oracle.com.
+		ocfs2-devel@lists.linux.dev.
diff --git a/Documentation/ABI/removed/o2cb b/Documentation/ABI/removed/o2cb
index 20c91adca6d4..61cff238fbe8 100644
--- a/Documentation/ABI/removed/o2cb
+++ b/Documentation/ABI/removed/o2cb
@@ -1,10 +1,10 @@
 What:		/sys/o2cb symlink
 Date:		May 2011
 KernelVersion:	3.0
-Contact:	ocfs2-devel@oss.oracle.com
+Contact:	ocfs2-devel@lists.linux.dev
 Description:	This is a symlink: /sys/o2cb to /sys/fs/o2cb. The symlink is
 		removed when new versions of ocfs2-tools which know to look
 		in /sys/fs/o2cb are sufficiently prevalent. Don't code new
 		software to look here, it should try /sys/fs/o2cb instead.
 Users:		ocfs2-tools. It's sufficient to mail proposed changes to
-		ocfs2-devel@oss.oracle.com.
+		ocfs2-devel@lists.linux.dev.
diff --git a/Documentation/ABI/stable/o2cb b/Documentation/ABI/stable/o2cb
index b62a967f01a0..3a83b5c54e93 100644
--- a/Documentation/ABI/stable/o2cb
+++ b/Documentation/ABI/stable/o2cb
@@ -1,10 +1,10 @@
 What:		/sys/fs/o2cb/
 Date:		Dec 2005
 KernelVersion:	2.6.16
-Contact:	ocfs2-devel@oss.oracle.com
+Contact:	ocfs2-devel@lists.linux.dev
 Description:	Ocfs2-tools looks at 'interface-revision' for versioning
 		information. Each logmask/ file controls a set of debug prints
 		and can be written into with the strings "allow", "deny", or
 		"off". Reading the file returns the current state.
 Users:		ocfs2-tools. It's sufficient to mail proposed changes to
-		ocfs2-devel@oss.oracle.com.
+		ocfs2-devel@lists.linux.dev.
diff --git a/Documentation/ABI/testing/sysfs-ocfs2 b/Documentation/ABI/testing/sysfs-ocfs2
index b7cc516a8a8a..494d7c1ac710 100644
--- a/Documentation/ABI/testing/sysfs-ocfs2
+++ b/Documentation/ABI/testing/sysfs-ocfs2
@@ -1,13 +1,13 @@
 What:		/sys/fs/ocfs2/
 Date:		April 2008
-Contact:	ocfs2-devel@oss.oracle.com
+Contact:	ocfs2-devel@lists.linux.dev
 Description:
 		The /sys/fs/ocfs2 directory contains knobs used by the
 		ocfs2-tools to interact with the filesystem.
 
 What:		/sys/fs/ocfs2/max_locking_protocol
 Date:		April 2008
-Contact:	ocfs2-devel@oss.oracle.com
+Contact:	ocfs2-devel@lists.linux.dev
 Description:
 		The /sys/fs/ocfs2/max_locking_protocol file displays version
 		of ocfs2 locking supported by the filesystem.  This version
@@ -28,7 +28,7 @@ Description:
 
 What:		/sys/fs/ocfs2/loaded_cluster_plugins
 Date:		April 2008
-Contact:	ocfs2-devel@oss.oracle.com
+Contact:	ocfs2-devel@lists.linux.dev
 Description:
 		The /sys/fs/ocfs2/loaded_cluster_plugins file describes
 		the available plugins to support ocfs2 cluster operation.
@@ -48,7 +48,7 @@ Description:
 
 What:		/sys/fs/ocfs2/active_cluster_plugin
 Date:		April 2008
-Contact:	ocfs2-devel@oss.oracle.com
+Contact:	ocfs2-devel@lists.linux.dev
 Description:
 		The /sys/fs/ocfs2/active_cluster_plugin displays which
 		cluster plugin is currently in use by the filesystem.
@@ -65,7 +65,7 @@ Description:
 
 What:		/sys/fs/ocfs2/cluster_stack
 Date:		April 2008
-Contact:	ocfs2-devel@oss.oracle.com
+Contact:	ocfs2-devel@lists.linux.dev
 Description:
 		The /sys/fs/ocfs2/cluster_stack file contains the name
 		of current ocfs2 cluster stack.  This value is set by
@@ -86,4 +86,4 @@ Description:
 		stack return an error.
 
 Users:
-	ocfs2-tools <ocfs2-tools-devel@oss.oracle.com>
+	ocfs2-tools <ocfs2-tools-devel@lists.linux.dev>
diff --git a/Documentation/filesystems/dlmfs.rst b/Documentation/filesystems/dlmfs.rst
index 28dd41a63be2..7e2b1fd471d7 100644
--- a/Documentation/filesystems/dlmfs.rst
+++ b/Documentation/filesystems/dlmfs.rst
@@ -12,7 +12,7 @@ dlmfs is built with OCFS2 as it requires most of its infrastructure.
 
 :Project web page:    http://ocfs2.wiki.kernel.org
 :Tools web page:      https://github.com/markfasheh/ocfs2-tools
-:OCFS2 mailing lists: https://oss.oracle.com/projects/ocfs2/mailman/
+:OCFS2 mailing lists: https://subspace.kernel.org/lists.linux.dev.html
 
 All code copyright 2005 Oracle except when otherwise noted.
 
diff --git a/Documentation/filesystems/ocfs2.rst b/Documentation/filesystems/ocfs2.rst
index 42ca9a3d4c6e..5827062995cb 100644
--- a/Documentation/filesystems/ocfs2.rst
+++ b/Documentation/filesystems/ocfs2.rst
@@ -14,7 +14,7 @@ get "mount.ocfs2" and "ocfs2_hb_ctl".
 
 Project web page:    http://ocfs2.wiki.kernel.org
 Tools git tree:      https://github.com/markfasheh/ocfs2-tools
-OCFS2 mailing lists: https://oss.oracle.com/projects/ocfs2/mailman/
+OCFS2 mailing lists: https://subspace.kernel.org/lists.linux.dev.html
 
 All code copyright 2005 Oracle except when otherwise noted.
 
diff --git a/fs/ocfs2/Kconfig b/fs/ocfs2/Kconfig
index 304d12186ccd..3123da7cfb30 100644
--- a/fs/ocfs2/Kconfig
+++ b/fs/ocfs2/Kconfig
@@ -17,9 +17,9 @@ config OCFS2_FS
 	  You'll want to install the ocfs2-tools package in order to at least
 	  get "mount.ocfs2".
 
-	  Project web page:    https://oss.oracle.com/projects/ocfs2
-	  Tools web page:      https://oss.oracle.com/projects/ocfs2-tools
-	  OCFS2 mailing lists: https://oss.oracle.com/projects/ocfs2/mailman/
+	  Project web page:    https://ocfs2.wiki.kernel.org/
+	  Tools web page:      https://github.com/markfasheh/ocfs2-tools
+	  OCFS2 mailing lists: https://subspace.kernel.org/lists.linux.dev.html
 
 	  For more information on OCFS2, see the file
 	  <file:Documentation/filesystems/ocfs2.rst>.
-- 
2.35.3

