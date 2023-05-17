Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E07370646F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjEQJoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEQJoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:44:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652B95580
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C14964493
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F51C433D2;
        Wed, 17 May 2023 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684316591;
        bh=8r7M5a3OEqoDbb+pxrJPm+TfUU/r1Lo2eHF4tZCywJE=;
        h=From:To:Cc:Subject:Date:From;
        b=p/ACQTlqdZsahA9Sbserch1JIbqI1qzvMKCUtrIYtrPz/Hb7+6myrsSbo7KgQiKuU
         sa6EO5nHINxLXMD8zGkTLZ1kjHt3W89lMoqBBvnA1GePIgCf4YBrtsMfvQe5pKJg/h
         dDHqs00QbhzxI71CdryJ/bJ2abirHDmy0/ebgw/bM6SvimLJmVtH5mkf9e01wm4d/V
         czR476P8kJ/T+7oqLmOEGf0+ZSlhaE/sI8Wum0f/XzI2/NkKdVjJL3vo0ZRgVTUiIj
         Zc9hw8IZ9kJvDptPA6pZ9E7zW5hoXAbXClfNk11KEjwFjorEr/w4EYCCNKbCnZkqEe
         dZOAycb1Z2IEg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: renew value of F2FS_MOUNT_*
Date:   Wed, 17 May 2023 17:42:49 +0800
Message-Id: <20230517094250.1407910-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Then we can just define newly introduced mount option w/ lasted
free number rather than random free one.

Just cleanup, no logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 56 +++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 99edc4981edf..6719cf1c5596 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -80,34 +80,34 @@ extern const char *f2fs_fault_name[FAULT_MAX];
 /*
  * For mount options
  */
-#define F2FS_MOUNT_DISABLE_ROLL_FORWARD	0x00000002
-#define F2FS_MOUNT_DISCARD		0x00000004
-#define F2FS_MOUNT_NOHEAP		0x00000008
-#define F2FS_MOUNT_XATTR_USER		0x00000010
-#define F2FS_MOUNT_POSIX_ACL		0x00000020
-#define F2FS_MOUNT_DISABLE_EXT_IDENTIFY	0x00000040
-#define F2FS_MOUNT_INLINE_XATTR		0x00000080
-#define F2FS_MOUNT_INLINE_DATA		0x00000100
-#define F2FS_MOUNT_INLINE_DENTRY	0x00000200
-#define F2FS_MOUNT_FLUSH_MERGE		0x00000400
-#define F2FS_MOUNT_NOBARRIER		0x00000800
-#define F2FS_MOUNT_FASTBOOT		0x00001000
-#define F2FS_MOUNT_READ_EXTENT_CACHE	0x00002000
-#define F2FS_MOUNT_DATA_FLUSH		0x00008000
-#define F2FS_MOUNT_FAULT_INJECTION	0x00010000
-#define F2FS_MOUNT_USRQUOTA		0x00080000
-#define F2FS_MOUNT_GRPQUOTA		0x00100000
-#define F2FS_MOUNT_PRJQUOTA		0x00200000
-#define F2FS_MOUNT_QUOTA		0x00400000
-#define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
-#define F2FS_MOUNT_RESERVE_ROOT		0x01000000
-#define F2FS_MOUNT_DISABLE_CHECKPOINT	0x02000000
-#define F2FS_MOUNT_NORECOVERY		0x04000000
-#define F2FS_MOUNT_ATGC			0x08000000
-#define F2FS_MOUNT_MERGE_CHECKPOINT	0x10000000
-#define	F2FS_MOUNT_GC_MERGE		0x20000000
-#define F2FS_MOUNT_COMPRESS_CACHE	0x40000000
-#define F2FS_MOUNT_AGE_EXTENT_CACHE	0x80000000
+#define F2FS_MOUNT_DISABLE_ROLL_FORWARD	0x00000001
+#define F2FS_MOUNT_DISCARD		0x00000002
+#define F2FS_MOUNT_NOHEAP		0x00000004
+#define F2FS_MOUNT_XATTR_USER		0x00000008
+#define F2FS_MOUNT_POSIX_ACL		0x00000010
+#define F2FS_MOUNT_DISABLE_EXT_IDENTIFY	0x00000020
+#define F2FS_MOUNT_INLINE_XATTR		0x00000040
+#define F2FS_MOUNT_INLINE_DATA		0x00000080
+#define F2FS_MOUNT_INLINE_DENTRY	0x00000100
+#define F2FS_MOUNT_FLUSH_MERGE		0x00000200
+#define F2FS_MOUNT_NOBARRIER		0x00000400
+#define F2FS_MOUNT_FASTBOOT		0x00000800
+#define F2FS_MOUNT_READ_EXTENT_CACHE	0x00001000
+#define F2FS_MOUNT_DATA_FLUSH		0x00002000
+#define F2FS_MOUNT_FAULT_INJECTION	0x00004000
+#define F2FS_MOUNT_USRQUOTA		0x00008000
+#define F2FS_MOUNT_GRPQUOTA		0x00010000
+#define F2FS_MOUNT_PRJQUOTA		0x00020000
+#define F2FS_MOUNT_QUOTA		0x00040000
+#define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00080000
+#define F2FS_MOUNT_RESERVE_ROOT		0x00100000
+#define F2FS_MOUNT_DISABLE_CHECKPOINT	0x00200000
+#define F2FS_MOUNT_NORECOVERY		0x00400000
+#define F2FS_MOUNT_ATGC			0x00800000
+#define F2FS_MOUNT_MERGE_CHECKPOINT	0x01000000
+#define	F2FS_MOUNT_GC_MERGE		0x02000000
+#define F2FS_MOUNT_COMPRESS_CACHE	0x04000000
+#define F2FS_MOUNT_AGE_EXTENT_CACHE	0x08000000
 
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
-- 
2.40.1

