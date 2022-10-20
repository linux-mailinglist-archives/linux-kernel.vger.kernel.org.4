Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E956064C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJTPi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJTPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:38:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660E01B7F22;
        Thu, 20 Oct 2022 08:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666280336; x=1697816336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QVXdULripvrbzTGS5Y/g2ZLL3Sw30NQHgfW9RlbH1GY=;
  b=IT1Out8AsvW0JyjQLpW4qDadFEvlPiuXWJ08qFRjCV8UQFI6ZlR1+utV
   DhLhkYvvga/S3qzCeYzNyIqm4j4ITeyrL1AnF5HoW/r2vsm4Pk8rQu/3V
   WZz0zRb54FavsyHQRuTNxWi9PCAMIk010Ks5zpfrcBFA/JcylVl18nIQ8
   YPbM+6nPBIUU2LO6JOWxQqPT2Mkrjd3FL9ZVFI0I+kpnzH0Tx6l0oDLxW
   MkUD792VCrrEL9UQdvh9rvePDFAJp84a9wmoIty+Zdv2c9JGlRKomQcRl
   oW10u82cS8fbK1Q3V5LJ7PmAm0fRIvS7JfUs1xOh8xE7ua0d5HsjJZ6Bq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="286464632"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="286464632"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 08:38:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719129557"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="719129557"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2022 08:38:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D05A8107; Thu, 20 Oct 2022 18:39:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpiolib: cdev: Fix typo in kernel doc for struct line
Date:   Thu, 20 Oct 2022 18:39:14 +0300
Message-Id: <20221020153914.63260-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When eflags has been renamed to the edflags, the kernel doc change were
missed. Update kernel doc accordingly.

Fixes: b1a92e94560d ("gpiolib: cdev: consolidate edge detector configuration flags")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 0c84b011a64a..f9288e41e3a7 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -412,7 +412,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @desc: the GPIO descriptor for this line.
  * @req: the corresponding line request
  * @irq: the interrupt triggered in response to events on this GPIO
- * @eflags: the edge flags, GPIO_V2_LINE_FLAG_EDGE_RISING and/or
+ * @edflags: the edge flags, GPIO_V2_LINE_FLAG_EDGE_RISING and/or
  * GPIO_V2_LINE_FLAG_EDGE_FALLING, indicating the edge detection applied
  * @timestamp_ns: cache for the timestamp storing it between hardirq and
  * IRQ thread, used to bring the timestamp close to the actual event
-- 
2.35.1

