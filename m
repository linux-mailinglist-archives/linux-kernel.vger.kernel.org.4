Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D96B708C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCMH5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCMH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:56:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2629826C2D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:54:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0x-0001j9-9v; Mon, 13 Mar 2023 08:54:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0v-003nag-Vy; Mon, 13 Mar 2023 08:54:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0v-004TOd-2l; Mon, 13 Mar 2023 08:54:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] clocksource: timer-stm32-lp: Mark driver as non-removable
Date:   Mon, 13 Mar 2023 08:54:27 +0100
Message-Id: <20230313075430.2730803-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
References: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=1luB8f8PtkOpiikyFH9Ccwu5voPX5s7Env0wEM4st1Q=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDtapEmix1GST9R/1wht2UbNbrXGI69ZtbBJbq V9jmYN/gUyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA7WqQAKCRDB/BR4rcrs CV9RB/4oYsjBQdpRw13S9H4gWYZjxGBXoOYAtrllTOalI8CmLFSgeICD0BZWUgRNA63uoHiT62p OXpp7ZnYi7V2s5aJbgfPy9HX2Bx5szg/vM+G5b+JEjcIL0Gl9o2DDcD5ooNsCpbcdpLXq1uMVkD WTKx12w4o8TyIq3+2nzDzMtC2Kdg38ZLpSg/reKLE3m+NSm3jikgbx7PuMmj0BpnWcWMUx9LXAi g7hx+V9PbwNAd4ainqYlIvM+WNnJ6dw3YJHHWxL6wMFjFerSRfZUQL87eI0DnT5bYglDystMsjw 9TbSe9/OXtZqT0463PvbnLTCoOHKzUJfIi9mZIxyRbAQ4MTH
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in the remove callback suggests that the driver is not
supposed to be unbound. However returning an error code in the remove
callback doesn't accomplish that. Instead set the suppress_bind_attrs
property (which makes it impossible to unbind the driver via sysfs).
The only remaining way to unbind an stm32-lp device would be module
unloading, but that doesn't apply here, as the driver cannot be built as
a module.

Also drop the useless remove callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/timer-stm32-lp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index db2841d0beb8..616ea4fe4234 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -195,11 +195,6 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int stm32_clkevent_lp_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent */
-}
-
 static const struct of_device_id stm32_clkevent_lp_of_match[] = {
 	{ .compatible = "st,stm32-lptimer-timer", },
 	{},
@@ -207,11 +202,11 @@ static const struct of_device_id stm32_clkevent_lp_of_match[] = {
 MODULE_DEVICE_TABLE(of, stm32_clkevent_lp_of_match);
 
 static struct platform_driver stm32_clkevent_lp_driver = {
-	.probe	= stm32_clkevent_lp_probe,
 	.remove = stm32_clkevent_lp_remove,
 	.driver	= {
 		.name = "stm32-lptimer-timer",
 		.of_match_table = of_match_ptr(stm32_clkevent_lp_of_match),
+		.suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(stm32_clkevent_lp_driver);
-- 
2.39.1

