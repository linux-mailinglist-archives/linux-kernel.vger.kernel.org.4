Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778EC62D901
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbiKQLIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239856AbiKQLIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:08:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C9D6A763;
        Thu, 17 Nov 2022 03:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668683286; x=1700219286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gGDtImubOcSLVP60+TzwKMDasoMDqFJiSB9lXa2+0Eg=;
  b=McLzHn0J+I3KoVlkj3qSMFAcf4T+4UAekLiCoKhaDGG7Jf2BBbu5X1Ir
   /BFTk5AMaHzhHaTaQbxYEg7+sMn/60LMSATLcOOJoZc+ffXm0PPsBt4Rn
   sNl1YoreZqxp9dRushQM0kaOhWOiP5LxodFEKo86ow6wVt3WgWeAXiKHY
   yGKUflFcUqSwuQUvDNffjYsIVlHnk98+yrpPcGP3v24tXh8YJOjSKyXCr
   uEnTxb1g8K4XDrxZGcQkw4l/RasCLC2lAEmnpeNjma4mI2HztW2cGMoXw
   tH0FtSBwoYOkjr7JkvgVwUx0CddtiWmhEkbZtrLHY2+EdSBLMN7PEWZYa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296186163"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296186163"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 03:07:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="639763876"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="639763876"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 17 Nov 2022 03:07:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 464C82B7; Thu, 17 Nov 2022 13:08:20 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 2/7] pwm: lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
Date:   Thu, 17 Nov 2022 13:08:01 +0200
Message-Id: <20221117110806.65470-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

