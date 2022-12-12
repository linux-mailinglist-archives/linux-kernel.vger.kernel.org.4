Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D334164AA30
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiLLW0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiLLWZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:25:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC521AD87
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:25:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4rFA-0004ep-8k; Mon, 12 Dec 2022 23:25:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4rF8-00477I-Rm; Mon, 12 Dec 2022 23:25:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4rF8-004bof-Ty; Mon, 12 Dec 2022 23:25:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 3/3] soc: tegra: cbb: Drop empty platform remove function
Date:   Mon, 12 Dec 2022 23:25:49 +0100
Message-Id: <20221212222549.3779846-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de>
References: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=y71smcDSlNK7gPTiR3iEOCLuDBdlfbnrdjyqfWwTI/o=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjl6pnz3ifx3C0R/Ble0taw1B/viUTPgVfHgrbpybV HXHTJ6+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY5eqZwAKCRDB/BR4rcrsCS0sB/ 9St3UDbCfHoLl3o6HI9IQQTovtNGpnBJ3vFhjuU8asQevIAjnbA090XdVSmEDwQbp5NRhN7ThDqUqS +S9SpWIH5Xb6tI0n+zIkOuSaqGvaMRczT5eJZMLY+mqGUv4+S8dnvEuH5zJE9JAndy926kkxG8tiKS BDPdfabKFu3ZPmQLU/lh6mr5w+gltTMR8UZQTT8rydbT1VnYdn8hoepi75zr+oqLE0cF4vctSsm62j fR7l1jEFnzmKf6JUm+1LhvNLYvriSKkZYORCkrEB5SqERPMwd0PJ3EB8c1ZUGEGVtxaul18XlQB+v3 YXg+gDTDzHWR7NREjm048z4YsI2gsg
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A remove callback just returning 0 is equivalent to no remove callback
at all. So drop the useless function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/soc/tegra/cbb/tegra234-cbb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index 3528f9e15d5c..3b26dcf9a70c 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -1066,11 +1066,6 @@ static int tegra234_cbb_probe(struct platform_device *pdev)
 	return tegra_cbb_register(&cbb->base);
 }
 
-static int tegra234_cbb_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static int __maybe_unused tegra234_cbb_resume_noirq(struct device *dev)
 {
 	struct tegra234_cbb *cbb = dev_get_drvdata(dev);
@@ -1088,7 +1083,6 @@ static const struct dev_pm_ops tegra234_cbb_pm = {
 
 static struct platform_driver tegra234_cbb_driver = {
 	.probe = tegra234_cbb_probe,
-	.remove = tegra234_cbb_remove,
 	.driver = {
 		.name = "tegra234-cbb",
 		.of_match_table = tegra234_cbb_dt_ids,
-- 
2.38.1

