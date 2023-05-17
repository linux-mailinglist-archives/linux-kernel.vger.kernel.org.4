Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2364706470
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjEQJoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEQJoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB31740E6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E402A6439F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C68C4339E;
        Wed, 17 May 2023 09:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684316593;
        bh=NO+AbaDYG5micS/+RgkrizmeaZsrsZUua0A4BGzvgC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V94AZLKo/ELXGH07H2m+B7Oghu8UwtDrEKGx8ZIIlBgFEOZIhAy2e4q7FzXOlDBTT
         ggqG8bgkOp53Bg/VcSGYeVAkj5g585ZUhDtzfNJMaY2Qx29hJEXobDimsa17npqSeU
         asobe+cbbCHg06C9HDqqIh6CUgK9EoDEDR+VJJlCjlVbwDwlvphKu7T0oAv5XWIif0
         j4M9cNJt0GA1PS2l8nZ3f3skNQrcPy7xXp7Ya7If/H82DaP+qVCLmvk15LxdOlFBXn
         1pPYa1u5atr859EbrG8wPdHtBWFvW/PhrdZKU8mMVMseJIfa27Ds6cOhTf6QRHIcof
         TIl2n+GOBd4Yg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: renew value of F2FS_FEATURE_*
Date:   Wed, 17 May 2023 17:42:50 +0800
Message-Id: <20230517094250.1407910-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517094250.1407910-1-chao@kernel.org>
References: <20230517094250.1407910-1-chao@kernel.org>
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

Define F2FS_FEATURE_* macro w/ 32-bits value rather than 16-bits value.

No logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6719cf1c5596..8d4eaf4d2246 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -186,21 +186,21 @@ struct f2fs_mount_info {
 	unsigned char noextensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
 };
 
-#define F2FS_FEATURE_ENCRYPT		0x0001
-#define F2FS_FEATURE_BLKZONED		0x0002
-#define F2FS_FEATURE_ATOMIC_WRITE	0x0004
-#define F2FS_FEATURE_EXTRA_ATTR		0x0008
-#define F2FS_FEATURE_PRJQUOTA		0x0010
-#define F2FS_FEATURE_INODE_CHKSUM	0x0020
-#define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
-#define F2FS_FEATURE_QUOTA_INO		0x0080
-#define F2FS_FEATURE_INODE_CRTIME	0x0100
-#define F2FS_FEATURE_LOST_FOUND		0x0200
-#define F2FS_FEATURE_VERITY		0x0400
-#define F2FS_FEATURE_SB_CHKSUM		0x0800
-#define F2FS_FEATURE_CASEFOLD		0x1000
-#define F2FS_FEATURE_COMPRESSION	0x2000
-#define F2FS_FEATURE_RO			0x4000
+#define F2FS_FEATURE_ENCRYPT			0x00000001
+#define F2FS_FEATURE_BLKZONED			0x00000002
+#define F2FS_FEATURE_ATOMIC_WRITE		0x00000004
+#define F2FS_FEATURE_EXTRA_ATTR			0x00000008
+#define F2FS_FEATURE_PRJQUOTA			0x00000010
+#define F2FS_FEATURE_INODE_CHKSUM		0x00000020
+#define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x00000040
+#define F2FS_FEATURE_QUOTA_INO			0x00000080
+#define F2FS_FEATURE_INODE_CRTIME		0x00000100
+#define F2FS_FEATURE_LOST_FOUND			0x00000200
+#define F2FS_FEATURE_VERITY			0x00000400
+#define F2FS_FEATURE_SB_CHKSUM			0x00000800
+#define F2FS_FEATURE_CASEFOLD			0x00001000
+#define F2FS_FEATURE_COMPRESSION		0x00002000
+#define F2FS_FEATURE_RO				0x00004000
 
 #define __F2FS_HAS_FEATURE(raw_super, mask)				\
 	((raw_super->feature & cpu_to_le32(mask)) != 0)
-- 
2.40.1

