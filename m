Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4306F702575
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbjEOGyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240483AbjEOGxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:53:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3C199F
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133573; x=1715669573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7HU4GkkFBUz3CDwO3kK4aBa3k7/H20TmG32LVN6IOSQ=;
  b=edVJDUa+ozApmZ2dERc0R4BRi5Dt1XdVlwX2sVzxniuvnZxz22mHFQcR
   eaO+BQo8T0SvTULrLvUdwTGM/R5bKDmVYXC31uUgLZ3bcf46rsHw/ngBx
   0txhXo39e4JKwuZSfoNGr5sIxS3Zl37a52VTwUbxVCYnmX4DF/dEqKPsj
   TujTdq4fzbyhqlAbGmEF653wdhmEM05Vm/TDL+McVVefmKXPypHNHnDip
   hTARD7cd1QXtgQaePgxc3PIQSNvJ5zUCSSIt0qcIh8UhiobPKSb2MmG2U
   qUC5zYjLNheuMWrkyUxlKYEwKcPESDu8TJRIyqp/rTV1fV+XcBErNFL5p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966573"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966573"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:51:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908802"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908802"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:51:18 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 25/26] soundwire: intel: remove .free callback implementation
Date:   Mon, 15 May 2023 15:10:41 +0800
Message-Id: <20230515071042.2038-26-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
References: <20230515071042.2038-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
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

The interface is not needed for IPC3 solution but will be needed with
an updated parameter list for ACE2.x+IPC4 combinations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 37 +------------------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 15cecd2e062d..f52167aa48db 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -663,25 +663,6 @@ static int intel_params_stream(struct sdw_intel *sdw,
 	return -EIO;
 }
 
-static int intel_free_stream(struct sdw_intel *sdw,
-			     int stream,
-			     struct snd_soc_dai *dai,
-			     int link_id)
-{
-	struct sdw_intel_link_res *res = sdw->link_res;
-	struct sdw_intel_stream_free_data free_data;
-
-	free_data.stream = stream; /* direction */
-	free_data.dai = dai;
-	free_data.link_id = link_id;
-
-	if (res->ops && res->ops->free_stream && res->dev)
-		return res->ops->free_stream(res->dev,
-					     &free_data);
-
-	return 0;
-}
-
 /*
  * DAI routines
  */
@@ -817,7 +798,6 @@ static int
 intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_cdns_dai_runtime *dai_runtime;
 	int ret;
 
@@ -838,12 +818,6 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 		return ret;
 	}
 
-	ret = intel_free_stream(sdw, substream->stream, dai, sdw->instance);
-	if (ret < 0) {
-		dev_err(dai->dev, "intel_free_stream: failed %d\n", ret);
-		return ret;
-	}
-
 	dai_runtime->pdi = NULL;
 
 	return 0;
@@ -871,7 +845,6 @@ static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
 static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct snd_soc_dai *dai)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
-	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_cdns_dai_runtime *dai_runtime;
 	int ret = 0;
 
@@ -894,7 +867,6 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 
 		dai_runtime->suspended = true;
 
-		ret = intel_free_stream(sdw, substream->stream, dai, sdw->instance);
 		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
@@ -940,9 +912,7 @@ static int intel_component_dais_suspend(struct snd_soc_component *component)
 	 */
 	for_each_component_dais(component, dai) {
 		struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
-		struct sdw_intel *sdw = cdns_to_intel(cdns);
 		struct sdw_cdns_dai_runtime *dai_runtime;
-		int ret;
 
 		dai_runtime = cdns->dai_runtime_array[dai->id];
 
@@ -952,13 +922,8 @@ static int intel_component_dais_suspend(struct snd_soc_component *component)
 		if (dai_runtime->suspended)
 			continue;
 
-		if (dai_runtime->paused) {
+		if (dai_runtime->paused)
 			dai_runtime->suspended = true;
-
-			ret = intel_free_stream(sdw, dai_runtime->direction, dai, sdw->instance);
-			if (ret < 0)
-				return ret;
-		}
 	}
 
 	return 0;
-- 
2.25.1

