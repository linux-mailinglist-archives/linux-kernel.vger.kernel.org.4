Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A39F649F22
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiLLMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiLLMwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:52:00 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2128.outbound.protection.outlook.com [40.107.215.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166061107
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:51:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxD8oteoQeKC0ly/LZK/S9sPrTRJoZ1JwHLQqxshisSnAMkqB/hiaa6qnJ7i6xi5lD1bsrLOJZW0fA0tfvJbk6nYdDTb7IrbcXICJuzrBA1s5eU1CNcG4Rle2wNoDOpmFdSoBW9RQqoElPe7Ay7bqIAWtSP2YWLNTWWJNLnwIAvVR0YLKRAGEAx7UR70hsmgWFPJWpx37Rboq4W5NJb3WZbWh9C8IgTjhJygTVkj0Wxj5WeUWevwBbJjHppkpDo2SJKHr/lzZF5OXX7jOAJDks6edCek5RzOGc6JCbqB3HVmtWj+r8CsDt7nqxhYsyk3hcIB0hA5D6fc/osjsToC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1c4sIPc/aAMDLCdXl9Z05V03AwP5ZqlC1501fqMy5I=;
 b=Rr7fnnHSvddABItBTzCknKG4sWwukb7zzhcVneMEfv95wkkOH8kHDZcQ4UzHP33PTS2ajxaguTOS8fvG6NDNWA+h8Dye41otWn6+GNYVFAIQEXZlBVLVF1KyKrx74F8auUlGKa6ZU3TLTm4JaD6r1xOy8UpEEeoxoeX5j+qnWqCPDibVcNTo34yl46jCZnoDlJRhLliyiBlURtUDWHGnLlCy/oT3KCltA+LJyiuYKCsvJH9X3FyJYJiVETZzNzwJuKHrUm/ugwueJHf1DhyRyX1ZUM9AULIDmdUt4j/pIq4uiKn9PuXor7ZcUyi9fZtNL0a4niFqzMBjG15RC9vibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1c4sIPc/aAMDLCdXl9Z05V03AwP5ZqlC1501fqMy5I=;
 b=qinfGrjRbHjTtfKR5eoJipSjCB4x6fApQHumK0fePjeS2q0P1ceA2EC/3FQMrHdXv7C83D8AwuwnkHIbllE/sK76I97jHFu5P81fq88dL9uYxaaPWEzK3RD6mNfcum0DRZHvle8WejRdVWJoNb0iL+EoPhihhNM+GqNWsUiQHaDdzB3GCfdwEf1F7/t+woWMmbYTaAKxFX8VWM1/XgBar37Z+PtWo1iyzjsLwjFdPJOChjm4ZhUSGfavjQIBqYIhaxmvuhAzP1qJswIff3z7MEv8mUKKZQ04tu3bWY1ClQj8l4/+Q3DP/EOQ6dwV1geOL4EER+TBYC5pHrEHpbt4Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4538.apcprd06.prod.outlook.com (2603:1096:4:156::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 12:51:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 12:51:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: add support for counting time of submit discard cmd
Date:   Mon, 12 Dec 2022 20:51:37 +0800
Message-Id: <20221212125137.77187-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: 339f33ce-d514-4468-4f2f-08dadc3fa298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0bIuKY1yW27QkjV5GdIIUjutbH45Oplh8Aad+vB4qVdNb27JmFwPnhCCuzr2DWiJKH70MaQYgfcdD5l7UcUqyIkrqX1IR0dcg22uymSEDEJu+vVYZce5HB3b+832C6nqXy7X1zXyoKaGgYytfHf7NiVKrFohpUtc4rQ7wcyKIvo9iAVHMt3jbVZab/SDllPCjLpPSDqp/MoFU2f/u2HbD4FYYdDXIBGmqkeXc0Z6ZPbqdXwzIZrQHw99ni52j6tlJ5jQUIKlOEuQL5xym9AUxmjAby6GTKJMKe4mw8cYAjYlKlzMAZOjbCpKHDoltsOsYz1HmvBtARNkSQYkxPcpnkF5aY4mHz3DK4Wvsczz6QpBZ7nsC3GXB2uuzJ6rTPmUh88BimSYq7FFKEIdco760SaKxfDzVPvaA0/Y2QrPHh2JFoRzij89NOC99csuR1U70VzDiwRjCA13D0aSJTnpDEVebwMiBBVTzkzB0VutxwXnhVxcb0TUfGc9IOLYNOeEbObBnhwCIjgHC4hqG2H5W1oFrmEj0fQTzp5jNnh2bOSjxD4y3u+DP36OJaPyspwdcLVTD6iBObVXaUd09G/2xueqVe9loMublFExCj3PDJtwpVH/6U/gTYHhfMBxKPxt3pE6Qiir9EtOXxOp3Fi+Dgrq4Jg76blUThg5N13PkRh7C4FWVGEoFHlpxOwnEc7p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199015)(36756003)(2616005)(186003)(1076003)(83380400001)(2906002)(107886003)(6666004)(6512007)(26005)(6506007)(478600001)(6486002)(41300700001)(52116002)(5660300002)(38100700002)(66476007)(66946007)(8936002)(66556008)(38350700002)(86362001)(8676002)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6YkQ6Pauh/9L0cW1GNePCnlxoiD1mOwtdKeGqeCZeWmDJ7y7kEYXyvSAbFtN?=
 =?us-ascii?Q?G7GC/HEl58E/I/+Y+8Hf6htfmM+cXUf9wjH0vAnkXGOXfXgXZpsLMD1qPYbH?=
 =?us-ascii?Q?LSyeDyMUYLe1MkusdZRfistcwyEN6vdP++RZ2nTu1772GVXHF6Iqp2L7P2nA?=
 =?us-ascii?Q?d1ZdUjS5mooPqniREr8vil8Hsg/BDfKPpPZIwIk0e/oRrx9KVgDI9W7NBhiB?=
 =?us-ascii?Q?o8C3dC9OJVYGiTuWMPdICYqI8x2URZ6KNAUnr4fzRcjxkyxRZh4A6yOLQqhI?=
 =?us-ascii?Q?3z1zPFNCXdRPRqcmaXZQABNJuOH/9uFEOB8mzKFQP4jczrxGxfgN/bqA2aSs?=
 =?us-ascii?Q?QS/O0vOrm5jB4MDBmAfOanJvoZgx/8Jrdh/l4EPEetwnUrPaxXi7VHbLW4ot?=
 =?us-ascii?Q?laSanreapi3IRzzbFCLHgr8/+Q4kOWSYiPO4TW2PGBgfXaYxBcvId1NO9AaN?=
 =?us-ascii?Q?GoJfmm5uqflRr+ayLX71NnDTXCHpY1DRkr4EN0OFj9SIlfTN0HYee+7nKmhM?=
 =?us-ascii?Q?js0MfIaH4QTxlIutk9XNoh249A4/YfXFOvmoEw0tM2ZnAUmUYyLWiGwby7Vl?=
 =?us-ascii?Q?rFOFcy/h+S30Lv+0S9xTrZZg9QnqkDCInZ6D5GZDNF8AWs0ol1wLvgx2UTCf?=
 =?us-ascii?Q?xa+/H0Iu3RZSxRyDyfjoasHphO3tbn2i0pCbjDeyVk+JaEKr5ShRHig4mKYd?=
 =?us-ascii?Q?obfNj8jOfz2bdpdRykK+vaVJn0yUrl6lXcs9PAWmj50T7a6VWMcRHpXWSJPB?=
 =?us-ascii?Q?TXS9Dg0NCtJCN2fEy7QSqhPmdGfXk/CMHTvtN4Z3gEu2nZ9+7UHXONY8LIkI?=
 =?us-ascii?Q?iyqrWApbLFx3ziW7nOFVseUZlLV7Bsw2JN+/luhY2sJVWgAH85sqvxNQYLSz?=
 =?us-ascii?Q?Om6v/GCfkVLE2IrL59Dm3aSiWDBuIOHZg+QkrkXkzslS9t8a/WHZY+NXm6nQ?=
 =?us-ascii?Q?+etHj40ibG5yxzBCcG3BJHr6vokLe5NXtmksVt6ZfpgVeTRySZc1LPewMupq?=
 =?us-ascii?Q?O2pYH9W3OpCkOhnQkELCZFU8UJ+yul8nI940F5sIc1Hh76qReKEa9D9UtP6L?=
 =?us-ascii?Q?5TEFO/lavykMFb+FWkoJQHHb9ScW8YZSULV4MFnutFMPN/JRRPo/I4BPseLI?=
 =?us-ascii?Q?P4ExHFdTiCGhqPi3+MyW4CAY0pzoVFzcQwIL37p5fJQj4FVFsO8yh50ZpM+m?=
 =?us-ascii?Q?UwNtzoEcd9JpDSmXeSIG7F5TC3pT2JgkuqUmR7NtHMVRKTCaI2MQWwH53Zr5?=
 =?us-ascii?Q?mKVlEwbJhVFgGr1Hdfb3oxUf+eP6+vFU1IWpnfEc5IeJbHjwd+FfjJ+P9sSC?=
 =?us-ascii?Q?Z6LqAkryOw833c5blwdFJ5xNPrCgi8F5kQlcUESM7JbhZDjB3GuR2082R4yJ?=
 =?us-ascii?Q?930QZTEia1x5BAgAqTzPdGk6zOcbYZTHDEkGYNNs+YzW3u85wekZabbdGYc+?=
 =?us-ascii?Q?BO5gDFfZzjarbPOXFxGSq9eR3IJzxxmvazmgFTO/4RGFivkc0hq19paXBr7C?=
 =?us-ascii?Q?FVySwhFImd8j1hzZzl6tpwQx/4t7xDa/0dSHKPZNXO/bfPkvDhm6vHzBkO5y?=
 =?us-ascii?Q?3jvPqJqvNelOFmDYopG0AFmhbWRwmtse2vDD29zn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339f33ce-d514-4468-4f2f-08dadc3fa298
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 12:51:49.7787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHVE5qxdCeZEt56ktU1VBj1aBNpBB4MPT0F7wohb+ovBc10+DWHwP3kfiX+lSEZ67AOzlYvThLsaD66ujETrFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4538
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for counting the average time and
peak time of submit discard command, and we can see its
value in debugfs.

It is not sure whether the block layer has recorded these
data, and these data are allowed to be accessed by fs,
or they are only exported to user space.

On the one hand, I added these data to better understand
the current device operating status, and to further control
the discard process in a more detailed manner based on the
discard submit time in the future.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/debug.c   | 10 +++++++---
 fs/f2fs/f2fs.h    |  6 ++++++
 fs/f2fs/segment.c | 21 +++++++++++++++++++--
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 32af4f0c5735..142c256b89d9 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -120,6 +120,10 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 			llist_empty(&SM_I(sbi)->fcc_info->issue_list);
 	}
 	if (SM_I(sbi)->dcc_info) {
+		struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+
+		si->discard_avg = dcc->discard_time_avg;
+		si->discard_peak = dcc->discard_time_peak;
 		si->nr_discarded =
 			atomic_read(&SM_I(sbi)->dcc_info->issued_discard);
 		si->nr_discarding =
@@ -545,9 +549,9 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->nr_wb_cp_data, si->nr_wb_data,
 			   si->nr_flushing, si->nr_flushed,
 			   si->flush_list_empty);
-		seq_printf(s, "Discard: (%4d %4d)) cmd: %4d undiscard:%4u\n",
-			   si->nr_discarding, si->nr_discarded,
-			   si->nr_discard_cmd, si->undiscard_blks);
+		seq_printf(s, "Discard: (%4d %4d, avg:%4lldns, peak:%4lldns)) cmd: %4d undiscard:%4u\n",
+			   si->nr_discarding, si->nr_discarded, ktime_to_us(si->discard_avg),
+			   ktime_to_us(si->discard_peak), si->nr_discard_cmd, si->undiscard_blks);
 		seq_printf(s, "  - atomic IO: %4d (Max. %4d)\n",
 			   si->aw_cnt, si->max_aw_cnt);
 		seq_printf(s, "  - compress: %4d, hit:%8d\n", si->compress_pages, si->compress_page_hit);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e8953c3dc81a..2cd55cb981ff 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -371,6 +371,8 @@ struct discard_cmd {
 	int error;			/* bio error */
 	spinlock_t lock;		/* for state/bio_ref updating */
 	unsigned short bio_ref;		/* bio reference count */
+	struct discard_cmd_control *dcc;	/* global discard cmd control */
+	ktime_t submit_start;	/* submit start time */
 };
 
 enum {
@@ -415,6 +417,9 @@ struct discard_cmd_control {
 	unsigned int max_ordered_discard;	/* maximum discard granularity issued by lba order */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
 	unsigned int next_pos;			/* next discard position */
+	spinlock_t discard_time_lock;	/* for discard time statistics */
+	ktime_t discard_time_avg;		/* issued discard cmd avg time */
+	ktime_t discard_time_peak;		/* issued discard cmd peak time */
 	atomic_t issued_discard;		/* # of issued discard */
 	atomic_t queued_discard;		/* # of queued discard */
 	atomic_t discard_cmd_cnt;		/* # of cached cmd count */
@@ -3896,6 +3901,7 @@ struct f2fs_stat_info {
 	int nr_dio_read, nr_dio_write;
 	unsigned int io_skip_bggc, other_skip_bggc;
 	int nr_flushing, nr_flushed, flush_list_empty;
+	ktime_t discard_avg, discard_peak;
 	int nr_discarding, nr_discarded;
 	int nr_discard_cmd;
 	unsigned int undiscard_blks;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a9099a754dd2..73cd05bb3f4a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -937,6 +937,7 @@ static struct discard_cmd *__create_discard_cmd(struct f2fs_sb_info *sbi,
 	list_add_tail(&dc->list, pend_list);
 	spin_lock_init(&dc->lock);
 	dc->bio_ref = 0;
+	dc->dcc = dcc;
 	atomic_inc(&dcc->discard_cmd_cnt);
 	dcc->undiscard_blks += len;
 
@@ -1006,9 +1007,13 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
 static void f2fs_submit_discard_endio(struct bio *bio)
 {
 	struct discard_cmd *dc = (struct discard_cmd *)bio->bi_private;
+	struct discard_cmd_control *dcc = dc->dcc;
 	unsigned long flags;
+	ktime_t submit_time;
+	int nr_discarded;
 
 	spin_lock_irqsave(&dc->lock, flags);
+	submit_time = ktime_sub(ktime_get(), dc->submit_start);
 	if (!dc->error)
 		dc->error = blk_status_to_errno(bio->bi_status);
 	dc->bio_ref--;
@@ -1018,6 +1023,16 @@ static void f2fs_submit_discard_endio(struct bio *bio)
 	}
 	spin_unlock_irqrestore(&dc->lock, flags);
 	bio_put(bio);
+
+	spin_lock_irqsave(&dcc->discard_time_lock, flags);
+	nr_discarded = atomic_read(&dcc->issued_discard);
+	dcc->discard_time_avg = div_u64(ktime_add(nr_discarded * dcc->discard_time_avg,
+										submit_time),
+									nr_discarded + 1);
+	if (dcc->discard_time_avg > dcc->discard_time_peak)
+		dcc->discard_time_peak = dcc->discard_time_avg;
+	atomic_inc(&dcc->issued_discard);
+	spin_unlock_irqrestore(&dcc->discard_time_lock, flags);
 }
 
 static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
@@ -1166,6 +1181,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		 * right away
 		 */
 		spin_lock_irqsave(&dc->lock, flags);
+		dc->submit_start = ktime_get();
 		if (last)
 			dc->state = D_SUBMIT;
 		else
@@ -1185,8 +1201,6 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		bio->bi_opf |= flag;
 		submit_bio(bio);
 
-		atomic_inc(&dcc->issued_discard);
-
 		f2fs_update_iostat(sbi, NULL, FS_DISCARD, len * F2FS_BLKSIZE);
 
 		lstart += len;
@@ -2079,9 +2093,12 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	INIT_LIST_HEAD(&dcc->wait_list);
 	INIT_LIST_HEAD(&dcc->fstrim_list);
 	mutex_init(&dcc->cmd_lock);
+	spin_lock_init(&dcc->discard_time_lock);
 	atomic_set(&dcc->issued_discard, 0);
 	atomic_set(&dcc->queued_discard, 0);
 	atomic_set(&dcc->discard_cmd_cnt, 0);
+	dcc->discard_time_avg = 0;
+	dcc->discard_time_peak = 0;
 	dcc->nr_discards = 0;
 	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
 	dcc->max_discard_request = DEF_MAX_DISCARD_REQUEST;
-- 
2.25.1

