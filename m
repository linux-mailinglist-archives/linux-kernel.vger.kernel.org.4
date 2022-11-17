Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1507A62D90F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbiKQLJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbiKQLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:08:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03757450A7;
        Thu, 17 Nov 2022 03:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668683282; x=1700219282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vb4Kjx+Zzgw7pJ7ccpP6XKDAM1GDRLtTdQAtD7V1YcM=;
  b=CwwbtulsbSftGJAX21u1zR9QCiyXrEL2fbOyIRrEVrpTRUVuCqi/TszF
   mziKyzTqaqfE2HxLeduDdpybGxFoL4MPOsZiGOmdvqQKryhYygk8URHfh
   HjZh4yGXFOfZyA3uHhpcC6ObLwdPE1IeZ0x6+1nBXtmJb07s303UmpMCh
   iogW+xpW/izq3wGLOVCUPI7U3Js/ggbCEQG87jAu/q/e1fH5R8r+hoZ5a
   b0iaDrq0O38k5fN2PM7q+lmHb3MDM7XqEupbCttZKI1iBYiyd4U5VIPcs
   bXEzXKaC70H/RnBwGH5vql7HX5FTTxPhrQnOzlB7sv8mKYRP6FLjxl0IV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="293218217"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="293218217"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 03:08:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="639763895"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="639763895"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 17 Nov 2022 03:07:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0214C2F3; Thu, 17 Nov 2022 13:08:23 +0200 (EET)
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
Subject: [PATCH v5 6/7] pwm: lpss: Add devm_pwm_lpss_probe() stub
Date:   Thu, 17 Nov 2022 13:08:05 +0200
Message-Id: <20221117110806.65470-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
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

