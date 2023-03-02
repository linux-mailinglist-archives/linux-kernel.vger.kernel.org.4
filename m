Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708866A8489
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCBOs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCBOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0840D498AA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDc-0003tr-Fw; Thu, 02 Mar 2023 15:47:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDb-001Lrf-Nx; Thu, 02 Mar 2023 15:47:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDa-001Zpv-L9; Thu, 02 Mar 2023 15:47:38 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/29] platform/x86: dell: dell-smo8800: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:13 +0100
Message-Id: <20230302144732.1903781-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1798; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=txLMuYR/cP10MBXXBYhoJncjcMTcRGlLrq4hOidzyFc=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALaprgeMkYzTuEyEiQoLcRYpGVSKWkuk6C5Zf EGmg4PzaBCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2qQAKCRDB/BR4rcrs CbF9B/93h3vJrbwyrN/LyZ4EIyOBZgUqoIvTcY/7dRJS/z0eobnQEmWjBppGl+0P79+VwpzyEJp 87p+mebKkXCLMzSkyIAV6Ln+S1qed/rgakfeeQO09SmO8dheo6JCuk4AKU756i57U9y/ZnobUzv r0pbEBUtblV+gasl70k/DwvYdO6EdeWuR9NA25j4eEj/i0u5W6NpBtWoUQdJo6jK0h/dXFOs9CL x6Ibi9x7nYifDtNDqdVuZqSSdtAmfRyGVW5Xd/qj1jwQKjbnVOR4ky165J79MpQWFcq123kTwqR 3kABcySlvdIz1LoK/UyC+AR6BquPZjKun+dREdYxPWCiElC9
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
 drivers/platform/x86/dell/dell-smo8800.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-smo8800.c b/drivers/platform/x86/dell/dell-smo8800.c
index 8d6b7a83cf24..f7ec17c56833 100644
--- a/drivers/platform/x86/dell/dell-smo8800.c
+++ b/drivers/platform/x86/dell/dell-smo8800.c
@@ -154,14 +154,13 @@ static int smo8800_probe(struct platform_device *device)
 	return err;
 }
 
-static int smo8800_remove(struct platform_device *device)
+static void smo8800_remove(struct platform_device *device)
 {
 	struct smo8800_device *smo8800 = platform_get_drvdata(device);
 
 	free_irq(smo8800->irq, smo8800);
 	misc_deregister(&smo8800->miscdev);
 	dev_dbg(&device->dev, "device /dev/freefall unregistered\n");
-	return 0;
 }
 
 /* NOTE: Keep this list in sync with drivers/i2c/busses/i2c-i801.c */
@@ -180,7 +179,7 @@ MODULE_DEVICE_TABLE(acpi, smo8800_ids);
 
 static struct platform_driver smo8800_driver = {
 	.probe = smo8800_probe,
-	.remove = smo8800_remove,
+	.remove_new = smo8800_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.acpi_match_table = smo8800_ids,
-- 
2.39.1

