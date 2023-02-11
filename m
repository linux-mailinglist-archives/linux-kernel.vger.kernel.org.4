Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53DC6931B5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 15:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjBKOnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 09:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBKOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 09:42:58 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FBBB2D174;
        Sat, 11 Feb 2023 06:42:55 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 43ACD7A06FE;
        Sat, 11 Feb 2023 15:42:50 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] pata_parport: remove obsolete changelogs
Date:   Sat, 11 Feb 2023 15:42:31 +0100
Message-Id: <20230211144232.15138-12-linux@zary.sk>
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

Remove obsolete changelogs from protocol drivers.

Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/aten.c  |  6 ------
 drivers/ata/pata_parport/bpck.c  |  7 -------
 drivers/ata/pata_parport/bpck6.c |  8 --------
 drivers/ata/pata_parport/comm.c  |  6 ------
 drivers/ata/pata_parport/dstr.c  |  6 ------
 drivers/ata/pata_parport/epat.c  |  7 -------
 drivers/ata/pata_parport/epia.c  |  7 -------
 drivers/ata/pata_parport/friq.c  |  5 -----
 drivers/ata/pata_parport/frpw.c  | 10 ----------
 drivers/ata/pata_parport/kbic.c  |  6 ------
 drivers/ata/pata_parport/on20.c  |  6 ------
 drivers/ata/pata_parport/on26.c  |  9 ---------
 12 files changed, 83 deletions(-)

diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
index dbdd89d091df..6559670b6120 100644
--- a/drivers/ata/pata_parport/aten.c
+++ b/drivers/ata/pata_parport/aten.c
@@ -9,12 +9,6 @@
 
 */
 
-/* Changes:
-
-	1.01	GRG 1998.05.05	init_proto, release_proto
-
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index bd53ab7a6c55..7f7927172b0b 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -7,13 +7,6 @@
 
 */
 
-/* Changes:
-
-	1.01	GRG 1998.05.05 init_proto, release_proto, pi->delay 
-	1.02    GRG 1998.08.15 default pi->delay returned to 4
-
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 08dbc1bca4b9..0679a04f5541 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -11,14 +11,6 @@
 
 */
 
-/*
-   This is Ken's linux wrapper for the PPC library
-   Version 1.0.0 is the backpack driver for which source is not available
-   Version 2.0.0 is the first to have source released 
-   Version 2.0.1 is the "Cox-ified" source code 
-   Version 2.0.2 - fixed version string usage, and made ppc functions static 
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index 8f0b55c1493a..be11a681c039 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -8,12 +8,6 @@
 	use this adapter.
 */
 
-/* Changes:
-
-	1.01	GRG 1998.05.05  init_proto, release_proto
-
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
index c0e44f33ae37..8eed094f57f6 100644
--- a/drivers/ata/pata_parport/dstr.c
+++ b/drivers/ata/pata_parport/dstr.c
@@ -7,12 +7,6 @@
 
 */
 
-/* Changes:
-
-        1.01    GRG 1998.05.06 init_proto, release_proto
-
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index 82f9d8d33765..5180e3fccfdc 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -9,13 +9,6 @@
 	
 */
 
-/* Changes:
-
-        1.01    GRG 1998.05.06 init_proto, release_proto
-        1.02    Joshua b. Jore CPP(renamed), epat_connect, epat_disconnect
-
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index 9b5ec8e02da6..3171dc1eb5d1 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -10,13 +10,6 @@
 
 */
 
-/* Changes:
-
-        1.01    GRG 1998.05.06 init_proto, release_proto
-	1.02    GRG 1998.06.17 support older versions of EPIA
-
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index 193d319bac66..4feaca2582a3 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -20,11 +20,6 @@
 
 */
 
-/* Changes:
-
-	1.01	GRG 1998.12.20	 Added support for soft power switch
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 1dbf051d0897..2bd82d7c60f3 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -13,16 +13,6 @@
 
 */
 
-/* Changes:
-
-        1.01    GRG 1998.05.06 init_proto, release_proto
-			       fix chip detect
-			       added EPP-16 and EPP-32
-	1.02    GRG 1998.09.23 added hard reset to initialisation process
-	1.03    GRG 1998.12.14 made hard reset conditional
-
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index 94a3af034cae..18f3641a9a8d 100644
--- a/drivers/ata/pata_parport/kbic.c
+++ b/drivers/ata/pata_parport/kbic.c
@@ -12,12 +12,6 @@
 
 */
 
-/* Changes:
-
-        1.01    GRG 1998.05.06 init_proto, release_proto
-
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
index 540b6f842484..8e1d49914aa7 100644
--- a/drivers/ata/pata_parport/on20.c
+++ b/drivers/ata/pata_parport/on20.c
@@ -6,12 +6,6 @@
         Onspec 90c20 parallel to IDE adapter. 
 */
 
-/* Changes:
-
-        1.01    GRG 1998.05.06 init_proto, release_proto
-
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
index 4ec1091ae6a7..cea1e6311e6b 100644
--- a/drivers/ata/pata_parport/on26.c
+++ b/drivers/ata/pata_parport/on26.c
@@ -7,15 +7,6 @@
 
 */
 
-/* Changes:
-
-        1.01    GRG 1998.05.06 init_proto, release_proto
-	1.02    GRG 1998.09.23 updates for the -E rev chip
-	1.03    GRG 1998.12.14 fix for slave drives
-	1.04    GRG 1998.12.20 yet another bug fix
-
-*/
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
Ondrej Zary

