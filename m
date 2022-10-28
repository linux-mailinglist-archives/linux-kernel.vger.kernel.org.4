Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4306112E0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiJ1NeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJ1NeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:34:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799841D067E;
        Fri, 28 Oct 2022 06:33:59 -0700 (PDT)
X-QQ-mid: bizesmtp84t1666964027tes9ngsu
Received: from localhost.localdomain ( [182.148.13.81])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Oct 2022 21:33:45 +0800 (CST)
X-QQ-SSF: 01000000000000F0J000000A0000000
X-QQ-FEAT: +bXiSo2NuBfWW+STpXQcaRYqkqBj+GJOiWoJGHbf2DYRkV22ZVU+A/+RguV50
        Bk4YC9O1Yi3DFJxKpWuGenHrPXc+GxQThofREPlwlafbL5wsZAXe17TSUegD0Fs4hYQ2ESV
        V7KcPlAs0L3Iv2Qnw/aTXw+ZkvD6ONRsjytX+P88OBwU1UTfIGCMDR0RFDF2e9Z0ZBI/8Wv
        CzpEJirq69UGmlsXScjaqbNb1nepQhrND3MJCf0kijtJ9AiXNkgppkmLc/O5BfNEKUVDwig
        eNgk/lQtrOKk0VLmCh1Q5rxKLJ1krSYWwA9AAJu7iP+CAE8aHrlUgzCnKH/2l4q7IS6cGax
        mOP0j3kc8HqjXvMQpQq4dCeIoWlvmEkT+4gbb3ouSfV0+hSiEbziCUBDNmpZA==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] scsi: megaraid_sas: fix repeated words in comments
Date:   Fri, 28 Oct 2022 21:33:39 +0800
Message-Id: <20221028133339.56897-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'be'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 9be4ba61a076..52210d99121c 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -2823,7 +2823,7 @@ static int megasas_wait_for_outstanding(struct megasas_instance *instance)
 			       "commands to complete\n",i,outstanding);
 			/*
 			 * Call cmd completion routine. Cmd to be
-			 * be completed directly without depending on isr.
+			 * completed directly without depending on isr.
 			 */
 			megasas_complete_cmd_dpc((unsigned long)instance);
 		}
-- 
2.36.1

