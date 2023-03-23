Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAD26C5ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCWFau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCWFag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:30:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538F12211B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549417; x=1711085417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QfbLjJIQPJg7lVSuxR7cbrpfZiSh+vhV76tbkAhqcic=;
  b=SRy8m4PnMQEK2DDZm2PqgXuaQOU5QDBGmlXNj+E0+Uf9hyKmfZV4wsRN
   TCyBj603elTq48KKGwS5pIqHdU5uQeqhuHRvIkp67NXtsWTO+KbdkrS40
   VEbNi0ImdV7U3M4EhTeFJbnJ9+syX6N+O/EFCp3quv8yV2T5nV7Heau6X
   0ndEyi/ve6Vuq6A72ZpLGPeGbLfM/h5BhZ5livPLXRE1A89BsekO0Zs8X
   etoi9NZ5M2NspReiMrjXEfLkiKNqbkWxRnxwwyDelFwTUVnmSKHQVvzIv
   kitxk3HUyH9ZSj0uOVxJ2BnrOJo2n+mcWchTG0fIYMHTcnA/VflIIT/T0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779297"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779297"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:29:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675566992"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675566992"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:29:55 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 03/20] soundwire: intel_ace2x: add empty new ops for LunarLake
Date:   Thu, 23 Mar 2023 13:44:35 +0800
Message-Id: <20230323054452.1543233-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
References: <20230323054452.1543233-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The register map and programming sequences for the ACE2.x IP are
completely different and need to be abstracted with a different set of
callbacks.

This initial patch adds a new file, follow-up patches will add each
required callback.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/Makefile          |  2 +-
 drivers/soundwire/intel_ace2x.c     | 19 +++++++++++++++++++
 include/linux/soundwire/sdw_intel.h |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soundwire/intel_ace2x.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 8038e840ac5b..d7212777a927 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -20,7 +20,7 @@ soundwire-cadence-y := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
 
 #Intel driver
-soundwire-intel-y :=	intel.o intel_auxdevice.o intel_init.o dmi-quirks.o \
+soundwire-intel-y :=	intel.o  intel_ace2x.o intel_auxdevice.o intel_init.o dmi-quirks.o \
 			intel_bus_common.o
 obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
 
diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
new file mode 100644
index 000000000000..623e4fd7db91
--- /dev/null
+++ b/drivers/soundwire/intel_ace2x.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+// Copyright(c) 2023 Intel Corporation. All rights reserved.
+
+/*
+ * Soundwire Intel ops for LunarLake
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_intel.h>
+#include "cadence_master.h"
+#include "bus.h"
+#include "intel.h"
+
+const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
+};
+EXPORT_SYMBOL_NS(sdw_intel_lnl_hw_ops, SOUNDWIRE_INTEL);
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 8e6183e029fa..66687e83a94f 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -419,5 +419,6 @@ struct sdw_intel_hw_ops {
 };
 
 extern const struct sdw_intel_hw_ops sdw_intel_cnl_hw_ops;
+extern const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops;
 
 #endif
-- 
2.25.1

