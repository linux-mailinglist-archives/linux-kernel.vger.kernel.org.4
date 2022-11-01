Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC259615203
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKATLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiKATLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:11:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1769C1DF27;
        Tue,  1 Nov 2022 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667329861; x=1698865861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BsFd6K0vbA/ZPFxh0y/0GJ1X/IwutzDVqy/9HTmBpgE=;
  b=LHBz2zh5RtuycRJshqoxKUvr2A9qkS4Nh5I9xC7v7NAnKLZwPiG1EazY
   55SYqltL97Feu1Z/oNCk+GmOxKycGngtGGkbDpQhKNL7jsQ8zHZlFOtbS
   bzxLcJYkiLPYDnafcp7/iaunwKlaF/xfVj+Of8EFFY+x2wF62SQ2Bp2dm
   HVQP3sqJZNAlb3fsbsbLQTPNzzn4v4ZUpZqvlK7TitaJIdrTtlwQbyHp/
   GcWgo9/qf9Ox40qEMZHc2BdjJLOfaTLaBNB3V01Y+SOGeLuPoeH54to5w
   1UUrucSFp30tzEvSegcpDeyhDzwi911BrlF5wJyFbVk1ybzdjWOHcl2EW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310932227"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="310932227"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 12:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="611951132"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="611951132"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 01 Nov 2022 12:10:26 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.195.64])
        by linux.intel.com (Postfix) with ESMTP id 15303580B9D;
        Tue,  1 Nov 2022 12:10:26 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] platform/x86/intel/sdsi: Add Intel On Demand text
Date:   Tue,  1 Nov 2022 12:10:15 -0700
Message-Id: <20221101191023.4150315-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101191023.4150315-1-david.e.box@linux.intel.com>
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Software Defined Silicon (SDSi) is now officially known as Intel
On Demand. Add On Demand to the description in the kconfig, documentation,
and driver source.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 .../ABI/testing/sysfs-driver-intel_sdsi       | 37 ++++++++++---------
 drivers/platform/x86/intel/Kconfig            |  8 ++--
 drivers/platform/x86/intel/sdsi.c             |  4 +-
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel_sdsi b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
index 96b92c105ec4..9d77f30d9b9a 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel_sdsi
+++ b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
@@ -4,21 +4,21 @@ KernelVersion:	5.18
 Contact:	"David E. Box" <david.e.box@linux.intel.com>
 Description:
 		This directory contains interface files for accessing Intel
-		Software Defined Silicon (SDSi) features on a CPU. X
-		represents the socket instance (though not the socket ID).
-		The socket ID is determined by reading the registers file
-		and decoding it per the specification.
+		On Demand (formerly Software Defined Silicon or SDSi) features
+		on a CPU. X represents the socket instance (though not the
+		socket ID). The socket ID is determined by reading the
+		registers file and decoding it per the specification.
 
-		Some files communicate with SDSi hardware through a mailbox.
-		Should the operation fail, one of the following error codes
-		may be returned:
+		Some files communicate with On Demand hardware through a
+		mailbox. Should the operation fail, one of the following error
+		codes may be returned:
 
 		==========	=====
 		Error Code	Cause
 		==========	=====
 		EIO		General mailbox failure. Log may indicate cause.
 		EBUSY		Mailbox is owned by another agent.
-		EPERM		SDSI capability is not enabled in hardware.
+		EPERM		On Demand capability is not enabled in hardware.
 		EPROTO		Failure in mailbox protocol detected by driver.
 				See log for details.
 		EOVERFLOW	For provision commands, the size of the data
@@ -54,8 +54,8 @@ KernelVersion:	5.18
 Contact:	"David E. Box" <david.e.box@linux.intel.com>
 Description:
 		(WO) Used to write an Authentication Key Certificate (AKC) to
-		the SDSi NVRAM for the CPU. The AKC is used to authenticate a
-		Capability Activation Payload. Mailbox command.
+		the On Demand NVRAM for the CPU. The AKC is used to authenticate
+		a Capability Activation Payload. Mailbox command.
 
 What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/provision_cap
 Date:		Feb 2022
@@ -63,17 +63,18 @@ KernelVersion:	5.18
 Contact:	"David E. Box" <david.e.box@linux.intel.com>
 Description:
 		(WO) Used to write a Capability Activation Payload (CAP) to the
-		SDSi NVRAM for the CPU. CAPs are used to activate a given CPU
-		feature. A CAP is validated by SDSi hardware using a previously
-		provisioned AKC file. Upon successful authentication, the CPU
-		configuration is updated. A cold reboot is required to fully
-		activate the feature. Mailbox command.
+		On Demand NVRAM for the CPU. CAPs are used to activate a given
+		CPU feature. A CAP is validated by On Demand hardware using a
+		previously provisioned AKC file. Upon successful authentication,
+		the CPU configuration is updated. A cold reboot is required to
+		fully activate the feature. Mailbox command.
 
 What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/state_certificate
 Date:		Feb 2022
 KernelVersion:	5.18
 Contact:	"David E. Box" <david.e.box@linux.intel.com>
 Description:
-		(RO) Used to read back the current State Certificate for the CPU
-		from SDSi hardware. The State Certificate contains information
-		about the current licenses on the CPU. Mailbox command.
+		(RO) Used to read back the current state certificate for the CPU
+		from On Demand hardware. The state certificate contains
+		information about the current licenses on the CPU. Mailbox
+		command.
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 794968bda115..d5a33473e838 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -157,13 +157,13 @@ config INTEL_RST
 	  as usual.
 
 config INTEL_SDSI
-	tristate "Intel Software Defined Silicon Driver"
+	tristate "Intel On Demand (Software Defined Silicon) Driver"
 	depends on INTEL_VSEC
 	depends on X86_64
 	help
-	  This driver enables access to the Intel Software Defined Silicon
-	  interface used to provision silicon features with an authentication
-	  certificate and capability license.
+	  This driver enables access to the Intel On Demand (formerly Software
+	  Defined Silicon) interface used to provision silicon features with an
+	  authentication certificate and capability license.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_sdsi.
diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index c830e98dfa38..32793919473d 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Intel Software Defined Silicon driver
+ * Intel On Demand (Software Defined Silicon) driver
  *
  * Copyright (c) 2022, Intel Corporation.
  * All Rights Reserved.
@@ -586,5 +586,5 @@ static struct auxiliary_driver sdsi_aux_driver = {
 module_auxiliary_driver(sdsi_aux_driver);
 
 MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
-MODULE_DESCRIPTION("Intel Software Defined Silicon driver");
+MODULE_DESCRIPTION("Intel On Demand (SDSi) driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

