Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DB16ACC73
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCFSYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCFSYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:24:16 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6EEA1FE9;
        Mon,  6 Mar 2023 10:23:58 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 373BA7A06F6;
        Mon,  6 Mar 2023 18:28:29 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/18] pata_parport: remove verbose parameter from log_adapter()
Date:   Mon,  6 Mar 2023 18:27:43 +0100
Message-Id: <20230306172752.7727-10-linux@zary.sk>
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

verbose parameter of log_adapter() is unused, remove it.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/aten.c         |  2 +-
 drivers/ata/pata_parport/bpck.c         |  4 +---
 drivers/ata/pata_parport/bpck6.c        |  2 +-
 drivers/ata/pata_parport/comm.c         |  2 +-
 drivers/ata/pata_parport/dstr.c         |  2 +-
 drivers/ata/pata_parport/epat.c         |  2 +-
 drivers/ata/pata_parport/epia.c         |  2 +-
 drivers/ata/pata_parport/fit2.c         |  2 +-
 drivers/ata/pata_parport/fit3.c         |  2 +-
 drivers/ata/pata_parport/friq.c         |  2 +-
 drivers/ata/pata_parport/frpw.c         |  2 +-
 drivers/ata/pata_parport/kbic.c         | 15 +++++++--------
 drivers/ata/pata_parport/ktti.c         |  2 +-
 drivers/ata/pata_parport/on20.c         |  2 +-
 drivers/ata/pata_parport/on26.c         |  2 +-
 drivers/ata/pata_parport/pata_parport.c |  2 +-
 include/linux/pata_parport.h            |  2 +-
 17 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/ata/pata_parport/aten.c b/drivers/ata/pata_parport/aten.c
index 4579e554fbad..0a98954f380f 100644
--- a/drivers/ata/pata_parport/aten.c
+++ b/drivers/ata/pata_parport/aten.c
@@ -120,7 +120,7 @@ static void aten_disconnect(struct pi_adapter *pi)
         w2(pi->saved_r2);
 } 
 
-static void aten_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void aten_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {       char    *mode_string[2] = {"4-bit","8-bit"};
 
diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index 46805c584730..1a3e3d5b1b25 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -416,7 +416,7 @@ static int bpck_test_port(struct pi_adapter *pi)	/* check for 8-bit port */
 	return 5;
 }
 
-static void bpck_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void bpck_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {	char	*mode_string[5] = { "4-bit","8-bit","EPP-8",
 				    "EPP-16","EPP-32" };
@@ -428,13 +428,11 @@ static void bpck_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
 	bpck_read_eeprom(pi,scratch);
 
 #ifdef DUMP_EEPROM
-	if (verbose) {
 	   for(i=0;i<128;i++)
 		if ((scratch[i] < ' ') || (scratch[i] > '~'))
 		    scratch[i] = '.';
 	   printk("bpck EEPROM: %64.64s\n", scratch);
 	   printk("             %64.64s\n", &scratch[64]);
-	}
 #endif
 
 	printk("bpck %s, backpack %8.8s unit %d",
diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
index 8ed3cf3b627e..68f7fdcab9be 100644
--- a/drivers/ata/pata_parport/bpck6.c
+++ b/drivers/ata/pata_parport/bpck6.c
@@ -195,7 +195,7 @@ static int bpck6_probe_unit(struct pi_adapter *pi)
   	}
 }
 
-static void bpck6_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void bpck6_log_adapter(struct pi_adapter *pi, char *scratch)
 {
 	char *mode_string[5]=
 		{"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/comm.c b/drivers/ata/pata_parport/comm.c
index 06c6fa29295b..69a66658aa29 100644
--- a/drivers/ata/pata_parport/comm.c
+++ b/drivers/ata/pata_parport/comm.c
@@ -179,7 +179,7 @@ static void comm_write_block(struct pi_adapter *pi, char *buf, int count)
         }
 }
 
-static void comm_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void comm_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8","EPP-16","EPP-32"};
 
diff --git a/drivers/ata/pata_parport/dstr.c b/drivers/ata/pata_parport/dstr.c
index 8cac71eb9c03..17b1a7cb0a15 100644
--- a/drivers/ata/pata_parport/dstr.c
+++ b/drivers/ata/pata_parport/dstr.c
@@ -190,7 +190,7 @@ static void dstr_write_block(struct pi_adapter *pi, char *buf, int count)
 }
 
 
-static void dstr_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void dstr_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index 9276dcb261d8..b125df16f160 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -287,7 +287,7 @@ static int epat_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
         return (e[0] && e[1]) || f;
 }
 
-static void epat_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void epat_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {	int	ver;
         char    *mode_string[6] = 
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index 85b1aba995e1..452d3a8e17af 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -272,7 +272,7 @@ static int epia_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 }
 
 
-static void epia_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void epia_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/fit2.c b/drivers/ata/pata_parport/fit2.c
index 67e095d6a718..632c51af84d7 100644
--- a/drivers/ata/pata_parport/fit2.c
+++ b/drivers/ata/pata_parport/fit2.c
@@ -113,7 +113,7 @@ static void fit2_disconnect(struct pi_adapter *pi)
         w2(pi->saved_r2);
 } 
 
-static void fit2_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void fit2_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {
 	printk("fit2 %s, FIT 2000 adapter at 0x%x, delay %d\n",
diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
index 01e862a94b96..bdf90cb536c2 100644
--- a/drivers/ata/pata_parport/fit3.c
+++ b/drivers/ata/pata_parport/fit3.c
@@ -169,7 +169,7 @@ static void fit3_disconnect(struct pi_adapter *pi)
         w2(pi->saved_r2);
 } 
 
-static void fit3_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void fit3_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {       char    *mode_string[3] = {"4-bit","8-bit","EPP"};
 
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index 9f8f4e6b1a7c..ee922b40bc95 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -216,7 +216,7 @@ static int friq_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 }
 
 
-static void friq_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void friq_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {       char    *mode_string[6] = {"4-bit","8-bit",
 				   "EPP-8","EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index e93570190dab..f17e0a4f66c2 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -267,7 +267,7 @@ static int frpw_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
 }
 
 
-static void frpw_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void frpw_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {       char    *mode_string[6] = {"4-bit","8-bit","EPP",
 				   "EPP-8","EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/kbic.c b/drivers/ata/pata_parport/kbic.c
index fffb79054144..3718441f60aa 100644
--- a/drivers/ata/pata_parport/kbic.c
+++ b/drivers/ata/pata_parport/kbic.c
@@ -229,8 +229,7 @@ static void kbic_write_block(struct pi_adapter *pi, char *buf, int count)
 
 }
 
-static void kbic_log_adapter(struct pi_adapter *pi, char *scratch,
-			      int verbose, char *chip)
+static void kbic_log_adapter(struct pi_adapter *pi, char *scratch, char *chip)
 
 {       char    *mode_string[6] = {"4-bit","5/3","8-bit",
 				   "EPP-8","EPP_16","EPP-32"};
@@ -241,14 +240,14 @@ static void kbic_log_adapter(struct pi_adapter *pi, char *scratch,
 
 }
 
-static void k951_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
-
-{	kbic_log_adapter(pi,scratch,verbose,"KBIC-951A");
+static void k951_log_adapter(struct pi_adapter *pi, char *scratch)
+{
+	kbic_log_adapter(pi, scratch, "KBIC-951A");
 }
 
-static void k971_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
-
-{       kbic_log_adapter(pi,scratch,verbose,"KBIC-971A");
+static void k971_log_adapter(struct pi_adapter *pi, char *scratch)
+{
+	kbic_log_adapter(pi, scratch, "KBIC-971A");
 }
 
 static struct pi_protocol k951 = {
diff --git a/drivers/ata/pata_parport/ktti.c b/drivers/ata/pata_parport/ktti.c
index ffb2af0ce045..ad7f0314f962 100644
--- a/drivers/ata/pata_parport/ktti.c
+++ b/drivers/ata/pata_parport/ktti.c
@@ -90,7 +90,7 @@ static void ktti_disconnect(struct pi_adapter *pi)
         w2(pi->saved_r2);
 } 
 
-static void ktti_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void ktti_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {
 	printk("ktti %s, KT adapter at 0x%x, delay %d\n",
diff --git a/drivers/ata/pata_parport/on20.c b/drivers/ata/pata_parport/on20.c
index fb3399329fb6..12a423f61996 100644
--- a/drivers/ata/pata_parport/on20.c
+++ b/drivers/ata/pata_parport/on20.c
@@ -111,7 +111,7 @@ static void on20_write_block(struct pi_adapter *pi, char *buf, int count)
 	w2(4);
 }
 
-static void on20_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void on20_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {       char    *mode_string[2] = {"4-bit","8-bit"};
 
diff --git a/drivers/ata/pata_parport/on26.c b/drivers/ata/pata_parport/on26.c
index 7e5fc499fcc5..ee5a0cc74900 100644
--- a/drivers/ata/pata_parport/on26.c
+++ b/drivers/ata/pata_parport/on26.c
@@ -275,7 +275,7 @@ static void on26_write_block(struct pi_adapter *pi, char *buf, int count)
 
 }
 
-static void on26_log_adapter(struct pi_adapter *pi, char *scratch, int verbose)
+static void on26_log_adapter(struct pi_adapter *pi, char *scratch)
 
 {       char    *mode_string[5] = {"4-bit","8-bit","EPP-8",
 				   "EPP-16","EPP-32"};
diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 49e99c9465fd..5aa0f05590fb 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -474,7 +474,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 		goto out_unreg_parport;
 	}
 
-	pi->proto->log_adapter(pi, scratch, 1);
+	pi->proto->log_adapter(pi, scratch);
 
 	host = ata_host_alloc_pinfo(&pi->pardev->dev, ppi, 1);
 	if (!host)
diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
index 381b4d0e3574..033cabede51c 100644
--- a/include/linux/pata_parport.h
+++ b/include/linux/pata_parport.h
@@ -68,7 +68,7 @@ struct pi_protocol {
 	int (*test_port)(struct pi_adapter *pi);
 	int (*probe_unit)(struct pi_adapter *pi);
 	int (*test_proto)(struct pi_adapter *pi, char *scratch, int verbose);
-	void (*log_adapter)(struct pi_adapter *pi, char *scratch, int verbose);
+	void (*log_adapter)(struct pi_adapter *pi, char *scratch);
 
 	int (*init_proto)(struct pi_adapter *pi);
 	void (*release_proto)(struct pi_adapter *pi);
-- 
Ondrej Zary

