Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57840731DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjFOQZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjFOQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:25:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6640D1BDB;
        Thu, 15 Jun 2023 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686846324; x=1718382324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XsJeHyM9PuN2tIHvCthEpU4ofv/DPS933pIxreJ5jeU=;
  b=GLlayUG32eAPuFaeKejWq3K7cvfdyA9NcOvaoJ4swfNNTEMtcuS5zjET
   EG4GcpOVdxepdrfiyOPsOFnkkslBjxYd6Ytrs18aqzZuhj5Hpy8TPgh79
   3XQSXMu8hSIED/qJa85iVXHY0KT+rT+FB3pWo+89hJbw08pw6uGwMO4Fz
   sJRT4iUuwxSOxjDrKp3uyocxdovodls/PhhYxtZIg8Kxk7B75quBHwE1W
   +M3X3N/OjqY+iRLi/WYAmhcy20nn4TmkVDBEy+be3aUKvXvtZ0h3O2tQp
   EUwT10SjRJw/4nDjT0/ot0rXYzy06XmBKmOT7jfYTLsBt6M1jUpp5uINB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356460456"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356460456"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 09:25:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="706730649"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="706730649"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2023 09:25:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BB3C6379; Thu, 15 Jun 2023 19:25:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/1] gpio: mpc8xxx: Remove unused of_gpio.h inclusion
Date:   Thu, 15 Jun 2023 19:25:14 +0300
Message-Id: <20230615162514.21195-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
 drivers/gpio/gpio-mpc8xxx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 3eb08cd1fdc0..35214e9de4ce 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -12,7 +12,6 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-- 
2.40.0.1.gaa8946217a0b

