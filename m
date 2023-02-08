Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA6A68E883
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjBHGxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBHGxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:53:01 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BFA442E5;
        Tue,  7 Feb 2023 22:52:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbAZ-7y_1675839170;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VbAZ-7y_1675839170)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 14:52:56 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     aacraid@microsemi.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] scsi: ips: clean up some inconsistent indenting
Date:   Wed,  8 Feb 2023 14:52:44 +0800
Message-Id: <20230208065244.62762-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

drivers/scsi/ips.c:2080 ips_host_info() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3993
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/ips.c | 114 ++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index bb206509265e..7f958871388a 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -2054,79 +2054,79 @@ ips_host_info(ips_ha_t *ha, struct seq_file *m)
 
 	seq_printf(m, "\tIRQ number                        : %d\n", ha->pcidev->irq);
 
-    /* For the Next 3 lines Check for Binary 0 at the end and don't include it if it's there. */
-    /* That keeps everything happy for "text" operations on the proc file.                    */
+	/* For the Next 3 lines Check for Binary 0 at the end and don't include it if it's there. */
+	/* That keeps everything happy for "text" operations on the proc file.                    */
 
 	if (le32_to_cpu(ha->nvram->signature) == IPS_NVRAM_P5_SIG) {
-	if (ha->nvram->bios_low[3] == 0) {
-		seq_printf(m,
-			  "\tBIOS Version                      : %c%c%c%c%c%c%c\n",
-			  ha->nvram->bios_high[0], ha->nvram->bios_high[1],
-			  ha->nvram->bios_high[2], ha->nvram->bios_high[3],
-			  ha->nvram->bios_low[0], ha->nvram->bios_low[1],
-			  ha->nvram->bios_low[2]);
+		if (ha->nvram->bios_low[3] == 0) {
+			seq_printf(m,
+				   "\tBIOS Version                      : %c%c%c%c%c%c%c\n",
+				   ha->nvram->bios_high[0], ha->nvram->bios_high[1],
+				   ha->nvram->bios_high[2], ha->nvram->bios_high[3],
+				   ha->nvram->bios_low[0], ha->nvram->bios_low[1],
+				   ha->nvram->bios_low[2]);
+
+		} else {
+			seq_printf(m,
+				   "\tBIOS Version                      : %c%c%c%c%c%c%c%c\n",
+				   ha->nvram->bios_high[0], ha->nvram->bios_high[1],
+				   ha->nvram->bios_high[2], ha->nvram->bios_high[3],
+				   ha->nvram->bios_low[0], ha->nvram->bios_low[1],
+				   ha->nvram->bios_low[2], ha->nvram->bios_low[3]);
+		}
 
-        } else {
+	}
+
+	if (ha->enq->CodeBlkVersion[7] == 0) {
 		seq_printf(m,
-			  "\tBIOS Version                      : %c%c%c%c%c%c%c%c\n",
-			  ha->nvram->bios_high[0], ha->nvram->bios_high[1],
-			  ha->nvram->bios_high[2], ha->nvram->bios_high[3],
-			  ha->nvram->bios_low[0], ha->nvram->bios_low[1],
-			  ha->nvram->bios_low[2], ha->nvram->bios_low[3]);
-        }
+			   "\tFirmware Version                  : %c%c%c%c%c%c%c\n",
+			   ha->enq->CodeBlkVersion[0], ha->enq->CodeBlkVersion[1],
+			   ha->enq->CodeBlkVersion[2], ha->enq->CodeBlkVersion[3],
+			   ha->enq->CodeBlkVersion[4], ha->enq->CodeBlkVersion[5],
+			   ha->enq->CodeBlkVersion[6]);
+	} else {
+		seq_printf(m,
+			   "\tFirmware Version                  : %c%c%c%c%c%c%c%c\n",
+			   ha->enq->CodeBlkVersion[0], ha->enq->CodeBlkVersion[1],
+			   ha->enq->CodeBlkVersion[2], ha->enq->CodeBlkVersion[3],
+			   ha->enq->CodeBlkVersion[4], ha->enq->CodeBlkVersion[5],
+			   ha->enq->CodeBlkVersion[6], ha->enq->CodeBlkVersion[7]);
+	}
 
-    }
-
-    if (ha->enq->CodeBlkVersion[7] == 0) {
-        seq_printf(m,
-		  "\tFirmware Version                  : %c%c%c%c%c%c%c\n",
-		  ha->enq->CodeBlkVersion[0], ha->enq->CodeBlkVersion[1],
-		  ha->enq->CodeBlkVersion[2], ha->enq->CodeBlkVersion[3],
-		  ha->enq->CodeBlkVersion[4], ha->enq->CodeBlkVersion[5],
-		  ha->enq->CodeBlkVersion[6]);
-    } else {
-	seq_printf(m,
-		  "\tFirmware Version                  : %c%c%c%c%c%c%c%c\n",
-		  ha->enq->CodeBlkVersion[0], ha->enq->CodeBlkVersion[1],
-		  ha->enq->CodeBlkVersion[2], ha->enq->CodeBlkVersion[3],
-		  ha->enq->CodeBlkVersion[4], ha->enq->CodeBlkVersion[5],
-		  ha->enq->CodeBlkVersion[6], ha->enq->CodeBlkVersion[7]);
-    }
-
-    if (ha->enq->BootBlkVersion[7] == 0) {
-        seq_printf(m,
-		  "\tBoot Block Version                : %c%c%c%c%c%c%c\n",
-		  ha->enq->BootBlkVersion[0], ha->enq->BootBlkVersion[1],
-		  ha->enq->BootBlkVersion[2], ha->enq->BootBlkVersion[3],
-		  ha->enq->BootBlkVersion[4], ha->enq->BootBlkVersion[5],
-		  ha->enq->BootBlkVersion[6]);
-    } else {
-        seq_printf(m,
-		  "\tBoot Block Version                : %c%c%c%c%c%c%c%c\n",
-		  ha->enq->BootBlkVersion[0], ha->enq->BootBlkVersion[1],
-		  ha->enq->BootBlkVersion[2], ha->enq->BootBlkVersion[3],
-		  ha->enq->BootBlkVersion[4], ha->enq->BootBlkVersion[5],
-		  ha->enq->BootBlkVersion[6], ha->enq->BootBlkVersion[7]);
-    }
+	if (ha->enq->BootBlkVersion[7] == 0) {
+		seq_printf(m,
+			   "\tBoot Block Version                : %c%c%c%c%c%c%c\n",
+			   ha->enq->BootBlkVersion[0], ha->enq->BootBlkVersion[1],
+			   ha->enq->BootBlkVersion[2], ha->enq->BootBlkVersion[3],
+			   ha->enq->BootBlkVersion[4], ha->enq->BootBlkVersion[5],
+			   ha->enq->BootBlkVersion[6]);
+	} else {
+		seq_printf(m,
+			   "\tBoot Block Version                : %c%c%c%c%c%c%c%c\n",
+			   ha->enq->BootBlkVersion[0], ha->enq->BootBlkVersion[1],
+			   ha->enq->BootBlkVersion[2], ha->enq->BootBlkVersion[3],
+			   ha->enq->BootBlkVersion[4], ha->enq->BootBlkVersion[5],
+			   ha->enq->BootBlkVersion[6], ha->enq->BootBlkVersion[7]);
+	}
 
 	seq_printf(m, "\tDriver Version                    : %s%s\n",
-		  IPS_VERSION_HIGH, IPS_VERSION_LOW);
+		   IPS_VERSION_HIGH, IPS_VERSION_LOW);
 
 	seq_printf(m, "\tDriver Build                      : %d\n",
-		  IPS_BUILD_IDENT);
+		   IPS_BUILD_IDENT);
 
 	seq_printf(m, "\tMax Physical Devices              : %d\n",
-		  ha->enq->ucMaxPhysicalDevices);
+		   ha->enq->ucMaxPhysicalDevices);
 	seq_printf(m, "\tMax Active Commands               : %d\n",
-		  ha->max_cmds);
+		   ha->max_cmds);
 	seq_printf(m, "\tCurrent Queued Commands           : %d\n",
-		  ha->scb_waitlist.count);
+		   ha->scb_waitlist.count);
 	seq_printf(m, "\tCurrent Active Commands           : %d\n",
-		  ha->scb_activelist.count - ha->num_ioctl);
+		   ha->scb_activelist.count - ha->num_ioctl);
 	seq_printf(m, "\tCurrent Queued PT Commands        : %d\n",
-		  ha->copp_waitlist.count);
+		   ha->copp_waitlist.count);
 	seq_printf(m, "\tCurrent Active PT Commands        : %d\n",
-		  ha->num_ioctl);
+		   ha->num_ioctl);
 
 	seq_putc(m, '\n');
 
-- 
2.20.1.7.g153144c

