Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FB46B6813
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCLQQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjCLQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336063754F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM2-0007sp-4V; Sun, 12 Mar 2023 17:15:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM1-003f3i-GL; Sun, 12 Mar 2023 17:15:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM0-004K9p-Ho; Sun, 12 Mar 2023 17:15:24 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/30] clk: x86: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:15:11 +0100
Message-Id: <20230312161512.2715500-30-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=q67zyHKhevN1eKgcWpbwGQPFWUk3s3NN9pb+s0sov04=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMaTw/uqwVSzYw13++7G/kdKUY+fuFzxWfdDJq8x+RSrcv zSw6AFvJ6MxCwMjF4OsmCJLXZGW2ASJNf/tSpZwwwxiZQKZwsDFKQATYb7M/ovp2ENt75Xxk3d/ sHvfmSt87N7bs6aihnoKX6cpht3WF1/p06r4TuLvwsTJ2vNvvrmkzZsvx+l+/4jJd+1g88T6R89 771Xc5075VnAj/hPfj1Mc6uoXvnOHtiosLE9o/Dd5pYndxVl1jofbFQIs083eeLxy7I2Z+t2kNs jyzVUh9T4ZVh1Z+YiNX6vPJgfvfbd+Ok/RtIxr6o8S2tY+5J4qmvmSTSSbc2rHv4AEpxOmAgwrb Bdc1mhtkrW3+R7/TNODUfnOUv4Qdkf1i2zrrQyMuG03NrXb2qtl7thSt2ZpqLPFDxnmiccPPDf8 /rxb2ECi6amlbfcSgQhHkdPP/2cfzjlx0PlvqvVUvr4QAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/x86/clk-fch.c      | 7 +++----
 drivers/clk/x86/clk-pmc-atom.c | 5 ++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
index fdc060e75839..aed7d22fae63 100644
--- a/drivers/clk/x86/clk-fch.c
+++ b/drivers/clk/x86/clk-fch.c
@@ -92,14 +92,14 @@ static int fch_clk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int fch_clk_remove(struct platform_device *pdev)
+static void fch_clk_remove(struct platform_device *pdev)
 {
 	int i, clks;
 	struct pci_dev *rdev;
 
 	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
 	if (!rdev)
-		return -ENODEV;
+		return;
 
 	clks = pci_match_id(fch_pci_ids, rdev) ? CLK_MAX_FIXED : ST_MAX_CLKS;
 
@@ -107,7 +107,6 @@ static int fch_clk_remove(struct platform_device *pdev)
 		clk_hw_unregister(hws[i]);
 
 	pci_dev_put(rdev);
-	return 0;
 }
 
 static struct platform_driver fch_clk_driver = {
@@ -116,6 +115,6 @@ static struct platform_driver fch_clk_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = fch_clk_probe,
-	.remove = fch_clk_remove,
+	.remove_new = fch_clk_remove,
 };
 builtin_platform_driver(fch_clk_driver);
diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
index e746e3f8d05a..2974dd0ec6f4 100644
--- a/drivers/clk/x86/clk-pmc-atom.c
+++ b/drivers/clk/x86/clk-pmc-atom.c
@@ -367,7 +367,7 @@ static int plt_clk_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int plt_clk_remove(struct platform_device *pdev)
+static void plt_clk_remove(struct platform_device *pdev)
 {
 	struct clk_plt_data *data;
 
@@ -377,7 +377,6 @@ static int plt_clk_remove(struct platform_device *pdev)
 	clkdev_drop(data->mclk_lookup);
 	plt_clk_unregister_loop(data, PMC_CLK_NUM);
 	plt_clk_unregister_parents(data);
-	return 0;
 }
 
 static struct platform_driver plt_clk_driver = {
@@ -385,6 +384,6 @@ static struct platform_driver plt_clk_driver = {
 		.name = "clk-pmc-atom",
 	},
 	.probe = plt_clk_probe,
-	.remove = plt_clk_remove,
+	.remove_new = plt_clk_remove,
 };
 builtin_platform_driver(plt_clk_driver);
-- 
2.39.1

