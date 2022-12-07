Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96C4646167
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLGTED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiLGTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:03:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03EA6F0E7;
        Wed,  7 Dec 2022 11:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670439836; x=1701975836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRKffxZn4Nwkxtj4PMXku1hJbrP2Pgxr1T1rdf7i76o=;
  b=eHrF9AhU4hKYOagO/YNGBew4CawukbDcRlOxQZuNtMj8MhfQRBu0T7ag
   lLZspWvv/JxgpxWbEOS6N2K9osig/AiplKLTJFsaW6B2EYTIAdEHd4Ph2
   WC4NzIorq3inum1VCtXKLcemGbTAE0EWbpz3Siqv3Jmbsq3EeXlHPPIpR
   3k2AmBkMNu4WP9sAQipsRBhQVT09ztZZY2i4RQEFmc0zk1LtOE6nKSuCi
   PAG19PQeH5d2DYO4dLVY/7/9lNyq13Uy3yJpHCEdFLh/QuSEDo+SSno96
   CEfX/q2q0j8T4Qb1ESgCkzm6TvXOwsiI+dpqyetx2oZCDm8FsOUe9rHyY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="297333251"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="297333251"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="624411154"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="624411154"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2022 11:03:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5F418801; Wed,  7 Dec 2022 21:04:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 11/11] iio: light: tsl2563: Keep Makefile sorted by module name
Date:   Wed,  7 Dec 2022 21:03:48 +0200
Message-Id: <20221207190348.9347-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
References: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
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

The Makefile is sorted by a module name, keep it that way.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/iio/light/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 6f23817fae6f..d74d2b5ff14c 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -39,7 +39,6 @@ obj-$(CONFIG_NOA1305)		+= noa1305.o
 obj-$(CONFIG_OPT3001)		+= opt3001.o
 obj-$(CONFIG_PA12203001)	+= pa12203001.o
 obj-$(CONFIG_RPR0521)		+= rpr0521.o
-obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
 obj-$(CONFIG_SI1133)		+= si1133.o
 obj-$(CONFIG_SI1145)		+= si1145.o
 obj-$(CONFIG_STK3310)          += stk3310.o
@@ -48,6 +47,7 @@ obj-$(CONFIG_ST_UVIS25_I2C)	+= st_uvis25_i2c.o
 obj-$(CONFIG_ST_UVIS25_SPI)	+= st_uvis25_spi.o
 obj-$(CONFIG_TCS3414)		+= tcs3414.o
 obj-$(CONFIG_TCS3472)		+= tcs3472.o
+obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
 obj-$(CONFIG_TSL2583)		+= tsl2583.o
 obj-$(CONFIG_TSL2591)		+= tsl2591.o
 obj-$(CONFIG_TSL2772)		+= tsl2772.o
-- 
2.35.1

