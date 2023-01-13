Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E5B66A20F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjAMS2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjAMS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:28:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB00944C56
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:24:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pGOjA-0001QR-Bg; Fri, 13 Jan 2023 19:24:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pGOj9-005pIj-NP; Fri, 13 Jan 2023 19:24:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pGOj9-00Cahx-3n; Fri, 13 Jan 2023 19:24:31 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/2] mfd: Make mfd_cell_disable() return void
Date:   Fri, 13 Jan 2023 19:24:27 +0100
Message-Id: <20230113182427.257484-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113182427.257484-1-u.kleine-koenig@pengutronix.de>
References: <20230113182427.257484-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=8+15TycfBn34R8uzROOfHpm0iFSqK9jUoxnISNz6QIM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjwaHXNn0ZTy0wkcPo4ksjjtHKP/GzwrPUyIJSATeu 5EPmEw+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY8Gh1wAKCRDB/BR4rcrsCTS8CA CIze4jRxOlIqrijYc5uV9ZoVtvzrXDa+ZfF3/18nKOWNyeYAEd/9vw0hoYDO/EdHXUa3ilx4Ihknqj kPmV/HgQRFTfVnXyxlXce8FpNuVuYJaQMTK0psQq7qjlAkWhaXSOPkeWXkGcI49k4WCqRuF6I56VuJ 4lt3i6Z8D7cOY4PH7ajpuO19M+OaiwgldQqggcuuKAMIrcFFq8BU33szE+pwlXdSMEgL7N7Pfg18xp W+IOg7KpfYpBKqZyuU5Ls0q8E9QyFGtPg4T5oCl1l3Sw8HSoZaOhXbg985H9o3whqG7AaD3l2tsem3 4ZnaOKzrPna8s+x4iG/MZhxukMhSOh
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

mfd_cell_disable() returns 0 unconditionally. Change it to return void
instead to make its usage a bit more obvious.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/leds-asic3.c |  6 ++++--
 drivers/mfd/mfd-core.c    | 12 ++++--------
 include/linux/mfd/core.h  |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/leds-asic3.c b/drivers/leds/leds-asic3.c
index 8cbc1b8bafa5..8256990394eb 100644
--- a/drivers/leds/leds-asic3.c
+++ b/drivers/leds/leds-asic3.c
@@ -117,7 +117,7 @@ static int asic3_led_probe(struct platform_device *pdev)
 	return 0;
 
 out:
-	(void) mfd_cell_disable(pdev);
+	mfd_cell_disable(pdev);
 	return ret;
 }
 
@@ -127,7 +127,9 @@ static int asic3_led_remove(struct platform_device *pdev)
 
 	led_classdev_unregister(led->cdev);
 
-	return mfd_cell_disable(pdev);
+	mfd_cell_disable(pdev);
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index b854c4adb527..33720f116b8c 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -46,18 +46,14 @@ int mfd_cell_enable(struct platform_device *pdev)
 }
 EXPORT_SYMBOL(mfd_cell_enable);
 
-int mfd_cell_disable(struct platform_device *pdev)
+void mfd_cell_disable(struct platform_device *pdev)
 {
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 
-	if (!cell->disable) {
+	if (cell->disable)
+		cell->disable(pdev);
+	else
 		dev_dbg(&pdev->dev, "No .disable() call-back registered\n");
-		return 0;
-	}
-
-	cell->disable(pdev);
-
-	return 0;
 }
 EXPORT_SYMBOL(mfd_cell_disable);
 
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 9833d0501d42..e43dc9ae2d71 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -130,7 +130,7 @@ struct mfd_cell {
  * clients are making use of it.
  */
 extern int mfd_cell_enable(struct platform_device *pdev);
-extern int mfd_cell_disable(struct platform_device *pdev);
+extern void mfd_cell_disable(struct platform_device *pdev);
 
 /*
  * Given a platform device that's been created by mfd_add_devices(), fetch
-- 
2.39.0

