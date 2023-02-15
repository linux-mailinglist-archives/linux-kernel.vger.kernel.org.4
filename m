Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C886984E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 20:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBOTrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 14:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBOTq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 14:46:26 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9A37410A3;
        Wed, 15 Feb 2023 11:46:16 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id E7F947A071E;
        Wed, 15 Feb 2023 20:46:05 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/18] pata_parport: remove verbose parameter from test_proto()
Date:   Wed, 15 Feb 2023 20:45:51 +0100
Message-Id: <20230215194554.25632-16-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230215194554.25632-1-linux@zary.sk>
References: <20230215194554.25632-1-linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

verbose parameter of test_proto() is now unused, remove it.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/bpck.c         | 2 +-
 drivers/ata/pata_parport/epat.c         | 2 +-
 drivers/ata/pata_parport/epia.c         | 2 +-
 drivers/ata/pata_parport/friq.c         | 2 +-
 drivers/ata/pata_parport/frpw.c         | 2 +-
 drivers/ata/pata_parport/pata_parport.c | 2 +-
 include/linux/pata_parport.h            | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
index 793ef2c7849e..2072e291fd16 100644
--- a/drivers/ata/pata_parport/bpck.c
+++ b/drivers/ata/pata_parport/bpck.c
@@ -274,7 +274,7 @@ static void bpck_force_spp(struct pi_adapter *pi)
 
 #define TEST_LEN  16
 
-static int bpck_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
+static int bpck_test_proto(struct pi_adapter *pi, char *scratch)
 
 {	int i, e, l, h, om;
 	char buf[TEST_LEN];
diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
index da63fe3b7182..da3398941f81 100644
--- a/drivers/ata/pata_parport/epat.c
+++ b/drivers/ata/pata_parport/epat.c
@@ -246,7 +246,7 @@ static void epat_disconnect(struct pi_adapter *pi)
 	w2(pi->saved_r2);
 }
 
-static int epat_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
+static int epat_test_proto(struct pi_adapter *pi, char *scratch)
 
 {       int     k, j, f, cc;
 	int	e[2] = {0,0};
diff --git a/drivers/ata/pata_parport/epia.c b/drivers/ata/pata_parport/epia.c
index 778ebd033ff9..a83685ed9dde 100644
--- a/drivers/ata/pata_parport/epia.c
+++ b/drivers/ata/pata_parport/epia.c
@@ -232,7 +232,7 @@ static void epia_write_block(struct pi_adapter *pi, char *buf, int count)
 
 }
 
-static int epia_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
+static int epia_test_proto(struct pi_adapter *pi, char *scratch)
 
 {       int     j, k, f;
 	int	e[2] = {0,0};
diff --git a/drivers/ata/pata_parport/friq.c b/drivers/ata/pata_parport/friq.c
index 422146f614d6..7ace1f7eea34 100644
--- a/drivers/ata/pata_parport/friq.c
+++ b/drivers/ata/pata_parport/friq.c
@@ -178,7 +178,7 @@ static void friq_disconnect(struct pi_adapter *pi)
         w2(pi->saved_r2);
 } 
 
-static int friq_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
+static int friq_test_proto(struct pi_adapter *pi, char *scratch)
 
 {       int     j, k, r;
 	int	e[2] = {0,0};
diff --git a/drivers/ata/pata_parport/frpw.c b/drivers/ata/pata_parport/frpw.c
index 068db960861e..d04a11889066 100644
--- a/drivers/ata/pata_parport/frpw.c
+++ b/drivers/ata/pata_parport/frpw.c
@@ -219,7 +219,7 @@ static int frpw_test_pnp(struct pi_adapter *pi)
    a hack :-(
 */
 
-static int frpw_test_proto(struct pi_adapter *pi, char *scratch, int verbose)
+static int frpw_test_proto(struct pi_adapter *pi, char *scratch)
 
 {       int     j, k, r;
 	int	e[2] = {0,0};
diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index f42a2cafc382..27aa2419af02 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -306,7 +306,7 @@ static int pi_test_proto(struct pi_adapter *pi, char *scratch)
 
 	parport_claim_or_block(pi->pardev);
 	if (pi->proto->test_proto)
-		res = pi->proto->test_proto(pi, scratch, 1);
+		res = pi->proto->test_proto(pi, scratch);
 	else
 		res = default_test_proto(pi, scratch);
 	parport_release(pi->pardev);
diff --git a/include/linux/pata_parport.h b/include/linux/pata_parport.h
index c44d30b3e886..e45bb1896003 100644
--- a/include/linux/pata_parport.h
+++ b/include/linux/pata_parport.h
@@ -67,7 +67,7 @@ struct pi_protocol {
 
 	int (*test_port)(struct pi_adapter *pi);
 	int (*probe_unit)(struct pi_adapter *pi);
-	int (*test_proto)(struct pi_adapter *pi, char *scratch, int verbose);
+	int (*test_proto)(struct pi_adapter *pi, char *scratch);
 	void (*log_adapter)(struct pi_adapter *pi);
 
 	int (*init_proto)(struct pi_adapter *pi);
-- 
Ondrej Zary

