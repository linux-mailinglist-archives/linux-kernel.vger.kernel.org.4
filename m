Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB456B708B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCMH4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCMH4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:56:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D33024BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:54:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0w-0001j7-E3; Mon, 13 Mar 2023 08:54:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0v-003nab-IO; Mon, 13 Mar 2023 08:54:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0u-004TOa-TW; Mon, 13 Mar 2023 08:54:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] clocksource: sh_mtu2: Mark driver as non-removable
Date:   Mon, 13 Mar 2023 08:54:26 +0100
Message-Id: <20230313075430.2730803-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
References: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jqp6GOMjSpdCmxIeDGA+mPUOdQcsY6oyMOjjcWRDVUc=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDtamyYLCZb7RA67Pd0H1tRCDLB8Z9mshljoqR fIrbRirSreJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA7WpgAKCRDB/BR4rcrs CeirB/9d9M2QhXLH2MlvVnu6W3F8eUc5j9eAVNlOVHW5GUYGTTdANh5pqKxOBhEHx8KKIeLBTEB XpesoDuc3EJ0TqhsC9VQfsiPBNXUOVL8idLaMVCirR/fq1ROX6LRdQdXbtoGfDl5Mjz8RO/A9OL FbckDAI6HY7PCod4ycEW4C9lFycNfGAxQK+mk4RlhEWI0OJFn9Xqa2qLHv0J6YfEsn4qiCyZvUs Z3KwDmeQR4/mcVSA4svEkEGOhoddqnaj4cvqr4zJmrBqA4tBDFJInwklrH3E5fcY2VPpFA6n6Uq 5ucUyd/8ybZiuTQok+YBLfA8HSpNPb00gk8Ik1pS6tKIg4w0
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
The only remaining way to unbind a sh_tmu2 device would be module
unloading, but that doesn't apply here, as the driver cannot be built as
a module.

Also drop the useless remove callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/sh_mtu2.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 169a1fccc497..6bd2d0299397 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -484,11 +484,6 @@ static int sh_mtu2_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sh_mtu2_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent */
-}
-
 static const struct platform_device_id sh_mtu2_id_table[] = {
 	{ "sh-mtu2", 0 },
 	{ },
@@ -503,10 +498,10 @@ MODULE_DEVICE_TABLE(of, sh_mtu2_of_table);
 
 static struct platform_driver sh_mtu2_device_driver = {
 	.probe		= sh_mtu2_probe,
-	.remove		= sh_mtu2_remove,
 	.driver		= {
 		.name	= "sh_mtu2",
 		.of_match_table = of_match_ptr(sh_mtu2_of_table),
+		.suppress_bind_attrs = true,
 	},
 	.id_table	= sh_mtu2_id_table,
 };
-- 
2.39.1

