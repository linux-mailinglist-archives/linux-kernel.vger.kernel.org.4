Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF064945A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 14:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiLKNFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 08:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiLKNFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 08:05:49 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA20E0BC;
        Sun, 11 Dec 2022 05:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670763936; x=1702299936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=virbk6rhnfIZfWCJDUiMIpVN6qxlNGltOo4qipvPCg4=;
  b=krhbLUm7iVih87HtXsEhViw0nj2ZgwIzvYEwTgRR62wOjUQUqeGODsWS
   C07WsI/ewyV8YcSuNE1+cJZYqlooElgGjpmHadG4VUqwcJmH9ILdNfmDo
   bvMBhFblJj5XNWlRksU/0dzrdaNAPZrD2rwSkXBT24cOMxV4zpjlMZT6F
   ZwNlXrRC98hCmvHf8kIvklPmMZEt/Wi6W71Pm5EHFQa33MTtxSV+SOLtx
   v/LpyXN4yokduNKA79Ars5VKxvswRmcMyFrf4qtuR/vvIXaf/iR/0EGYR
   fnNbQZPfzcSpIx5DTPAnTqbJXzSqKCUxnY0h0U+p22TZRSADy6T2g6sAI
   w==;
X-IronPort-AV: E=Sophos;i="5.96,236,1665417600"; 
   d="scan'208";a="218373534"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2022 21:05:36 +0800
IronPort-SDR: Qdms07bEsYnc8iIAhuE29cgVdz20A9vPuewpeHUonXeSFjhFosaPzF0gyio+ehHwhw5Tr8w97l
 8GLPrV5/tz0PFyjvAQyPGe7qziLntvQXWD8XJbpSwzWUSIjok5ssMiwEV5D+5u4RQi6Sex5Dp4
 oMrkavTEKBydhLOuGMFssgeIa9XY0Po+KShWz0hHe4iWJlWiyEG/9Ye+uVnjYPe9lU02fQy+VE
 YWev4eGXOD6c+SyZpRLKZxXxYi7cmmZ4wEo/4w7kALcYAbXxzGqNyD5wjz4WI72u6Wc9jbiErQ
 ZKc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2022 04:24:02 -0800
IronPort-SDR: CFUMjJwsfpiF5e1l0dQA7ZsNakqTfUOdKmtmfSMWGqOtsO5DxyIkRioWcmeC4RB5EwLDocTC0M
 Uxbt3/GzCcpMncSU3JSk2gc/cjyNit4rGJy9+Ge01y7I4/VqcqPGnT0k0JelbKVErsyBsSwLf7
 iXNrxdFJr1FJdv3+W4u/K2ZfA+ZqK9Ye6uTr6blJVS33ByfaSM0XuSE5lKQchzKvOym28fh5ly
 4rogVux9hirQHOD3lD1gClnj4CQNgZvcfXD1EehMkKgSJlSJaF6U7xH9hKDRiTaaPvxmlUmoDj
 QRg=
WDCIronportException: Internal
Received: from ilb001078.ad.shared (HELO ilb001078.sdcorp.global.sandisk.com) ([10.45.31.219])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Dec 2022 05:05:34 -0800
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v5 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length function
Date:   Sun, 11 Dec 2022 15:05:11 +0200
Message-Id: <1670763911-8695-5-git-send-email-Arthur.Simchaev@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
References: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
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
index b6ef92d3..7f89626 100644
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

