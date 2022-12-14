Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444BA64C8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiLNMCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbiLNMCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:02:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3061F26ABB;
        Wed, 14 Dec 2022 04:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671019310; x=1702555310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2nnC8hqhsbGCXjQ/5cko/ZVY7VIV0k35M+A/Vnl8B3w=;
  b=fhNyrVPbEFKrRMp2RoCJvRp3F/E8tWRkg0iZFFd0g0DkkYtJyteaDhr7
   cJN4HGsG8uqaZMybH2rmV7cRCdzadSoDHknmhC+ZegB5V3cTkttlMy6IL
   w8ptZy2pNovCmhk5nza/B0V5Nz5Eb4c6F01NGzoNAPCEC401VXh2ZO6vy
   s69QoHlTUuEqOSDYfGoyLZbidTzQc1ZhJTs1QvY/efJqXQOxQlzpIICc3
   PVCmcPqJV/6v/+zSF6qrnPsmgpT1Nr21YRCGXYFvK8KiXnRM0JiLR+1fV
   e/2Eqn6iujPPgiv3ODX6oEXhPeE8CRvZi4yAcWQ0rOqqVU3naMByJfRlU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="320243481"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="320243481"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 04:01:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="626708582"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="626708582"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 14 Dec 2022 04:01:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 35AC4F4; Wed, 14 Dec 2022 14:02:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/2] iio: adc: ti-adc128s052: Sort headers
Date:   Wed, 14 Dec 2022 14:02:02 +0200
Message-Id: <20221214120202.4658-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221214120202.4658-1-andriy.shevchenko@linux.intel.com>
References: <20221214120202.4658-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/adc/ti-adc128s052.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 7c4e8025861c..a003264ca835 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -11,12 +11,12 @@
 
 #include <linux/bits.h>
 #include <linux/err.h>
-#include <linux/spi/spi.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
 
 #include <asm/unaligned.h>
 
-- 
2.35.1

