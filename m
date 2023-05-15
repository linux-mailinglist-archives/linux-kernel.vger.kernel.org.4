Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D55E702551
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbjEOGuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbjEOGue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:50:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC61D10EF
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133431; x=1715669431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kmDbCUIES+5ZVKXI71LGbR/AUG9G2hwf5/ixjyhOExs=;
  b=Cqe9DJftSm9NWlLYnOPKR/KfhojTVNW8jicZkte96+tbyLyr0kjnOG+v
   N7k2dXcsnORXhbhHIJ3VM13eaBxerQP4lZrtKadnAmdER5K4z2aacfA/d
   jEyzoNxDZev7gS6FZ8v9bwS3tJcH6J+KTbkwR8qMmoubZtgQowg/oGbdE
   hgpoyPJ4hTgeoIzeYWoihV7E60c3/pArGi32i1MpfE/yPFvmcJRfXSX13
   cWEEDQM0Z9fSLsr4iDGSQIhlQZZk9aGLq0kBshHNe9aX9n+bIL1wZOX5g
   g+7x6Lufxjh7+YdBzPmXUOr2VYSqjMbt1vYdap+Lpi+qnyi2GRY2fV/Hq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966301"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966301"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908617"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908617"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:28 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 04/26] soundwire/ASOC: Intel: update offsets for LunarLake
Date:   Mon, 15 May 2023 15:10:20 +0800
Message-Id: <20230515071042.2038-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Acked-by: Mark Brown <broonie@kernel.org>
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
index 3153e21f100a..793baf60c78b 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -158,6 +158,7 @@ static int hda_sdw_acpi_scan(struct snd_sof_dev *sdev)
 
 static int hda_sdw_probe(struct snd_sof_dev *sdev)
 {
+	const struct sof_intel_dsp_desc *chip;
 	struct sof_intel_hda_dev *hdev;
 	struct sdw_intel_res res;
 	void *sdw;
@@ -166,10 +167,22 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 
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

