Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F6A6A8490
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjCBOsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCBOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2098755B7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDg-00047D-P2; Thu, 02 Mar 2023 15:47:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDf-001Lsy-K7; Thu, 02 Mar 2023 15:47:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDe-001ZrA-PF; Thu, 02 Mar 2023 15:47:42 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/29] platform/x86: xo1-rfkill: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:32 +0100
Message-Id: <20230302144732.1903781-30-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1613; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/cHo/OCIZQ5qmf/ucqmCGmO1pyy35MQ6zTCo8fFg0vg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALb+CScRPFDRsjjCksIWibKoudblETkcH6IrZ Xb/qz0BJV+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2/gAKCRDB/BR4rcrs CVFdB/90zGKMc6uqyCIs6l3icW8VpmwLQ0oPsoq8vzU3e8rzwoxbZmGuMlA9aeLsDqh4UivkfAq jzRjdEEYrK3z9DuxGFmpqHVgF7DZom3ovHvfEQ/ScVj8RGrWOYuOKZLg4z6tQGzfKC948MaN8VT VlUmToaVFtPkNyl4VG9F3AocSbCEmeurnTE2GtEBIdu9pGx14HkfPRhD2d395XPjujV5N0I1HBe WFxgUGcISQgdcO9A4z+DVCSnX7G1IHR+2+hd9E7eB/a4CgWo2eJTS5iWdzRgdbBeoFnN2NOsVuz Z4vusWPbWzzmmMXYf4xe1K+5KfY/vY6RFIgbj7Kxr7HWPMLx
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
 drivers/platform/x86/xo1-rfkill.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/xo1-rfkill.c b/drivers/platform/x86/xo1-rfkill.c
index cb3253c10ef3..e64d5646b4c7 100644
--- a/drivers/platform/x86/xo1-rfkill.c
+++ b/drivers/platform/x86/xo1-rfkill.c
@@ -56,12 +56,11 @@ static int xo1_rfkill_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int xo1_rfkill_remove(struct platform_device *pdev)
+static void xo1_rfkill_remove(struct platform_device *pdev)
 {
 	struct rfkill *rfk = platform_get_drvdata(pdev);
 	rfkill_unregister(rfk);
 	rfkill_destroy(rfk);
-	return 0;
 }
 
 static struct platform_driver xo1_rfkill_driver = {
@@ -69,7 +68,7 @@ static struct platform_driver xo1_rfkill_driver = {
 		.name = "xo1-rfkill",
 	},
 	.probe		= xo1_rfkill_probe,
-	.remove		= xo1_rfkill_remove,
+	.remove_new	= xo1_rfkill_remove,
 };
 
 module_platform_driver(xo1_rfkill_driver);
-- 
2.39.1

