Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF53361652D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiKBOag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiKBO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:29:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D18D2B25C;
        Wed,  2 Nov 2022 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667399391; x=1698935391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bRKQ9sSqIIZS0Qkc9JECvRRYfZDd/bzOP/3pGDU3Yus=;
  b=Gfdfsb8NDcvYBcYN8V+hFf12XW4eTyu8OcA+ZfuMySPdhrHxRw3+GoPQ
   C3PDoLu3LOQDHqFw5fbhFFQsrvILDObtgJV67/2zf95EUFE4m3dQXUPgi
   j3AVqMt4Js+T72RogFtZKWkES0JCLcAR/kiBiHiN2BjWiI3bbm9FCEcwc
   QJgDk+SkhanWw06XXTsSLCv0HRhj5gKWCAVgzleCel+ZWlb3Dua3Sj4Je
   VJ0XQsVeHwaJnGxazqIu+JzpRzyM2WwVeSlnRqXIt6527qqgWv15AvgxO
   5/0k/vGMwowa8iFkiBusis4iVG6BTJOcvpZ4KfdlAw9LFaiIWudt0qxLN
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,234,1661788800"; 
   d="scan'208";a="215319620"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 22:29:51 +0800
IronPort-SDR: bhfH8S2Qs1Tzmcc2DqEUoLgXBC76m0geG80oiwbXYu8eBaepwWwNJnJ9eZr1wQaZ9G5zJ38bsC
 HG0yJO/IYNxybS+opsEm6N0n4dQv9ICcXUOMrVNWGCG+WkgdazUc6xvulJQqRBZMlupKZbTkgE
 s1ojuYsK/s9y7/94NJIWboVjh+/TZ/VClKwtjKCIGSTVTKdg5r1RCb7N3X7fAVLrOozGkzAQ8B
 9eUcnZsrDfC+Hgx00415Ty1firGWPXrDXilWs14YdTb5nMe7oEAUey5PmAEDh0N3YrJ4P/Z6ol
 KNg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 06:43:19 -0700
IronPort-SDR: eta2s5xDpUnGetZKtHb0VGq1XorldfADSVDfCWFwnDq85tr5u8YsNYYF7wxW0gFcH9litXpiNe
 HbJBTGrFFYCOK9b3KYm9ZjTAExlpFrihO3eD8OZ/MQcR+HNHUbQO+UiX5d0Y+Q4LsuKRnxpM1N
 up/OFSRziGIHdWgw38LhqMvbGpm7NIeBwv9+LjUHJb3zo1OuTXEKQArunG7pdUfR+201moo4Cw
 YJ08nPOIli+KOpJlj1eK6aelrEjZaNXCzN7EYtRjQrjwRrWannflOHdDSggNfioULbqbyHKAca
 L6I=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Nov 2022 07:29:49 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v2 2/4] ufs: core: Remove redundant desc_size variable from hba
Date:   Wed,  2 Nov 2022 16:29:11 +0200
Message-Id: <1667399353-10228-3-git-send-email-Arthur.Simchaev@wdc.com>
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

Always read the descriptor with QUERY_DESC_MAX_SIZE.
According to the spec, the device returns the actual size

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufshcd.c | 51 ++++++++++++-----------------------------------
 include/ufs/ufshcd.h      |  1 -
 2 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index de4e7e7..aa46292 100644
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
@@ -4905,7 +4887,7 @@ static void ufshcd_setup_links(struct ufs_hba *hba, struct scsi_device *sdev)
  */
 static void ufshcd_lu_init(struct ufs_hba *hba, struct scsi_device *sdev)
 {
-	int len = hba->desc_size[QUERY_DESC_IDN_UNIT];
+	int len = QUERY_DESC_MAX_SIZE;
 	u8 lun = ufshcd_scsi_to_upiu_lun(sdev->lun);
 	u8 lun_qdepth = hba->nutrs;
 	u8 *desc_buf;
@@ -7446,25 +7428,24 @@ static u32 ufshcd_find_max_sup_active_icc_level(struct ufs_hba *hba,
 static void ufshcd_set_active_icc_lvl(struct ufs_hba *hba)
 {
 	int ret;
-	int buff_len = hba->desc_size[QUERY_DESC_IDN_POWER];
 	u8 *desc_buf;
 	u32 icc_level;
 
-	desc_buf = kmalloc(buff_len, GFP_KERNEL);
+	desc_buf = kmalloc(QUERY_DESC_MAX_SIZE, GFP_KERNEL);
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
@@ -7688,7 +7669,7 @@ static int ufs_get_device_desc(struct ufs_hba *hba)
 	}
 
 	err = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_DEVICE, 0, 0, desc_buf,
-				     hba->desc_size[QUERY_DESC_IDN_DEVICE]);
+				     QUERY_DESC_MAX_SIZE);
 	if (err) {
 		dev_err(hba->dev, "%s: Failed reading Device Desc. err = %d\n",
 			__func__, err);
@@ -7935,18 +7916,16 @@ static void ufshcd_clear_dbg_ufs_stats(struct ufs_hba *hba)
 static int ufshcd_device_geo_params_init(struct ufs_hba *hba)
 {
 	int err;
-	size_t buff_len;
 	u8 *desc_buf;
 
-	buff_len = hba->desc_size[QUERY_DESC_IDN_GEOMETRY];
-	desc_buf = kmalloc(buff_len, GFP_KERNEL);
+	desc_buf = kmalloc(QUERY_DESC_MAX_SIZE, GFP_KERNEL);
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
@@ -7958,7 +7937,7 @@ static int ufshcd_device_geo_params_init(struct ufs_hba *hba)
 	else if (desc_buf[GEOMETRY_DESC_PARAM_MAX_NUM_LUN] == 0)
 		hba->dev_info.max_lu_supported = 8;
 
-	if (hba->desc_size[QUERY_DESC_IDN_GEOMETRY] >=
+	if (desc_buf[QUERY_DESC_LENGTH_OFFSET] >=
 		GEOMETRY_DESC_PARAM_HPB_MAX_ACTIVE_REGS)
 		ufshpb_get_geo_info(hba, desc_buf);
 
@@ -8043,11 +8022,7 @@ static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
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
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 96538eb..c3a0875 100644
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

