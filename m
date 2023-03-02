Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B216A849B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCBOtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCBOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B104C423B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDe-0003wI-Fi; Thu, 02 Mar 2023 15:47:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDc-001Ls1-QW; Thu, 02 Mar 2023 15:47:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDc-001ZqN-5d; Thu, 02 Mar 2023 15:47:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/29] platform/x86: intel: chtwc_int33fe: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:20 +0100
Message-Id: <20230302144732.1903781-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=QVO6dKKemFdskHjiF8vZD9pCO2k/PVTJ/KaR9VN2t/A=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALbM3iGaNjk9rUPjk1X1CVhZ/lW1RT7BMjzm4 WS+CUGLvRiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2zAAKCRDB/BR4rcrs CdyIB/98Uza7jBnNrGDjo63pDRiw1Bc222LHFRiCTGDDT0Wh/OntnnUftyaWqIQfFJsOxTc25tU K22JLqgJChyTGgjUCj4UOUxsl8OMfe8unXibaATEUHv/d2Y0o4CWxpTiVP2Xu3KfTyNUITkuGHq 8nl7AB/5lD45Fu2cZ4CsFEauvxsaZJKd4szFnmuYHmS9WinC5liaqyNq9WrEwllFqewKaq32fiO QFB7O0AmyTIAhITjl/i1caMfZwEJIwTfn+d5x4xzLQvcTLn3WOFXzAE+1aIElQGGDtZP4lkm1AO qsuksMER3UeqWLX1v1yRPImOMS0d6g0doEOuCO8iJ9CA4SQs
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
 drivers/platform/x86/intel/chtwc_int33fe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platform/x86/intel/chtwc_int33fe.c
index 2c9a7d52be07..848baecc1bb0 100644
--- a/drivers/platform/x86/intel/chtwc_int33fe.c
+++ b/drivers/platform/x86/intel/chtwc_int33fe.c
@@ -405,7 +405,7 @@ static int cht_int33fe_typec_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int cht_int33fe_typec_remove(struct platform_device *pdev)
+static void cht_int33fe_typec_remove(struct platform_device *pdev)
 {
 	struct cht_int33fe_data *data = platform_get_drvdata(pdev);
 
@@ -414,8 +414,6 @@ static int cht_int33fe_typec_remove(struct platform_device *pdev)
 	i2c_unregister_device(data->battery_fg);
 
 	cht_int33fe_remove_nodes(data);
-
-	return 0;
 }
 
 static const struct acpi_device_id cht_int33fe_acpi_ids[] = {
@@ -429,7 +427,7 @@ static struct platform_driver cht_int33fe_typec_driver = {
 		.acpi_match_table = ACPI_PTR(cht_int33fe_acpi_ids),
 	},
 	.probe = cht_int33fe_typec_probe,
-	.remove = cht_int33fe_typec_remove,
+	.remove_new = cht_int33fe_typec_remove,
 };
 
 module_platform_driver(cht_int33fe_typec_driver);
-- 
2.39.1

