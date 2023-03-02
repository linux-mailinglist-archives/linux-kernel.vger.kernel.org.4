Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD20A6A846E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjCBOsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCBOru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BAC4391F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDb-0003rT-72; Thu, 02 Mar 2023 15:47:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDa-001LrH-JH; Thu, 02 Mar 2023 15:47:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDZ-001ZpX-11; Thu, 02 Mar 2023 15:47:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/29] platform/x86: amd: pmc: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:07 +0100
Message-Id: <20230302144732.1903781-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=N/5HsQ5hB+LY0fL7yq3qKM6LTsVLQJmEQenXSQKhbOE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALaRyFlnNiYZtBpEr4pwKkNUqnnDW7udEIyiF a9JWVDchEuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2kQAKCRDB/BR4rcrs CfP4CACR1mYYMgYbAFfoUr3kO3mz8olRcx2Uw2iMcxDacBjm4LJdvWiY8OySjrvsIM49RCOohrf KnIIPovSEAh4hxHtGZGdX479q1S/AiKaztGLZ0QsWXcPGRkqw2ELLH4ei20WqfvNl6FlTLEWa/U O/Q+rImUgIGtPZ+TAja1MIxLBEmzLHTm/n7e09wGeT/SHzn++Q7ZZRhkDZbE6H7e45f0j1GUS7K mnW9cILhEbQeI8LXxpbRtHIjrD5/xs2eVHPmIHRyoxUr/Td8wlTT/F0jbjlqmwpGthSuPsYr8os kqnU1SW9uQ3N7FjaHzLJQiRoODJ84mmRRIu3uobnosrYYYF3
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
 drivers/platform/x86/amd/pmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index ab05b9ee6655..2f7b1267c5e4 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -1031,7 +1031,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int amd_pmc_remove(struct platform_device *pdev)
+static void amd_pmc_remove(struct platform_device *pdev)
 {
 	struct amd_pmc_dev *dev = platform_get_drvdata(pdev);
 
@@ -1041,7 +1041,6 @@ static int amd_pmc_remove(struct platform_device *pdev)
 	amd_pmc_dbgfs_unregister(dev);
 	pci_dev_put(dev->rdev);
 	mutex_destroy(&dev->lock);
-	return 0;
 }
 
 static const struct acpi_device_id amd_pmc_acpi_ids[] = {
@@ -1066,7 +1065,7 @@ static struct platform_driver amd_pmc_driver = {
 #endif
 	},
 	.probe = amd_pmc_probe,
-	.remove = amd_pmc_remove,
+	.remove_new = amd_pmc_remove,
 };
 module_platform_driver(amd_pmc_driver);
 
-- 
2.39.1

