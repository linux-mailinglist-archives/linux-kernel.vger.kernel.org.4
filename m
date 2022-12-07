Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BDF64616A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiLGTEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLGTD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:03:58 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE06F0E9;
        Wed,  7 Dec 2022 11:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670439837; x=1701975837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OnC3gSlrO1t+XETiAEwCFw4xmz5yXm4O4Aj0g0fKpiI=;
  b=mGlGkLQ5D68smF+UtavYX27lvWkOrCrz3cgBxTKAk+5dbWReoh3Z/dj3
   ozy4k870KpgNL+9YFMWsUtP1QiekFNvBwYgn+FeXDP1KSXbJpOgb3WORR
   6kfm3On6KipaSyhLuv19RYifwL9exoLWLRsyheGheNq5oJzuv916qBt3d
   f0v2Ek0/AUq4JYJ/Gxipv/fmJmWxYuxwWtq2Lq3bWoo0/DhU+SI9uzgDd
   QgUzP4jlvTIHxg8MUF538TWXVdWjwZiRMMuHxGfemEYiOKCLG0MNGtooP
   l5heIrI310ScOoktRRUcGcmDnWIEIG/QASMbjfa6y0TXPxzJ6MBjRntL8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="297333257"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="297333257"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="624411155"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="624411155"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2022 11:03:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 50D5C6B1; Wed,  7 Dec 2022 21:04:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 10/11] iio: light: tsl2563: sort header inclusion alphabetically
Date:   Wed,  7 Dec 2022 21:03:47 +0200
Message-Id: <20221207190348.9347-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
References: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
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
Tested-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/iio/light/tsl2563.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index f92190fadffd..f2f55239a072 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -12,23 +12,23 @@
  */
 
 #include <linux/bits.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/property.h>
+#include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/sched.h>
 #include <linux/math.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/delay.h>
 #include <linux/pm.h>
-#include <linux/err.h>
+#include <linux/property.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
 
 /* Use this many bits for fraction part. */
 #define ADC_FRAC_BITS		14
-- 
2.35.1

