Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F030965BFC1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbjACMTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjACMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:19:10 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3025F6162
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672748350; x=1704284350;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=elqTm1rYxyeo9CJ5NDKg7yRt0wglg+CZgv5XyVSgWNY=;
  b=Q5r6zAz5c83uOi0rP/xR1qsVcY3Mhu0iWhPhyDfbZpB7y0bfJpI01+VF
   7ZsIVflyUgJe2RYkbifNiEZDNEMrFWl/oU2K8gbgq/8oGvFtrdFyvnSga
   8kIqJgY1wf4xLHNyHh5f7qVmtdFfUT6ngLfMe4ste+53ciQQywCh2Mj4O
   8L2JTSZ06h+OTzOMRV16WZB3Gph1SXAtU3Iq7GENTbj6XiuWkzSDlFtjd
   kWcl9qAIIuIiAgr7GEOzKG/06gLf5PO05K91xQEyDMGmAgmzw7I5AHQJ3
   odmDbvEEZraGLMTLP8TCP8fGOW3otxBTTQw8M3j9K3J7en7VcEj9EDGgj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="302020876"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="302020876"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 04:19:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="828837720"
X-IronPort-AV: E=Sophos;i="5.96,296,1665471600"; 
   d="scan'208";a="828837720"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 03 Jan 2023 04:19:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A9035F4; Tue,  3 Jan 2023 14:19:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 1/1] util_macros.h: Add missing insclusion
Date:   Tue,  3 Jan 2023 14:19:37 +0200
Message-Id: <20230103121937.32085-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

The header is the direct user of definitions from the math.h,
include it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/util_macros.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/util_macros.h b/include/linux/util_macros.h
index 72299f261b25..b641ec00be3e 100644
--- a/include/linux/util_macros.h
+++ b/include/linux/util_macros.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_HELPER_MACROS_H_
 #define _LINUX_HELPER_MACROS_H_
 
+#include <linux/math.h>
+
 #define __find_closest(x, a, as, op)					\
 ({									\
 	typeof(as) __fc_i, __fc_as = (as) - 1;				\
-- 
2.35.1

