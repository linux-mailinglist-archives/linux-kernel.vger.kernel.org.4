Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21A3638243
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 03:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKYCIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 21:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKYCIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:08:11 -0500
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72F3217E13;
        Thu, 24 Nov 2022 18:08:08 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 3AFE01E80D75;
        Fri, 25 Nov 2022 10:04:27 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QGUiM31TIaYm; Fri, 25 Nov 2022 10:04:24 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 91EAB1E80D0A;
        Fri, 25 Nov 2022 10:04:23 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH v2] scsi: megaraid_sas: fix some spelling mistakes in comment
Date:   Fri, 25 Nov 2022 10:07:03 +0800
Message-Id: <20221125020703.22216-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20221124092514.32032-1-yuzhe@nfschina.com>
References: <20221124092514.32032-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typos in comment.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 6650f8c8e9b0..fe70f8f11435 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -80,7 +80,7 @@ static void megasas_fusion_crash_dump(struct megasas_instance *instance);
  * @ocr_context:			If called from OCR context this will
  *					be set to 1, else 0
  *
- * This function initates a chip reset followed by a wait for controller to
+ * This function initiates a chip reset followed by a wait for controller to
  * transition to ready state.
  * During this, driver will block all access to PCI config space from userspace
  */
@@ -334,7 +334,7 @@ megasas_fire_cmd_fusion(struct megasas_instance *instance,
  *
  * This function is only for fusion controllers.
  * Update host can queue, if firmware downgrade max supported firmware commands.
- * Firmware upgrade case will be skiped because underlying firmware has
+ * Firmware upgrade case will be skipped because underlying firmware has
  * more resource than exposed to the OS.
  *
  */
@@ -2588,7 +2588,7 @@ static void megasas_stream_detect(struct megasas_instance *instance,
 			if ((io_info->ldStartBlock != current_sd->next_seq_lba)	&&
 			    ((!io_info->isRead) || (!is_read_ahead)))
 				/*
-				 * Once the API availible we need to change this.
+				 * Once the API is available we need to change this.
 				 * At this point we are not allowing any gap
 				 */
 				continue;
@@ -4650,7 +4650,7 @@ megasas_issue_tm(struct megasas_instance *instance, u16 device_handle,
 }
 
 /*
- * megasas_fusion_smid_lookup : Look for fusion command correpspodning to SCSI
+ * megasas_fusion_smid_lookup : Look for fusion command corresponding to SCSI
  * @instance: per adapter struct
  *
  * Return Non Zero index, if SMID found in outstanding commands
-- 
2.11.0

