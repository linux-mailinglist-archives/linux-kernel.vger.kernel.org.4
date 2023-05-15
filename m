Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EE2702571
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbjEOGxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240332AbjEOGxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:53:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FDDC2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 23:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684133554; x=1715669554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P4I4WMgNIQxYQ334Q+vWNS1kymuWnkPuLaU0h554R2Q=;
  b=aDZrahoO9qnOb+BaXAlTuzRLwfI0qVsAhDMdk3DOkMQ+zWXbiHXcvsQq
   M0UjSt5pC86fuXEOMggx53gb6Pk4EgpRM78Zj1b44M4yxoOG/hPurNwuf
   GqA5cKqbQZkktwl0ErBMj1nfwACrJtpPOzC/EdjICw7DB2mw0/NZzWTBD
   spg1CRZ5/jUEOuJd8anikyLzCPNlQ8CFlFywLdxfOwdUMmxt17EB9VgVR
   QRF+zHVySEFIL4f2/zX4z++rHar90OC1zQ/AiM+8SfVX0a+VDMD/AdqcU
   pwvvrBl1T1K5c4blIW3gmZsNvWnVruq43WKcypxOUPKQbNtJmbfTEZcez
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349966555"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349966555"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:51:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="694908791"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="694908791"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 23:51:13 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org,
        tiwai@suse.de
Cc:     linux-kernel@vger.kernel.org, vinod.koul@linaro.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH v2 23/26] soundwire: intel: remove .trigger callback implementation
Date:   Mon, 15 May 2023 15:10:39 +0800
Message-Id: <20230515071042.2038-24-yung-chuan.liao@linux.intel.com>
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

The interface is not needed for IPC3 solutions but will be needed
with an updated parameter list for ACE2.x+IPC4 combinations.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c8eb1ec512c4..15cecd2e062d 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -872,18 +872,9 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_intel *sdw = cdns_to_intel(cdns);
-	struct sdw_intel_link_res *res = sdw->link_res;
 	struct sdw_cdns_dai_runtime *dai_runtime;
 	int ret = 0;
 
-	/*
-	 * The .trigger callback is used to send required IPC to audio
-	 * firmware. The .free_stream callback will still be called
-	 * by intel_free_stream() in the TRIGGER_SUSPEND case.
-	 */
-	if (res->ops && res->ops->trigger)
-		res->ops->trigger(dai, cmd, substream->stream);
-
 	dai_runtime = cdns->dai_runtime_array[dai->id];
 	if (!dai_runtime) {
 		dev_err(dai->dev, "failed to get dai runtime in %s\n",
-- 
2.25.1

