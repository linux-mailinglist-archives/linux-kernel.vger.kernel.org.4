Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C113F633DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiKVNfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiKVNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:35:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CD351C1D;
        Tue, 22 Nov 2022 05:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669124141; x=1700660141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E2o75a0dR2r76pyJZbgE/pHYuyelnQX13nzZY5Ng3hk=;
  b=fwvfdyQUp6NJPUHdjzezC7gOeMznS51dLKg5c1q0X/M2DmGZPvYccSK8
   xtxGX2nC7nKZjn8RmlNZ9qiOWsbaA8TmKvICNhTUUwjAVEbrbdEKzpJC9
   Ezgu2K7PHFrBdYD72Ng+ewavoyCAl34GnuicXfV6NexF16/pdO4p4ItOv
   g8yBGdCNfuUDNASVrdkANCft7mg9TMUCBhQ+uvPGHcT0qFLMTAUq0nX0k
   5I7QEvtSvXeIs6sORm8oryUJNCfFDzFerv7X7yk8lyaQ92a6wTIYh1QEj
   IoPKwNNYIAMgLax52k5R5nNaxKqMPh1IyxIB3ZUqP48Z+KhfT1x/xIfMY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="311442547"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="311442547"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 05:35:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="672484470"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="672484470"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 22 Nov 2022 05:35:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8DC4A12B; Tue, 22 Nov 2022 15:36:04 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v4 4/4] device property: Add a blank line in Kconfig of tests
Date:   Tue, 22 Nov 2022 15:36:00 +0200
Message-Id: <20221122133600.49897-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122133600.49897-1-andriy.shevchenko@linux.intel.com>
References: <20221122133600.49897-1-andriy.shevchenko@linux.intel.com>
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
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
v4: added tag (Heikki)
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

