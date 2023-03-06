Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8046AB725
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCFHfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCFHfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:35:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1A2E388
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:34:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ5N2-0008Ou-ND; Mon, 06 Mar 2023 08:34:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ5N1-002C0t-Sx; Mon, 06 Mar 2023 08:34:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ5N1-002bas-4i; Mon, 06 Mar 2023 08:34:55 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 2/3] spmi: mtk-pmif: Convert to platform remove callback returning void
Date:   Mon,  6 Mar 2023 08:34:45 +0100
Message-Id: <20230306073446.2194048-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306073446.2194048-1-u.kleine-koenig@pengutronix.de>
References: <20230306073446.2194048-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5a+AWwYSnblGSgN1CjlLhD5ySXt5UsbCdNXjzOaMDCo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBZeNw+Op0YHpL7jeNZglJdgk4+HUUAM9Syky4 ZopRHF9SD6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAWXjQAKCRDB/BR4rcrs CRFuB/4rWilHuRqmsO6Tvne6ucKbjyP6e/oEpCNTWXJi4wAQWy/PA01KR1+U4isqwbFlNKhj7MA 6ZzMRG7JvPk4LMS2YiKoyNCMTsBpibuaptG5ltsCFYUQ+/3PMyp7E9Kcgpec516fuIzGQFHEfRK D+pFr7HQCuxvrtD/bq/M72MaWx3efZecUWPJPYKYSJnoBAuN5hrdJtme7HPk2F6+jZcTIysvkh1 P7gklleW9mNP1MRoeLgwiR4D246K8biZWLVsck6rihhzWDwyqWHpH6Jvsmk7TNtVcPPM6BBNzKm RQcw6r/w9FU222K3hwnXdWfUtd618Wppjt7aJInqUfWyDP45
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
 drivers/spmi/spmi-mtk-pmif.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index ad511f2c3324..fbcb3921e70c 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -503,7 +503,7 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mtk_spmi_remove(struct platform_device *pdev)
+static void mtk_spmi_remove(struct platform_device *pdev)
 {
 	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
 	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
@@ -511,7 +511,6 @@ static int mtk_spmi_remove(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
 	spmi_controller_remove(ctrl);
 	spmi_controller_put(ctrl);
-	return 0;
 }
 
 static const struct of_device_id mtk_spmi_match_table[] = {
@@ -533,7 +532,7 @@ static struct platform_driver mtk_spmi_driver = {
 		.of_match_table = of_match_ptr(mtk_spmi_match_table),
 	},
 	.probe		= mtk_spmi_probe,
-	.remove		= mtk_spmi_remove,
+	.remove_new	= mtk_spmi_remove,
 };
 module_platform_driver(mtk_spmi_driver);
 
-- 
2.39.1

