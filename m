Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062796A848C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjCBOsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCBOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A8FF96D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDf-00040h-3B; Thu, 02 Mar 2023 15:47:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDd-001LsQ-TG; Thu, 02 Mar 2023 15:47:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDd-001Zqc-1U; Thu, 02 Mar 2023 15:47:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/29] platform/x86: intel: int3472: discrete: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:24 +0100
Message-Id: <20230302144732.1903781-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UZcNHKDZjEJbsCj/ym4PGZg6gRKQSXlA+HuRGH++vF4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALbc1iljYRotrm+Rq2yhzl9a/KRtXWqcsLW3s iyn+tlGYCiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC23AAKCRDB/BR4rcrs CdnWB/99xSk8KJ5WTtdChUxqNX7Nlr9oFUYmlHtxAqOF5m1LtLOHZZ+onMuEJqdS8zDM1MX4B47 i+cokuQiYNkMmt7KhF6lFGRIEGx7cEesi8NcSvvMweGumCsnuZTaI9WyGf72j0vseoSc/RzlyR3 kEu8dtEGYy83oWsjGihFY7lkSnuUFJyxdCEsfb9Z24rwV9iYomnegHQ58HRIVOEhwYAaOJw36gN 8OjD6YVDL+NMROL6PcAaAh1QIFIgeTc9BUua98cOnfFgKV46tidNbJ2IBwvyPAvQdkxOGgAy96c GPrPj8xM1urAI9sA0SuoBf5dWx4LqS5Sb1uJzJEHOMn+bxSX
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
 drivers/platform/x86/intel/int3472/discrete.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/platform/x86/intel/int3472/discrete.c
index f064da74f50a..ef020e23e596 100644
--- a/drivers/platform/x86/intel/int3472/discrete.c
+++ b/drivers/platform/x86/intel/int3472/discrete.c
@@ -317,7 +317,7 @@ static int skl_int3472_parse_crs(struct int3472_discrete_device *int3472)
 	return 0;
 }
 
-static int skl_int3472_discrete_remove(struct platform_device *pdev)
+static void skl_int3472_discrete_remove(struct platform_device *pdev)
 {
 	struct int3472_discrete_device *int3472 = platform_get_drvdata(pdev);
 
@@ -326,8 +326,6 @@ static int skl_int3472_discrete_remove(struct platform_device *pdev)
 	skl_int3472_unregister_clock(int3472);
 	skl_int3472_unregister_pled(int3472);
 	skl_int3472_unregister_regulator(int3472);
-
-	return 0;
 }
 
 static int skl_int3472_discrete_probe(struct platform_device *pdev)
@@ -392,7 +390,7 @@ static struct platform_driver int3472_discrete = {
 		.acpi_match_table = int3472_device_id,
 	},
 	.probe = skl_int3472_discrete_probe,
-	.remove = skl_int3472_discrete_remove,
+	.remove_new = skl_int3472_discrete_remove,
 };
 module_platform_driver(int3472_discrete);
 
-- 
2.39.1

