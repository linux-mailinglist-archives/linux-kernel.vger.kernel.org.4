Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E7B6A848E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCBOsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjCBOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D5D126E4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDf-000456-Sz; Thu, 02 Mar 2023 15:47:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDe-001Lse-U4; Thu, 02 Mar 2023 15:47:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDd-001Zqg-9d; Thu, 02 Mar 2023 15:47:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/29] platform/x86: intel: mrfld_pwrbtn: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:25 +0100
Message-Id: <20230302144732.1903781-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OG41i3sS4T3dTQzV9HEPZLUvI3D2MnBGxhm9QPceSMg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALbg9lEKjeaVD8wtq8wL8UjqxJ46eyp20lTtD SxmsWXcMW6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC24AAKCRDB/BR4rcrs CfO/B/45kD3W0vEHIuGJdqj5KAIbCyTqJQwNCcmkpfQ2ddVpoxDCvGlVsIDKPTIlc1/f/uuxzUo hJPaNhNuZZRXrzrMV9YFpmRDCkTch8BTjxbNzvLCLlSTSamAJ6HR12FHq2MFa47d25NiSqvnGnT v/QTQ8K6JY//DpGdP8V16Aqk5X+y6DVH/NrykmbJCRre8PgQiUg9dEyOH4iOwD1mID8qDBuT9+o xkaV6NqSXmqhUVleqmOY4EKwY6aWmE17+SwfHiOURWk44d4XHAbtlpe2/Idoc97GMXaKlHr9FWm A+ulnzE5JhONxJ+5eidaNgqCnxIUCMu8Np14DYcKwK0mhoby
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
 drivers/platform/x86/intel/mrfld_pwrbtn.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/mrfld_pwrbtn.c b/drivers/platform/x86/intel/mrfld_pwrbtn.c
index d58fea51747e..549a3f586f3b 100644
--- a/drivers/platform/x86/intel/mrfld_pwrbtn.c
+++ b/drivers/platform/x86/intel/mrfld_pwrbtn.c
@@ -78,13 +78,12 @@ static int mrfld_pwrbtn_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mrfld_pwrbtn_remove(struct platform_device *pdev)
+static void mrfld_pwrbtn_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
 	dev_pm_clear_wake_irq(dev);
 	device_init_wakeup(dev, false);
-	return 0;
 }
 
 static const struct platform_device_id mrfld_pwrbtn_id_table[] = {
@@ -98,7 +97,7 @@ static struct platform_driver mrfld_pwrbtn_driver = {
 		.name	= "mrfld_bcove_pwrbtn",
 	},
 	.probe		= mrfld_pwrbtn_probe,
-	.remove		= mrfld_pwrbtn_remove,
+	.remove_new	= mrfld_pwrbtn_remove,
 	.id_table	= mrfld_pwrbtn_id_table,
 };
 module_platform_driver(mrfld_pwrbtn_driver);
-- 
2.39.1

