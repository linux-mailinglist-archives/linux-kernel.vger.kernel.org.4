Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FAA75008C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGLH6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjGLH6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:58:45 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358CD10F7;
        Wed, 12 Jul 2023 00:58:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VnC3MN3_1689148717;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VnC3MN3_1689148717)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 15:58:38 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] scsi: ufs: core: Fix some kernel-doc comments
Date:   Wed, 12 Jul 2023 15:58:36 +0800
Message-Id: <20230712075836.15375-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use colons to separate parameter names from their specific meanings.
silencethe warnings:

drivers/ufs/core/ufs-mcq.c:499: warning: Function parameter or member 'hba' not described in 'ufshcd_mcq_sq_cleanup'
drivers/ufs/core/ufs-mcq.c:499: warning: Function parameter or member 'task_tag' not described in 'ufshcd_mcq_sq_cleanup'
drivers/ufs/core/ufs-mcq.c:560: warning: Function parameter or member 'utrd' not described in 'ufshcd_mcq_nullify_sqe'
drivers/ufs/core/ufs-mcq.c:583: warning: Function parameter or member 'hba' not described in 'ufshcd_mcq_sqe_search'
drivers/ufs/core/ufs-mcq.c:583: warning: Function parameter or member 'hwq' not described in 'ufshcd_mcq_sqe_search'
drivers/ufs/core/ufs-mcq.c:583: warning: Function parameter or member 'task_tag' not described in 'ufshcd_mcq_sqe_search'
drivers/ufs/core/ufs-mcq.c:630: warning: Function parameter or member 'cmd' not described in 'ufshcd_mcq_abort'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5850
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ufs/core/ufs-mcq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index e8bad5e9518e..1e23ba3e2bdf 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -490,8 +490,8 @@ static int ufshcd_mcq_sq_start(struct ufs_hba *hba, struct ufs_hw_queue *hwq)
 /**
  * ufshcd_mcq_sq_cleanup - Clean up submission queue resources
  * associated with the pending command.
- * @hba - per adapter instance.
- * @task_tag - The command's task tag.
+ * @hba: per adapter instance.
+ * @task_tag: The command's task tag.
  *
  * Returns 0 for success; error code otherwise.
  */
@@ -554,7 +554,7 @@ int ufshcd_mcq_sq_cleanup(struct ufs_hba *hba, int task_tag)
  * Write the sqe's Command Type to 0xF. The host controller will not
  * fetch any sqe with Command Type = 0xF.
  *
- * @utrd - UTP Transfer Request Descriptor to be nullified.
+ * @utrd: UTP Transfer Request Descriptor to be nullified.
  */
 static void ufshcd_mcq_nullify_sqe(struct utp_transfer_req_desc *utrd)
 {
@@ -571,9 +571,9 @@ static void ufshcd_mcq_nullify_sqe(struct utp_transfer_req_desc *utrd)
  * If the command is in the submission queue and not issued to the device yet,
  * nullify the sqe so the host controller will skip fetching the sqe.
  *
- * @hba - per adapter instance.
- * @hwq - Hardware Queue to be searched.
- * @task_tag - The command's task tag.
+ * @hba: per adapter instance.
+ * @hwq: Hardware Queue to be searched.
+ * @task_tag: The command's task tag.
  *
  * Returns true if the SQE containing the command is present in the SQ
  * (not fetched by the controller); returns false if the SQE is not in the SQ.
@@ -622,7 +622,7 @@ static bool ufshcd_mcq_sqe_search(struct ufs_hba *hba,
 
 /**
  * ufshcd_mcq_abort - Abort the command in MCQ.
- * @cmd - The command to be aborted.
+ * @cmd: The command to be aborted.
  *
  * Returns SUCCESS or FAILED error codes
  */
-- 
2.20.1.7.g153144c

