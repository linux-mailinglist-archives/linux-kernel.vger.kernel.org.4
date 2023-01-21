Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036FE6765F1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjAULSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjAULSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:18:10 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B54BB8A;
        Sat, 21 Jan 2023 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674299885; x=1705835885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9kwPT8kksIgBqxpcCWvfEkT1fuXwQ6iPUQQcqQPVcAQ=;
  b=jXbDlv094PytF8cKa0OKjxQK727kv2ZxYP9MzpikB/SrH1nozZCfabIu
   OHlR6VopNXXINtywy7+0DRJ92FbC/v9kUeQFoFDJ+5FB53OYo3l+PcCrs
   4uKjIBeU+xB4Ls/v70DK7aj/oYbyXkLQzXCUVgQGb66fD+LPiHzhgRwd3
   itvYTmrgiRoOKj3RSe3nOlIkM9O+aXevfm1h95POrgeKgpNjQhQGUjeAU
   2gHUhVMFgCyH+nlWnkS6JFiozUA9vjjfqb+2yyOlbjt1eKAYFQJpp5g1l
   1w42XvIsCD59w7isZV/gRs9SrYdzFqJvmkOoiVsg9CGrM27sfjh2d8Pao
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="325814372"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="325814372"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 03:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="803369301"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="803369301"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jan 2023 03:18:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2EBE8368; Sat, 21 Jan 2023 13:18:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Moses Christopher Bollavarapu <mosescb.dev@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] gpio: zevio: Add missing header
Date:   Sat, 21 Jan 2023 13:18:35 +0200
Message-Id: <20230121111835.35245-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 899f6a9c4364 ("gpio: zevio: Use proper headers and drop
OF_GPIO dependency") missed one header this driver depends on. Add it.

Fixes: 899f6a9c4364 ("gpio: zevio: Use proper headers and drop OF_GPIO dependency")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Seems I somehow messed up with the series. Here is the missing part.
Feel free apply it separately or fold into the original patch.

 drivers/gpio/gpio-zevio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-zevio.c b/drivers/gpio/gpio-zevio.c
index 778ae82413e4..0223c69b9d7b 100644
--- a/drivers/gpio/gpio-zevio.c
+++ b/drivers/gpio/gpio-zevio.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
-- 
2.39.0

