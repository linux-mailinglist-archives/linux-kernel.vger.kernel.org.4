Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D0961652F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiKBOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiKBOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:30:00 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B1C2A957;
        Wed,  2 Nov 2022 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667399397; x=1698935397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+e9nf+rVBfAa2c/WjCtcUpaxL45lHT++qX95yYgmOY0=;
  b=fiP3aczDV9w8fFtZY8u7vn+53F5siv8PNFPz5q7aL2GMri+QvU/NYEzH
   GaUmW7aqkF6xxNTNnBxakOL/6lrvWFvBn9qkTtNF5PzgPXP8RF5dQ0Qq4
   7O/9AlNWSVlLvVVVpzE0R4WgE8Hxf3N26DQPoHW2TVhpkirfnRNeoBlUy
   +ttp681W9ob0/EgYyfwTVmZhUmSVQnkbRVrOlMX+KjA25f+lrmMNq9Hoz
   JlnWjN4W0fV+qwYrdExNbrqerXEkeyZIJFc6TqXNg1FZRYHl82Ix0i8C2
   6aECOA11vsoEkW1pAcbNpEF8UD3fpwtW5iLM8TJS/e+OKezzYga6mQ92V
   A==;
X-IronPort-AV: E=Sophos;i="5.95,234,1661788800"; 
   d="scan'208";a="215319626"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 22:29:56 +0800
IronPort-SDR: jy8v/t3MXDOGg9MJ6zv4cbg0LLYUzUpv0PkQY6bBj3ITggQaWnzFLwjP524UTo2SN0ss9KaktK
 BtakqFAbbpmtt0F3FDdbvEp5ExsE5HxsUpIPu8BTHBBedo+T8GcTDwC6oKbbK+LFTZxzMf2OXY
 SpuUrPx97qZhzKn9J6ACRCSWO2xAbLqdzhsGes2VmourV05wW27qRVl7Z5Y4ZMagRHB3p8b841
 muOsiS4CDkhgzEqYPKTMvQiZslr+T+kQE0xwQcR0LOq4pXkeRftgTsTxLIWcWBpZKJmClEuza9
 Otg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 06:43:25 -0700
IronPort-SDR: 1V0GFg2in1LN3SSCzO/ZbxAw+GnY3EUZAZmcKPLCA7VSdDBM/8qoB8edxiWxTyfBkahvLSGyYf
 4l248NI16rIze2SoCbVmiDO8/3kNuo36ZyKN908o36mPgPI2YUjuxLk8WXDz2avYHRn/DV8Wxl
 llbx3c4pk7k9zNDDVXlgDOy1NuA5BiISB1l+B1ysyJut2Sb+thl/eefMSZAJlBILsVBPMcI2wj
 VKlghsFmjrW7Ob7T/eQnlgS5Nc1BvR1EBtydqsS7iSjIHqCpIdTnHxMzt84A7DBve7ShQusHfQ
 zkE=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Nov 2022 07:29:55 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v2 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length function
Date:   Wed,  2 Nov 2022 16:29:13 +0200
Message-Id: <1667399353-10228-5-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667399353-10228-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1667399353-10228-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
index 9cc3abd..fc0695f 100644
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

