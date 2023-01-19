Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F626745E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjASWX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjASWWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:22:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831D6A1007;
        Thu, 19 Jan 2023 14:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674166067; x=1705702067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SB0OeZdWiLkarVjZZSXMF9jf/8tzMUUbELrTM8zHlBE=;
  b=aoVupjRtE+cAdnZBqhETH0KQOmUNWJtM+s8DK0POD5vL0QOxlRfpu2cI
   mrWQ5P4lX12dltLI95PrjXP4dqtBtAUl6ILVAzHz/Vezh1e1a8aumf1GQ
   EHLwCeEZHmGy8WctThgUJ5RZxP2guwl6U6tf+bxYp0kNeXToJfXCd9wZG
   YlTFtXqYhglh0fZwG4BOPVG+8MOWsmjOV5MzSGHgUzlsrEEv4lQeBtWy+
   RM1aFabXysz/aHDPs2bXjFRJjFNno7bmRD5CZnqyDXFhEbF3JX5wWYn11
   8CR0hnM3fWGJPH8CLwRQzndWny0wh3tIxorEIrPveCJX4fKwipc0jM2Zu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323130660"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323130660"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 14:07:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="784226649"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="784226649"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 19 Jan 2023 14:07:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B38C57E; Fri, 20 Jan 2023 00:08:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 9/9] pktcdvd: Sort headers
Date:   Fri, 20 Jan 2023 00:08:09 +0200
Message-Id: <20230119220809.5518-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
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

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/block/pktcdvd.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 22048739a245..93597bde9c33 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -46,29 +46,30 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/pktcdvd.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
+#include <linux/backing-dev.h>
 #include <linux/compat.h>
-#include <linux/kthread.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/spinlock.h>
 #include <linux/file.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/miscdevice.h>
 #include <linux/freezer.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/nospec.h>
+#include <linux/pktcdvd.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
-#include <linux/backing-dev.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_ioctl.h>
-#include <scsi/scsi.h>
-#include <linux/debugfs.h>
-#include <linux/device.h>
-#include <linux/nospec.h>
-#include <linux/uaccess.h>
 
 #include <asm/unaligned.h>
 
-- 
2.39.0

