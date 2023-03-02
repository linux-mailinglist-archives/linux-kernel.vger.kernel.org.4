Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EC06A848F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCBOsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCBOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29EE4C6E6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDd-0003wh-QD; Thu, 02 Mar 2023 15:47:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDd-001Ls7-5q; Thu, 02 Mar 2023 15:47:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDb-001ZqE-Or; Thu, 02 Mar 2023 15:47:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/29] platform/x86: intel: bxtwc_tmu: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:18 +0100
Message-Id: <20230302144732.1903781-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6Gq36LIAmzl6zxp6vtsQ1GkeFu+buKYvyyDT0NmxZ90=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALbDzuqo/4A3YztsyXhANHGikIWuz8ooykUIG PFylWg87X+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2wwAKCRDB/BR4rcrs CQm3B/kBtltAwWOWaz603Bb14l+iccKUyiGRQdRLfyCPKAEH77NxiN2PwwnfXlR0G+A7vhnsq9d DKJfYsdP9cXhHPHXXZQP6dS4aWHk/ygX6bG4VJC/64jKLR5l2HdhjV+Hs515kVeD8IzWKDqrx+P ndUdIBSc/dKC7LpjXofqSv7wN2Bpm8I9N3ZcBq4qDEeN38rJ0Wz26kKL97Vc6RdKLawl7kD74dq A28JQiu/6LTkysCuhW5u7qksbFnKw6jsFunb6wS+2EtkVHdGCBSUGAMT7l1L0purW2lcEsL0xC8 xiv5Jvs9u/vi5T3bpZfKp5cSPg8OeMrOVR9RawLDz6n2LN63
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
 drivers/platform/x86/intel/bxtwc_tmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/bxtwc_tmu.c b/drivers/platform/x86/intel/bxtwc_tmu.c
index 7ccf583649e6..d0e2a3c293b0 100644
--- a/drivers/platform/x86/intel/bxtwc_tmu.c
+++ b/drivers/platform/x86/intel/bxtwc_tmu.c
@@ -89,7 +89,7 @@ static int bxt_wcove_tmu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int bxt_wcove_tmu_remove(struct platform_device *pdev)
+static void bxt_wcove_tmu_remove(struct platform_device *pdev)
 {
 	struct wcove_tmu *wctmu = platform_get_drvdata(pdev);
 	unsigned int val;
@@ -101,7 +101,6 @@ static int bxt_wcove_tmu_remove(struct platform_device *pdev)
 	regmap_read(wctmu->regmap, BXTWC_MTMUIRQ_REG, &val);
 	regmap_write(wctmu->regmap, BXTWC_MTMUIRQ_REG,
 			val | BXTWC_TMU_ALRM_MASK);
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -132,7 +131,7 @@ MODULE_DEVICE_TABLE(platform, bxt_wcove_tmu_id_table);
 
 static struct platform_driver bxt_wcove_tmu_driver = {
 	.probe = bxt_wcove_tmu_probe,
-	.remove = bxt_wcove_tmu_remove,
+	.remove_new = bxt_wcove_tmu_remove,
 	.driver = {
 		.name = "bxt_wcove_tmu",
 		.pm     = &bxtwc_tmu_pm_ops,
-- 
2.39.1

