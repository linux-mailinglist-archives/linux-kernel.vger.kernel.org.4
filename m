Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06B76931AF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 15:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjBKOn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 09:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBKOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 09:42:59 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FC262D177;
        Sat, 11 Feb 2023 06:42:55 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 5F5367A0708;
        Sat, 11 Feb 2023 15:42:50 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] pata_parport: move pata_parport.h to drivers/ata/pata_parport
Date:   Sat, 11 Feb 2023 15:42:32 +0100
Message-Id: <20230211144232.15138-13-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230211144232.15138-1-linux@zary.sk>
References: <20230211144232.15138-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that paride is gone, pata_parport.h does not need to be in
include/linux. Move it to drivers/ata/pata_parport.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/aten.c                            | 3 +--
 drivers/ata/pata_parport/bpck.c                            | 3 +--
 drivers/ata/pata_parport/bpck6.c                           | 3 +--
 drivers/ata/pata_parport/comm.c                            | 3 +--
 drivers/ata/pata_parport/dstr.c                            | 3 +--
 drivers/ata/pata_parport/epat.c                            | 3 +--
 drivers/ata/pata_parport/epia.c                            | 3 +--
 drivers/ata/pata_parport/fit2.c                            | 3 +--
 drivers/ata/pata_parport/fit3.c                            | 3 +--
 drivers/ata/pata_parport/friq.c                            | 3 +--
 drivers/ata/pata_parport/frpw.c                            | 3 +--
 drivers/ata/pata_parport/kbic.c                            | 3 +--
 drivers/ata/pata_parport/ktti.c                            | 3 +--
 drivers/ata/pata_parport/on20.c                            | 3 +--
 drivers/ata/pata_parport/on26.c                            | 3 +--
 drivers/ata/pata_parport/pata_parport.c                    | 2 +-
 {include/linux => drivers/ata/pata_parport}/pata_parport.h | 0
 17 files changed, 16 insertions(+), 31 deletions(-)
 rename {include/linux => drivers/ata/pata_parport}/pata_parport.h (100%)

diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
index 6559670b6120..2a542a06866e 100644
--- a/drivers/ata/pata_parport/aten.c
+++ b/drivers/ata/pata_parport/aten.c
@@ -16,8 +16,7 @@
 #include <linux/wait.h>
 #include <linux/types.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 #define j44(a,b)                ((((a>>4)&0x0f)|(b&0xf0))^0x88)
 
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index 7f7927172b0b..0bb72e02cc96 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -14,8 +14,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 #undef r2
 #undef w2
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 0679a04f5541..2709245590d9 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -18,9 +18,8 @@
 #include <linux/types.h>
 #include <asm/io.h>
 #include <linux/parport.h>
-
 #include "ppc6lnx.c"
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 #define PPCSTRUCT(pi) ((Interface *)(pi->private))
 
diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index be11a681c039..d3083d535292 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -15,8 +15,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 /* mode codes:  0  nybble reads, 8-bit writes
                 1  8-bit reads and writes
diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
index 8eed094f57f6..6b2a99d8abbf 100644
--- a/drivers/ata/pata_parport/dstr.c
+++ b/drivers/ata/pata_parport/dstr.c
@@ -14,8 +14,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 /* mode codes:  0  nybble reads, 8-bit writes
                 1  8-bit reads and writes
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index 5180e3fccfdc..ca687789cb6e 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -16,8 +16,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 #define j44(a,b)		(((a>>4)&0x0f)+(b&0xf0))
 #define j53(a,b)		(((a>>3)&0x1f)+((b<<4)&0xe0))
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index 3171dc1eb5d1..3abecabdb5a4 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -17,8 +17,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 /* mode codes:  0  nybble reads on port 1, 8-bit writes
                 1  5/3 reads on ports 1 & 2, 8-bit writes
diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
index a32250c9d042..eeb2c385731d 100644
--- a/drivers/ata/pata_parport/fit2.c
+++ b/drivers/ata/pata_parport/fit2.c
@@ -20,8 +20,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 #define j44(a,b)                (((a>>4)&0x0f)|(b&0xf0))
 
diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index cb2771de7c32..d50a0c30f9da 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -24,8 +24,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 #define j44(a,b)                (((a>>3)&0x0f)|((b<<1)&0xf0))
 
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index 4feaca2582a3..d94857d1a978 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -27,8 +27,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 #define CMD(x)		w2(4);w0(0xff);w0(0xff);w0(0x73);w0(0x73);\
 			w0(0xc9);w0(0xc9);w0(0x26);w0(0x26);w0(x);w0(x);
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 2bd82d7c60f3..8b9a176fce17 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -20,8 +20,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 #define cec4		w2(0xc);w2(0xe);w2(0xe);w2(0xc);w2(4);w2(4);w2(4);
 #define j44(l,h)	(((l>>4)&0x0f)|(h&0xf0))
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index 18f3641a9a8d..d0f10f84413b 100644
--- a/drivers/ata/pata_parport/kbic.c
+++ b/drivers/ata/pata_parport/kbic.c
@@ -19,8 +19,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 #define r12w()			(delay_p,inw(pi->port+1)&0xffff) 
 
diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
index 5fd4d797720c..89a1e8b23bf4 100644
--- a/drivers/ata/pata_parport/ktti.c
+++ b/drivers/ata/pata_parport/ktti.c
@@ -16,8 +16,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 #define j44(a,b)                (((a>>4)&0x0f)|(b&0xf0))
 
diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
index 8e1d49914aa7..e08395be87da 100644
--- a/drivers/ata/pata_parport/on20.c
+++ b/drivers/ata/pata_parport/on20.c
@@ -13,8 +13,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 #define op(f)	w2(4);w0(f);w2(5);w2(0xd);w2(5);w2(0xd);w2(5);w2(4);
 #define vl(v)	w2(4);w0(v);w2(5);w2(7);w2(5);w2(4);
diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
index cea1e6311e6b..440325081bc5 100644
--- a/drivers/ata/pata_parport/on26.c
+++ b/drivers/ata/pata_parport/on26.c
@@ -14,8 +14,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <asm/io.h>
-
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 /* mode codes:  0  nybble reads, 8-bit writes
                 1  8-bit reads and writes
diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 45dacb2de9c5..601c086b75ee 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -6,7 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/parport.h>
-#include <linux/pata_parport.h>
+#include "pata_parport.h"
 
 #define DRV_NAME "pata_parport"
 
diff --git a/include/linux/pata_parport.h b/drivers/ata/pata_parport/pata_parport.h
similarity index 100%
rename from include/linux/pata_parport.h
rename to drivers/ata/pata_parport/pata_parport.h
-- 
Ondrej Zary

