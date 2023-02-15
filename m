Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EEB69815A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBOQwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBOQwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:52:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853F33B3F1;
        Wed, 15 Feb 2023 08:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676479923; x=1708015923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8/i1BluFtjUwTdVlQY3hhixrEBqCRsP6t/IrrG8HidM=;
  b=UkaUIXU4lPGyck6+V1sJmMkq+BvK8tCuzMAAq78LnGQLk65HOwHuv/BO
   ch6qDk1zViqaPyIijBZHGEKEGdJrVXAIEBz47FF408QYN5mTryNGnu8FL
   naqYI7IqZIqiFQGFk8Q5D54rZaetdc0eJO1aCffAeyWQS0vOT6h4bGnvB
   tSlXgMsRic4b+s/9mAGXc6VvIOgmK4aBnmCQyrz9ubSlf+haPLBRrAoLf
   VQCBvJk8QnoEDqnC74QZmOPYLJqb6+fqBb4steniBgmScBlzuLmMtrGz3
   hvlt4IVBlHaFe5CG495Eou3xqlwJAk9u3DkA/Z8Vw80tTgx25aerEon+x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="319512327"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="319512327"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 08:52:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="733379580"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="733379580"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Feb 2023 08:51:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ACD9E1A6; Wed, 15 Feb 2023 18:52:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Piyush Mehta <piyush.mehta@amd.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] usb: dwc3: xilinx: Remove unused of_gpio,h
Date:   Wed, 15 Feb 2023 18:52:39 +0200
Message-Id: <20230215165239.83806-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

of_gpio.h provides a single function, which is not used in this driver.
Remove unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 0745e9f11b2e..2c36f97652ca 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -14,7 +14,6 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
-- 
2.39.1

