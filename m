Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C083625E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiKKPqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiKKPqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:46:03 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BEFDE93;
        Fri, 11 Nov 2022 07:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668181563; x=1699717563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s5EAnjlVfk1tGXA/lPL/gyF6PcL/A8uBGKW/S3pRYSU=;
  b=cdyklsZng7CyD9eoyR+Ahacul6G8INE5W6iPvkfpilZsIrdwniA2dDxN
   LuZFvHuqJ3cvXw94Rt9SMyHPa9aRa+FfEqKAogD21iowcIw4bHsWiPC7a
   zEzNrsySooE3+oLQjtgWDKuqZmlQSHnaeT8bRmJJH02dKGvKeIXSAXUo3
   5eT+gvh/JnHs20xa2aTPrpAdjIRozKv3Y+YCOwaixSSSoQ1uHwt1rsvXq
   nlEXEL2Q3h4tq4bgXO2HJv/L1XyC8R0Xz68NvK2YtlmQEGA+GKjq+38KG
   zHEKsRTw4eZWPsR9JkDiA5Ph54hEejiJPuGxnVjjox/JvV8uu/fuUkuXz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="309246130"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="309246130"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 07:46:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="668843584"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="668843584"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2022 07:46:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A78B129D; Fri, 11 Nov 2022 17:46:24 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 3/3] device property: Add a blank line in Kconfig of tests
Date:   Fri, 11 Nov 2022 17:46:21 +0200
Message-Id: <20221111154621.15941-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221111154621.15941-1-andriy.shevchenko@linux.intel.com>
References: <20221111154621.15941-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems the blank line to separate entries in Kconfig was missing.
Add it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new patch
 drivers/base/test/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
index 2f3fa31a948e..610a1ba7a467 100644
--- a/drivers/base/test/Kconfig
+++ b/drivers/base/test/Kconfig
@@ -8,6 +8,7 @@ config TEST_ASYNC_DRIVER_PROBE
 	  The module name will be test_async_driver_probe.ko
 
 	  If unsure say N.
+
 config DRIVER_PE_KUNIT_TEST
 	bool "KUnit Tests for property entry API" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
-- 
2.35.1

