Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9076B4D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjCJQvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjCJQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:50:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFC713480C;
        Fri, 10 Mar 2023 08:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678466860; x=1710002860;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=GUE2klioiCUZxp/OgoQzXCq9RQkFrhiLvLdVx5qpQ9s=;
  b=XgHqTARj0TPabh2T/N51XATBtqbwxJw02v9x8cGVucBc5C1U+a3KoXaL
   lt7UND59Uet6n7qFptwB8k0/Vq4Vsr6TduxaS4uVUMVrT9gqahJJfQrfm
   4FppnYTVdUrPIWbsRl2gWfkZUMdmhRsKDU1CCzDYbQPW7pYMRkjv33USC
   HjwATU3GjVlcrLooi99lUYvfpOwvSrAWBF2ekXHeI/IYg4TSGGxsJZEPb
   V7Cb4KIipIHK45GA6oxhe7X4hJe1AY6/ahyUDCOiGF5oSsKHz+2q1JVll
   dhZKi6+mBER2mGQcjGMjAVIpx3Gr+sW+oq9FWI9DVapFpWhRvyxQJXEQw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320621153"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="320621153"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:45:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746778640"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="746778640"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 08:45:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6D93C59E; Fri, 10 Mar 2023 18:45:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] pktcdvd: Sort headers
Date:   Fri, 10 Mar 2023 18:45:49 +0200
Message-Id: <20230310164549.22133-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
References: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.39.1

