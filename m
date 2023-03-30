Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573BC6D0B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjC3Q2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjC3Q2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:28:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A998C15C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv2isaB+SSF0dnfb8C5wwDLnEoVesmEPaAbyrlTdNAGWnKsI07NQFBmexO6tKEU60g+PYhSWsIRbyui+zb1qi8xbpN8O07uTYN6ColLY3RyCCJ1V4HY3SXUqz5PURsSndKHCrmgmx1vEUQ3eTSX2gXRsqOkzFBFBcsxl0Zuu5/azNj/sD8i/dvu4XFTu9Ss/d6fYVg2qtqleUxrHvsc3ArxVMlDhH5LxVMlUNj/vVDtZiDnM8YKO+U6STJ1njbszoQP3NTkRcojGvW6jhBATLWm4JGjpJetG47Ms5xA47rHtSKEkOe4kPjaD/WUCXVgQJCcKOapQHpMHP/2IcB5BIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkFRCy9DDI8CX6WsddO36xVa2wo8ptGLsLrJQzL4eg4=;
 b=Qyeax//uvuX3eOTca6/Z7i+kgeBhh0DL3JoaKzarkJvP3qlEEynZwcmJl5eBe49ajovSS5d3KeieQ2EX4XHVO+AcB+tfyOmyjx0Zng//ctg7/mbLnzv67kS0/V4/8WRQ15l+V29/CS8xn/9iX1WaDT7xE1NBdPu7eM2HMOIWk6iAvgmgP+Rcg2z9zzuILP7AvKbED/aiw4lNz6aWE6tDHHTBxbZYGPBVkBDjlm9vrZ1aWJ25S1FWcrS0BHHTuRQCXW5F5slj+vL7nICahEHBgi9JEB5F5TF4QPBoNjOwBHBBHdN0m5ZZZLZkaHtBm0W1uGBzuRE6M8ImQAbGf8ze6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkFRCy9DDI8CX6WsddO36xVa2wo8ptGLsLrJQzL4eg4=;
 b=fWb9Aa/xOURsKJXtcFRmvQFok8Kkas1EgStqM4WBeKjFfQISkjgjI55o0ASZ1tBh3GrNYfK9XqmFI8he+E02NnWXWaErgj+hIeVm7BfvIuCB3vxoxlFzNCXpHTxHg5FsKsNJvddGcbiXttrHAry9UdllM6C5RdXJ3Uy1SrFS/oNIXXSUU/ObVy1ia7voxrSnSSD51qyzR8nPOnEq2pkw2W43eKdJbd6kl1qYZzSmUKI+mGB3XdsVesQyVWljcBqx4rycs3PH/3wyGaeKSuDv5X3savM0EArKfg6Tb029q2Y13eW7Lnd6PlAf2mJhU8GOsrzI4Pov5Pw85f7tZy4vXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4009.apcprd06.prod.outlook.com (2603:1096:4:e8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.20; Thu, 30 Mar 2023 16:28:25 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6222.033; Thu, 30 Mar 2023
 16:28:25 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Nick Terrell <terrelln@fb.com>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [RESEND] f2fs: add sanity compress level check for compressed file
Date:   Fri, 31 Mar 2023 00:28:11 +0800
Message-Id: <20230330162811.18923-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4009:EE_
X-MS-Office365-Filtering-Correlation-Id: 41603b14-f0e0-4488-027f-08db313bc917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CL3dObbQgp61mR1u4K/C+kU8xbFedl5fGaeMcVq5yu05kAKXcApiKdS7e6ZhxgeJMbZAcRh6GyL261ib/JMOU1MB81qdHAeGDaGOD60rQkWvL7tKctkmz0Y3qxJBVsgdnj5ALPD3j2VFmxSitksdUqqI2LJrJpf7scC7CGvVA7PjmLYfH1ABLCpsimclLu+2fHKv6uGk8po7DpbLES9KmRa0VgUdeesmNKS6qaly5rn6lAO9ccawgESwqGPEZi4nRf67YuFoHrtYnxd2k4JyU5sEesw08by2Iy1Gr2PX866XwQloqPdv0CjATaSNiKtX2ISXZrK5ybh0ao/KVrcI2JUyxtCDvLnb4QLp9vqkzag4EOQPgm4e1EVuZ7ZiR9KiWKNdDKGGVK23YUgmDjy2wW9eau0aMw7BeUXPLiwrxFTzY01QyLRgOgAWaKPpDL2O+MgipRlOuFj8QFbt2+WMJzjzBfNGFqiNZrQS2K52D4T8DJP2z7w+hFCIhfoxz2NDDBvP8TcYgpb5qYsBhAnC1qwLs37YXzChl20/kKrQoblrewkHIINQrAygVvwQlQQFjeOXHZzd2c1OJbocZ5St7hY+8lKSXAVRV72BUzhCZQ6vOOjF61H6mBkBYEXAT4G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(2906002)(8936002)(86362001)(66946007)(41300700001)(66556008)(8676002)(66476007)(4326008)(186003)(36756003)(316002)(110136005)(6506007)(1076003)(6512007)(26005)(5660300002)(83380400001)(52116002)(6666004)(6486002)(38350700002)(2616005)(38100700002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ks/+9vaBcZTZo3l/wGDHnaJT3LQbW6AjDCoD9URcuXBXrgVzGnrIm1+BeOH6?=
 =?us-ascii?Q?+VQ8oItw/XLk3tb5vIGAX1yDBoO1VLtLBbA6Y01JfkJLjTyTrhRH1csbXKIa?=
 =?us-ascii?Q?DuJpwnpUi9bbw/Uh9XJSu/jIEO54ZVaN5+EuCklHLPm+UH+Qkgpom3k0wHTs?=
 =?us-ascii?Q?waOgBg508jNgthZ9Q4+cIbyayzXNhtGeOpFiceGhjLzmEQ0J3W7RPfeDzP08?=
 =?us-ascii?Q?13WtroCTsMr/HiFG2AicYMiCidFrbEKybY3Z7TaEMCZg/LdTuZPteYOZ/jGd?=
 =?us-ascii?Q?Byigu7ss+DIKzKb/VnwEdfo+Z1O2BjhTjWmE40wLhu5c+bR2l8EtAVLUzSXM?=
 =?us-ascii?Q?Hdk6NS8sVJTYD49oMnskxtffV1qYsQZsxbgv0QDHgFIN5w75lyMaVM1+6Um3?=
 =?us-ascii?Q?jwFqu64yA2tOuJCpqUcTe/cCwkIktSoo5L5lWXGFx8cCWHYX8D93btsmwQcP?=
 =?us-ascii?Q?oOqDg7iGrJ2wErMvcv8CLLtz6SLeRNSCp/cEm2lAWgcg9X2cpGPxx5W5sqx4?=
 =?us-ascii?Q?Hefv21RVbKEercgI/E89d/PNOCc89+vxvo3afB2ji3jsgA6HIlQigIHbLjf9?=
 =?us-ascii?Q?sEKSrKlPUj89rnccadCNowuRpCtzZrn1pEluRNXQ51mxgRqpA5MIsdQmz0tf?=
 =?us-ascii?Q?7h/dVUjUwI4sY9eV4BxXzDlZEzJUcd1qShTNij+QIgmoF8m1+yRTSuzMXUB5?=
 =?us-ascii?Q?iA2b8F05rG296Etx3XRPfX7AkZ87EnzNVWTvOlyYOofA4RvgHUI4rh4FJlH/?=
 =?us-ascii?Q?CvWX1HnErzmEMU8arH9RlVJgdr81qaJFY04oSWQwaDx92aCAR09NpSP7src5?=
 =?us-ascii?Q?g3KjCFuguXXi77hWfyxnwn9lcOQWDAt4/t+zZnvoT7k/WHMt6LZ+vJv0S6wz?=
 =?us-ascii?Q?JG4BLNo6GWGf31B0oDQEwBeB1BtQtalUXb5Hc1H4TMfecul5AdYbMuhsYLJ+?=
 =?us-ascii?Q?BnULhTO5ZKXubingvwd0Bcb0q6AuT10IVbKanGktcGPvdE8VLxow1Cqm4yxv?=
 =?us-ascii?Q?YG0jNOqTKyxR8uQ6iizspzbmVnxnrRgLcDE5+7J68e3nI0BhlY5+wWRnwZAp?=
 =?us-ascii?Q?S02SavvQGijnCoEGJU5Ao70Zz65JYuustcD/HMnUxuDhM0Bc67rLVzqJ79oT?=
 =?us-ascii?Q?tlaczljRwpk88nuqnJVQpPbmCSRszZomkbWkq4DTQkvSXmlxO/fK0E6eQ1uE?=
 =?us-ascii?Q?CmYXCDeoABqyQ8+5asLxUWmzNahQ53/kpY9mhZlucoDMcfwBFjlscyOY9vR2?=
 =?us-ascii?Q?qb4PWQMun/uFDFtwS0E2A+5AEDXhAXfrOOxkFI+YriS9utGhhfaY5AaLUDX/?=
 =?us-ascii?Q?lwrXH/uSBF49FcyOOdJq1cFtHNOHfIE4YFshr4sOyJKNNJ9edlL9pU9JzpC+?=
 =?us-ascii?Q?PPgsefLc71ckNWxYfRCKu+uiGcSh7r7nSwMCMpY+Mz5x770n0bwotHppv04m?=
 =?us-ascii?Q?4swTqjWKwUmTe9sNtVdEcrPAfUeeJKc6UANUlQSnk+sZb6tkRzGIjANUxW/f?=
 =?us-ascii?Q?4RCUus7l5TyfzbgwPLw8lgyrQVXTJ6uDe+N8NIpR3zybuwA13wdrpX5mBVrO?=
 =?us-ascii?Q?vCkhjAIDc/On0NEEOG4+h/f0YYWLRX++T5kSadSN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41603b14-f0e0-4488-027f-08db313bc917
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 16:28:25.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: An0N5g8+/5RghEe3ozSRhPNNHZx35OJ8FT2UAs0PBT3yl+KjDi3rP3+kxBuFPfWI3VrzmB/E1/PZELPc1IQBTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4009
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3fde13f817e2 ("f2fs: compress: support compress level")
forgot to do basic compress level check, let's add it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/inode.c             | 94 +++++++++++++++++++++++++------------
 include/linux/zstd_lib.h    |  3 ++
 lib/zstd/compress/clevels.h |  4 --
 3 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index bb5b365a195d..e63f75168700 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -10,6 +10,8 @@
 #include <linux/buffer_head.h>
 #include <linux/writeback.h>
 #include <linux/sched/mm.h>
+#include <linux/lz4.h>
+#include <linux/zstd.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -202,6 +204,66 @@ void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page)
 	ri->i_inode_checksum = cpu_to_le32(f2fs_inode_chksum(sbi, page));
 }
 
+static bool sanity_check_compress_inode(struct inode *inode,
+			struct f2fs_inode *ri)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned char compress_level;
+
+	if (ri->i_compress_algorithm >= COMPRESS_MAX) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi,
+			"%s: inode (ino=%lx) has unsupported compress algorithm: %u, run fsck to fix",
+			__func__, inode->i_ino, ri->i_compress_algorithm);
+		return false;
+	}
+	if (le64_to_cpu(ri->i_compr_blocks) >
+			SECTOR_TO_BLOCK(inode->i_blocks)) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi,
+			"%s: inode (ino=%lx) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
+			__func__, inode->i_ino, le64_to_cpu(ri->i_compr_blocks),
+			SECTOR_TO_BLOCK(inode->i_blocks));
+		return false;
+	}
+	if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
+		ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_warn(sbi,
+			"%s: inode (ino=%lx) has unsupported log cluster size: %u, run fsck to fix",
+			__func__, inode->i_ino, ri->i_log_cluster_size);
+		return false;
+	}
+
+	compress_level = le16_to_cpu(ri->i_compress_flag) >> COMPRESS_LEVEL_OFFSET;
+	switch (ri->i_compress_algorithm) {
+	case COMPRESS_LZO:
+	case COMPRESS_LZORLE:
+		if (compress_level)
+			goto err;
+		break;
+	case COMPRESS_LZ4:
+		if ((compress_level && compress_level < LZ4HC_MIN_CLEVEL) ||
+				compress_level > LZ4HC_MAX_CLEVEL)
+			goto err;
+		break;
+	case COMPRESS_ZSTD:
+		if (!compress_level || compress_level > ZSTD_MAX_CLEVEL)
+			goto err;
+		break;
+	default:
+		goto err;
+	}
+
+	return true;
+
+err:
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported compress level: %u, run fsck to fix",
+		  __func__, inode->i_ino, compress_level);
+	return false;
+}
+
 static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -285,36 +347,8 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 
 	if (f2fs_has_extra_attr(inode) && f2fs_sb_has_compression(sbi) &&
 			fi->i_flags & F2FS_COMPR_FL &&
-			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
-						i_log_cluster_size)) {
-		if (ri->i_compress_algorithm >= COMPRESS_MAX) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
-				"compress algorithm: %u, run fsck to fix",
-				  __func__, inode->i_ino,
-				  ri->i_compress_algorithm);
-			return false;
-		}
-		if (le64_to_cpu(ri->i_compr_blocks) >
-				SECTOR_TO_BLOCK(inode->i_blocks)) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			f2fs_warn(sbi, "%s: inode (ino=%lx) has inconsistent "
-				"i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
-				  __func__, inode->i_ino,
-				  le64_to_cpu(ri->i_compr_blocks),
-				  SECTOR_TO_BLOCK(inode->i_blocks));
-			return false;
-		}
-		if (ri->i_log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
-			ri->i_log_cluster_size > MAX_COMPRESS_LOG_SIZE) {
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			f2fs_warn(sbi, "%s: inode (ino=%lx) has unsupported "
-				"log cluster size: %u, run fsck to fix",
-				  __func__, inode->i_ino,
-				  ri->i_log_cluster_size);
-			return false;
-		}
-	}
+			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_log_cluster_size))
+		sanity_check_compress_inode(inode, ri);
 
 	return true;
 }
diff --git a/include/linux/zstd_lib.h b/include/linux/zstd_lib.h
index 79d55465d5c1..ff55f41c73d3 100644
--- a/include/linux/zstd_lib.h
+++ b/include/linux/zstd_lib.h
@@ -88,6 +88,9 @@ ZSTDLIB_API const char* ZSTD_versionString(void);
 #  define ZSTD_CLEVEL_DEFAULT 3
 #endif
 
+/*-=====  Pre-defined compression levels  =====-*/
+#define ZSTD_MAX_CLEVEL     22
+
 /* *************************************
  *  Constants
  ***************************************/
diff --git a/lib/zstd/compress/clevels.h b/lib/zstd/compress/clevels.h
index d9a76112ec3a..b040d9d29089 100644
--- a/lib/zstd/compress/clevels.h
+++ b/lib/zstd/compress/clevels.h
@@ -14,10 +14,6 @@
 #define ZSTD_STATIC_LINKING_ONLY  /* ZSTD_compressionParameters  */
 #include <linux/zstd.h>
 
-/*-=====  Pre-defined compression levels  =====-*/
-
-#define ZSTD_MAX_CLEVEL     22
-
 __attribute__((__unused__))
 
 static const ZSTD_compressionParameters ZSTD_defaultCParameters[4][ZSTD_MAX_CLEVEL+1] = {
-- 
2.35.1

