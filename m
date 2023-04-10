Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3FE6DC8AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 17:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDJPnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjDJPm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 11:42:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068E01BCA;
        Mon, 10 Apr 2023 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681141378; x=1712677378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FGV+fdCgw3aBzLM/prNQt4Br3a3O7eyOg7GihjhTucw=;
  b=kYcZcWcuftunIHrUyNB1vMc5is3ZmqzvFgdQ3hcqyhEKLgblHQYVox8G
   KIQDOYWab8j1kTGtbVyLwc+3Fncl2R9HOeFj2+0DH46q+cchMVMwgAPYz
   wPEeQMBVxFFgNhVOakpZVIGayi+k7N0T4wJ9fncCLktneLbR8f1Rep+g0
   lYkPGKSNlguhOVU1LjH2uPygwvgwyvQFcgHwAe6jUC/x6aVEu50NLt/Q1
   xFdRKaoRY/1wMRtsiOwConhXwwu7HKS1uVxyi/IzONoA40xTTDRNoLMS/
   aI5nCtjmR/tRFgHLuT14jsTF7Ytn++RMikgoL3R+kIrBk/e0cLhqZZeou
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340868168"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="340868168"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 08:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757482051"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="757482051"
Received: from linux-builds1.an.intel.com ([10.122.105.32])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 08:42:56 -0700
From:   dinh.nguyen@linux.intel.com
To:     linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Dinh Nguyen <dinh.nguyen@linux.intel.com>
Subject: [PATCH 4/5] MAINTAINERS: add Dinh Nguyen for socfpga-hwmon driver
Date:   Mon, 10 Apr 2023 10:33:13 -0500
Message-Id: <20230410153314.27127-4-dinh.nguyen@linux.intel.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
References: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
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

Add Dinh Nguyen as the maintainer for the SoCFPGA hardware monitor
driver.

Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..064f9db7ffe1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2781,6 +2781,12 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/edac/altera_edac.[ch]
 
+ARM/SOCFPGA HARDWARE MONITOR
+M:	Dinh Nguyen <dinh.nguyen@linux.intel.com>
+S:	Maintained
+F:	drivers/hwmon/socfpga-hwmon.c
+F:	Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
+
 ARM/SPREADTRUM SoC SUPPORT
 M:	Orson Zhai <orsonzhai@gmail.com>
 M:	Baolin Wang <baolin.wang7@gmail.com>
-- 
2.40.0

