Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D226DC8AC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDJPm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDJPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:42:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB79A5BA2;
        Mon, 10 Apr 2023 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681141375; x=1712677375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OwXZLZleXFeAooPhA0PTrMxq3lQ05ppIoojJrb4Dj0Y=;
  b=ipgJDQIxec8L1Hh52GCYMbNCE6rSSbLBMv4Kvoa6ZhVyfodCpuz3G+lF
   4qgpYamvNVU+YCzaDm94zXk+vPzJKnXdoQUPGaRDRjgCfOZTOmiS3i2BU
   kpH+jO4LQQB6Li53V43tXu+zmpSsJIKfCOfVbo5uBmDylTkEwe6kPaGig
   CXpx6dCOY6tQDkDFRkFIfVFk7OxfN+Dli8WaUYxv6GiCHLrM9QwKXu0FE
   okeoQA2cuMAMMbya+otWW2NWQrIz/BanweXHT17MKlh8/VIKCDeXeJ3gY
   Fix2N7ZMATvC1wCuQoh8fyI9g/zu/j1eYmehUL+BH/41cSiIn5Yx3I+rC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340868146"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="340868146"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 08:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757482046"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="757482046"
Received: from linux-builds1.an.intel.com ([10.122.105.32])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 08:42:54 -0700
From:   dinh.nguyen@linux.intel.com
To:     linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Dinh Nguyen <dinh.nguyen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/5] units: add a macro for MILLIVOLT_PER_VOLT
Date:   Mon, 10 Apr 2023 10:33:10 -0500
Message-Id: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@linux.intel.com>

Add a define for MILLIVOLT_PER_VOLT.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
---
 include/linux/units.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index 2793a41e73a2..5b797535e1b9 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -31,6 +31,8 @@
 #define MICROWATT_PER_MILLIWATT	1000UL
 #define MICROWATT_PER_WATT	1000000UL
 
+#define MILLIVOLT_PER_VOLT	1000UL
+
 #define ABSOLUTE_ZERO_MILLICELSIUS -273150
 
 static inline long milli_kelvin_to_millicelsius(long t)
-- 
2.40.0

