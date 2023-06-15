Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872B1731DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjFOQZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFOQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:25:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67211FE2;
        Thu, 15 Jun 2023 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686846314; x=1718382314;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gZVNHON66K092rebzdYLLooqv26SviVTgyudimDhcFU=;
  b=BiSqYjMkST7QRtfdi7nHKSIeg0XwPha6KhS0KBCdrvTb8G3V2ohQcRnN
   /bhcJBEPe3GB//5iZVUQQbRBlUhvaA3oB9XMdQlSziWi5S5fNySvA+AjC
   IwCe/Ub+JrG15NrbTBVktuX7uba3FYM7qm6OMBGGrjSZmaMHm72oUeSOS
   79byjNP0jTk10VohSvsgkTa3Txfyu1wYFiwoT/yJYU0ysNOsUbEnkE4/S
   OL6HT0hF+hSCr36YDyzqOrnB6nQEKi7Isv83Gq5n3iS3NE/Ct/q8mzGAp
   QSMjBY1+QmhBKFD+BrVhjnvvJzIHcO1WHExSYx9YFBrNKsYNDUt0VjKUH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343696429"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343696429"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:25:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802469660"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="802469660"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 09:25:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1D9D1403; Thu, 15 Jun 2023 19:25:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v1 1/1] gpio: lpc18xx: Remove unused of_gpio.h inclusion
Date:   Thu, 15 Jun 2023 19:25:19 +0300
Message-Id: <20230615162519.21244-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_gpio.h is not and shouldn't be used in the GPIO drivers.
Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-lpc18xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-lpc18xx.c b/drivers/gpio/gpio-lpc18xx.c
index d711ae06747e..ed3f653a1dfc 100644
--- a/drivers/gpio/gpio-lpc18xx.c
+++ b/drivers/gpio/gpio-lpc18xx.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
-- 
2.40.0.1.gaa8946217a0b

