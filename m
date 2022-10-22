Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58F608539
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 08:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJVGmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 02:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJVGmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:42:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562212A5229;
        Fri, 21 Oct 2022 23:42:30 -0700 (PDT)
X-QQ-mid: bizesmtp69t1666420938tlbrf44a
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:42:17 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: dS+JUNSIibc3AY3qrHR6jniD05r/Uw4yojYLttszvxF1wtYINjTE8yXE2QXy2
        YBmLPm7SY+m0D0cJCkV0e+VcpDOD4TiLZXN1N3TxwkriR8HxWfVGpfUbdYJx9CA5H9sv5WO
        QOhocdUn1fs5ZFKe7msKNrMp+SLbLTNJbdxBgkO3LVVlqPLDU88LJ83aZZwAx0He0C5NGVy
        nZAafoqEniFRQxtNmNAZR+NtNuUi2C1ogvybrSS6Pvm6wozE6b0Wjf0hMSEVCQJob7nZ47k
        IKEwZ8/s9XaIwzmHLvPmZOGmQFAEGuw53Ym16P3ItbdOCa08iQFFN/L6zSqOIFUFkiXnWeH
        +65jR7zR2fvO3EHlJrYJHOiiGrIMGm7AwB2enweE+Tmv6/zeDkDN+x0GiFFQQ==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] scsi/lpfc: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:42:11 +0800
Message-Id: <20221022064211.31984-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 80ac3a051c19..9ee7e8a236b7 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -20538,7 +20538,7 @@ lpfc_log_fw_write_cmpl(struct lpfc_hba *phba, u32 shdr_status,
  * the offset after the write object mailbox has completed. @size is used to
  * determine the end of the object and whether the eof bit should be set.
  *
- * Return 0 is successful and offset will contain the the new offset to use
+ * Return 0 is successful and offset will contain the new offset to use
  * for the next write.
  * Return negative value for error cases.
  **/
-- 
2.36.1

