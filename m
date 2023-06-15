Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AEB731E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbjFOQma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjFOQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:41:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A1026BA;
        Thu, 15 Jun 2023 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686847318; x=1718383318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=17xTbfJhMgfENVpSupn8hOyp2oKxbDUByWTYz01g7Zs=;
  b=YWKOxUyAdFGBqKFAT4tRuf471p8nNZJYAjriCySyADQaH+PgqsNfWvlS
   GBvO4M1Rh9PtQEcprsQ2OLolkjwxiOK+kham2Y0JRpRnjbpwxWoN9xScp
   8jtZuR01FxJkhCubepRIVIGEZCJNLBHh+PkK5jmsw9zeJZ0R+/4p9Zth5
   3gtTNtbvMRvWCm94CbGLnDEo2QysvbmgIwzuRGLO9mMdBFUFQvnkig/n9
   3GqmtJvNQpij7NWuipVBDUksfcVLzVMN+vU/nBfDb9Sadj1JVWac/Gd5D
   i/lmEnTQkGjVY8h+VReFKjMY7SXWEudYEJII/SHlJxlbJT5GQh2HZPx0D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343702852"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="343702852"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:41:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="777742116"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="777742116"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jun 2023 09:41:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 992E4379; Thu, 15 Jun 2023 19:42:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aleksander Jan Bajkowski <olek2@wp.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: lantiq: Remove unused of_gpio.h inclusion
Date:   Thu, 15 Jun 2023 19:42:04 +0300
Message-Id: <20230615164204.25462-1-andriy.shevchenko@linux.intel.com>
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

The of_gpio.h is not and shouldn't be used in the drivers. Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-falcon.c | 1 -
 drivers/pinctrl/pinctrl-xway.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-falcon.c b/drivers/pinctrl/pinctrl-falcon.c
index 2eab14f86fa3..0bf9ffbcc79f 100644
--- a/drivers/pinctrl/pinctrl-falcon.c
+++ b/drivers/pinctrl/pinctrl-falcon.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
index 858abb23b337..cf0383f575d9 100644
--- a/drivers/pinctrl/pinctrl-xway.c
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -8,11 +8,11 @@
  */
 
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/of_address.h>
-#include <linux/of_gpio.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/device.h>
-- 
2.40.0.1.gaa8946217a0b

