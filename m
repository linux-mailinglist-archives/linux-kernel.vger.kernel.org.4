Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC067161A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjARIVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjARIUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:20:51 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC96F8B0;
        Tue, 17 Jan 2023 23:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674028090; x=1705564090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4xNa1gOUF5AxrOMYRZd3X+KrP42jd2ivX/meHUjRZ3o=;
  b=Rti2eXE9CYJtbLF0KjGkHg0yrrpzDr1m3H3EofXcCGDIvtlxsqLPE7Do
   H6ujt10loXWUPM+0xFLHsk8nuIzYH+L9KvXaENjPjMyexudghTJ9X6QS6
   42P3ouywG2xtfYd1VXUfO2xsii/eHYtNap7o64uhkxmxDe2NCafhGKX4o
   Om1Nfpx0KknBZDNq424WcIx8VB1pFSc3RTDnhjBaoE9cPfkwFAPWG1Zpc
   S/PzTQVaTNl7kCl0tmMzzt7jSXpJAX1VyOqvgLYFqP49RPsI3khqq0P/E
   r0jYJ4GqsLsPyCQoQ9bZBaL6SzHS+bn5NRuHU4jJ4Quh9KQfqC4aTrv/c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="312800650"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="312800650"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 23:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="637171942"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="637171942"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 17 Jan 2023 23:48:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 03C947C; Wed, 18 Jan 2023 09:48:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] iio: core: Sort headers
Date:   Wed, 18 Jan 2023 09:48:28 +0200
Message-Id: <20230118074828.66155-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118074828.66155-1-andriy.shevchenko@linux.intel.com>
References: <20230118074828.66155-1-andriy.shevchenko@linux.intel.com>
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

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 26e357f14db8..c117f50d0cf3 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -8,30 +8,32 @@
 
 #define pr_fmt(fmt) "iio-core: " fmt
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/idr.h>
-#include <linux/kdev_t.h>
-#include <linux/err.h>
+#include <linux/anon_inodes.h>
+#include <linux/cdev.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/fs.h>
+#include <linux/idr.h>
+#include <linux/kdev_t.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/sched.h>
-#include <linux/wait.h>
-#include <linux/cdev.h>
 #include <linux/slab.h>
-#include <linux/anon_inodes.h>
-#include <linux/debugfs.h>
-#include <linux/mutex.h>
-#include <linux/iio/iio.h>
+#include <linux/wait.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio-opaque.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
 #include "iio_core.h"
 #include "iio_core_trigger.h"
-#include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/buffer_impl.h>
 
 /* IDA to assign each registered device a unique id */
 static DEFINE_IDA(iio_ida);
-- 
2.39.0

