Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527E3667932
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbjALP1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjALP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:26:13 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1F73D9C2;
        Thu, 12 Jan 2023 07:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673536734; x=1705072734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tUZlln14GPxQq7kWMeSVk86M/DOORIiTmAPcsVtVcz8=;
  b=CnAZJJVTiexghmNcROMnJ3aO4efzCUnW9WFIfCSatq7xzyKQJ8YJ+OWq
   S0tdStukPR7KUqaIpW0rAqez3ppegy7r6rK7CzISj8V9jN1XBYjsqVvwW
   HEkaDGhpyHyJVFQ0lWlrnuOxGBs2dS2RNky1P3HbHIGXhoMS/3ed/2Sir
   9g+dr8jkPSMo5ZYJJnuj0x2Jpvjnqtle3KVUHwqfLZEBNr5tplwssUGox
   IwVYB4nl8lytR8Mh4uagcdGtzt2rVZ6RtX0C/xZPrF8vYSnzacaEO4cDa
   lsVjPbjLtCkP4s2Ym7b14+mQhJL8e2LWgcv+5gWmdhwBH0yZaOALonT4T
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388210527"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="388210527"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:45:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="659809686"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="659809686"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2023 06:45:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BA7EA130; Thu, 12 Jan 2023 16:45:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v1 1/1] gpiolib: Remove unused of_mm_gpiochip_add()
Date:   Thu, 12 Jan 2023 16:45:26 +0200
Message-Id: <20230112144526.66794-1-andriy.shevchenko@linux.intel.com>
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

of_mm_gpiochip_add() is unused API, remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/TODO       | 4 ++--
 include/linux/of_gpio.h | 5 -----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index 76560744587a..68ada1066941 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -61,8 +61,8 @@ Work items:
 
 - Get rid of struct of_mm_gpio_chip altogether: use the generic  MMIO
   GPIO for all current users (see below). Delete struct of_mm_gpio_chip,
-  to_of_mm_gpio_chip(), of_mm_gpiochip_add_data(), of_mm_gpiochip_add()
-  of_mm_gpiochip_remove() from the kernel.
+  to_of_mm_gpio_chip(), of_mm_gpiochip_add_data(), of_mm_gpiochip_remove()
+  from the kernel.
 
 - Change all consumer drivers that #include <linux/of_gpio.h> to
   #include <linux/gpio/consumer.h> and stop doing custom parsing of the
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index e27a9187c0c6..935225caf70d 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -56,11 +56,6 @@ extern int of_get_named_gpio(const struct device_node *np,
 extern int of_mm_gpiochip_add_data(struct device_node *np,
 				   struct of_mm_gpio_chip *mm_gc,
 				   void *data);
-static inline int of_mm_gpiochip_add(struct device_node *np,
-				     struct of_mm_gpio_chip *mm_gc)
-{
-	return of_mm_gpiochip_add_data(np, mm_gc, NULL);
-}
 extern void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc);
 
 #else /* CONFIG_OF_GPIO */
-- 
2.39.0

