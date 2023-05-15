Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8C70254E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbjEOGu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbjEOGuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:50:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB818F
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133423; x=1715669423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ulAOPJpFKU1kbrYfiKz1ABKjFv/hYupKOQurQHC/rd0=;
  b=N97dpRR1MiDhi1Vydoi8otmJatInDRA/mskAFBGQuslNhrt03WAV2e9k
   EAn7vOQ2XpUMeXO+jP98XihdIQYSRpfegBaT2uiqQ5HbbZfpS41Zi+wfs
   XmY+Q/KIw2YWTZq6z4aeqwnYVPPCZcXO8iOqD0KSIkQSajXb4x1ZDHTqz
   iXI8OeU97IZUcQnwCrQmPpMFpmqOjziT7qIV/eRfSf3NsZ8o9hbc45OU8
   bYWe7pPdkP19YhYJl9NOoCXkvLi2v7UcBHCOqlLsmcmoyAfqfdUbvosgZ
   5p/vlBoN61WEYJl1OvRo7UhhvOzL1Vy/zzX75H48s09sY4p3RcmS2yrMs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966250"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966250"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908576"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908576"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:50:21 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 01/26] ASoC: SOF: Intel: shim: add enum for ACE 2.0 IP used in LunarLake
Date:   Mon, 15 May 2023 15:10:17 +0800
Message-Id: <20230515071042.2038-2-yung-chuan.liao@linux.intel.com>
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

Add the new enum needed for SoundWire IP selection. The LunarLake PCI
descriptors and DSP parts will be added at a later time.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/shim.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/shim.h b/sound/soc/sof/intel/shim.h
index 48428ccbcfe0..207df48e27cf 100644
--- a/sound/soc/sof/intel/shim.h
+++ b/sound/soc/sof/intel/shim.h
@@ -21,6 +21,7 @@ enum sof_intel_hw_ip_version {
 	SOF_INTEL_CAVS_2_0,	/* IceLake, JasperLake */
 	SOF_INTEL_CAVS_2_5,	/* TigerLake, AlderLake */
 	SOF_INTEL_ACE_1_0,	/* MeteorLake */
+	SOF_INTEL_ACE_2_0,	/* LunarLake */
 };
 
 /*
-- 
2.25.1

