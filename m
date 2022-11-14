Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A704628635
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbiKNQzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiKNQz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:55:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B68315715;
        Mon, 14 Nov 2022 08:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668444928; x=1699980928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gGDtImubOcSLVP60+TzwKMDasoMDqFJiSB9lXa2+0Eg=;
  b=lU9dD0m7ywUUNSo+VuTImB3Bpfq7MoszSG4gtFlJabuUAEXFalcCYaj3
   o09rj7PyuFsDJNNZVIdI4ALIjHo1NdXz9n1nHALeLFiG2xe8UkQ8zsZpI
   e1UcjTXFe8OYWMipO1GVpSW29+KrFgtFwwYbwDZM2CteLnIWKm75RTdtR
   sHtVzgqNPTBrkh6/UsU1x+/eLqm1jyPUkqpdJJW0O36EqvfeGLii+B6+u
   02AGOQZdImA6igThD4wGFl1ZGSea2tJodKm7PwjGN8LxmV59JoGRxuEvK
   CpsGxlDRTzI+osvO2Ch+n+RoDxePvAnzo/3+prKGR5+8fLnyzDUjuOvSH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="292417752"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="292417752"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:55:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="702079042"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="702079042"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2022 08:55:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F0169339; Mon, 14 Nov 2022 18:55:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 2/7] pwm: lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
Date:   Mon, 14 Nov 2022 18:55:40 +0200
Message-Id: <20221114165545.56088-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX_PWMS definition is already being used by the PWM core.
Using the same name in the certain driver confuses people
and potentially can clash with it.

Hence, rename it by adding LPSS prefix.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpss.c | 2 +-
 drivers/pwm/pwm-lpss.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index accdef5dd58e..b8739cd2c235 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -252,7 +252,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 	int i, ret;
 	u32 ctrl;
 
-	if (WARN_ON(info->npwm > MAX_PWMS))
+	if (WARN_ON(info->npwm > LPSS_MAX_PWMS))
 		return ERR_PTR(-ENODEV);
 
 	lpwm = devm_kzalloc(dev, sizeof(*lpwm), GFP_KERNEL);
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 8e82eb5a7e00..2c746c51b883 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -13,7 +13,7 @@
 #include <linux/device.h>
 #include <linux/pwm.h>
 
-#define MAX_PWMS			4
+#define LPSS_MAX_PWMS			4
 
 struct pwm_lpss_chip {
 	struct pwm_chip chip;
-- 
2.35.1

