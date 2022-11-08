Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94111621626
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiKHOXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiKHOWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:22:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809DE54B2F;
        Tue,  8 Nov 2022 06:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667917338; x=1699453338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E9ags/i2eDk5WiEL1lMfAOWBo+2EbAcbpeazBtcJaqI=;
  b=IY8eOGG5AbGU/thfTYtpls063zxVpV5GhebaF0WBpN2XhwgrSwOyfsur
   BRM61jpRSb4AobgbzZ+yG5nimeoU1d1v7Do86xiHmC/G6KJi9qOS9BQFv
   Qq0ImAW8CxPffvRmL9vCtmOQK75sXKwYmaphjjLea5UZdu4zkguVYJrow
   LSzqAE0zazYMulRy5y+mGWyHYLPYZrqlMDX4xmUDu1B973kBe9+nAcEVm
   4RiIabUdg2lD8fJ1L1iTbSY48pDbzWmsXUNXTS4XlIgxeoAC8SUWH2RFK
   pjS4y4T6biqEi/Id9/ILyH35ko5Mtlxx6KC4MU05w0g7TJaUAUJA3qmy4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="310700753"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="310700753"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:22:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="587386418"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="587386418"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 08 Nov 2022 06:22:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 75ED429D; Tue,  8 Nov 2022 16:22:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 2/6] pwm: lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
Date:   Tue,  8 Nov 2022 16:22:22 +0200
Message-Id: <20221108142226.63161-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
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

The MAX_PWMS definition is already being used by PWM core.
Using the same name in the certain driver confuses people
and potentially can clash with it.

Hence, rename it by adding LPSS prefix.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
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

