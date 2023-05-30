Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F03E715689
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjE3HVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjE3HUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:20:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88647130
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:20:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tda-0006UU-IX; Tue, 30 May 2023 09:19:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdY-003orU-JK; Tue, 30 May 2023 09:19:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdX-009OR1-SR; Tue, 30 May 2023 09:19:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 6/6] usb: typec: qcom-pmic-typec: Convert to platform remove callback returning void
Date:   Tue, 30 May 2023 09:19:13 +0200
Message-Id: <20230530071913.2192214-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
References: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jpdI0wKAzCKfSIdoytHtaArQhcpWcjWM7rMVkKxkEf8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdaNuHZQHNrrYNxx7x6G8L2H4hx+Uadud3Tupk DLu1oU6p9qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHWjbgAKCRCPgPtYfRL+ Thh/CACxNzUceNfCaLmXLS91AoiU3oYlDx3kbimDWN849Bb81GFi0f0IPnZ0SZkflTYVYaZ8YOc PWheY7wGuat7niquEnZCtVziQm33cZ10UXgsxJgWfuVaRHsIxxVRdkmhEGG4Vmxs75xKOEwjy45 q2hzDx7jI9zIkkgZvMB8V6LzrovT728DXSgkQ4bXE9uLGxBUAdmPpd9I0J3+jOlhTSPFBys7vCB QDBhWG3gBZAxuRTGibWSsxqIG7GmsOomuR9stCwzUemKEQF1gaq7B0IXNHy9d1T2qAisdA5i0Qm +FCEz7vErMTeomPi/kvHx4pPG/8RRh/BzBGxlZQZrOBwWJjh
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index 191458ce4a06..f9e63ef35dca 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -236,7 +236,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_pmic_typec_remove(struct platform_device *pdev)
+static void qcom_pmic_typec_remove(struct platform_device *pdev)
 {
 	struct pmic_typec *tcpm = platform_get_drvdata(pdev);
 
@@ -244,8 +244,6 @@ static int qcom_pmic_typec_remove(struct platform_device *pdev)
 	qcom_pmic_typec_port_stop(tcpm->pmic_typec_port);
 	tcpm_unregister_port(tcpm->tcpm_port);
 	fwnode_remove_software_node(tcpm->tcpc.fwnode);
-
-	return 0;
 }
 
 static struct pmic_typec_pdphy_resources pm8150b_pdphy_res = {
@@ -337,7 +335,7 @@ static struct platform_driver qcom_pmic_typec_driver = {
 		.of_match_table = qcom_pmic_typec_table,
 	},
 	.probe = qcom_pmic_typec_probe,
-	.remove = qcom_pmic_typec_remove,
+	.remove_new = qcom_pmic_typec_remove,
 };
 
 module_platform_driver(qcom_pmic_typec_driver);
-- 
2.39.2

