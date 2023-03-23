Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4C6C5ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 06:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjCWF35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 01:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjCWF3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 01:29:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4361E20050
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 22:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679549393; x=1711085393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jSG2veXKUxcXyV1zpGUhKNlxMdGkTNUGl0TfqUCdrR0=;
  b=nBme8f7xb3aJdQdLHuZgKrfnYVrdNcJFQ9TlMVY6E9hTT2N0EGtOZSOx
   acrZhMuIQ+HTjkrzZxkbIyQ+SC6edvPE31UQSLym/DZFv8uyHT6i2MzjW
   t+5AGPlgT1WPqKvIBiSN7NV8cdyAD1Cppdwrx+b7ImskRGOPfZ9LjFhGj
   Xs2R7eoxomi8YI6R16wk7lsAD3AbrnWcknfLz31XOhpvrwFQdXz/j2JdG
   Ubzm4qDmxGTWvwOjbQFyaMx/O21yvBBwyrk/hHmCOQPdpPGU5Ncbyzhkq
   gVHoD+m7VzCqNDHfjKuM3MUTp67033mGp0D9iGccSiVRiDYxOjbBr2651
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327779279"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327779279"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675566986"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="675566986"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:29:50 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org, broonie@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        tiwai@suse.de
Subject: [PATCH 01/20] ASoC: SOF: Intel: shim: add enum for ACE 2.0 IP used in LunarLake
Date:   Thu, 23 Mar 2023 13:44:33 +0800
Message-Id: <20230323054452.1543233-2-yung-chuan.liao@linux.intel.com>
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

Add the new enum needed for SoundWire IP selection. The LunarLake PCI
descriptors and DSP parts will be added at a later time.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
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

