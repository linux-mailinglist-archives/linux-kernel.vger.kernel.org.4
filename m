Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FF25E8129
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIWRxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIWRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:53:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D67112C6A1;
        Fri, 23 Sep 2022 10:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663955626; x=1695491626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t6K0dRAorrnNaUoJ2fzA0TiDE5e3dyyKs6gmKdLULpg=;
  b=Cm7twJx/L5O5oj/JDhwDpU/PxYR/7rvUSDeXCa/VWeqGxknuutc26GvE
   Ldv3QaJKhYclgmnqYi09sws/gOixcR62F3iNtZmBLO9m2Wht0VZ3pGVoS
   s/K8MndVSMk3jSC7giPx9kHTikL7CzY3El+p2nAnSuyYHGgIDvjV8raIF
   kBU7cgNjQQouSVQ2/uTpc7OgFv3nncRasqtw4kfHn1BI/S00yYZSjH2xn
   Sla/6KhCi0iNQYZK1BvW2mAeK/MdhjJ0E12QMsDC2DWxx0xzRwEOeeE5y
   +n0eF2gKZra/JvJvNM7C840n+YbseHc+mBrZhwbMywIrJEYKZi9AhVTvM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="299373724"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="299373724"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 10:53:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="949104142"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2022 10:53:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EFD1BF7; Fri, 23 Sep 2022 20:54:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mfd: twl4030: Add missed linux/device.h header
Date:   Fri, 23 Sep 2022 20:54:01 +0300
Message-Id: <20220923175401.8723-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With compile testing on non-OMAP platforms compiler might be not happy:

In function ‘twl4030_sih_setup’:
  error: implicit declaration of function ‘dev_err’ [-Werror=implicit-function-declaration]
  error: implicit declaration of function ‘dev_info’ [-Werror=implicit-function-declaration]
In function ‘twl4030_init_irq’:
  error: invalid use of undefined type ‘struct device’

Add missed header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/twl4030-irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 4f576f0160a9..87496c1cb8bc 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -14,6 +14,7 @@
  * by syed khasim <x0khasim@ti.com>
  */
 
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-- 
2.35.1

