Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C57639A5A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 13:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiK0MIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 07:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiK0MIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 07:08:42 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE42F58D;
        Sun, 27 Nov 2022 04:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669550921; x=1701086921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SUE566R94CnqYxmANcyAUdfEbOCvEF2a7+p3jOhVJKs=;
  b=b0CVcw1KF3O9Ci9n8C04GM9ysIrHGsD9TdHLNQVSS/nU2V6apyrT0g9Z
   +rcwNqMwQU2JsWNuq0PUPieUkQKkugmQWFnd1SUlMY6AHmqW/zq2AkjL7
   o6/dNmoeKh8HZ8aYG5rNXrxxd98dy/6lzW99q0AHQnbl+lC34yvqSjNxi
   ywZcLyr2Rm7R5RIcafZOGL48ZGxFfHZEt6fIUsLN9kKETsCsboo2AecJy
   FB1wxUBnLNZC5RMB/c1gGwnK5V9iSc6c/Kywdtr0ZergqR4ilz078Myd9
   1h53S4DdmhbN81BbnnsteLHgd5vPkGDXeQGP7WNB1WZUqtrYOsqvQjfnb
   A==;
X-IronPort-AV: E=Sophos;i="5.96,198,1665417600"; 
   d="scan'208";a="215510881"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2022 20:08:41 +0800
IronPort-SDR: VzdkvOlbXOC1XsfpcLqtrrdJ6/6qPlZUm/EfHw5LKzWPwpipkgLk92/j4w8DLD8Hub/7tIvYoV
 YuBvlOP4S7bJ6eE+pAGez2B7GqyAceSWp6GhVlf95iJCl8cNGuk8JDk0sYHheJns7NQmbgAjyP
 HPtNZi4HTlpA/uEOPrkjyY3BOa/OneQxAQ7aSgdEarmMYmTNY/GdoIHUawEnsKipm1bem9JQ0+
 blQ7rZ8IYMLq7jiHEcYYa37tNSc4lsu3U0ADyj+m1zcuIwmWC89wgasDWEvgMsJVFqwVWEVkpq
 A0k=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2022 03:27:24 -0800
IronPort-SDR: spoPjWjffvUZwCkJjwwqZVcZC8C9hZNxLmk1Iq4k7uO2smqRC5br/lYolW9kZiqnb2+GLMMQJt
 dJCqQuZDJx8TbtN1NHLbtzjlDkdZEWyNICjwJViuwUUlYHNjsOS60XnBT8hKs6wYy/W0aRmDJy
 88SfXLPrVTPiw3JQ5i9V+wDNYk/u1tqAeWYEfO7+kBmIeMRFatRmQrzWFxAqlgWgX9a58Y+Lf8
 Diad3+j9kDuDsI2J3/jllODN9V+IIqPydNNAfcNTmbNpj7kF6xJug0wPSuaZGj/L6qdPfc3a8D
 Z4s=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Nov 2022 04:08:39 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v4 2/4] ufs: core: Remove redundant desc_size variable from hba
Date:   Sun, 27 Nov 2022 14:08:28 +0200
Message-Id: <1669550910-9672-3-git-send-email-Arthur.Simchaev@wdc.com>
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

Always read the descriptor with QUERY_DESC_MAX_SIZE.
According to the spec, the device returns the actual size

Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 53 +++++++++++++----------------------------------
 include/ufs/ufs.h         |  1 -
 include/ufs/ufshcd.h      |  1 -
 3 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 2e47c69..70e96b6 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3377,28 +3377,11 @@ int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
 void ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_id,
 				  int *desc_len)
 {
-	if (desc_id >= QUERY_DESC_IDN_MAX || desc_id == QUERY_DESC_IDN_RFU_0 ||
-	    desc_id == QUERY_DESC_IDN_RFU_1)
-		*desc_len = 0;
-	else
-		*desc_len = hba->desc_size[desc_id];
+	/*Always returns QUERY_DESC_MAX_SIZE*/
+	*desc_len = QUERY_DESC_MAX_SIZE;
 }
 EXPORT_SYMBOL(ufshcd_map_desc_id_to_length);
 
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
 /**
  * ufshcd_read_desc_param - read the specified descriptor parameter
  * @hba: Pointer to adapter instance
@@ -3470,7 +3453,6 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 
 	/* Update descriptor length */
 	buff_len = desc_buf[QUERY_DESC_LENGTH_OFFSET];
-	ufshcd_update_desc_length(hba, desc_id, desc_index, buff_len);
 
 	if (is_kmalloc) {
 		/* Make sure we don't copy more data than available */
@@ -4909,7 +4891,7 @@ static void ufshcd_setup_links(struct ufs_hba *hba, struct scsi_device *sdev)
  */
 static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device *sdev)
 {
-	int len = hba->desc_size[QUERY_DESC_IDN_UNIT];
+	int len = QUERY_DESC_MAX_SIZE;
 	u8 lun = ufshcd_scsi_to_upiu_lun(sdev->lun);
 	u8 lun_qdepth = hba->nutrs;
 	u8 *desc_buf;
@@ -7480,25 +7462,24 @@ static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
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
@@ -7715,14 +7696,14 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
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
@@ -7969,18 +7950,16 @@ static void ufshcd_clear_dbg_ufs_stats(struct ufs_hba *hba)
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
@@ -7992,7 +7971,7 @@ static int ufshcd_device_geo_params_init(struct ufs_hba *hba)
 	else if (desc_buf[GEOMETRY_DESC_PARAM_MAX_NUM_LUN] == 0)
 		hba->dev_info.max_lu_supported = 8;
 
-	if (hba->desc_size[QUERY_DESC_IDN_GEOMETRY] >=
+	if (desc_buf[QUERY_DESC_LENGTH_OFFSET] >=
 		GEOMETRY_DESC_PARAM_HPB_MAX_ACTIVE_REGS)
 		ufshpb_get_geo_info(hba, desc_buf);
 
@@ -8077,11 +8056,7 @@ static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
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
index 5cf81df..7df2ce1 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -952,7 +952,6 @@ struct ufs_hba {
 	bool is_urgent_bkops_lvl_checked;
 
 	struct rw_semaphore clk_scaling_lock;
-	unsigned char desc_size[QUERY_DESC_IDN_MAX];
 	atomic_t scsi_block_reqs_cnt;
 
 	struct device		bsg_dev;
-- 
2.7.4

