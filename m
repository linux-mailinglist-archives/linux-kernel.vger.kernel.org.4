Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959366C5ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCWFay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjCWFah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:30:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3116B222F8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549419; x=1711085419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSkxVbe47xbUsq7avOoYR8upNoWBv4uK3aM/asFJSEA=;
  b=TJH7MxmDgLy9N7rxTVfE6M+uszLK5LYTlsBPnH8sTYGXTJHPaXz2At8f
   yrUeijr4hBfnouts/YI3Po9w7sUW7ip/OrsdVLTEDbcU8q7YJSA4Rv+ow
   mL9ka/LNaMFFA8MJDA+bT+L0JWBJvx/JPuejJakfI9qTDfIbLm5ilhMR2
   c0sFLz7kKjs9HCDyon+aP7+GtFOlwUnTzzhbJoqRca/G2phuQWW4ub2wx
   hh6iKH8617FX/HoC4MmV4MrW5FOxe2PX9XoHIx7R6HbcPB2lq9yqvDbpS
   10L/mb4uZwoJ/xcU3yFLpoac0YOab0qBbMGewRoqzBB+UbnoOo/kGQv8k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779308"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779308"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:30:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675566998"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675566998"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:29:58 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 04/20] soundwire/ASOC: Intel: update offsets for LunarLake
Date:   Thu, 23 Mar 2023 13:44:36 +0800
Message-Id: <20230323054452.1543233-5-yung-chuan.liao@linux.intel.com>
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

The previous settings are not applicable, use a flag to determine what
the register layout is.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.h           |  2 ++
 drivers/soundwire/intel_init.c      | 14 ++++++++++----
 include/linux/soundwire/sdw_intel.h |  2 ++
 sound/soc/sof/intel/hda.c           | 21 +++++++++++++++++----
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index 09d479f2c77b..51aa42a5a824 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -11,6 +11,7 @@
  * @mmio_base: mmio base of SoundWire registers
  * @registers: Link IO registers base
  * @shim: Audio shim pointer
+ * @shim_vs: Audio vendor-specific shim pointer
  * @alh: ALH (Audio Link Hub) pointer
  * @irq: Interrupt line
  * @ops: Shim callback ops
@@ -28,6 +29,7 @@ struct sdw_intel_link_res {
 	void __iomem *mmio_base; /* not strictly needed, useful for debug */
 	void __iomem *registers;
 	void __iomem *shim;
+	void __iomem *shim_vs;
 	void __iomem *alh;
 	int irq;
 	const struct sdw_intel_ops *ops;
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index cbe56b993c6c..e0023af9e0e1 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -63,10 +63,16 @@ static struct sdw_intel_link_dev *intel_link_dev_register(struct sdw_intel_res *
 	link = &ldev->link_res;
 	link->hw_ops = res->hw_ops;
 	link->mmio_base = res->mmio_base;
-	link->registers = res->mmio_base + SDW_LINK_BASE
-		+ (SDW_LINK_SIZE * link_id);
-	link->shim = res->mmio_base + res->shim_base;
-	link->alh = res->mmio_base + res->alh_base;
+	if (!res->ext) {
+		link->registers = res->mmio_base + SDW_LINK_BASE
+			+ (SDW_LINK_SIZE * link_id);
+		link->shim = res->mmio_base + res->shim_base;
+		link->alh = res->mmio_base + res->alh_base;
+	} else {
+		link->registers = res->mmio_base + SDW_IP_BASE(link_id);
+		link->shim = res->mmio_base +  SDW_SHIM2_GENERIC_BASE(link_id);
+		link->shim_vs = res->mmio_base + SDW_SHIM2_VS_BASE(link_id);
+	}
 
 	link->ops = res->ops;
 	link->dev = res->dev;
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 66687e83a94f..88eb5bf98140 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -323,6 +323,7 @@ struct sdw_intel_ctx {
  * DSP driver. The quirks are common for all links for now.
  * @shim_base: sdw shim base.
  * @alh_base: sdw alh base.
+ * @ext: extended HDaudio link support
  */
 struct sdw_intel_res {
 	const struct sdw_intel_hw_ops *hw_ops;
@@ -337,6 +338,7 @@ struct sdw_intel_res {
 	u32 clock_stop_quirks;
 	u32 shim_base;
 	u32 alh_base;
+	bool ext;
 };
 
 /*
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 81c697e20108..db103524be4f 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -198,6 +198,7 @@ static int hda_sdw_acpi_scan(struct snd_sof_dev *sdev)
 
 static int hda_sdw_probe(struct snd_sof_dev *sdev)
 {
+	const struct sof_intel_dsp_desc *chip;
 	struct sof_intel_hda_dev *hdev;
 	struct sdw_intel_res res;
 	void *sdw;
@@ -206,10 +207,22 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 
 	memset(&res, 0, sizeof(res));
 
-	res.hw_ops = &sdw_intel_cnl_hw_ops;
-	res.mmio_base = sdev->bar[HDA_DSP_BAR];
-	res.shim_base = hdev->desc->sdw_shim_base;
-	res.alh_base = hdev->desc->sdw_alh_base;
+	chip = get_chip_info(sdev->pdata);
+	if (chip->hw_ip_version < SOF_INTEL_ACE_2_0) {
+		res.mmio_base = sdev->bar[HDA_DSP_BAR];
+		res.hw_ops = &sdw_intel_cnl_hw_ops;
+		res.shim_base = hdev->desc->sdw_shim_base;
+		res.alh_base = hdev->desc->sdw_alh_base;
+		res.ext = false;
+	} else {
+		res.mmio_base = sdev->bar[HDA_DSP_HDA_BAR];
+		/*
+		 * the SHIM and SoundWire register offsets are link-specific
+		 * and will be determined when adding auxiliary devices
+		 */
+		res.hw_ops = &sdw_intel_lnl_hw_ops;
+		res.ext = true;
+	}
 	res.irq = sdev->ipc_irq;
 	res.handle = hdev->info.handle;
 	res.parent = sdev->dev;
-- 
2.25.1

