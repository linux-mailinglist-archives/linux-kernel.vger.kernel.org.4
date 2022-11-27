Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B28639A5C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiK0MJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiK0MIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:08:49 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40997F59A;
        Sun, 27 Nov 2022 04:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669550926; x=1701086926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=AcrYLNFC69GBpZDau/GkN2EkK6yLdYoD4nEUN+JjbNA=;
  b=Nm6eriDpRVTvCq8Sb726O8TgZLuWYIUM3Nm/lXif/9RLqAzCBl7u6I8g
   qOxQKxxRPYtZG3XoeOiVdGowx2RZEs0BNnsKxkek/HGD+Rj8zt5da6Q0g
   aSFOwr4PgGqKaINKErL0c9fNE3ikfUh3CamH+GZ5Vt1VL60hOvQrAOdJ1
   69tFD4+ZI3IHz3FSvMVg8AT3Bvp72FRRCe/G4c+E5iEW4McyyUpSrDDll
   wWY3CLh3sl8jHH7PhHriOjMZU+wiFoeAOd3vcz8g+nVFkO0Mb9IRy0ddC
   1XJEN463J3/RQkbYQNcj3APMnliobhwTvtLPbWRMKBh5ftwagTbsHusEr
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,198,1665417600"; 
   d="scan'208";a="215510895"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2022 20:08:46 +0800
IronPort-SDR: yCGUKLzBNJPFHAfRn0uD3UjUUUg0gb+SK0ZX9hyMaB0iBpWP9L33isOP9j8quaXcrhvq0LrQ4f
 YC7Kvd1oiS7fYu7oDsghZtRLG8X5+6ueDXKZHkCVwz7Ikh4APF9fIHOe6Wi0CyfbMcwIjDaH8S
 nQwrXJdrGX64gw8JsXkTjAaMOnsBqxTuqwx4Wr+xuvyPtxGmvoPg6QddipCU8OIZzFaNWiLC/M
 sTJ+Qg1cwOH5kidUUr054BDUoTRHFA+8XQdqki0yGuztsZoBnJDBWVHSiBdFSj2uN29Aq9O9Tb
 y9s=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2022 03:27:29 -0800
IronPort-SDR: pRRi84UOocDVSbZEdDbvvWhI+wjFHAm0qbN4fEFSnj0Qd9Gi7hwEkeOMv3HAae01DkQmge1Z+d
 Gq0xHM1r66Tr+pol+z+2K6j9m/LBuU6XKGqDv+sMikkdi7tR+eK2EtSwIq35zOBkWbWh5LOwAD
 Ubu62QcDkuOuYKxlo5T4A1inmeCeFLU/PqGnbtDMtrGGw6U9NypDcHClHQ9a6raAOVoKVORPKm
 hsn4Z3FANqCj/PjG4UYPPg6VE5KUB5y8NEvkVS3tQXUPc+zDg9h01891WD6m0QFVWFCqY9eyc8
 5CY=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Nov 2022 04:08:44 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v4 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length function
Date:   Sun, 27 Nov 2022 14:08:30 +0200
Message-Id: <1669550910-9672-5-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
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

Reviewed-by: Bean Huo <beanhuo@micron.com>
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
index 617c4e0..7f89626 100644
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
-- 
2.7.4

