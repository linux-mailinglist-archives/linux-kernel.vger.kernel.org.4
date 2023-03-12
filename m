Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06E36B6821
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjCLQQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCLQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A434C0D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM1-0007ri-1K; Sun, 12 Mar 2023 17:15:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM0-003f3H-Bo; Sun, 12 Mar 2023 17:15:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-004K9O-1e; Sun, 12 Mar 2023 17:15:23 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/30] clk: qcom: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:15:04 +0100
Message-Id: <20230312161512.2715500-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4258; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Gb1ghgWvrKiy4huMqkZkfU3Mnh39km7SHMXWnvwoFQs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfpvKyV+GkyFyEGujzmzrVJX4VHYLYmILN/Vg K+byq0Tv9CJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36bwAKCRDB/BR4rcrs CdR/CACGRL9fTmx1gCk3RFSzsSUKcKJNONCQ5RYIIJ0KbzLYi5K1HXOULpyPTO5Hkqb4liDinSw LdxWBWFNXNLikW13Q7YXRNCQ2nkV0eL1p440d2OTi2rResLm5AD3X2KHLOi6M5gmOGVimgoY4ax ZEycleh4IE15iePs6iUwi68u2Qu+TO0cjqy/i/KhaMt5dQJuez5eWU9U841mlMmA7qYo4VRrJjj arEwJtHW6+1Bz4FWThNqeYJZ3BABudTXTfMfOiXXqaMGHruNRHO89mAPXJdSttXKV6JT4bjcLuA zJY8rkg+nXoHJ7pg/7nYq8SSw5eIhuYfhlmF5ckV0B9V+jJS
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
 drivers/clk/qcom/apcs-msm8916.c | 6 ++----
 drivers/clk/qcom/apcs-sdx55.c   | 6 ++----
 drivers/clk/qcom/clk-rpm.c      | 5 ++---
 drivers/clk/qcom/gcc-msm8960.c  | 6 ++----
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
index 89e0730810ac..ce57b333ec99 100644
--- a/drivers/clk/qcom/apcs-msm8916.c
+++ b/drivers/clk/qcom/apcs-msm8916.c
@@ -119,18 +119,16 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_apcs_msm8916_clk_remove(struct platform_device *pdev)
+static void qcom_apcs_msm8916_clk_remove(struct platform_device *pdev)
 {
 	struct clk_regmap_mux_div *a53cc = platform_get_drvdata(pdev);
 
 	clk_notifier_unregister(a53cc->pclk, &a53cc->clk_nb);
-
-	return 0;
 }
 
 static struct platform_driver qcom_apcs_msm8916_clk_driver = {
 	.probe = qcom_apcs_msm8916_clk_probe,
-	.remove = qcom_apcs_msm8916_clk_remove,
+	.remove_new = qcom_apcs_msm8916_clk_remove,
 	.driver = {
 		.name = "qcom-apcs-msm8916-clk",
 	},
diff --git a/drivers/clk/qcom/apcs-sdx55.c b/drivers/clk/qcom/apcs-sdx55.c
index e599f862ec44..d644e6e1f8b7 100644
--- a/drivers/clk/qcom/apcs-sdx55.c
+++ b/drivers/clk/qcom/apcs-sdx55.c
@@ -120,20 +120,18 @@ static int qcom_apcs_sdx55_clk_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_apcs_sdx55_clk_remove(struct platform_device *pdev)
+static void qcom_apcs_sdx55_clk_remove(struct platform_device *pdev)
 {
 	struct device *cpu_dev = get_cpu_device(0);
 	struct clk_regmap_mux_div *a7cc = platform_get_drvdata(pdev);
 
 	clk_notifier_unregister(a7cc->pclk, &a7cc->clk_nb);
 	dev_pm_domain_detach(cpu_dev, true);
-
-	return 0;
 }
 
 static struct platform_driver qcom_apcs_sdx55_clk_driver = {
 	.probe = qcom_apcs_sdx55_clk_probe,
-	.remove = qcom_apcs_sdx55_clk_remove,
+	.remove_new = qcom_apcs_sdx55_clk_remove,
 	.driver = {
 		.name = "qcom-sdx55-acps-clk",
 	},
diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
index b1be5b664bf3..e723ddb99a44 100644
--- a/drivers/clk/qcom/clk-rpm.c
+++ b/drivers/clk/qcom/clk-rpm.c
@@ -591,10 +591,9 @@ static int rpm_clk_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rpm_clk_remove(struct platform_device *pdev)
+static void rpm_clk_remove(struct platform_device *pdev)
 {
 	of_clk_del_provider(pdev->dev.of_node);
-	return 0;
 }
 
 static struct platform_driver rpm_clk_driver = {
@@ -603,7 +602,7 @@ static struct platform_driver rpm_clk_driver = {
 		.of_match_table = rpm_clk_match_table,
 	},
 	.probe = rpm_clk_probe,
-	.remove = rpm_clk_remove,
+	.remove_new = rpm_clk_remove,
 };
 
 static int __init rpm_clk_init(void)
diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index 9dd4e7ffa1f8..dbc7093ab9cc 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -3754,19 +3754,17 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int gcc_msm8960_remove(struct platform_device *pdev)
+static void gcc_msm8960_remove(struct platform_device *pdev)
 {
 	struct platform_device *tsens = platform_get_drvdata(pdev);
 
 	if (tsens)
 		platform_device_unregister(tsens);
-
-	return 0;
 }
 
 static struct platform_driver gcc_msm8960_driver = {
 	.probe		= gcc_msm8960_probe,
-	.remove		= gcc_msm8960_remove,
+	.remove_new	= gcc_msm8960_remove,
 	.driver		= {
 		.name	= "gcc-msm8960",
 		.of_match_table = gcc_msm8960_match_table,
-- 
2.39.1

