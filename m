Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA3B614EB2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 16:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiKAP4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 11:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiKAP43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 11:56:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBBF65AC;
        Tue,  1 Nov 2022 08:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667318188; x=1698854188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NI154NeC1RWG4hSdSSq9uISzU3eVykdnlrIdlNSvC4A=;
  b=KkXarmWr/Efn/RiHllZ6FOxL4J4zLyJxG7rAdBs3f6Hn513mEUpjTm8H
   fyfa/3KqBnIskWPCOXYoJvTlkCXFhbl6GyybEo06AuBESG9dNIMP2zueI
   TThVK7v8VzU+YY/0iqMqSBquVv5BowV5kBBJN+VpnYFsiMyDxn7ktXmYy
   76iBf44lfehHNVDii4hhhTFj5iNgWqYbVwySY8YvYKUpZ2YydgvM9Htkt
   tygQoDQ7SAYGjCX7FK8sEE3KCvqve/9dwzu5H2bR/IhhbI9X3+pXBVBVk
   qTSgHNAUqzU0XKTHNehSuHE77rL4X9W1B40Y4KkUjODYoidMEqbx0QWia
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="292474806"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="292474806"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 08:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="776537916"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="776537916"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2022 08:56:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7271215C; Tue,  1 Nov 2022 17:56:47 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/6] pwm: lpss: Rename MAX_PWMS --> LPSS_MAX_PWMS
Date:   Tue,  1 Nov 2022 17:56:38 +0200
Message-Id: <20221101155642.52575-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221101155642.52575-1-andriy.shevchenko@linux.intel.com>
References: <20221101155642.52575-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

