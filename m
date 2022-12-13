Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862B564B274
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiLMJfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiLMJfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:35:44 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BA26278
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXE1evBZAVXI2mFEmRJu4lS9i/Q7d8MlresVmbYODj6l+FPJ9+uBP7sugZacu59AgWg1k9GKDF4V5bqiGWBEr72h5Y3o8m1zStUta+C1FkhM8HjtQNZlwnH1jsUkrWF/r1uc2BT2H/afbuRy72pv3jxSfA8UKuGgjcXZ/FW1S8HtR2F/x0WEWZWUKgeYqGdXG6mEZ3ZbILK0iqUesFdTGFB5Gs5pfPR/l1sNRrl9ge4xPyh349ts7BPt5gvKmdHhoZTpgOejHkpR4AN6yH+CIKnksYU8p9QqEW0hHD2BEjTyLVwniantceLG5tpE9d3COSeN68iTUeK03yiP/mrakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDcMXWr2haAQo2uOJ1NCfpbPG0JfhsxwumzD6mtAocA=;
 b=GPSMNz2t8SiC33rVEfpkzhzlFzxYoWAukwdp3ZeIC/olLwb0yl4+AIjkIHYNKHKpqJc3xEjFypC+D3YnFEthTnGFP1a0jn2Kf63X153JiaqWW0VW439/mBMW0cfJQMyPaWkict2xtcQXgwcIJP8mNGgBqSS3trb/KPW0yaahYC7RTdAHTWNam269aAIYDsKfwejDBYq9JG+/llR3eawPBBmnilw/5QKB+3EaMiEiQXJQjVZGmC21Ju5wxi59TWN2XmOJZjUwxXUuPVRxgR/nhpFewzLlUVD8npsoa/t34aZwEeiuE2HR6SuSRdBJOdMS+0pVRHoExbWKSGFtn0yNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 63.140.6.66) smtp.rcpttodomain=kernel.org smtp.mailfrom=zeekrlife.com;
 dmarc=none action=none header.from=zeekrlife.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geely.onmicrosoft.com;
 s=selector2-geely-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDcMXWr2haAQo2uOJ1NCfpbPG0JfhsxwumzD6mtAocA=;
 b=kqu2Mq85QcvJtsSofTXTe16375Cti5MWuDGrRmpk0o+X1DMj1XWSOT++uLDpP7rgP2mzVyKUHm7bFiIdG71kJbSPKoV3xSewBRcDTk2c41O2n13bK6/BAO3uuJt/IbvEY+MgsA4F0JqqwmBJui0R4iPQvX7ZqJvDGkLm/xOJr5k=
Received: from SL2PR03CA0015.apcprd03.prod.outlook.com (2603:1096:100:55::27)
 by SG2PR02MB4442.apcprd02.prod.outlook.com (2603:1096:0:7::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.11; Tue, 13 Dec 2022 09:35:40 +0000
Received: from PSAAPC01FT012.eop-APC01.prod.protection.outlook.com
 (2603:1096:100:55:cafe::f9) by SL2PR03CA0015.outlook.office365.com
 (2603:1096:100:55::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.10 via Frontend
 Transport; Tue, 13 Dec 2022 09:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 63.140.6.66)
 smtp.mailfrom=zeekrlife.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zeekrlife.com;
Received-SPF: Fail (protection.outlook.com: domain of zeekrlife.com does not
 designate 63.140.6.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.140.6.66; helo=CN-BJI-EXP64.Geely.Auto;
Received: from CN-BJI-EXP64.Geely.Auto (63.140.6.66) by
 PSAAPC01FT012.mail.protection.outlook.com (10.13.38.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.10 via Frontend Transport; Tue, 13 Dec 2022 09:35:39 +0000
Received: from Zbook.localdomain (10.186.29.23) by CN-BJI-EXP64.Geely.Auto
 (10.186.65.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 13 Dec
 2022 17:35:13 +0800
From:   Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        Yuwei Guan <Yuwei.Guan@zeekrlife.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3] f2fs: deliver the accumulated 'issued' to __issue_discard_cmd_orderly() to meet the max_requests limit
Date:   Tue, 13 Dec 2022 17:34:19 +0800
Message-ID: <20221213093419.134-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.186.29.23]
X-ClientProxiedBy: CN-BJI-EXP36.Geely.Auto (10.186.65.33) To
 CN-BJI-EXP64.Geely.Auto (10.186.65.77)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAAPC01FT012:EE_|SG2PR02MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: 271c7a11-56e9-4e2e-3a60-08dadced6555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOxsEV0MgPVswOlKUkQ59NuS9DL7Z2LMbBBAiN2Fjj5x0prYLjMyPGWTD7DspeW+ctZAh298vnY3v1pLIVXPBfeZO0t1Psivlsz/K8sXIY+1wgsWkrfMP4OXOy0XbcEak+mkEzzlahRiPzjYLcGrhaIFTFNimOkixQDnyCiZERAv11nJ5xJSJD7N4cIRvwaYdoqPOIq/vuaIhHjmuu2HnF+pPhyxmjIyGNW227E+TZGtYBPFqZU8qFG3mE1flOAyuj3elUloz3Lh/nleAv/u+l22xSfibj3jGb6NJCb4JJXeFTA64CTDOycntqlj9qlZTiTM5Mokh17UHIyVzndqcDCDTQYPCmhci7QgcXvlJlWFpcFARy5GVJ+MbaR6kIw0oekiZQHa86vZ1D09fzwYvrp8wkxMyvg/oaLBUppx0eByiiNtEkZUlg3obxrK7E6LiYhTIVnFZ8AJjfalE9IZZlQKcR1u5C7tRfT3Twjx8BI3kojpqjaC8O2a0L3hlJrOvpFmEiDnwL6Tfrt89GcV2/gs++4SVgBgnGW2aGa9HYiVVtjI0m85wOtcPGt/zNi+dJLKtMN+dxjKmRX9COIIL9LxQfTGbCj+2LBm1zTldNAO/QkIvqmQ5xIPpGTXRPtYmp+5lVwIJkpwxhP2hjPqtJhYNcbq5ZlweVJvWH3sgpH9/dTikhvHeLjATHoKZzB3+OOL4BhAOXBAar/9FzZ3z1H8yXnOkCDQr5NLPUU/+X0=
X-Forefront-Antispam-Report: CIP:63.140.6.66;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:CN-BJI-EXP64.Geely.Auto;PTR:ErrorRetry;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(54906003)(36906005)(316002)(478600001)(40460700003)(110136005)(2906002)(336012)(41300700001)(16526019)(4326008)(2616005)(70586007)(8676002)(70206006)(47076005)(83380400001)(8936002)(5660300002)(1076003)(36860700001)(82310400005)(186003)(26005)(36756003)(86362001)(40480700001)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: Zeekrlife.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 09:35:39.0384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 271c7a11-56e9-4e2e-3a60-08dadced6555
X-MS-Exchange-CrossTenant-Id: 6af81d03-dafe-4d76-a257-3cc43cb0454f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6af81d03-dafe-4d76-a257-3cc43cb0454f;Ip=[63.140.6.66];Helo=[CN-BJI-EXP64.Geely.Auto]
X-MS-Exchange-CrossTenant-AuthSource: PSAAPC01FT012.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4442
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any of the following scenarios will send more than the number of
max_requests at a time, which will not meet the design of the
max_requests limit.

- Set max_ordered_discard larger than discard_granularity from userspace.
- It is a small size device, discard_granularity can be tuned to 1 in
  f2fs_tuning_parameters().

We need to deliver the accumulated @issued to __issue_discard_cmd_orderly()
to meet the max_requests limit.

BTW, convert the parameter type of @issued in __submit_discard_cmd().

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/f2fs/segment.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a9099a754dd2..5268938466f5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1097,8 +1097,7 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 /* this function is copied from blkdev_issue_discard from block/blk-lib.c */
 static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 						struct discard_policy *dpolicy,
-						struct discard_cmd *dc,
-						unsigned int *issued)
+						struct discard_cmd *dc, int *issued)
 {
 	struct block_device *bdev = dc->bdev;
 	unsigned int max_discard_blocks =
@@ -1379,8 +1378,8 @@ static void __queue_discard_cmd(struct f2fs_sb_info *sbi,
 	mutex_unlock(&SM_I(sbi)->dcc_info->cmd_lock);
 }
 
-static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
-					struct discard_policy *dpolicy)
+static void __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
+					struct discard_policy *dpolicy, int *issued)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
@@ -1388,7 +1387,6 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 	struct discard_cmd *dc;
 	struct blk_plug plug;
 	unsigned int pos = dcc->next_pos;
-	unsigned int issued = 0;
 	bool io_interrupted = false;
 
 	mutex_lock(&dcc->cmd_lock);
@@ -1415,9 +1413,9 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 		}
 
 		dcc->next_pos = dc->lstart + dc->len;
-		err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
+		err = __submit_discard_cmd(sbi, dpolicy, dc, issued);
 
-		if (issued >= dpolicy->max_requests)
+		if (*issued >= dpolicy->max_requests)
 			break;
 next:
 		node = rb_next(&dc->rb_node);
@@ -1433,10 +1431,8 @@ static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 
 	mutex_unlock(&dcc->cmd_lock);
 
-	if (!issued && io_interrupted)
-		issued = -1;
-
-	return issued;
+	if (!(*issued) && io_interrupted)
+		*issued = -1;
 }
 static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 					struct discard_policy *dpolicy);
@@ -1464,8 +1460,10 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		if (i + 1 < dpolicy->granularity)
 			break;
 
-		if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered)
-			return __issue_discard_cmd_orderly(sbi, dpolicy);
+		if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered) {
+			__issue_discard_cmd_orderly(sbi, dpolicy, &issued);
+			return issued;
+		}
 
 		pend_list = &dcc->pend_list[i];
 
-- 
2.34.1

