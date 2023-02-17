Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4270369A6EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBQIaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBQIaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:30:17 -0500
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3194741A;
        Fri, 17 Feb 2023 00:30:14 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id NCW00008;
        Fri, 17 Feb 2023 16:30:08 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server id
 15.1.2507.16; Fri, 17 Feb 2023 16:30:09 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <rdunlap@infradead.org>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] scsi: lpfc: Fix double word in comments
Date:   Fri, 17 Feb 2023 03:30:03 -0500
Message-ID: <20230217083003.3987-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2023217163008f10997f8d74a58218f4986e73ba4e7f5
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "the" in comments.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 drivers/scsi/lpfc/lpfc_attr.c    | 10 +++++-----
 drivers/scsi/lpfc/lpfc_els.c     |  2 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c |  2 +-
 drivers/scsi/lpfc/lpfc_init.c    |  4 ++--
 drivers/scsi/lpfc/lpfc_mbox.c    |  4 ++--
 drivers/scsi/lpfc/lpfc_nvmet.c   |  2 +-
 drivers/scsi/lpfc/lpfc_sli.c     |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 76c3434f8976..1a32b3f93d77 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -2541,7 +2541,7 @@ lpfc_sriov_hw_max_virtfn_show(struct device *dev,
 
 /**
  * lpfc_enable_bbcr_set: Sets an attribute value.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Description:
@@ -2632,7 +2632,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
  * takes a default argument, a minimum and maximum argument.
  *
  * lpfc_##attr##_init: Initializes an attribute.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Validates the min and max values then sets the adapter config field
@@ -2665,7 +2665,7 @@ lpfc_##attr##_init(struct lpfc_hba *phba, uint val) \
  * into a function with the name lpfc_hba_queue_depth_set
  *
  * lpfc_##attr##_set: Sets an attribute value.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Description:
@@ -2794,7 +2794,7 @@ lpfc_##attr##_show(struct device *dev, struct device_attribute *attr, \
  * lpfc_##attr##_init: validates the min and max values then sets the
  * adapter config field accordingly, or uses the default if out of range
  * and prints an error message.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val: integer attribute value.
  *
  * Returns:
@@ -2826,7 +2826,7 @@ lpfc_##attr##_init(struct lpfc_vport *vport, uint val) \
  * lpfc_##attr##_set: validates the min and max values then sets the
  * adapter config field if in the valid range. prints error message
  * and does not set the parameter if invalid.
- * @phba: pointer the the adapter structure.
+ * @phba: pointer the adapter structure.
  * @val:	integer attribute value.
  *
  * Returns:
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 569639dc8b2c..cf55236a22ca 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -8886,7 +8886,7 @@ lpfc_els_rcv_rtv(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
  * @rrq: Pointer to the rrq struct.
  *
  * Build a ELS RRQ command and send it to the target. If the issue_iocb is
- * Successful the the completion handler will clear the RRQ.
+ * Successful the completion handler will clear the RRQ.
  *
  * Return codes
  *   0 - Successfully sent rrq els iocb.
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index a6df0a5b4006..32a2181c45f9 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -2459,7 +2459,7 @@ static void lpfc_sli4_fcf_pri_list_del(struct lpfc_hba *phba,
  * @phba: pointer to lpfc hba data structure.
  * @fcf_index: the index of the fcf record to update
  * This routine acquires the hbalock and then set the LPFC_FCF_FLOGI_FAILED
- * flag so the the round robin slection for the particular priority level
+ * flag so the round robin slection for the particular priority level
  * will try a different fcf record that does not have this bit set.
  * If the fcf record is re-read for any reason this flag is cleared brfore
  * adding it to the priority list.
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 6eb4085a3a22..02024f2c758f 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -5502,7 +5502,7 @@ lpfc_sli4_async_link_evt(struct lpfc_hba *phba,
 	bf_set(lpfc_mbx_read_top_link_spd, la,
 	       (bf_get(lpfc_acqe_link_speed, acqe_link)));
 
-	/* Fake the the following irrelvant fields */
+	/* Fake the following irrelvant fields */
 	bf_set(lpfc_mbx_read_top_topology, la, LPFC_TOPOLOGY_PT_PT);
 	bf_set(lpfc_mbx_read_top_alpa_granted, la, 0);
 	bf_set(lpfc_mbx_read_top_il, la, 0);
@@ -12549,7 +12549,7 @@ lpfc_cpu_affinity_check(struct lpfc_hba *phba, int vectors)
 			/* Mark CPU as IRQ not assigned by the kernel */
 			cpup->flag |= LPFC_CPU_MAP_UNASSIGN;
 
-			/* If so, find a new_cpup thats on the the SAME
+			/* If so, find a new_cpup thats on the SAME
 			 * phys_id as cpup. start_cpu will start where we
 			 * left off so all unassigned entries don't get assgined
 			 * the IRQ of the first entry.
diff --git a/drivers/scsi/lpfc/lpfc_mbox.c b/drivers/scsi/lpfc/lpfc_mbox.c
index 9858b1743769..cebb3d7598e5 100644
--- a/drivers/scsi/lpfc/lpfc_mbox.c
+++ b/drivers/scsi/lpfc/lpfc_mbox.c
@@ -2509,7 +2509,7 @@ lpfc_sli4_dump_page_a0(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
  * information via a READ_FCF mailbox command. This mailbox command also is used
  * to indicate where received unsolicited frames from this FCF will be sent. By
  * default this routine will set up the FCF to forward all unsolicited frames
- * the the RQ ID passed in the @phba. This can be overridden by the caller for
+ * the RQ ID passed in the @phba. This can be overridden by the caller for
  * more complicated setups.
  **/
 void
@@ -2577,7 +2577,7 @@ lpfc_reg_fcfi(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
  * information via a READ_FCF mailbox command. This mailbox command also is used
  * to indicate where received unsolicited frames from this FCF will be sent. By
  * default this routine will set up the FCF to forward all unsolicited frames
- * the the RQ ID passed in the @phba. This can be overridden by the caller for
+ * the RQ ID passed in the @phba. This can be overridden by the caller for
  * more complicated setups.
  **/
 void
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index f7cfac0da9b6..7517dd55fe91 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1469,7 +1469,7 @@ lpfc_nvmet_cleanup_io_context(struct lpfc_hba *phba)
 	if (!infop)
 		return;
 
-	/* Cycle the the entire CPU context list for every MRQ */
+	/* Cycle the entire CPU context list for every MRQ */
 	for (i = 0; i < phba->cfg_nvmet_mrq; i++) {
 		for_each_present_cpu(j) {
 			infop = lpfc_get_ctx_list(phba, j, i);
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index edbd81c3b643..c5b69f313af3 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -20804,7 +20804,7 @@ lpfc_log_fw_write_cmpl(struct lpfc_hba *phba, u32 shdr_status,
  * the offset after the write object mailbox has completed. @size is used to
  * determine the end of the object and whether the eof bit should be set.
  *
- * Return 0 is successful and offset will contain the the new offset to use
+ * Return 0 is successful and offset will contain the new offset to use
  * for the next write.
  * Return negative value for error cases.
  **/
-- 
2.27.0

