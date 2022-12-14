Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A91C64C659
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbiLNJvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbiLNJum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:50:42 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E4B2126F;
        Wed, 14 Dec 2022 01:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671011437; x=1702547437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7wNAUKTbab7nY2a/QfI1pno+BWWg0xkJ8TQ/0e/c6xE=;
  b=oWXk1zMuFXhhKJbNDZOsrwrKHNTpEBpLyJ0Bi7I9xWDapUWJ5E4rHLvw
   wi/iZscKn/Qq4WoNQG+MZz5Wve52PluK4b/dq96NmzD31BPaLD5G7tZdo
   BldCEtkkm5bbkH4yUhbArjw34oTzJJ3Q1EJyoy5+r7ckoQ21mLVJCWC09
   F2nCoL6e46Krv5D74mI+5UafStr7sjs6sh6F7ivOOYvQ3p5ybABbHj0PJ
   RDfxVZxqNVZWSL3Jh5a+1Vz7jqwtHPHKszqDi25wWvDFm19lJXxFZmoel
   mKPr4pQxDtdjZ2TtcjXjsuMm6hW4LrS5AlgsEXnhJuF4nwasgG8q2ylpf
   w==;
X-IronPort-AV: E=Sophos;i="5.96,244,1665417600"; 
   d="scan'208";a="218870763"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2022 17:50:37 +0800
IronPort-SDR: mXxAlXaZM7WsS82MnMn7SIyZhHU2BYWmz3xt8VSyeMY5SLWhSVID9WxbfE6TRgiuhuuNzknT3F
 37+NI08zEr3YqLs7RXv8CiGC5fNQj3JXS/6rnPVnTQdSG56z5RN2qKfurRgb0q17IfaCJVKnzf
 TJvJs84Zd2HpL7s/SAsZ+0ST0XkAe2VV13C8uyLYj75+RDAjsquvj6tRZ7Onkf1k5TTFpKTHHZ
 a8DF1N1BUs5yZz2GnpG0V2StKri1ylVilXzRUiFWaLaON1gnc+Ur1mcsBzhjewgp0E4NIgSkkn
 vmk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Dec 2022 01:08:59 -0800
IronPort-SDR: KKLnNQCLZcD/btFME3T/nPs3fTtRqdUd6r9T6XOFu3Td75cQh13+p7zN4kRwxmJyOimg4S7hqM
 utnTJed08JNXBVxmrdaMoXIHIHjW03Pzi2X1s+8yUUjInpc5NZEcgiaLuZlKqPb5pfxeVwAWIE
 SdVGgwXe1Sr1IWSfVISRLNJsyGHPh1zrN/5xYdcxw9QDOrJeyK8/U2NXT18f3/69PBLUNaFRcF
 KseTPKRHlih5wPO9WvU9l/kDeqfxffZeu/vUEDhaq/g+o1CqcZziAnpx3ndNQAtRsg8N0AI+UU
 7UE=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2022 01:50:36 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v6 2/4] ufs: core: Remove redundant desc_size variable from hba
Date:   Wed, 14 Dec 2022 11:50:25 +0200
Message-Id: <1671011427-26184-3-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671011427-26184-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1671011427-26184-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always read the descriptor with QUERY_DESC_MAX_SIZE.
According to the spec, the device returns the actual size

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufs_bsg.c     |  6 +---
 drivers/ufs/core/ufshcd-priv.h |  3 --
 drivers/ufs/core/ufshcd.c      | 72 ++++++++----------------------------------
 drivers/ufs/core/ufshpb.c      |  4 +--
 include/ufs/ufs.h              |  1 -
 include/ufs/ufshcd.h           |  4 ---
 6 files changed, 15 insertions(+), 75 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index b99e3f3..7eec38c 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -21,11 +21,7 @@ static int ufs_bsg_get_query_desc_size(struct ufs_hba *hba, int *desc_len,
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
index c43dc2e..97eb5a6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3369,37 +3369,6 @@ int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
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
-	if (desc_id >= QUERY_DESC_IDN_MAX || desc_id == QUERY_DESC_IDN_RFU_0 ||
-	    desc_id == QUERY_DESC_IDN_RFU_1)
-		*desc_len = 0;
-	else
-		*desc_len = hba->desc_size[desc_id];
-}
-EXPORT_SYMBOL(ufshcd_map_desc_id_to_length);
-
-static void ufshcd_update_desc_length(struct ufs_hba *hba,
-				      enum desc_idn desc_id, int desc_index,
-				      unsigned char desc_len)
-{
-	if (hba->desc_size[desc_id] == QUERY_DESC_MAX_SIZE &&
-	    desc_id != QUERY_DESC_IDN_STRING && desc_index != UFS_RPMB_UNIT)
-		/* For UFS 3.1, the normal unit descriptor is 10 bytes larger
-		 * than the RPMB unit, however, both descriptors share the same
-		 * desc_idn, to cover both unit descriptors with one length, we
-		 * choose the normal unit descriptor length by desc_index.
-		 */
-		hba->desc_size[desc_id] = desc_len;
-}
-
-/**
  * ufshcd_read_desc_param - read the specified descriptor parameter
  * @hba: Pointer to adapter instance
  * @desc_id: descriptor idn value
@@ -3419,20 +3388,13 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
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
 	if (param_offset >= buff_len) {
 		dev_err(hba->dev, "%s: Invalid offset 0x%x in descriptor IDN 0x%x, length 0x%x\n",
 			__func__, param_offset, desc_id, buff_len);
@@ -3470,7 +3432,6 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 
 	/* Update descriptor length */
 	buff_len = desc_buf[QUERY_DESC_LENGTH_OFFSET];
-	ufshcd_update_desc_length(hba, desc_id, desc_index, buff_len);
 
 	if (is_kmalloc) {
 		/* Make sure we don't copy more data than available */
@@ -4909,7 +4870,7 @@ static void ufshcd_setup_links(struct ufs_hba *hba, struct scsi_device *sdev)
  */
 static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device *sdev)
 {
-	int len = hba->desc_size[QUERY_DESC_IDN_UNIT];
+	int len = QUERY_DESC_MAX_SIZE;
 	u8 lun = ufshcd_scsi_to_upiu_lun(sdev->lun);
 	u8 lun_qdepth = hba->nutrs;
 	u8 *desc_buf;
@@ -7488,25 +7449,24 @@ static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
 static void ufshcd_set_active_icc_lvl(struct ufs_hba *hba)
 {
 	int ret;
-	int buff_len = hba->desc_size[QUERY_DESC_IDN_POWER];
 	u8 *desc_buf;
 	u32 icc_level;
 
-	desc_buf = kmalloc(buff_len, GFP_KERNEL);
+	desc_buf = kzalloc(QUERY_DESC_MAX_SIZE, GFP_KERNEL);
 	if (!desc_buf)
 		return;
 
 	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_POWER, 0, 0,
-				     desc_buf, buff_len);
+				     desc_buf, QUERY_DESC_MAX_SIZE);
 	if (ret) {
 		dev_err(hba->dev,
-			"%s: Failed reading power descriptor.len = %d ret = %d",
-			__func__, buff_len, ret);
+			"%s: Failed reading power descriptor ret = %d",
+			__func__, ret);
 		goto out;
 	}
 
 	icc_level = ufshcd_find_max_sup_active_icc_level(hba, desc_buf,
-							 buff_len);
+							 QUERY_DESC_MAX_SIZE);
 	dev_dbg(hba->dev, "%s: setting icc_level 0x%x", __func__, icc_level);
 
 	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
@@ -7723,14 +7683,14 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 	u8 *desc_buf;
 	struct ufs_dev_info *dev_info = &hba->dev_info;
 
-	desc_buf = kmalloc(QUERY_DESC_MAX_SIZE, GFP_KERNEL);
+	desc_buf = kzalloc(QUERY_DESC_MAX_SIZE, GFP_KERNEL);
 	if (!desc_buf) {
 		err = -ENOMEM;
 		goto out;
 	}
 
 	err = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_DEVICE, 0, 0, desc_buf,
-				     hba->desc_size[QUERY_DESC_IDN_DEVICE]);
+				     QUERY_DESC_MAX_SIZE);
 	if (err) {
 		dev_err(hba->dev, "%s: Failed reading Device Desc. err = %d\n",
 			__func__, err);
@@ -7977,18 +7937,16 @@ static void ufshcd_clear_dbg_ufs_stats(struct ufs_hba *hba)
 static int ufshcd_device_geo_params_init(struct ufs_hba *hba)
 {
 	int err;
-	size_t buff_len;
 	u8 *desc_buf;
 
-	buff_len = hba->desc_size[QUERY_DESC_IDN_GEOMETRY];
-	desc_buf = kmalloc(buff_len, GFP_KERNEL);
+	desc_buf = kzalloc(QUERY_DESC_MAX_SIZE, GFP_KERNEL);
 	if (!desc_buf) {
 		err = -ENOMEM;
 		goto out;
 	}
 
 	err = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_GEOMETRY, 0, 0,
-				     desc_buf, buff_len);
+				     desc_buf, QUERY_DESC_MAX_SIZE);
 	if (err) {
 		dev_err(hba->dev, "%s: Failed reading Geometry Desc. err = %d\n",
 				__func__, err);
@@ -8000,7 +7958,7 @@ static int ufshcd_device_geo_params_init(struct ufs_hba *hba)
 	else if (desc_buf[GEOMETRY_DESC_PARAM_MAX_NUM_LUN] == 0)
 		hba->dev_info.max_lu_supported = 8;
 
-	if (hba->desc_size[QUERY_DESC_IDN_GEOMETRY] >=
+	if (desc_buf[QUERY_DESC_LENGTH_OFFSET] >=
 		GEOMETRY_DESC_PARAM_HPB_MAX_ACTIVE_REGS)
 		ufshpb_get_geo_info(hba, desc_buf);
 
@@ -8085,11 +8043,7 @@ static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
 static int ufshcd_device_params_init(struct ufs_hba *hba)
 {
 	bool flag;
-	int ret, i;
-
-	 /* Init device descriptor sizes */
-	for (i = 0; i < QUERY_DESC_IDN_MAX; i++)
-		hba->desc_size[i] = QUERY_DESC_MAX_SIZE;
+	int ret;
 
 	/* Init UFS geometry descriptor related parameters */
 	ret = ufshcd_device_geo_params_init(hba);
diff --git a/drivers/ufs/core/ufshpb.c b/drivers/ufs/core/ufshpb.c
index be3fb24..19c9b5d 100644
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
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 1bba3fe..2fc7107 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -38,7 +38,6 @@
 #define UFS_UPIU_MAX_UNIT_NUM_ID	0x7F
 #define UFS_MAX_LUNS		(SCSI_W_LUN_BASE + UFS_UPIU_MAX_UNIT_NUM_ID)
 #define UFS_UPIU_WLUN_ID	(1 << 7)
-#define UFS_RPMB_UNIT		0xC4
 
 /* WriteBooster buffer is available only for the logical unit from 0 to 7 */
 #define UFS_UPIU_MAX_WB_LUN_ID	8
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 5cf81df..830abab 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -952,7 +952,6 @@ struct ufs_hba {
 	bool is_urgent_bkops_lvl_checked;
 
 	struct rw_semaphore clk_scaling_lock;
-	unsigned char desc_size[QUERY_DESC_IDN_MAX];
 	atomic_t scsi_block_reqs_cnt;
 
 	struct device		bsg_dev;
@@ -1186,9 +1185,6 @@ void ufshcd_release(struct ufs_hba *hba);
 
 void ufshcd_clkgate_delay_set(struct device *dev, unsigned long value);
 
-void ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
-				  int *desc_length);
-
 u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba);
 
 int ufshcd_get_vreg(struct device *dev, struct ufs_vreg *vreg);
-- 
2.7.4

