Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067E86C2A01
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCUFrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCUFr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:47:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6674B298FD;
        Mon, 20 Mar 2023 22:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679377645; x=1710913645;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7BhFhs8BuGPv7rmu8S+dpE17X+MFawyQP4/vYdI0Bt4=;
  b=c/NlWFT73VVtC2w0WrQaopjg5B1uXYb1+wCtSIdvEDtW802Ixix2N1Qs
   jpUtlcGI98tpk4ELky3FEocxMSrVyKagOOt8FMa5rR+YceMp66iInt1bf
   BbLnTLTFpygc5bOYsW7gOmhDtCbOQG3USiv9mCYQaDEltii3d6+uRTxlA
   oXMxXufkZCkPfjLD+Y0QSGcfX/MOxiPHMGFO9X0KYMaesyGUeNGXYUVzj
   sGqnE+FmcR8NslJMam+WQfNIel3H5LjBBFphe0FMYMcbAdc9xi8rT8j0Z
   F0IZ3Sxbl18zXRWlAy2WuRQaTxNXoigGkjs4+ux1GgQEhI6cDInm2peVz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="336359299"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="336359299"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:47:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="927271464"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="927271464"
Received: from zhouf-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.171.160])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:47:23 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal/governors/step_wise: delete obsolete comment
Date:   Tue, 21 Mar 2023 13:47:13 +0800
Message-Id: <20230321054714.76287-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4102c4042a33 ("thermal/core: Remove DROP_FULL and RAISE_FULL")
removes support for THERMAL_TREND_RAISE_FULL/DROP_FULL but leaves the
comment unchanged.

Delete the obsolte comment about THERMAL_TREND_RAISE_FULL/DROP_FULL.

Fixes: 4102c4042a33 ("thermal/core: Remove DROP_FULL and RAISE_FULL")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/gov_step_wise.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 31235e169c5a..7a760b6a4279 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -21,19 +21,11 @@
  *    a. if the trend is THERMAL_TREND_RAISING, use higher cooling
  *       state for this trip point
  *    b. if the trend is THERMAL_TREND_DROPPING, do nothing
- *    c. if the trend is THERMAL_TREND_RAISE_FULL, use upper limit
- *       for this trip point
- *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
- *       for this trip point
  * If the temperature is lower than a trip point,
  *    a. if the trend is THERMAL_TREND_RAISING, do nothing
  *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
  *       state for this trip point, if the cooling state already
  *       equals lower limit, deactivate the thermal instance
- *    c. if the trend is THERMAL_TREND_RAISE_FULL, do nothing
- *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit,
- *       if the cooling state already equals lower limit,
- *       deactivate the thermal instance
  */
 static unsigned long get_target_state(struct thermal_instance *instance,
 				enum thermal_trend trend, bool throttle)
-- 
2.25.1

