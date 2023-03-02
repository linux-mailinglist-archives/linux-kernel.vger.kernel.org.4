Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C24B6A8495
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCBOtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjCBOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF81C40FC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDd-0003tO-Hb; Thu, 02 Mar 2023 15:47:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDb-001LrZ-Gp; Thu, 02 Mar 2023 15:47:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDa-001Zq0-Rm; Thu, 02 Mar 2023 15:47:38 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Eric Piel <eric.piel@tremplin-utc.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/29] platform/x86: hp: hp_accel: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:14 +0100
Message-Id: <20230302144732.1903781-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=X9kQ4rbY4lv4/tckzYkf30KKQ7sZ/1lbGj8mnGbM7BA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALatDr6PLBGpno5AQOIzDvVee/jz9769sMvCp 96IWli4YEeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2rQAKCRDB/BR4rcrs CWAzB/9Tpizdmk32o5fGzhOLxHYbu8RR4wu8CswSQQC6tgaHZpJlXSNaJjOa6x7n4njopchTN8k IZ81sbLnXgTRKCQwzfiinGLyZiiHSuS9hpOokK+0NK55bLZ6qZRBZgFlnsuk5B3oH8WRSgiySnn 9sPzFOWlSnZWrATXrEU+cbeNcl0NByUB/jEngUtbftSY4ylOkWHLW7bnCFiXTt7VoIy77mcBed2 W7/p/2JDmk2X1DEkLfE1xho9s/ge7HHZ8geG7EM23GKChy20CxCJrqsC0ZHk6xAKz9MHKpTXMKe wGBPPIHbvFK2RilOacd1CZeuZ5kHSobmxBYqMwPpj3K1ItlI
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
 drivers/platform/x86/hp/hp_accel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp_accel.c b/drivers/platform/x86/hp/hp_accel.c
index 6477591747cf..52535576772a 100644
--- a/drivers/platform/x86/hp/hp_accel.c
+++ b/drivers/platform/x86/hp/hp_accel.c
@@ -342,7 +342,7 @@ static int lis3lv02d_probe(struct platform_device *device)
 	return ret;
 }
 
-static int lis3lv02d_remove(struct platform_device *device)
+static void lis3lv02d_remove(struct platform_device *device)
 {
 	i8042_remove_filter(hp_accel_i8042_filter);
 	lis3lv02d_joystick_disable(&lis3_dev);
@@ -352,7 +352,6 @@ static int lis3lv02d_remove(struct platform_device *device)
 	flush_work(&hpled_led.work);
 
 	lis3lv02d_remove_fs(&lis3_dev);
-	return 0;
 }
 
 static int __maybe_unused lis3lv02d_suspend(struct device *dev)
@@ -373,7 +372,7 @@ static SIMPLE_DEV_PM_OPS(hp_accel_pm, lis3lv02d_suspend, lis3lv02d_resume);
 /* For the HP MDPS aka 3D Driveguard */
 static struct platform_driver lis3lv02d_driver = {
 	.probe	= lis3lv02d_probe,
-	.remove	= lis3lv02d_remove,
+	.remove_new = lis3lv02d_remove,
 	.driver	= {
 		.name	= "hp_accel",
 		.pm	= &hp_accel_pm,
-- 
2.39.1

