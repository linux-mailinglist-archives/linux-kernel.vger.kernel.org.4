Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF54731DB5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjFOQ0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjFOQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:26:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B41FFA;
        Thu, 15 Jun 2023 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686846369; x=1718382369;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ecnQLg0yyPJCrtYS69iDFhI+WnLwoqvUOIJ82r+8BfI=;
  b=VgX+t6r6NiHUTS+pt8MmPOWUN9dTEwUxiV9pX2nI/VuRGQO+Thu2Vs4w
   Tqs4CLAhxyfYDfIwgai7rc9cvaSJoYitVMuvUtOflnS8aUuQ1yomRRP+r
   WqpPq+gvosxEDfmPGm8XdKsBD2x5NFnxnDXQnGJSjwKErGFTHiaxJNcqs
   C6U2BlbYrvcid1Vg8o0TOmSU1o8CYdxAY4pMWMWuJm7PwfJKdPN1h3Gb1
   LRpp3NP7bdFijWXt2EAArS5zKUuauUFTLEEqlRq7ol/bifVD27VY/QCvj
   qG57q3vow7SXX9693/ctI5iTntPz8ok1zIyJtTHOB4U51aa8W9alBlKDK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="338594185"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="338594185"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="777739556"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="777739556"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2023 09:26:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 580B1379; Thu, 15 Jun 2023 19:26:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nandor Han <nandor.han@ge.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] gpio: xra1403: Remove unused of_gpio.h inclusion
Date:   Thu, 15 Jun 2023 19:26:12 +0300
Message-Id: <20230615162612.21487-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_gpio.h is not and shouldn't be used in the GPIO drivers.
Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-xra1403.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-xra1403.c b/drivers/gpio/gpio-xra1403.c
index 51d6119e1bb4..bbc06cdd9634 100644
--- a/drivers/gpio/gpio-xra1403.c
+++ b/drivers/gpio/gpio-xra1403.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/seq_file.h>
 #include <linux/spi/spi.h>
 #include <linux/regmap.h>
-- 
2.40.0.1.gaa8946217a0b

