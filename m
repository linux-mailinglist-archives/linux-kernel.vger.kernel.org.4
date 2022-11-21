Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B06632894
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiKUPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiKUPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:46:55 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873D2205FB;
        Mon, 21 Nov 2022 07:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669045607; x=1700581607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yiM1yufWrsKiq6yVdSoRwS2PWUHBeXAhZCRxYu1y7wA=;
  b=EDW3utCpPTPUDtIIPiQ14UiZl24QtAaia0I5/ZZSXuE4JMqnY7w6xcJ8
   bRbbt731ykgDb4/YwIu8uxdIS1w3QUX3wCR6v98Xtg5JoLtTf/MkgBlZa
   mcbndmgpaO1ycvfjTc9eosYedFRRbV3o3YlgUWuzuvM5989+tmx50On8y
   B4hY1/gbvT6EeBK9qBA44K7GPNpb3rLg842OlTSrwe0ZSrdr7IKXgYioZ
   tpANZIbLglJVWTrnlwKpkfTFgsSW61i7Gqh8nrvIXMcH6ff44y7JY1Klt
   e1O/1je8Z4ZE5S49RLkAsi59BxGADAfbXdQSdRqds92hwzMcPr/FhR/ct
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665417600"; 
   d="scan'208";a="215054347"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 23:46:46 +0800
IronPort-SDR: saCNomazBVeDa3zmKjjQMNvR+9ZP0zxXzqaizBKVbYKgnotegrA659KJg2EYFV5vH5rfxQ04MV
 nghG2Ste+X4t8wjnDfey/l7tw8klUrKI+KHW12/8MaGfkPfpKi0XlqsIB38VHwlSWhAYp5ObZB
 l/X5UxdmpE62xmdoo7Q907x6kG2jDBkG6ZBDKjSxSDedO5QYNzs7FdE2iueehwqQkLwoJ8Htfn
 7MbiQqhb3O/KUf8nw5mGozGRETsaw93dKYiI0KpNXWVs9TOMQVzI8ONPZU+vTJCdlI3kFyR7Hu
 53A=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 06:59:52 -0800
IronPort-SDR: 0lXtwMYxoomeZSavH7aVr8AfbBP5QZhE4fBtoisYkkuGuqfw/Q8ZR0TEONY6cKlWYpzCHHzaet
 vSDu8vDMciUNee4G1bfN67fVkd4UjA09zOhlacex/3mOSOzHeLfXBPYbug1U9+7TwdvIpX9KpF
 x7iczukX1x2U74tqoV0kP6pYGu7EasHpko/vNTrtW4UbYkA6hp3v8UAgvY4K0O2ssUFQc8ZQwP
 i5qqN0d4CHuJmMHpnoqkt1o1Ng+KjaYdSQfBTRaFTTTe7KtvAPsnz48tzJK37ig8vtj1tP2bh/
 YLo=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Nov 2022 07:46:45 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v3 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length function
Date:   Mon, 21 Nov 2022 17:46:30 +0200
Message-Id: <1669045590-26101-5-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669045590-26101-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1669045590-26101-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There shouldn't be any restriction of the descriptor size
(not the descriptor id for that matter) up to QUERY_DESC_MAX_SIZE.
According to the spec, the caller can use any descriptor size,
and it is up to the device to return the actual size.
Therefore there shouldn't be any sizes hardcoded in the kernel,
nor any need to cache it, hence ufshcd_map_desc_id_to_length function is redundant.
always read the descriptors with QUERY_DESC_MAX_SIZE size.

Suggested-by: Bean Huo <beanhuo@micron.com>

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufs_bsg.c     |  7 +------
 drivers/ufs/core/ufshcd-priv.h |  3 ---
 drivers/ufs/core/ufshcd.c      | 46 +++++++++++-------------------------------
 drivers/ufs/core/ufshpb.c      |  4 +---
 4 files changed, 14 insertions(+), 46 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index b99e3f3..dc441ac 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -16,16 +16,11 @@ static int ufs_bsg_get_query_desc_size(struct ufs_hba *hba, int *desc_len,
 				       struct utp_upiu_query *qr)
 {
 	int desc_size = be16_to_cpu(qr->length);
-	int desc_id = qr->idn;
 
 	if (desc_size <= 0)
 		return -EINVAL;
 
-	ufshcd_map_desc_id_to_length(hba, desc_id, desc_len);
-	if (!*desc_len)
-		return -EINVAL;
-
-	*desc_len = min_t(int, *desc_len, desc_size);
+	*desc_len = min_t(int, QUERY_DESC_MAX_SIZE, desc_size);
 
 	return 0;
 }
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index a9e8e1f..c52e2f3 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -70,9 +70,6 @@ int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
 int ufshcd_hold(struct ufs_hba *hba, bool async);
 void ufshcd_release(struct ufs_hba *hba);
 
-void ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
-				  int *desc_length);
-
 int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd);
 
 int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 604348f..7990922 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3369,20 +3369,6 @@ int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
 }
 
 /**
- * ufshcd_map_desc_id_to_length - map descriptor IDN to its length
- * @hba: Pointer to adapter instance
- * @desc_id: descriptor idn value
- * @desc_len: mapped desc length (out)
- */
-void ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
-				  int *desc_len)
-{
-	/*Always returns QUERY_DESC_MAX_SIZE*/
-	*desc_len = QUERY_DESC_MAX_SIZE;
-}
-EXPORT_SYMBOL(ufshcd_map_desc_id_to_length);
-
-/**
  * ufshcd_read_desc_param - read the specified descriptor parameter
  * @hba: Pointer to adapter instance
  * @desc_id: descriptor idn value
@@ -3402,26 +3388,13 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 {
 	int ret;
 	u8 *desc_buf;
-	int buff_len;
+	int buff_len = QUERY_DESC_MAX_SIZE;
 	bool is_kmalloc = true;
 
 	/* Safety check */
 	if (desc_id >= QUERY_DESC_IDN_MAX || !param_size)
 		return -EINVAL;
 
-	/* Get the length of descriptor */
-	ufshcd_map_desc_id_to_length(hba, desc_id, &buff_len);
-	if (!buff_len) {
-		dev_err(hba->dev, "%s: Failed to get desc length\n", __func__);
-		return -EINVAL;
-	}
-
-	if (param_offset >= buff_len) {
-		dev_err(hba->dev, "%s: Invalid offset 0x%x in descriptor IDN 0x%x, length 0x%x\n",
-			__func__, param_offset, desc_id, buff_len);
-		return -EINVAL;
-	}
-
 	/* Check whether we need temp memory */
 	if (param_offset != 0 || param_size < buff_len) {
 		desc_buf = kzalloc(buff_len, GFP_KERNEL);
@@ -3434,15 +3407,23 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 
 	/* Request for full descriptor */
 	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
-					desc_id, desc_index, 0,
-					desc_buf, &buff_len);
-
+					    desc_id, desc_index, 0,
+					    desc_buf, &buff_len);
 	if (ret) {
 		dev_err(hba->dev, "%s: Failed reading descriptor. desc_id %d, desc_index %d, param_offset %d, ret %d\n",
 			__func__, desc_id, desc_index, param_offset, ret);
 		goto out;
 	}
 
+	/* Update descriptor length */
+	buff_len = desc_buf[QUERY_DESC_LENGTH_OFFSET];
+
+	if (param_offset >= buff_len) {
+		dev_err(hba->dev, "%s: Invalid offset 0x%x in descriptor IDN 0x%x, length 0x%x\n",
+			__func__, param_offset, desc_id, buff_len);
+		return -EINVAL;
+	}
+
 	/* Sanity check */
 	if (desc_buf[QUERY_DESC_DESC_TYPE_OFFSET] != desc_id) {
 		dev_err(hba->dev, "%s: invalid desc_id %d in descriptor header\n",
@@ -3451,9 +3432,6 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 		goto out;
 	}
 
-	/* Update descriptor length */
-	buff_len = desc_buf[QUERY_DESC_LENGTH_OFFSET];
-
 	if (is_kmalloc) {
 		/* Make sure we don't copy more data than available */
 		if (param_offset >= buff_len)
diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index 3d69a81c..11f8aa6 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -2382,12 +2382,10 @@ static int ufshpb_get_lu_info(struct ufs_hba *hba, int lun,
 {
 	u16 max_active_rgns;
 	u8 lu_enable;
-	int size;
+	int size = QUERY_DESC_MAX_SIZE;
 	int ret;
 	char desc_buf[QUERY_DESC_MAX_SIZE];
 
-	ufshcd_map_desc_id_to_length(hba, QUERY_DESC_IDN_UNIT, &size);
-
 	ufshcd_rpm_get_sync(hba);
 	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
 					    QUERY_DESC_IDN_UNIT, lun, 0,
-- 
2.7.4

