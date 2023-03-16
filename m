Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656596BDC22
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCPW5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjCPW5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:57:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C75ED7C14;
        Thu, 16 Mar 2023 15:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679007458; x=1710543458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qwbi8WFPAtRQ/5UGVKeLue4Y8i0TM3Lz0+U0sm0VmRY=;
  b=PIUz2WUr8xOvg8DGtqg57NUmJkTAXOzCmElX+uyvq4p+ZnhGQVH/6+In
   Nk9r2YoXwp35z9kLrtCQkc1dQrNfhc21qZhGqvoaU15/x4Pq4ANfKirTJ
   u1Gyj6JOL2U7ofiBOE3iJNZR09wfvXk3C/DHt9qjvLnDXGppYv2mYkFPI
   9/FBRJfwhvQoaY2xfHCNgbU3i+pTzuphzq+q1x8R5hcKW9FMIDyj7JV7c
   8DNlq5Ep8YmR5N38zK4aGUW6hpxSEvbbxLk5QYSJM/dz7xtVsxuaxIeRH
   P7VNiKDx2DW1dlOA44kCCuSn6kz0Pqimfk/BuIiTyXdsalffYN5smuVmt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="321984201"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="321984201"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 15:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="803914132"
X-IronPort-AV: E=Sophos;i="5.98,267,1673942400"; 
   d="scan'208";a="803914132"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2023 15:57:36 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.175.15])
        by linux.intel.com (Postfix) with ESMTP id A1A3F580C4C;
        Thu, 16 Mar 2023 15:57:36 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/2] platform/x86/intel/pmt/telemetry: Add driver version
Date:   Thu, 16 Mar 2023 15:57:36 -0700
Message-Id: <20230316225736.2856521-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316225736.2856521-1-david.e.box@linux.intel.com>
References: <20230316225736.2856521-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 71cdef42084a..deb96b5777ce 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -19,6 +19,7 @@
 #include "../vsec.h"
 #include "class.h"
 
+#define DRIVER_VERSION		"1.0"
 #define TELEM_SIZE_OFFSET	0x0
 #define TELEM_GUID_OFFSET	0x4
 #define TELEM_BASE_OFFSET	0x8
@@ -160,4 +161,5 @@ module_exit(pmt_telem_exit);
 MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
 MODULE_DESCRIPTION("Intel PMT Telemetry driver");
 MODULE_LICENSE("GPL v2");
+MODULE_VERSION(DRIVER_VERSION);
 MODULE_IMPORT_NS(INTEL_PMT);
-- 
2.34.1

