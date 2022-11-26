Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F107963965E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiKZORy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKZORv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:17:51 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BC020340;
        Sat, 26 Nov 2022 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669472269; x=1701008269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9dgWdr0fMMMvj7yoBb+AISsyHcjZYsN6cesstQv37Zk=;
  b=P4zKFPbzKKze27TfI+fLaFB1YKyXsdjKEB2jELB/apvU2PCSBsRtRfjV
   Nzz6OWKYgB0twMtD2GlHMB+sCkWHSz95dyZO2255wjcpXuJyUxEkBx5mD
   sSjPvfCHkbY1B4WjhoBqdxACHJHJVs81Vn9cc607rw8swWzrHua1+ZBLH
   7c8Wn5njEDifILL9sAnlyxOf3jLoFl2S5pvVvz1N32bCoS2HL1M0l6Dcv
   ja4xIicvOLTou6g335J64bNIHbuw8E96Ba3h/mEPLx807DsAytVrR+lV+
   tCsoKqBl4T2OlbgvATsSq/c9sHSnqYmi2OBfbcylGHnjSXPj99RlkbQQ2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="315755384"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="315755384"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 06:17:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="971800594"
X-IronPort-AV: E=Sophos;i="5.96,196,1665471600"; 
   d="scan'208";a="971800594"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 26 Nov 2022 06:17:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 33573184; Sat, 26 Nov 2022 16:18:11 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] rtc: isl12022: sort header inclusion alphabetically
Date:   Sat, 26 Nov 2022 16:18:06 +0200
Message-Id: <20221126141806.62205-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221126141806.62205-1-andriy.shevchenko@linux.intel.com>
References: <20221126141806.62205-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort header inclusion alphabetically for better maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
2.35.1

