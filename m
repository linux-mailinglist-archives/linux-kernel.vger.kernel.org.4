Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421B16254FC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiKKIK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiKKIKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:10:41 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D9426587F;
        Fri, 11 Nov 2022 00:10:39 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Nov 2022 17:10:39 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 7452F20584CE;
        Fri, 11 Nov 2022 17:10:39 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Nov 2022 17:10:39 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 27100B62A4;
        Fri, 11 Nov 2022 17:10:39 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 4/6] mmc: f-sdh30: Add compatible string for Socionext F_SDH30_E51
Date:   Fri, 11 Nov 2022 17:10:31 +0900
Message-Id: <20221111081033.3813-5-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221111081033.3813-1-hayashi.kunihiko@socionext.com>
References: <20221111081033.3813-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for Socionext F_SDH30_E51.
Since this IP is transferred to Socionext, so append it to Copyright
and MODULE_AUTHOR as vendor name.

F_SDH30_E51 is a higher version of F_SDH30 that supports eMMC 5.1,
though, currently there are no new features for this IP in this driver,
just add the compatible string.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/mmc/host/sdhci_f_sdh30.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index 7f4553b28180..556f4601643d 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2013 - 2015 Fujitsu Semiconductor, Ltd
  *              Vincent Yang <vincent.yang@tw.fujitsu.com>
  * Copyright (C) 2015 Linaro Ltd  Andy Green <andy.green@linaro.org>
+ * Copyright (C) 2019 Socionext Inc.
  */
 
 #include <linux/acpi.h>
@@ -218,6 +219,7 @@ static int sdhci_f_sdh30_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id f_sdh30_dt_ids[] = {
 	{ .compatible = "fujitsu,mb86s70-sdhci-3.0" },
+	{ .compatible = "socionext,f-sdh30-e51-mmc" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, f_sdh30_dt_ids);
@@ -247,5 +249,5 @@ module_platform_driver(sdhci_f_sdh30_driver);
 
 MODULE_DESCRIPTION("F_SDH30 SD Card Controller driver");
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("FUJITSU SEMICONDUCTOR LTD.");
+MODULE_AUTHOR("FUJITSU SEMICONDUCTOR LTD., Socionext Inc.");
 MODULE_ALIAS("platform:f_sdh30");
-- 
2.25.1

