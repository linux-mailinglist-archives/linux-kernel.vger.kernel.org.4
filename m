Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039AA6ACB76
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCFRy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCFRyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:54:24 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FA713C794;
        Mon,  6 Mar 2023 09:53:56 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 1A6FB7A073E;
        Mon,  6 Mar 2023 18:28:30 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/18] pata_parport: remove obsolete changelogs
Date:   Mon,  6 Mar 2023 18:27:51 +0100
Message-Id: <20230306172752.7727-18-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230306172752.7727-1-linux@zary.sk>
References: <20230306172752.7727-1-linux@zary.sk>
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

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
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
index 8995a4a08b76..f0d63b8513e0 100644
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
index ecb98bf0e6de..472029a21d59 100644
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
index f0ab30fa739a..683a11131acd 100644
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
index 6e05b50c322c..0483caa80544 100644
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
index 64e45eed9588..c5af7a5fa636 100644
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
index 609614b2c69e..0315f98326f8 100644
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
index 970532619aeb..77869639773d 100644
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
index 1888e8bcb884..8883b3c509cc 100644
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
index 484b5b9d31eb..1ef8be79d793 100644
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
index 3fab7a896e79..29f4f1e14d21 100644
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
index 9cc8be9fa562..6956b91efb47 100644
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
index e37f69db5f76..1d90eb9b541e 100644
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

