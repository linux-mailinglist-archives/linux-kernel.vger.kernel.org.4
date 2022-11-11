Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B002626193
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiKKSnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiKKSnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:43:12 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A781B7A4;
        Fri, 11 Nov 2022 10:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668192191; x=1699728191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gGDtImubOcSLVP60+TzwKMDasoMDqFJiSB9lXa2+0Eg=;
  b=EmU+LWuqPyBIA7FqRJnwLeOXs9kYFHjxGmnhDJ57GZcyRsSq6OtWQyl3
   HtWQTNWDg+pZ1JnLeYxZL/CYnjMzRAmCbCOFS1sxBwpP81kksFP6Kb9VT
   /3lZ2Pc3/8gbvU1zefFaXpZOn58iO9A1GfHIlKLhZ9H7x56oEx0FEIKsv
   0Hzxw4nj6E5n2pJuN7w7OJsCeB1Y04BIuhv5DPlwvnbOdzUMooqU2d/gh
   njuKKlltcHjfPrtxUd95ZwvZsbs10kDZntYqFBOSY9MzCtAVNNnlzCKNl
   o1E7QVBHM8cD7jtJOXMDx9H3JOcUxYvT89V9hacFc8tFfabRZJmWkN9Sw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="309274047"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="309274047"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:43:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="632103056"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="632103056"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2022 10:43:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 27B3315C; Fri, 11 Nov 2022 20:43:32 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 2/6] pwm: lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
Date:   Fri, 11 Nov 2022 20:43:24 +0200
Message-Id: <20221111184328.58108-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221111184328.58108-1-andriy.shevchenko@linux.intel.com>
References: <20221111184328.58108-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

