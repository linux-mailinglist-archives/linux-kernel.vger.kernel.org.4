Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC046A8499
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCBOtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCBOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FCF44B2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDg-000465-IH; Thu, 02 Mar 2023 15:47:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDf-001Lsr-8H; Thu, 02 Mar 2023 15:47:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDd-001Zql-GN; Thu, 02 Mar 2023 15:47:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/29] platform/x86: intel: pmc: core: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:26 +0100
Message-Id: <20230302144732.1903781-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uAI4ihJxvW4g+0BlsuHpE7TOaB4sZpNOr0yzWOEQmig=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALbk0pATwQt1Fk1UTJsVrARpIaPV4Hnc20cCq vE5tCX27dGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC25AAKCRDB/BR4rcrs Cb0YB/9hCziSWMMpJxmY/mG+rWnQZ/1jcm9ipG1J8irNinnhipWult0aC+2TVkFPBWp1itAeCWn 0ajIptER5my2NjrMx4CHT8CB7ZZ2pSUHMy9TXK1ptkFTAokFJTf/tzj0YZksbbHn627ol4t1/oS Xvl2Tmsn2RU0OjWigLqZbZvBbVZBNCPpw7qLPTxov1E2maTOWtSto6e6e7grimZvpnVJZHlpGhi 2jeYaixppbyBhrgbcLorQc2XmSWQIqqF8W6xtRroj73vSggNvneMu6FaEvOUCwk/4QghcpK43i9 whtlFi1L3axIHaj2zQ192SNiYpZXe62PdDwyxgspH1MDn+Em
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
 drivers/platform/x86/intel/pmc/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 3a15d32d7644..e489d2175e42 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1149,7 +1149,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pmc_core_remove(struct platform_device *pdev)
+static void pmc_core_remove(struct platform_device *pdev)
 {
 	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
 
@@ -1157,7 +1157,6 @@ static int pmc_core_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	mutex_destroy(&pmcdev->lock);
 	iounmap(pmcdev->regbase);
-	return 0;
 }
 
 static bool warn_on_s0ix_failures;
@@ -1264,7 +1263,7 @@ static struct platform_driver pmc_core_driver = {
 		.dev_groups = pmc_dev_groups,
 	},
 	.probe = pmc_core_probe,
-	.remove = pmc_core_remove,
+	.remove_new = pmc_core_remove,
 };
 
 module_platform_driver(pmc_core_driver);
-- 
2.39.1

