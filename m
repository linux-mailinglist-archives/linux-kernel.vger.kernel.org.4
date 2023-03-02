Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2B86A847E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCBOsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCBOru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AA946080
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDd-0003uq-5f; Thu, 02 Mar 2023 15:47:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDc-001Lrr-AU; Thu, 02 Mar 2023 15:47:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDb-001ZqA-GP; Thu, 02 Mar 2023 15:47:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Ike Panhc <ike.pan@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/29] platform/x86: ideapad-laptop: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:17 +0100
Message-Id: <20230302144732.1903781-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1806; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pDk7jwubfCsGp7anhhTuGzgHcgasJat6lH0VGQp+ErA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALa+07KJdRSyk7nfg3tmGNvagCT7Zx6blt9rM yrKEDFTZruJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2vgAKCRDB/BR4rcrs CcFRCACclEPioKPU5ApA2tnEvuiryygWnK4+p6CHzE9W0Rov296G9pkCAcSYHNEKnNJAq33u0cH jMwJr6GJGSl3WNksR7vwutRP4E6TiCDBaTNVIMrrAMaudkVd8hHzjhWCKfYUOz2w8p7AGRy1wMR +fL1++K0uV+wNHu7eyvz/czEwiCgeBcMLACR2D1JkuzF24iKEJst9a0+E7icT6O639hZO/YBIM6 qWcHbDhvF5QXoHEnHODu6s4ohwIGomD8HxxDW+pDFTN6hHr48MRlSX93dvqU7w5egCnYMh1fWR2 WZpQmBzZxeBNnyhuNELTqGvCjmUgcT2gOSsPfaMn5CxjnSWo
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
 drivers/platform/x86/ideapad-laptop.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index 0eb5bfdd823a..b5ef3452da1f 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1921,7 +1921,7 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 	return err;
 }
 
-static int ideapad_acpi_remove(struct platform_device *pdev)
+static void ideapad_acpi_remove(struct platform_device *pdev)
 {
 	struct ideapad_private *priv = dev_get_drvdata(&pdev->dev);
 	int i;
@@ -1942,8 +1942,6 @@ static int ideapad_acpi_remove(struct platform_device *pdev)
 	ideapad_input_exit(priv);
 	ideapad_debugfs_exit(priv);
 	ideapad_sysfs_exit(priv);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1970,7 +1968,7 @@ MODULE_DEVICE_TABLE(acpi, ideapad_device_ids);
 
 static struct platform_driver ideapad_acpi_driver = {
 	.probe = ideapad_acpi_add,
-	.remove = ideapad_acpi_remove,
+	.remove_new = ideapad_acpi_remove,
 	.driver = {
 		.name   = "ideapad_acpi",
 		.pm     = &ideapad_pm,
-- 
2.39.1

