Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3060364A9A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiLLVoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiLLVoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:44:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDE0186FE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:44:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4qad-0008FE-GY; Mon, 12 Dec 2022 22:43:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4qab-0046cQ-Lm; Mon, 12 Dec 2022 22:43:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4qab-004bJI-Lk; Mon, 12 Dec 2022 22:43:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] mfd: twl4030-power: Drop empty platform remove function
Date:   Mon, 12 Dec 2022 22:43:52 +0100
Message-Id: <20221212214352.3776110-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BzmOHIPwX22OuQ0j7QceFIwmWa5znnV1hu65LFP3ox8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjl6CU7iVyCxC00llipkoCqDHfxObd2aeCr4wzYNnN S3SyVyOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY5eglAAKCRDB/BR4rcrsCQw1B/ 4iJxyAr7se/ctq384UOztRz2h46yEE/E2oujGbtCZEKWJ56kh0POCPpF2c5rUO2QLx2P4ksU9II+BN PKCxJ4mUQ56FwiCHRIyU4Rz5nmyjgMrFum/fET93OhsFfynqlfEQqYPcIOvI/EP2do2ISu1ePybcB6 xD9Uob6ulDQLB8Rglmx4uDxcuAkj6YIyAO0dqglYHG33VtwJkmFah04Ju+iPeoocW38fgBvuxac1BJ 7ZF8hrXULDPYYWVIZnDMTS1/gdV1kh6xoJlgwJ574JOtonlr44jqdoDiyakY7nxma8Q2UK9mM3pKrp H+q6eLs4eFWs1sLkNCRYkXRWzAM/bL
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A remove callback just returning 0 is equivalent to no remove callback
at all. So drop the useless function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/twl4030-power.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 6b36932263ba..e35b0f788c50 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -953,18 +953,12 @@ static int twl4030_power_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int twl4030_power_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver twl4030_power_driver = {
 	.driver = {
 		.name	= "twl4030_power",
 		.of_match_table = of_match_ptr(twl4030_power_of_match),
 	},
 	.probe		= twl4030_power_probe,
-	.remove		= twl4030_power_remove,
 };
 
 module_platform_driver(twl4030_power_driver);

base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
-- 
2.38.1

