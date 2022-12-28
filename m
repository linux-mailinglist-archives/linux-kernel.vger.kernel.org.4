Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FCE657492
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiL1JUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiL1JUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:20:34 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D91DF02;
        Wed, 28 Dec 2022 01:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672219233; x=1703755233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GY6NY1HpIaYGhu1PBgNFe1uObbv63oyykWwXwJ1FhnY=;
  b=Hz0q7EuUnWgePoRMMiBY22ePeAiDf0Lz47X5Ke93N35tdgxsdKHUH05h
   SGmpBe4ZRrS8pxr+DFRBUFjLJ3M7pY9dGHnS5PESNcWkDqaPARkN1a4/W
   sBVSnr2imEVFd4jI1lBrici1rPgMT3k+2/IhDWttBQEOh9DLoBpF5OnO2
   eTKFvdgtfuFF2AjBYg+4jkabKDFaP2yWXfn1BZWagjtiYfzdOFrxWGjCf
   olEBPoKVd23VEN+t86ycUncojwB6Qs17X1Ynwmn48IBLBl5uyVmUWtQeu
   Rp5MbE+1BSkADXXQ1mdTx+7H8kqNB4IFEvpdkBlc/B37DnhPBPO0S91y5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="301202856"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="301202856"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 01:20:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="603285114"
X-IronPort-AV: E=Sophos;i="5.96,280,1665471600"; 
   d="scan'208";a="603285114"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2022 01:20:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 735381CA; Wed, 28 Dec 2022 11:21:02 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 3/3] gpiolib: sort header inclusion alphabetically
Date:   Wed, 28 Dec 2022 11:20:45 +0200
Message-Id: <20221228092045.80425-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
References: <20221228092045.80425-1-andriy.shevchenko@linux.intel.com>
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

Sort header inclusion alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e72c539fbec5..ace11a89d24a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1,34 +1,35 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
+#include <linux/compat.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/debugfs.h>
-#include <linux/seq_file.h>
+#include <linux/file.h>
+#include <linux/fs.h>
 #include <linux/gpio.h>
-#include <linux/idr.h>
-#include <linux/slab.h>
-#include <linux/acpi.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
-#include <linux/fs.h>
-#include <linux/compat.h>
-#include <linux/file.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
 #include <uapi/linux/gpio.h>
 
-#include "gpiolib.h"
-#include "gpiolib-of.h"
 #include "gpiolib-acpi.h"
-#include "gpiolib-swnode.h"
 #include "gpiolib-cdev.h"
+#include "gpiolib-of.h"
+#include "gpiolib-swnode.h"
 #include "gpiolib-sysfs.h"
+#include "gpiolib.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/gpio.h>
-- 
2.35.1

