Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E686B87BB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCNBlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCNBlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE4A72B10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758072; x=1710294072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vr8Kw7ba92HG1JhiR1fBD72PK2abpi9TsV7vewjYowA=;
  b=bZIRtRRooWMT3Q3vmwi8/KxsAQIxHwtVfYyi4soqKQhW+3oZ14Qp3u0/
   aD+uKJuAQ3MWusN1AUt01khcBCAlS8rklusQVV1Meba0AI2ZQp6fBY85W
   3vYlHud088JoxPGiKEMz2+Ry+3RJxXB3zn4lMm3o7+5ejDEBh+5uPk/1Q
   sdKhySkOhWn6qRfSf4ovh/XUog1zA72qEligd4JMnE6lmJas5q+m51SBt
   JKJWNM6LtTgw6+lSjKxEAiWubv+6dkLzym8QvOjTe939LB3OZmI6nLyj7
   MlBjIF8SV5wvZy7jpT/3Rt8FNGF6PjrXhw5WqBGtvOg0gNjiw1Cp60txL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949206"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949206"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327326"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327326"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:06 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 01/16] soundwire: intel: move common definitions to header file
Date:   Tue, 14 Mar 2023 09:53:55 +0800
Message-Id: <20230314015410.487311-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
References: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Prepare for reused for addition of new hardware

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 32 --------------------------------
 drivers/soundwire/intel.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 2651767272c7..20067f9cd128 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -19,38 +19,6 @@
 #include "bus.h"
 #include "intel.h"
 
-
-enum intel_pdi_type {
-	INTEL_PDI_IN = 0,
-	INTEL_PDI_OUT = 1,
-	INTEL_PDI_BD = 2,
-};
-
-#define cdns_to_intel(_cdns) container_of(_cdns, struct sdw_intel, cdns)
-
-/*
- * Read, write helpers for HW registers
- */
-static inline int intel_readl(void __iomem *base, int offset)
-{
-	return readl(base + offset);
-}
-
-static inline void intel_writel(void __iomem *base, int offset, int value)
-{
-	writel(value, base + offset);
-}
-
-static inline u16 intel_readw(void __iomem *base, int offset)
-{
-	return readw(base + offset);
-}
-
-static inline void intel_writew(void __iomem *base, int offset, u16 value)
-{
-	writew(value, base + offset);
-}
-
 static int intel_wait_bit(void __iomem *base, int offset, u32 mask, u32 target)
 {
 	int timeout = 10;
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index de9883313c8f..089c41babfc1 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -50,6 +50,35 @@ struct sdw_intel {
 #endif
 };
 
+enum intel_pdi_type {
+	INTEL_PDI_IN = 0,
+	INTEL_PDI_OUT = 1,
+	INTEL_PDI_BD = 2,
+};
+
+/*
+ * Read, write helpers for HW registers
+ */
+static inline int intel_readl(void __iomem *base, int offset)
+{
+	return readl(base + offset);
+}
+
+static inline void intel_writel(void __iomem *base, int offset, int value)
+{
+	writel(value, base + offset);
+}
+
+static inline u16 intel_readw(void __iomem *base, int offset)
+{
+	return readw(base + offset);
+}
+
+static inline void intel_writew(void __iomem *base, int offset, u16 value)
+{
+	writew(value, base + offset);
+}
+
 #define cdns_to_intel(_cdns) container_of(_cdns, struct sdw_intel, cdns)
 
 #define INTEL_MASTER_RESET_ITERATIONS	10
-- 
2.25.1

