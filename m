Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559496BBC30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjCOSee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjCOSeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1719D40D3;
        Wed, 15 Mar 2023 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905253; x=1710441253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L00M9MXhIWKlvY9DN1BY3XH1GCJuxFHrq9jz+q4X/hA=;
  b=GHurIbEE0omo52F9FiRAeAjQWpTIIaPr5lrVGdz+JV6U4xHNNtO62p7s
   +XNZFJP6oO+EYH1viByoweF3vtYoN06oDrZME/+hXve3sxtZ1i3J+RZGN
   0d9dDQWyAkIjyU7Sy4kPPDfYTUMH5vz91OM2oIW0tAhe60scEmDY631my
   4ldNxUPwQXkF1M0/ibMUGphAtF+ewOYqTr6mUszpV8u4NAMQu4RyTMRpo
   DfloH8lbkLrgbCseH+JaxeZetOBk1hR1ffqH+ogIPpw2IrbNRnWqeqvyL
   5hetSJ02Xt3EMJ8IsVzx+erXBfaLr7/6TRW/kUT1sar482qxNg81WDJeF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340154549"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340154549"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925435213"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925435213"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:34:07 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.75.205])
        by linux.intel.com (Postfix) with ESMTP id 8CD42580C6E;
        Wed, 15 Mar 2023 11:34:07 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 06/11] platform/x86/intel/pmt/telemetry: Add driver version
Date:   Wed, 15 Mar 2023 11:34:00 -0700
Message-Id: <20230315183405.2465630-7-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315183405.2465630-1-david.e.box@linux.intel.com>
References: <20230315183405.2465630-1-david.e.box@linux.intel.com>
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

Add a driver version number to make it easier to track changes in
backported kernels.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/telemetry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
index 39ec8d9fb5b1..7593726e814d 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -19,6 +19,7 @@
 #include "../vsec.h"
 #include "class.h"
 
+#define DRIVER_VERSION		"1.0"
 #define TELEM_SIZE_OFFSET	0x0
 #define TELEM_GUID_OFFSET	0x4
 #define TELEM_BASE_OFFSET	0x8
@@ -348,4 +349,5 @@ module_exit(pmt_telem_exit);
 MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
 MODULE_DESCRIPTION("Intel PMT Telemetry driver");
 MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRIVER_VERSION);
 MODULE_IMPORT_NS(INTEL_PMT);
-- 
2.34.1

