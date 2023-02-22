Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6BE69F76F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjBVPNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjBVPNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:13:00 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48B376B6;
        Wed, 22 Feb 2023 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677078778; x=1708614778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=qh6V3JCVCTK+n6YBnE1F5Zo0FiUn5Q2cvmxnoYVuJVA=;
  b=DKe7dB9TEC7yyQFsO6xLQQG79KGf0KWZfik1PeDOAuKmJDmYTn+Zwtp+
   ObQjXgbVTW3xZljIuRFX+eiXc5IdAW5S+mStXXLLq2qybV9Uy4tnAjsWE
   zDIxJD1ngsBZ0KLKhfpqjTrzeH/PbZDpINgUAmd+doH9TN03l9dxq+Ia0
   ETyHEz5Iquxg6ld3K3UyVWl6go2Z0zGqS7f/RaANzZOO3uNTtCtpcgdxI
   frtw1/tAN9eS1OryV+JHraLqiNty6SkduT8q9+a76Q5XZZoFtPxg3G6D7
   siOMP67miSsDMwSUCebIhD2BNb/izSxetzyjVftwoxUPrs1E7srK1V1PB
   w==;
X-IronPort-AV: E=Sophos;i="5.97,319,1669046400"; 
   d="scan'208";a="223701430"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2023 23:12:58 +0800
IronPort-SDR: l2ikg5iofzGWrMam9BghSPdIuMDng7Z5opr+sYsLF1okbmgiYENdqFbo4mYRAJ6/OXrpGevaw3
 dOmFJeg8TrXo1P7LGaXUOgwFLnlAaDOwnsijBk+bAEegMm4zO8mLZd4G/IXizPB77260WuRUgp
 t2vRaTHoYG+Ae9Lb0omaJg7aMJLPsGrYMv+vSGfog6dO6ETphQt4BqZnsZ8ZfVbAST5d029uwh
 Lf/4zO6XnqIv3Cm88zenLcq64lJU7PJqWTW6Fzd+E2Kl1j0+DOu/q/IukTW3oZRmdimaWjqJ0X
 zVk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2023 06:24:12 -0800
IronPort-SDR: w5gor1iuxqMw0QZPjoW0A8p/J/EYQnLm1bcni0A4xgBthPMnR87X/qABM/E1X/7ECb24ri2kMM
 zzG6uitHCqdeL1jTTC867ML7YfG5LWUmDg3PT2Jw80eRtvOqQ0zbIdw2qQm5bXD1ihVji2pwnr
 +PRvW3elZNkQ+LJcW967cj7VP/vZQ2quSII/gkIkh3T1Xcas4UZ1NAi2h+9M724aXPvQvuSB7S
 IosiOHd/RE/kZyHL7lWJamIcOdXmc0yrA17X+FNtkAD5jq8MRxoxCLzwgRSvAjR1p7drS2IlhU
 NEE=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2023 07:12:56 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, bvanassche@acm.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH 1/2] include: uapi: scsi: Change utp_upiu_query struct
Date:   Wed, 22 Feb 2023 17:12:49 +0200
Message-Id: <1677078770-30994-2-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1677078770-30994-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1677078770-30994-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In UFS 4.0 the attribute value was extended to 8 bytes. Therefore the
current definition is incorrect. Change the struct fields to osf
(Opcode Specific Field) in order define the struct generally.
Remove redundant reserved field

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufs_bsg.c       |  2 +-
 drivers/ufs/core/ufshcd.c        | 24 ++++++++++++------------
 include/uapi/scsi/scsi_bsg_ufs.h | 17 +++++++++--------
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 0d38e7f..335e0ef 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -16,7 +16,7 @@
 static int ufs_bsg_get_query_desc_size(struct ufs_hba *hba, int *desc_len,
 				       struct utp_upiu_query *qr)
 {
-	int desc_size = be16_to_cpu(qr->length);
+	int desc_size = be16_to_cpu(qr->osf5);
 
 	if (desc_size <= 0)
 		return -EINVAL;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 629442c..b08760d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -80,7 +80,7 @@
 /* Maximum number of error handler retries before giving up */
 #define MAX_ERR_HANDLER_RETRIES 5
 
-/* Expose the flag value from utp_upiu_query.value */
+/* Expose the flag value from utp_upiu_query.osf6 */
 #define MASK_QUERY_UPIU_FLAG_LOC 0xFF
 
 /* Interrupt aggregation default timeout, unit: 40us */
@@ -2280,8 +2280,7 @@ int ufshcd_copy_query_response(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 		/* data segment length */
 		resp_len = be32_to_cpu(lrbp->ucd_rsp_ptr->header.dword_2) &
 						MASK_QUERY_DATA_SEG_LEN;
-		buf_len = be16_to_cpu(
-				hba->dev_cmd.query.request.upiu_req.length);
+		buf_len = be16_to_cpu(hba->dev_cmd.query.request.upiu_req.osf5);
 		if (likely(buf_len >= resp_len)) {
 			memcpy(hba->dev_cmd.query.descriptor, descp, resp_len);
 		} else {
@@ -2681,7 +2680,7 @@ static void ufshcd_prepare_utp_query_req_upiu(struct ufs_hba *hba,
 {
 	struct utp_upiu_req *ucd_req_ptr = lrbp->ucd_req_ptr;
 	struct ufs_query *query = &hba->dev_cmd.query;
-	u16 len = be16_to_cpu(query->request.upiu_req.length);
+	u16 len;
 
 	/* Query request header */
 	ucd_req_ptr->header.dword_0 = UPIU_HEADER_DWORD(
@@ -2691,12 +2690,13 @@ static void ufshcd_prepare_utp_query_req_upiu(struct ufs_hba *hba,
 			0, query->request.query_func, 0, 0);
 
 	/* Data segment length only need for WRITE_DESC */
-	if (query->request.upiu_req.opcode == UPIU_QUERY_OPCODE_WRITE_DESC)
+	if (query->request.upiu_req.opcode == UPIU_QUERY_OPCODE_WRITE_DESC) {
+		len = be16_to_cpu(query->request.upiu_req.osf5);
 		ucd_req_ptr->header.dword_2 =
 			UPIU_HEADER_DWORD(0, 0, (len >> 8), (u8)len);
-	else
+	} else {
 		ucd_req_ptr->header.dword_2 = 0;
-
+	}
 	/* Copy the Query Request buffer as is */
 	memcpy(&ucd_req_ptr->qr, &query->request.upiu_req,
 			QUERY_OSF_SIZE);
@@ -3287,7 +3287,7 @@ int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
 	}
 
 	if (flag_res)
-		*flag_res = (be32_to_cpu(response->upiu_res.value) &
+		*flag_res = (be32_to_cpu(response->upiu_res.osf6) &
 				MASK_QUERY_UPIU_FLAG_LOC) & 0x1;
 
 out_unlock:
@@ -3331,7 +3331,7 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 	switch (opcode) {
 	case UPIU_QUERY_OPCODE_WRITE_ATTR:
 		request->query_func = UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST;
-		request->upiu_req.value = cpu_to_be32(*attr_val);
+		request->upiu_req.osf6 = cpu_to_be32(*attr_val);
 		break;
 	case UPIU_QUERY_OPCODE_READ_ATTR:
 		request->query_func = UPIU_QUERY_FUNC_STANDARD_READ_REQUEST;
@@ -3351,7 +3351,7 @@ int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 		goto out_unlock;
 	}
 
-	*attr_val = be32_to_cpu(response->upiu_res.value);
+	*attr_val = be32_to_cpu(response->upiu_res.osf6);
 
 out_unlock:
 	mutex_unlock(&hba->dev_cmd.lock);
@@ -3424,7 +3424,7 @@ static int __ufshcd_query_descriptor(struct ufs_hba *hba,
 	ufshcd_init_query(hba, &request, &response, opcode, idn, index,
 			selector);
 	hba->dev_cmd.query.descriptor = desc_buf;
-	request->upiu_req.length = cpu_to_be16(*buf_len);
+	request->upiu_req.osf5 = cpu_to_be16(*buf_len);
 
 	switch (opcode) {
 	case UPIU_QUERY_OPCODE_WRITE_DESC:
@@ -3449,7 +3449,7 @@ static int __ufshcd_query_descriptor(struct ufs_hba *hba,
 		goto out_unlock;
 	}
 
-	*buf_len = be16_to_cpu(response->upiu_res.length);
+	*buf_len = be16_to_cpu(response->upiu_res.osf5);
 
 out_unlock:
 	hba->dev_cmd.query.descriptor = NULL;
diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bsg_ufs.h
index 2801b65..cccc07d 100644
--- a/include/uapi/scsi/scsi_bsg_ufs.h
+++ b/include/uapi/scsi/scsi_bsg_ufs.h
@@ -54,20 +54,21 @@ struct utp_upiu_header {
  * @idn: a value that indicates the particular type of data B-1
  * @index: Index to further identify data B-2
  * @selector: Index to further identify data B-3
- * @reserved_osf: spec reserved field B-4,5
- * @length: number of descriptor bytes to read/write B-6,7
- * @value: Attribute value to be written DW-5
- * @reserved: spec reserved DW-6,7
+ * @osf4: spec field B-5
+ * @osf5: spec field B 6,7
+ * @osf6: spec field DW 8,9
+ * @osf7: spec field DW 10,11
  */
 struct utp_upiu_query {
 	__u8 opcode;
 	__u8 idn;
 	__u8 index;
 	__u8 selector;
-	__be16 reserved_osf;
-	__be16 length;
-	__be32 value;
-	__be32 reserved[2];
+	__u8 osf3;
+	__u8 osf4;
+	__be16 osf5;
+	__be32 osf6;
+	__be32 osf7;
 };
 
 /**
-- 
2.7.4

