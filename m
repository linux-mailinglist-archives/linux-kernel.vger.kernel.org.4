Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF5C6642D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 15:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbjAJOIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 09:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbjAJOIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:08:13 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8F58CBE2;
        Tue, 10 Jan 2023 06:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673359692; x=1704895692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4NOTfNW4jDLP34KQ7vuObhZRGJ9+73gybtn8mNZS7J4=;
  b=l75mJ+HL+1N2aIBmgFij+XfJj7/rOdqwPDjQSdzj5HuHm3qyIbXu5WMe
   1+zMSJAoOOOGfd8ebRFXOxIEmIXfH5kvSygF2+7VznVX+/JCPzvpdbCiz
   wxYw7x8x/UNuid5qmR/zppUH+C77Foc6A67p4YRAgVxgXPagCXRozr7cX
   t3yFFkkysCj6IKgLRSxYFLmLpIsQiw0Wd2S7Nm+mlHBl40ypILSGSEQl/
   Yqtds/g5TjgHuGQLvSCKjq+xls188IPjzdL9s4lYGYUMp2qGX3GKB4lje
   v/VOKmb1kD82hzOqsRyF/PIQwc3VRnKqENkqswcuE+pkPQEULViHS61RB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="303513607"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303513607"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 06:07:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="725555694"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="725555694"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jan 2023 06:07:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 125EB4E3; Tue, 10 Jan 2023 16:08:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 5/5] rtc: isl12022: sort header inclusion alphabetically
Date:   Tue, 10 Jan 2023 16:08:06 +0200
Message-Id: <20230110140806.87432-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110140806.87432-1-andriy.shevchenko@linux.intel.com>
References: <20230110140806.87432-1-andriy.shevchenko@linux.intel.com>
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

Sort header inclusion alphabetically for better maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index ee38c5067ea8..e68a79b5e00e 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -8,14 +8,14 @@
  * by Alessandro Zummo <a.zummo@towertech.it>.
  */
 
-#include <linux/i2c.h>
 #include <linux/bcd.h>
-#include <linux/rtc.h>
-#include <linux/slab.h>
-#include <linux/module.h>
 #include <linux/err.h>
-#include <linux/regmap.h>
 #include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
 
 #include <asm/byteorder.h>
 
-- 
2.39.0

