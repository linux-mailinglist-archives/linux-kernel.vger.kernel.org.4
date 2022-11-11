Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF86254C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiKKH5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiKKH5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:57:51 -0500
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D78663CD7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:57:49 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id FIQ00143;
        Fri, 11 Nov 2022 15:57:43 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 11 Nov 2022 15:57:44 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <hirofumi@mail.parknet.co.jp>
CC:     <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] fat (exportfs): Fix some kernel-doc warnings
Date:   Fri, 11 Nov 2022 02:56:48 -0500
Message-ID: <20221111075648.4005-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20221111155743820564bb3ad0c95da1b7c3c2f81dd913
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):
  fs/fat/nfs.c:21: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  fs/fat/nfs.c:139: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 fs/fat/nfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
index af191371c352..3626eb585a98 100644
--- a/fs/fat/nfs.c
+++ b/fs/fat/nfs.c
@@ -17,7 +17,7 @@ struct fat_fid {
 #define FAT_FID_SIZE_WITHOUT_PARENT 3
 #define FAT_FID_SIZE_WITH_PARENT (sizeof(struct fat_fid)/sizeof(u32))
 
-/**
+/*
  * Look up a directory inode given its starting cluster.
  */
 static struct inode *fat_dget(struct super_block *sb, int i_logstart)
@@ -135,7 +135,7 @@ fat_encode_fh_nostale(struct inode *inode, __u32 *fh, int *lenp,
 	return type;
 }
 
-/**
+/*
  * Map a NFS file handle to a corresponding dentry.
  * The dentry may or may not be connected to the filesystem root.
  */
-- 
2.27.0

