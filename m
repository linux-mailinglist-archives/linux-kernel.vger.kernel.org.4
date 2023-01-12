Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D761667382
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjALNsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjALNsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:48:21 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C909F4731B;
        Thu, 12 Jan 2023 05:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673531300; x=1705067300;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oQ62R1jpCWfknySG4HTd0BHpObXTct1LjU8FAn9WbOc=;
  b=gxehbjhHYqXzrikO0Gr2vkoePx76LEBbRTODkUvTJV+v8TK2P8fRHXnz
   lkPixY4OSWahhAE/EswAkQ64Fss+naPQe+SLVKeSV9janHARRcV4a9VWw
   OxhaFwZqDplxTlcoMsec0fYOvNlYgFY/mE44uBob2pL1XuWK2l/po2q3e
   UOlzOTQK5HBcSlBaKfjHtafMiUkdyFOkzHPuaQmwtc+t/8ALCcWEZH75+
   UpwiKFEupOsHm1IqHEtHtJQO8KyqPrJJGlEaayBT3ioOZZkzprv28KjTW
   ZUvHXW8TZrEQcBVWm+ZI6Ntvaw2Z+mzxoojYCYBmOQoP9R7Uu4qLk082g
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="386021284"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="386021284"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 05:48:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10587"; a="688338287"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="688338287"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2023 05:48:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 621F5E1; Thu, 12 Jan 2023 15:48:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pinctrl: samsung: Do not mention legacy API in the code
Date:   Thu, 12 Jan 2023 15:48:49 +0200
Message-Id: <20230112134849.59534-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

Replace mentioning of legacy API by the latest one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 514001e448b9..833e170e3d99 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -649,7 +649,7 @@ static int samsung_gpio_direction_output(struct gpio_chip *gc, unsigned offset,
 }
 
 /*
- * gpiolib gpio_to_irq callback function. Creates a mapping between a GPIO pin
+ * gpiod_to_irq() callback function. Creates a mapping between a GPIO pin
  * and a virtual IRQ, if not already present.
  */
 static int samsung_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
-- 
2.39.0

