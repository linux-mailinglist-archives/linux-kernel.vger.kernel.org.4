Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D468621623
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiKHOWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiKHOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:22:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F2454B1E;
        Tue,  8 Nov 2022 06:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667917330; x=1699453330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VsJcziyUcLS2jz0W0PAWmK1QOKoj8deRzU/nYzqqEQU=;
  b=fJ3Bc5U55+8hYgAWOuiRe4giMeuNM/FeA14n87WN2opLQAJwHM0+xGJn
   7yispibOlJ1vyzp2gmUJLBS39yBkVzvMGVghlR3cCrdo4jW+WiJxQANFs
   fqENY3p0qdkxQM16UTOSbt+YdPtbFXvs+YsV9HCbSBbSl9+MgoMKAO4qA
   MKpailFpZEwX2PS6YHFseILiRqlp7Dy+7cL47PC9vn+21RZ1bi0hd4WMV
   QfKx4VCJnadXZFymvhTECbpGhfgEmat7YxpYzYlBXnoMNueh9Y923Phtr
   YZSp0K8B5xQF7XugRlJGCVOkAYZ+girtevDYWCB1j2Dzy/dVWZhogP5jE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="298219292"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="298219292"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 06:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="761506503"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="761506503"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Nov 2022 06:22:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 93544533; Tue,  8 Nov 2022 16:22:27 +0200 (EET)
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
Subject: [PATCH v2 5/6] pwm: lpss: Add pwm_lpss_probe() stub
Date:   Tue,  8 Nov 2022 16:22:25 +0200
Message-Id: <20221108142226.63161-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the PWM LPSS module is not provided, allow users to be
compiled with a help of a pwm_lpss_probe() stub.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 include/linux/platform_data/x86/pwm-lpss.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/platform_data/x86/pwm-lpss.h b/include/linux/platform_data/x86/pwm-lpss.h
index 296bd837ddbb..c868b396ed2c 100644
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
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 				     const struct pwm_lpss_boardinfo *info);
+#else
+static inline
+struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
+				     const struct pwm_lpss_boardinfo *info)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif	/* CONFIG_PWM_LPSS */
 
 #endif	/* __PLATFORM_DATA_X86_PWM_LPSS_H */
-- 
2.35.1

