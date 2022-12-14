Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47264C657
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiLNJv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237999AbiLNJux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:50:53 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CA9DEB4;
        Wed, 14 Dec 2022 01:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671011442; x=1702547442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=69zno3M60qAV367e6Uw903iTsxOyrn8t8oVcNIbb1Mc=;
  b=AnFzmL8RPY+52E46cpliy4k9zX52mgvr8EWZT6bgtfZ7/j3yHKssvmoS
   5cFqMwdf16k8z3nWDNOT67IPs89YsEmoJcHUWGT7BPPMQeKOvVEWI/voB
   uF/mrFz9sjD1ieab07KDh3ygPyuhk1ppHETIwMQ0vLz4t5SxBGsqMS+bU
   5PjeOlSfnMN+VG4it7b34025J4dkgWh8ODN766tCR9w9z98AI62NMZTUA
   F/Hte0NWiOFYNKgq+kUS1awGGIo3VH/tSSgtygt+Kt0K0EpaZkGWzL8oT
   It+WFZvbeNufAae5GF7xzDZ5HWL5mSShZoxIHiq+2RyScrTmYPmjkXpuP
   w==;
X-IronPort-AV: E=Sophos;i="5.96,244,1665417600"; 
   d="scan'208";a="218870767"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2022 17:50:42 +0800
IronPort-SDR: hgUrkFkkkP2XXm213beGnsCwtSMjo6N4P8PNWK9LTIJ+Jtj1REvpvDM8JuOXQy97rger7pgQOT
 lVJlde8jHHMNWTy5nbAo4wexFPaD5ya30qDibXkPWltyhDmQPHd3jlllERlnGy772iUAA7g51D
 T6q5clHY3VOBrDF4slXuDnP9IP0GnEldnpOZC068FLb6TDrj6kpYlgdfDDtJbH5EpaZV099pK1
 y2H42nMK+KWBi+PU81k60036ClUwS+ne+T9iBJah/a+87qcaM3JQ1H9/1LReuheUgOK9/5u/tQ
 VAM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Dec 2022 01:09:05 -0800
IronPort-SDR: NwO40jDqDkRlof8sYwhctsynsU2NrjjaLOkxMfISI/LVXPwwMx1KdIVpMBtH8o3tHfDIkhNGJB
 MWcaPbVEYtO8oESXXu3RXKgNkKE98kSUwGBG77WaxL9S7Tc7NRJ7f9GSdZnrRqiW0wYk1OIvBs
 tUJKzp1/FTdTg98csbRzjV9H679iY+4DsMAae7C4PL4rBc6TcVc+NSEwD0um2/6lTvqd7nE63+
 Acwbmj7lc2J+Nt02O64eaE8sBAmGoj+jTWOoF5/dOijstTPqt4V4DL3WfN6P5QwKryA0etVnuW
 13o=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Dec 2022 01:50:41 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v6 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length function
Date:   Wed, 14 Dec 2022 11:50:27 +0200
Message-Id: <1671011427-26184-5-git-send-email-Arthur.Simchaev@wdc.com>
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

There shouldn't be any restriction of the descriptor size
(not the descriptor id for that matter) up to QUERY_DESC_MAX_SIZE.
According to the spec, the caller can use any descriptor size,
and it is up to the device to return the actual size.
Therefore there shouldn't be any sizes hardcoded in the kernel,
nor any need to cache it, hence ufshcd_map_desc_id_to_length function is
redundant. Always read the descriptors with QUERY_DESC_MAX_SIZE size.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Suggested-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Arthur Simchaev <Arthur.Simchaev@wdc.com>
---
 drivers/ufs/core/ufs_bsg.c |  1 -
 drivers/ufs/core/ufshcd.c  | 23 +++++++++++------------
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 7eec38c..dc441ac 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -16,7 +16,6 @@ static int ufs_bsg_get_query_desc_size(struct ufs_hba *hba, int *desc_len,
 				       struct utp_upiu_query *qr)
 {
 	int desc_size = be16_to_cpu(qr->length);
-	int desc_id = qr->idn;
 
 	if (desc_size <= 0)
 		return -EINVAL;
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 99806c7..0a33e53 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3395,12 +3395,6 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 	if (desc_id >= QUERY_DESC_IDN_MAX || !param_size)
 		return -EINVAL;
 
-	if (param_offset >= buff_len) {
-		dev_err(hba->dev, "%s: Invalid offset 0x%x in descriptor IDN 0x%x, length 0x%x\n",
-			__func__, param_offset, desc_id, buff_len);
-		return -EINVAL;
-	}
-
 	/* Check whether we need temp memory */
 	if (param_offset != 0 || param_size < buff_len) {
 		desc_buf = kzalloc(buff_len, GFP_KERNEL);
@@ -3413,15 +3407,23 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 
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
@@ -3430,9 +3432,6 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 		goto out;
 	}
 
-	/* Update descriptor length */
-	buff_len = desc_buf[QUERY_DESC_LENGTH_OFFSET];
-
 	if (is_kmalloc) {
 		/* Make sure we don't copy more data than available */
 		if (param_offset >= buff_len)
-- 
2.7.4

