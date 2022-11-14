Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCC6628639
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbiKNQ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbiKNQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:55:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88B6186CB;
        Mon, 14 Nov 2022 08:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668444928; x=1699980928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vb4Kjx+Zzgw7pJ7ccpP6XKDAM1GDRLtTdQAtD7V1YcM=;
  b=UFSVZxDpalM2YYD1T6RFq7dEwhdAGYuQZ5g8koAfC1UendLsd6DY7iQB
   jTffM8ir224m61XgRdK+XzM1darMRNGQDvy+EZ6mPuMqNPIOtoth4/GrB
   8RjmONiA/F3CJL+vFFyGW4IU0drvQZgWixHMEA4waNl/RVKjLFx7CJsFy
   G/I3IJiYk1+KRn49PVAZ8ak4iMYaGnNdICG7J3PWNrzcvoWaBDHA2o04t
   +o3hTiwV5hlECM+JCo0KGKbxm3yS0OyR0z8RKz7Z8DCfnUM8vbEZCavon
   oGRpO8YT25wMy6gaoc9nTt9q/wFKqcp7c712qKD5r2CmNBJ+dMd++nI2p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310728460"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310728460"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:55:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727593562"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727593562"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2022 08:55:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2C7E7389; Mon, 14 Nov 2022 18:55:47 +0200 (EET)
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
Subject: [PATCH v4 6/7] pwm: lpss: Add devm_pwm_lpss_probe() stub
Date:   Mon, 14 Nov 2022 18:55:44 +0200
Message-Id: <20221114165545.56088-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the PWM LPSS module is not provided, allow users to be
compiled with the help of the devm_pwm_lpss_probe() stub.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 include/linux/platform_data/x86/pwm-lpss.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/platform_data/x86/pwm-lpss.h b/include/linux/platform_data/x86/pwm-lpss.h
index c852fe24fe2a..6ef21b8baec7 100644
--- a/include/linux/platform_data/x86/pwm-lpss.h
+++ b/include/linux/platform_data/x86/pwm-lpss.h
@@ -4,6 +4,8 @@
 #ifndef __PLATFORM_DATA_X86_PWM_LPSS_H
 #define __PLATFORM_DATA_X86_PWM_LPSS_H
 
+#include <linux/err.h>
+#include <linux/kconfig.h>
 #include <linux/types.h>
 
 struct device;
@@ -27,7 +29,16 @@ struct pwm_lpss_boardinfo {
 	bool other_devices_aml_touches_pwm_regs;
 };
 
+#if IS_REACHABLE(CONFIG_PWM_LPSS)
 struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
 					  const struct pwm_lpss_boardinfo *info);
+#else
+static inline
+struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
+					  const struct pwm_lpss_boardinfo *info)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif	/* CONFIG_PWM_LPSS */
 
 #endif	/* __PLATFORM_DATA_X86_PWM_LPSS_H */
-- 
2.35.1

