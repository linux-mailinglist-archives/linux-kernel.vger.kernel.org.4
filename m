Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB684715677
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjE3HTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjE3HTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:19:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F4990
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:19:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdZ-0006UP-0S; Tue, 30 May 2023 09:19:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdY-003orI-5S; Tue, 30 May 2023 09:19:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdW-009OQk-PA; Tue, 30 May 2023 09:19:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Subject: [PATCH v2 1/6] usb: dwc2/platform: Convert to platform remove callback returning void
Date:   Tue, 30 May 2023 09:19:08 +0200
Message-Id: <20230530071913.2192214-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
References: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ftSCFNBqW4RCJYtuDczd14yu9FrAHicQAwihlFp9aNE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdaNoOOlLGJfWGniNRqHtS99WBUZhA06l0i85g 8ZMrJVttqeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHWjaAAKCRCPgPtYfRL+ TmsqB/4x//lvQZlITmETYWDiAdUXAM3zUX2qZOfKuKKXCwKOOicz3Od20jxBOepmDkaL7wBauA8 FWz0ldEhoibRJhfkDOh+74AyBrJwR19qiaRTF/iJNLpKzNHJRKYTbpK2a0FbwYSj1Ur9eSpHxfI 6V21ATu0l5EQncpPt+z+osRIbaP2ya0/IRYv+/pQUcOFoGSFseEiIqbrUaZUjVAm6sL+5XHQS02 fgJkz0FpL/SyVEkZGcvFrpPNYYRCO9xEbDFa7Nn6NPTmMQP1aIAmKCvg+dBy+NfuyRJmEcuo+3R +jdRhFRYhRy83CPzgF6BG0OwE2NVX8rnVcp3hrSw5gJVRmOx
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart from
emitting a warning) and this typically results in resource leaks. To improve
here there is a quest to make the remove callback return void. In the first
step of this quest all drivers are converted to .remove_new() which already
returns void. Eventually after all drivers are converted, .remove_new() is
renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Acked-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/usb/dwc2/platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 5cf025511cce..0a806f80217e 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -301,7 +301,7 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
  * stops device processing. Any resources used on behalf of this device are
  * freed.
  */
-static int dwc2_driver_remove(struct platform_device *dev)
+static void dwc2_driver_remove(struct platform_device *dev)
 {
 	struct dwc2_hsotg *hsotg = platform_get_drvdata(dev);
 	struct dwc2_gregs_backup *gr;
@@ -351,8 +351,6 @@ static int dwc2_driver_remove(struct platform_device *dev)
 
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
-
-	return 0;
 }
 
 /**
@@ -756,7 +754,7 @@ static struct platform_driver dwc2_platform_driver = {
 		.pm = &dwc2_dev_pm_ops,
 	},
 	.probe = dwc2_driver_probe,
-	.remove = dwc2_driver_remove,
+	.remove_new = dwc2_driver_remove,
 	.shutdown = dwc2_driver_shutdown,
 };
 
-- 
2.39.2

