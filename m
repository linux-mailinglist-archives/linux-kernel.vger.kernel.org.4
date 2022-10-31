Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14BE613B48
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiJaQ0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiJaQ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:26:19 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721312AA4;
        Mon, 31 Oct 2022 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667233568; x=1698769568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Mj7AY5j761Zq4jzbtHts5Ba1UjUflyJ/f0xmcurSyRk=;
  b=jB07cJAj+0isllSKSN/HZg0q/Lj/FnYp4CEZRQB2EvnVjbvUFaOP9N6T
   ZHT9mycIv2bihukDS2E1KC3IfBHHPMFFgpSTaB0BDBtSljiSk1D/5kIEo
   XLLTLpwCt8TqlyarlrigDCVUh9PRZcsImn0xIgVgIA1yfiiu6FuefHdLw
   H66PuGt4jlrca901Sh+/qAOO+9XKSJc+K1drbI3JTqY5XQwGFSU117BXN
   jInZY1WS6sOGAvYbW1ufFcaYaH7ltxZBNiUGKg446H5k9QD0oeeq/czZE
   O9S4/dOL1UATDpH1vAbTIoJ5lNPIjC66QnM/zSlqPjuBDKCjHZQgGQtSA
   w==;
X-IronPort-AV: E=Sophos;i="5.95,228,1661788800"; 
   d="scan'208";a="215498933"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Nov 2022 00:26:08 +0800
IronPort-SDR: I82/3JsYSkDGXDlgnPrj9P0e54VYdxOb0gdgp9VUnXB0nW056dBB9eY2yww0JRKqw/uCpgGR8T
 llRrUhe03xExiPjsyB0IrSJenfmJiupwgI6Io8ruIjK+LmQdbneKpBkeP4vcfqOilPGacHhzgy
 PhyAqpNAQZOOX7VJdToqlhRl8Sc/ZJebPtxrMxIyU0oJJQAvSNLZ7wN8Yq04tjE2zZtI7q1NpL
 Rx4CyoSvEOSnWiBHl+b8j1A+dpqASaq0oxMoRofJxbS9d5/rbW4+6Dww2Kjvi04ns5RtScFFrb
 cI/tnxYO/7QgabQjcNde28Oc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2022 08:39:40 -0700
IronPort-SDR: Bh0mgGwTYC/LBUKJuvZft33sv5tLX6dpjy+vB5WEwpeMilZJd0RWAt7MlogEXdXA3CRt8aBte9
 V6Ps5v+Vu7k/LF5Fo6wXtPg9/7d6WUtfb7VWZGkGE+TW7nTr8lWX0kxt0YDrrb/dasGVnaqyU2
 RDOH+XpD7CE6eS9gruYY//lUuam7VnDcnbNDywQckp6Nezfu100GumokwynL20TkK7cPsj7bdE
 7G6uZqk/5Wign5hjhDCL92hHlwcHNdBI9qYuPBdQY3R1MIxRs9QkkODv7Uenw8qv/5XfC6abFt
 bVw=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Oct 2022 09:26:05 -0700
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     avri.altman@wdc.com, Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length function
Date:   Mon, 31 Oct 2022 18:25:24 +0200
Message-Id: <1667233524-13715-5-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1667233524-13715-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1667233524-13715-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ufshcd_map_desc_id_to_length function is redundant.
According to the spec the host can send any descriptor size, the device
will return the actual size. Therefore always read the descriptors with
QUERY_DESC_MAX_SIZE size

Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufs_bsg.c     |  7 +------
 drivers/ufs/core/ufshcd-priv.h |  3 ---
 drivers/ufs/core/ufshcd.c      | 46 +++++++++++-------------------------------
 drivers/ufs/core/ufshpb.c      |  5 +----
 4 files changed, 14 insertions(+), 47 deletions(-)

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
index 3d69a81c..053fd66 100644
--- a/drivers/ufs/core/ufshpb.c
+++ b/drivers/ufs/core/ufshpb.c
@@ -2382,16 +2382,13 @@ static int ufshpb_get_lu_info(struct ufs_hba *hba, int lun,
 {
 	u16 max_active_rgns;
 	u8 lu_enable;
-	int size;
 	int ret;
 	char desc_buf[QUERY_DESC_MAX_SIZE];
 
-	ufshcd_map_desc_id_to_length(hba, QUERY_DESC_IDN_UNIT, &size);
-
 	ufshcd_rpm_get_sync(hba);
 	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
 					    QUERY_DESC_IDN_UNIT, lun, 0,
-					    desc_buf, &size);
+					    desc_buf, QUERY_DESC_MAX_SIZE);
 	ufshcd_rpm_put_sync(hba);
 
 	if (ret) {
-- 
2.7.4

