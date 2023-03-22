Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B1D6C426B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCVFzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCVFza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:55:30 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507F43347B;
        Tue, 21 Mar 2023 22:55:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VePWA1N_1679464521;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VePWA1N_1679464521)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 13:55:25 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] pata_parport: Clean up some inconsistent indenting
Date:   Wed, 22 Mar 2023 13:55:19 +0800
Message-Id: <20230322055519.67900-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

drivers/ata/pata_parport/comm.c:159 comm_write_block() warn: inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4587
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/ata/pata_parport/comm.c | 227 ++++++++++++++++----------------
 1 file changed, 116 insertions(+), 111 deletions(-)

diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index 4c2f9ad60ad8..b474bda59323 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -1,12 +1,13 @@
-/* 
-        comm.c    (c) 1997-8  Grant R. Guenther <grant@torque.net>
-                              Under the terms of the GNU General Public License.
-
-	comm.c is a low-level protocol driver for some older models
-	of the DataStor "Commuter" parallel to IDE adapter.  Some of
-	the parallel port devices marketed by Arista currently
-	use this adapter.
-*/
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * comm.c    (c) 1997-8  Grant R. Guenther <grant@torque.net>
+ *			 Under the terms of the GNU General Public License.
+ *
+ * comm.c is a low-level protocol driver for some older models
+ * of the DataStor "Commuter" parallel to IDE adapter.  Some of
+ * the parallel port devices marketed by Arista currently
+ * use this adapter.
+ */
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -18,120 +19,126 @@
 #include "pata_parport.h"
 
 /* mode codes:  0  nybble reads, 8-bit writes
-                1  8-bit reads and writes
-                2  8-bit EPP mode
-*/
+ *		1  8-bit reads and writes
+ *		2  8-bit EPP mode
+ */
 
-#define j44(a,b)	(((a>>3)&0x0f)|((b<<1)&0xf0))
+#define j44(a, b)	(((a>>3)&0x0f)|((b<<1)&0xf0))
 
-#define P1	w2(5);w2(0xd);w2(0xd);w2(5);w2(4);
-#define P2	w2(5);w2(7);w2(7);w2(5);w2(4);
+#define P1	w2(5); w2(0xd); w2(0xd); w2(5); w2(4);
+#define P2	w2(5); w2(7); w2(7); w2(5); w2(4);
 
-/* cont = 0 - access the IDE register file 
-   cont = 1 - access the IDE command set 
-*/
+/*
+ * cont = 0 - access the IDE register file
+ * cont = 1 - access the IDE command set
+ */
 
 static int  cont_map[2] = { 0x08, 0x10 };
 
 static int comm_read_regr(struct pi_adapter *pi, int cont, int regr)
+{
+	int l, h, r;
 
-{       int     l, h, r;
-
-        r = regr + cont_map[cont];
+	r = regr + cont_map[cont];
 
-        switch (pi->mode)  {
+	switch (pi->mode) {
 
-        case 0: w0(r); P1; w0(0);
-        	w2(6); l = r1(); w0(0x80); h = r1(); w2(4);
-                return j44(l,h);
+	case 0: w0(r); P1; w0(0);
+		w2(6); l = r1(); w0(0x80); h = r1(); w2(4);
+		return j44(l, h);
 
-        case 1: w0(r+0x20); P1; 
-        	w0(0); w2(0x26); h = r0(); w2(4);
-                return h;
+	case 1: w0(r+0x20); P1;
+		w0(0); w2(0x26); h = r0(); w2(4);
+		return h;
 
 	case 2:
 	case 3:
-        case 4: w3(r+0x20); (void)r1();
-        	w2(0x24); h = r4(); w2(4);
-                return h;
+	case 4: w3(r+0x20); (void)r1();
+		w2(0x24); h = r4(); w2(4);
+		return h;
 
-        }
-        return -1;
-}       
+	}
 
-static void comm_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+	return -1;
+}
 
-{       int  r;
+static void comm_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
+{
+	int r;
 
-        r = regr + cont_map[cont];
+	r = regr + cont_map[cont];
 
-        switch (pi->mode)  {
+	switch (pi->mode) {
 
-        case 0:
-        case 1: w0(r); P1; w0(val); P2;
+	case 0:
+	case 1: w0(r); P1; w0(val); P2;
 		break;
 
 	case 2:
 	case 3:
-        case 4: w3(r); (void)r1(); w4(val);
-                break;
-        }
+	case 4: w3(r); (void)r1(); w4(val);
+		break;
+	}
 }
 
 static void comm_connect(struct pi_adapter *pi)
-
-{       pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
-        w2(4); w0(0xff); w2(6);
-        w2(4); w0(0xaa); w2(6);
-        w2(4); w0(0x00); w2(6);
-        w2(4); w0(0x87); w2(6);
-        w2(4); w0(0xe0); w2(0xc); w2(0xc); w2(4);
+{
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
+	w2(4); w0(0xff); w2(6);
+	w2(4); w0(0xaa); w2(6);
+	w2(4); w0(0x00); w2(6);
+	w2(4); w0(0x87); w2(6);
+	w2(4); w0(0xe0); w2(0xc); w2(0xc); w2(4);
 }
 
 static void comm_disconnect(struct pi_adapter *pi)
-
-{       w2(0); w2(0); w2(0); w2(4); 
+{
+	w2(0); w2(0); w2(0); w2(4);
 	w0(pi->saved_r0);
-        w2(pi->saved_r2);
-} 
+	w2(pi->saved_r2);
+}
 
 static void comm_read_block(struct pi_adapter *pi, char *buf, int count)
 
-{       int     i, l, h;
-
-        switch (pi->mode) {
-        
-        case 0: w0(0x48); P1;
-                for(i=0;i<count;i++) {
-                        w0(0); w2(6); l = r1();
-                        w0(0x80); h = r1(); w2(4);
-                        buf[i] = j44(l,h);
-                }
-                break;
-
-        case 1: w0(0x68); P1; w0(0);
-                for(i=0;i<count;i++) {
-                        w2(0x26); buf[i] = r0(); w2(0x24);
-                }
+{       int i, l, h;
+
+	switch (pi->mode) {
+	case 0: w0(0x48); P1;
+		for (i = 0; i < count; i++) {
+			w0(0); w2(6); l = r1();
+			w0(0x80); h = r1(); w2(4);
+			buf[i] = j44(l, h);
+		}
+
+		break;
+	case 1: w0(0x68); P1; w0(0);
+		for (i = 0; i < count; i++) {
+			w2(0x26);
+			buf[i] = r0();
+			w2(0x24);
+		}
+
 		w2(4);
 		break;
-		
 	case 2: w3(0x68); (void)r1(); w2(0x24);
-		for (i=0;i<count;i++) buf[i] = r4();
+		for (i = 0; i < count; i++)
+			buf[i] = r4();
+
 		w2(4);
 		break;
+	case 3: w3(0x68); (void)r1(); w2(0x24);
+		for (i = 0; i < count/2; i++)
+			((u16 *)buf)[i] = r4w();
 
-        case 3: w3(0x68); (void)r1(); w2(0x24);
-                for (i=0;i<count/2;i++) ((u16 *)buf)[i] = r4w();
-                w2(4);
-                break;
+		w2(4);
+		break;
+	case 4: w3(0x68); (void)r1(); w2(0x24);
+		for (i = 0; i < count/4; i++)
+			((u32 *)buf)[i] = r4l();
 
-        case 4: w3(0x68); (void)r1(); w2(0x24);
-                for (i=0;i<count/4;i++) ((u32 *)buf)[i] = r4l();
-                w2(4);
-                break;
-		
+		w2(4);
+		break;
 	}
 }
 
@@ -139,43 +146,41 @@ static void comm_read_block(struct pi_adapter *pi, char *buf, int count)
 
 static void comm_write_block(struct pi_adapter *pi, char *buf, int count)
 
-{       int	k;
+{
+	int k;
 
-        switch (pi->mode) {
+	switch (pi->mode) {
+	case 0:
+	case 1: w0(0x68); P1;
+		for (k = 0; k < count; k++) {
+			w2(5);
+			w0(buf[k^1]);
+			w2(7);
+		}
 
-        case 0:
-        case 1: w0(0x68); P1;
-        	for (k=0;k<count;k++) {
-                        w2(5); w0(buf[k^1]); w2(7);
-                }
-                w2(5); w2(4);
-                break;
-
-        case 2: w3(0x48); (void)r1();
-                for (k=0;k<count;k++) w4(buf[k^1]);
-                break;
-
-        case 3: w3(0x48); (void)r1();
-		for (k = 0; k < count / 2; k++)
+		w2(5); w2(4);
+		break;
+	case 2: w3(0x48); (void)r1();
+		for (k = 0; k < count; k++)
+			w4(buf[k^1]);
+		break;
+	case 3: w3(0x48); (void)r1();
+		for (k = 0; k < count/2; k++)
 			w4w(swab16(((u16 *)buf)[k]));
-                break;
-
-        case 4: w3(0x48); (void)r1();
-		for (k = 0; k < count / 4; k++)
-			w4l(swab16(((u16 *)buf)[2 * k]) |
-			    swab16(((u16 *)buf)[2 * k + 1]) << 16);
-                break;
-
-
-        }
+		break;
+	case 4: w3(0x48); (void)r1();
+		for (k = 0; k < count/4; k++)
+			w4l(swab16(((u16 *)buf)[2 * k]) | swab16(((u16 *)buf)[2 * k + 1]) << 16);
+		break;
+	}
 }
 
 static void comm_log_adapter(struct pi_adapter *pi)
-
-{       char    *mode_string[5] = {"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
+{
+	char *mode_string[5] = {"4-bit", "8-bit", "EPP-8", "EPP-16", "EPP-32"};
 
 	dev_info(&pi->dev, "DataStor Commuter at 0x%x, mode %d (%s), delay %d\n",
-		pi->port, pi->mode, mode_string[pi->mode], pi->delay);
+		 pi->port, pi->mode, mode_string[pi->mode], pi->delay);
 }
 
 static struct pi_protocol comm = {
-- 
2.20.1.7.g153144c

