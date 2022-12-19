Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB14650C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiLSNZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSNZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:25:34 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2121.outbound.protection.outlook.com [40.107.117.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320BC101DB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:25:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iknVU0QJ40oaN20iu7Yp0HWasgr0wcH9exhEgG62eLiUC4Y3c7jVJS73PFDMot+ghqoNEiRv5tRoiTsTZIy91i2AH8PsqDndlhXI9GzStq8XzVPepUduuRX/KdEBPnKA/KkehdsDz5SJACBPRLXrv+KHohIsFZEwrD2ulX9xBIqsPXA0defJ3WTx3idbIYN1L+35N5WRHCUcOyQf3IydXS6Uzg8lGAwuHa02q78iy3dgcF/VGe36+zTyL6IBYWXQaQ9U5EFsNefTAwukG6bnB20JQBgxNc8prAwARjiEMAyBoX48+OGfx2PnzNbXaQ9LajXrF/3FqpwKZj87SjpKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwvnzahXGKE+Iqi6uy0YF4Po2D4QAHAtuKprunOqWVw=;
 b=N7UdvQs+FrOJL8/nUq713IomyOcj5bP1LT0G+Ke9QjfaKdU/bGOefMR9o0KyuHyROAoOJtKYqgEDhctBpjRGIKpnT+c7vgALuAEOB1h9rpRXg4USfAgox7Fewqrxo9KuPoyY/T/x4rYGG9tjXfNwFkdGEFXrlLwYOzbwOcc1T9cCdLVMOlnBb1XcNcH8Dht/OdZpSxOvDOx3+nzusu4sRPgtt2fomc/G1BjXIDb4Qz7+IPyt52lYfylWFSCHNvYKE7tB+rKCwnpoRxVi/hul+4FLzv5wDnqKUr4VTJ2KlKfcENzs7kZeeXl3s8SD1jU5gZW+nguLNdSOj5WPtgT6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwvnzahXGKE+Iqi6uy0YF4Po2D4QAHAtuKprunOqWVw=;
 b=EDxJiPJqWv+2FxQlnOhdTb5FoKT84+FiVKH09QkADymRaSHzh4Q9CPMFzXVUbYn1va3DwGO515eWRGQUaQSDmlqlTyVNY2wBu9KaUw5njKNdEh82kPHRp5sXNCGXs9lBSF1hqKWGKx4+TsVOaBdYEVojLEGaERQglYnayeR3tU8iqJuusETLTlAfcKLqQZ+hfScPOSoABuf2X/dwIaDyUwtvYRB2l54pvvTgbVoz5WbPV1IuzZlQxmZmu9LQ7NaMDJefOda8vlywVLmyN0Uq//ltTlbbhot/Lrt4n5LYvR/9IR4dJW3OJpPNIFA0BiR6t/cd0tgvWx1nRDdeyVAEnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5915.apcprd06.prod.outlook.com (2603:1096:101:dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 13:25:27 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 13:25:27 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: merge f2fs_show_injection_info() into time_to_inject()
Date:   Mon, 19 Dec 2022 21:25:17 +0800
Message-Id: <20221219132517.17576-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: cf44d13a-58da-4bdb-5b56-08dae1c47e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73YEA1XzMUu6XucLUE4g1HblP3PGUseNIqr+oCytcaFM2Wh/Zos7OFw6bLB8YVfPl+D6UbORpuVxCtRUzE3LlLJT9VxQhHY/1XfU6C9+y34NNb9rm/iMqQIi6a1r9/Riga0ZJkPnQIvVf0peAFRt7ik7S4UCsltcM//YpEbrJPbrsEuyqB4NDpTGxLfrZTuw09rejZAxsRInKi2kZ80UtDwNw9Q38HRlzQq0AYK0q0V/Wy6hhbz1pVcrEO7LamjQL3t7y1UTI3L9fNCTRE1TnauezRjQK12937vwz35D4iQd+/ZsMVMFEfKHjiTeXaQJpyUg1YNjEOUqlhdPFkJiaXCoFT55UIPrNdmf4SHN8I/kAm7TUdgZdZhHQDsaKOn8kW+yoIArTXW1NbSAxi/hogo8BNQsgf0pU1Fpv6Xjhg+LkM0czogEceZpwE4Mr5BekjJvxuqExvrbhg1WONnjTI8fA24QoQOwikN4+OYTReNNwVHGiZy4AdX+GVTn+WlUtxTS+En9SvMgTahOrZk/YUEIIwVJJ0JxHN3J4yVJ+62dlOyl++ZL1tuNlNNGZlz1jQTsfcXv4A7SYv+HwpiUGMaSFWUZETYGEYMQKVgJ3BJXvng3Vf6E6ENmfRdhSVFz9ukWnLbmrJwSS346X1Pr/YV0IM5H42329tbTenDvt+CuYkaRRAX+pJu8jJ08Unn5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(36756003)(1076003)(2616005)(4326008)(8676002)(66476007)(66556008)(66946007)(83380400001)(5660300002)(30864003)(8936002)(52116002)(6506007)(6486002)(6666004)(107886003)(478600001)(316002)(6512007)(186003)(26005)(41300700001)(86362001)(2906002)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p8hMGA2lIOs09Il0m+HZdvGgdAFiWbAXKMvaK6K469gs9Z4yNJtr0lbeQaLf?=
 =?us-ascii?Q?HXYs7RNOMoiUmIHrQ7+A+E+P8WY6suax3g8WDR3M0m/TU5+j/0abRB/XLSdT?=
 =?us-ascii?Q?Dh/XFzoKzM+9RAUM8Kaf4jJreRMBTGReO+T5Lh1Aod04HymGm7RpR+PQDhuP?=
 =?us-ascii?Q?/sOXHRpmlk7R//9xA5clvgpWDerFjEool45EDyqMjdTaazFi+Z8hNzQroGQn?=
 =?us-ascii?Q?6mxSPOrCsxOZdwwyA+xrqxpQaXrdCOsq61MoE9kn4Ua8kv0kUm0DR+jusdFp?=
 =?us-ascii?Q?Um1PtKgYpyaoUvR+8dM78NPnOY2HfJPtlKfgmAf8ucPUp3m1BnFhSiiBmSsE?=
 =?us-ascii?Q?3SYlEi+awEGLM9lIFMIvEYug/2GD9+ZUb9XW1jY3ISfjft99u0uh57byBL+/?=
 =?us-ascii?Q?Xn+ZdqiJHAMFWxCN5xfadgVa73amZ47MNW1Ydhr98Su55PSZHnyw+QMMjBDd?=
 =?us-ascii?Q?8DZIMXnlxTlLlSAoUAwdmap9aFR+mpk9o6IFXkGeWFXmBI7HA9osmgMmROs7?=
 =?us-ascii?Q?eeczdOgSlExVmd0mHjoUs2jpdlST4gElDys4MOaI0+u2lfTHvBljV1R2Dpdd?=
 =?us-ascii?Q?yl5IavTJD8m6AHZhzF78SDh6XVRz+FdzovIfhhipsyZqTik1FLMyftJFabkY?=
 =?us-ascii?Q?Z1rSfGECmnX2xWOYrdyA0ZPfdaWQYcRb2sQX96HgfjSEPnUBYqI8p3RmFhh8?=
 =?us-ascii?Q?Zf8cgt7JsQgQf9UAospCvmLF0ijZna/E/rRwG+brB8m3pMx2o1gCPaOcEqrT?=
 =?us-ascii?Q?gaxav/5AQxcaT/jNKpcsqFtU3MkZ51PP6vC1DaZGzkYUwc1Xg03gRyqcnt+9?=
 =?us-ascii?Q?xtSq94ZjS0U9apkycZRU0okEMA2oDKsogCJYHKbwjfTle1z7XXybmpNqHMPb?=
 =?us-ascii?Q?jRzXn9laIJYSuz09xXN0N2RLZiJuJFvCVW3KvTFvn2K/mEfSeF8E5Jjk/vcs?=
 =?us-ascii?Q?qg4CvborH54LaqTtm+J1gnwBrOFhvJvN5t4IdA045XVBkKwSp0/C2AYyj3+f?=
 =?us-ascii?Q?0ZideMRBD/nEwGZYhkAYlQRFP0lb6CDX2JY96abcbjkU/S3tKEkTrO7kcd4p?=
 =?us-ascii?Q?vRszYWcNKK37M+b2JfCXhUpIuxAzEqrb6ljHu1CjZQnYsJNGZ3kmYleYYMUE?=
 =?us-ascii?Q?+emHlmNGhTrov7M13LdWi24zrG7wO/S3S72XbcAFzC7uH+CaODMRLC7g/xYA?=
 =?us-ascii?Q?C3X3E357Gn+nWDg4sUr6TLRGoAvK3gnEdUhyQmXZLstIxul6oIyJi95tSO87?=
 =?us-ascii?Q?JOuS42I1yyPyEQ1iE+sWDGahjwSQPA3ZhJaPn0FJAvapPfY1jfpNuoVtxs4G?=
 =?us-ascii?Q?pYvwnikjxy+65gYMIQftwLuBtbr7X2C8mQxP2+AVheNS3BcB0riAOtF3ijpD?=
 =?us-ascii?Q?/5Dw/cgj7G8Z55GEsj4CD8Yq4goo3DvU8zcpBaR6BxrBx2p+umz1Em5DoFxY?=
 =?us-ascii?Q?sXDZNR4ghwe5WfaUo7BdbRXVZGqY+JcWEGnn/qVBk8g4U9gscSsgQEQYT7T+?=
 =?us-ascii?Q?tnehYAXx8qcrGf+LfFcMO/YexTRSlCoppEmiyc+KCjiZY0iuB/RcbGDw+ZtS?=
 =?us-ascii?Q?d4Y2aB+xSU5pXlw+XYkUp8UzWHUSipKmgHnmg3QZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf44d13a-58da-4bdb-5b56-08dae1c47e5e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 13:25:27.7705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPu1YfjXXno/ej9KdnajLkYh4//UhwNSmIH9DRa8A74xVwZLfG7Hu+OvWYOXZjZro/mdv/59W6m+qgWlD1jSJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to additionally use f2fs_show_injection_info()
to output information. Concatenate time_to_inject() and
__time_to_inject() via a macro. In the new __time_to_inject()
function, pass in the caller function name. And in order to avoid
this inline function is not expanded causing __builtin_return_address(0)
return address of of time_to_inject(), mark time_to_inject() as
__always_inline.

In this way, we no longer need the f2fs_show_injection_info() function,
and let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-mark time_to_inject() as __always_inline
 fs/f2fs/checkpoint.c |  5 +----
 fs/f2fs/data.c       |  8 ++------
 fs/f2fs/dir.c        |  4 +---
 fs/f2fs/f2fs.h       | 43 +++++++++++++------------------------------
 fs/f2fs/file.c       |  4 +---
 fs/f2fs/gc.c         |  4 +---
 fs/f2fs/inode.c      |  4 +---
 fs/f2fs/node.c       |  4 +---
 fs/f2fs/segment.c    |  5 +----
 fs/f2fs/super.c      |  8 ++------
 10 files changed, 24 insertions(+), 65 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 56f7d0d6a8b2..d68b3c991888 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -171,10 +171,8 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
 bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type)
 {
-	if (time_to_inject(sbi, FAULT_BLKADDR)) {
-		f2fs_show_injection_info(sbi, FAULT_BLKADDR);
+	if (time_to_inject(sbi, FAULT_BLKADDR))
 		return false;
-	}
 
 	switch (type) {
 	case META_NAT:
@@ -622,7 +620,6 @@ int f2fs_acquire_orphan_inode(struct f2fs_sb_info *sbi)
 
 	if (time_to_inject(sbi, FAULT_ORPHAN)) {
 		spin_unlock(&im->ino_lock);
-		f2fs_show_injection_info(sbi, FAULT_ORPHAN);
 		return -ENOSPC;
 	}
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c77442a42f89..873908ed20f7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -295,10 +295,8 @@ static void f2fs_read_end_io(struct bio *bio)
 	iostat_update_and_unbind_ctx(bio, 0);
 	ctx = bio->bi_private;
 
-	if (time_to_inject(sbi, FAULT_READ_IO)) {
-		f2fs_show_injection_info(sbi, FAULT_READ_IO);
+	if (time_to_inject(sbi, FAULT_READ_IO))
 		bio->bi_status = BLK_STS_IOERR;
-	}
 
 	if (bio->bi_status) {
 		f2fs_finish_read_bio(bio, intask);
@@ -335,10 +333,8 @@ static void f2fs_write_end_io(struct bio *bio)
 	iostat_update_and_unbind_ctx(bio, 1);
 	sbi = bio->bi_private;
 
-	if (time_to_inject(sbi, FAULT_WRITE_IO)) {
-		f2fs_show_injection_info(sbi, FAULT_WRITE_IO);
+	if (time_to_inject(sbi, FAULT_WRITE_IO))
 		bio->bi_status = BLK_STS_IOERR;
-	}
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct page *page = bvec->bv_page;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8e025157f35c..9ccdbe120425 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -732,10 +732,8 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
 	}
 
 start:
-	if (time_to_inject(F2FS_I_SB(dir), FAULT_DIR_DEPTH)) {
-		f2fs_show_injection_info(F2FS_I_SB(dir), FAULT_DIR_DEPTH);
+	if (time_to_inject(F2FS_I_SB(dir), FAULT_DIR_DEPTH))
 		return -ENOSPC;
-	}
 
 	if (unlikely(current_depth == MAX_DIR_HASH_DEPTH))
 		return -ENOSPC;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4035dab1f570..6298bc030246 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1875,12 +1875,9 @@ struct f2fs_sb_info {
 };
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
-#define f2fs_show_injection_info(sbi, type)					\
-	printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n",	\
-		KERN_INFO, sbi->sb->s_id,				\
-		f2fs_fault_name[type],					\
-		__func__, __builtin_return_address(0))
-static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
+#define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__)
+static __always_inline bool __time_to_inject(struct f2fs_sb_info *sbi, int type,
+								    const char *func_name)
 {
 	struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
 
@@ -1893,12 +1890,14 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 	atomic_inc(&ffi->inject_ops);
 	if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
 		atomic_set(&ffi->inject_ops, 0);
+		printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n",
+			KERN_INFO, sbi->sb->s_id, f2fs_fault_name[type],
+			func_name, __builtin_return_address(0));
 		return true;
 	}
 	return false;
 }
 #else
-#define f2fs_show_injection_info(sbi, type) do { } while (0)
 static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 {
 	return false;
@@ -2231,10 +2230,8 @@ static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
 
 static inline int f2fs_trylock_op(struct f2fs_sb_info *sbi)
 {
-	if (time_to_inject(sbi, FAULT_LOCK_OP)) {
-		f2fs_show_injection_info(sbi, FAULT_LOCK_OP);
+	if (time_to_inject(sbi, FAULT_LOCK_OP))
 		return 0;
-	}
 	return f2fs_down_read_trylock(&sbi->cp_rwsem);
 }
 
@@ -2322,7 +2319,6 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 		return ret;
 
 	if (time_to_inject(sbi, FAULT_BLOCK)) {
-		f2fs_show_injection_info(sbi, FAULT_BLOCK);
 		release = *count;
 		goto release_quota;
 	}
@@ -2602,10 +2598,8 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 			return err;
 	}
 
-	if (time_to_inject(sbi, FAULT_BLOCK)) {
-		f2fs_show_injection_info(sbi, FAULT_BLOCK);
+	if (time_to_inject(sbi, FAULT_BLOCK))
 		goto enospc;
-	}
 
 	spin_lock(&sbi->stat_lock);
 
@@ -2729,11 +2723,8 @@ static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 		if (page)
 			return page;
 
-		if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_ALLOC)) {
-			f2fs_show_injection_info(F2FS_M_SB(mapping),
-							FAULT_PAGE_ALLOC);
+		if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_ALLOC))
 			return NULL;
-		}
 	}
 
 	if (!for_write)
@@ -2750,10 +2741,8 @@ static inline struct page *f2fs_pagecache_get_page(
 				struct address_space *mapping, pgoff_t index,
 				int fgp_flags, gfp_t gfp_mask)
 {
-	if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_GET)) {
-		f2fs_show_injection_info(F2FS_M_SB(mapping), FAULT_PAGE_GET);
+	if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_GET))
 		return NULL;
-	}
 
 	return pagecache_get_page(mapping, index, fgp_flags, gfp_mask);
 }
@@ -2803,10 +2792,8 @@ static inline void *f2fs_kmem_cache_alloc(struct kmem_cache *cachep,
 	if (nofail)
 		return f2fs_kmem_cache_alloc_nofail(cachep, flags);
 
-	if (time_to_inject(sbi, FAULT_SLAB_ALLOC)) {
-		f2fs_show_injection_info(sbi, FAULT_SLAB_ALLOC);
+	if (time_to_inject(sbi, FAULT_SLAB_ALLOC))
 		return NULL;
-	}
 
 	return kmem_cache_alloc(cachep, flags);
 }
@@ -3380,10 +3367,8 @@ static inline bool is_dot_dotdot(const u8 *name, size_t len)
 static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi,
 					size_t size, gfp_t flags)
 {
-	if (time_to_inject(sbi, FAULT_KMALLOC)) {
-		f2fs_show_injection_info(sbi, FAULT_KMALLOC);
+	if (time_to_inject(sbi, FAULT_KMALLOC))
 		return NULL;
-	}
 
 	return kmalloc(size, flags);
 }
@@ -3397,10 +3382,8 @@ static inline void *f2fs_kzalloc(struct f2fs_sb_info *sbi,
 static inline void *f2fs_kvmalloc(struct f2fs_sb_info *sbi,
 					size_t size, gfp_t flags)
 {
-	if (time_to_inject(sbi, FAULT_KVMALLOC)) {
-		f2fs_show_injection_info(sbi, FAULT_KVMALLOC);
+	if (time_to_inject(sbi, FAULT_KVMALLOC))
 		return NULL;
-	}
 
 	return kvmalloc(size, flags);
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cad4bdd6f097..ef25b5b14b10 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -782,10 +782,8 @@ int f2fs_truncate(struct inode *inode)
 
 	trace_f2fs_truncate(inode);
 
-	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE)) {
-		f2fs_show_injection_info(F2FS_I_SB(inode), FAULT_TRUNCATE);
+	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE))
 		return -EIO;
-	}
 
 	err = f2fs_dquot_initialize(inode);
 	if (err)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 83e68ec7763d..2b9891efcfee 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -72,11 +72,9 @@ static int gc_thread_func(void *data)
 			continue;
 		}
 
-		if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
-			f2fs_show_injection_info(sbi, FAULT_CHECKPOINT);
+		if (time_to_inject(sbi, FAULT_CHECKPOINT))
 			f2fs_stop_checkpoint(sbi, false,
 					STOP_CP_REASON_FAULT_INJECT);
-		}
 
 		if (!sb_start_write_trylock(sbi->sb)) {
 			stat_other_skip_bggc_count(sbi);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ff6cf66ed46b..01b9e6f85f6b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -809,10 +809,8 @@ void f2fs_evict_inode(struct inode *inode)
 	if (F2FS_HAS_BLOCKS(inode))
 		err = f2fs_truncate(inode);
 
-	if (time_to_inject(sbi, FAULT_EVICT_INODE)) {
-		f2fs_show_injection_info(sbi, FAULT_EVICT_INODE);
+	if (time_to_inject(sbi, FAULT_EVICT_INODE))
 		err = -EIO;
-	}
 
 	if (!err) {
 		f2fs_lock_op(sbi);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index dde4c0458704..8e87be0fa85e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2544,10 +2544,8 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i = NULL;
 retry:
-	if (time_to_inject(sbi, FAULT_ALLOC_NID)) {
-		f2fs_show_injection_info(sbi, FAULT_ALLOC_NID);
+	if (time_to_inject(sbi, FAULT_ALLOC_NID))
 		return false;
-	}
 
 	spin_lock(&nm_i->nid_list_lock);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 25ddea478fc1..573955d9aed7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -384,10 +384,8 @@ int f2fs_commit_atomic_write(struct inode *inode)
  */
 void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 {
-	if (time_to_inject(sbi, FAULT_CHECKPOINT)) {
-		f2fs_show_injection_info(sbi, FAULT_CHECKPOINT);
+	if (time_to_inject(sbi, FAULT_CHECKPOINT))
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_FAULT_INJECT);
-	}
 
 	/* balance_fs_bg is able to be pending */
 	if (need && excess_cached_nats(sbi))
@@ -1142,7 +1140,6 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		dc->len += len;
 
 		if (time_to_inject(sbi, FAULT_DISCARD)) {
-			f2fs_show_injection_info(sbi, FAULT_DISCARD);
 			err = -EIO;
 		} else {
 			err = __blkdev_issue_discard(bdev,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1f812b9ce985..73e779d3b2e7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1372,10 +1372,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 {
 	struct f2fs_inode_info *fi;
 
-	if (time_to_inject(F2FS_SB(sb), FAULT_SLAB_ALLOC)) {
-		f2fs_show_injection_info(F2FS_SB(sb), FAULT_SLAB_ALLOC);
+	if (time_to_inject(F2FS_SB(sb), FAULT_SLAB_ALLOC))
 		return NULL;
-	}
 
 	fi = alloc_inode_sb(sb, f2fs_inode_cachep, GFP_F2FS_ZERO);
 	if (!fi)
@@ -2595,10 +2593,8 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 
 int f2fs_dquot_initialize(struct inode *inode)
 {
-	if (time_to_inject(F2FS_I_SB(inode), FAULT_DQUOT_INIT)) {
-		f2fs_show_injection_info(F2FS_I_SB(inode), FAULT_DQUOT_INIT);
+	if (time_to_inject(F2FS_I_SB(inode), FAULT_DQUOT_INIT))
 		return -ESRCH;
-	}
 
 	return dquot_initialize(inode);
 }
-- 
2.25.1

