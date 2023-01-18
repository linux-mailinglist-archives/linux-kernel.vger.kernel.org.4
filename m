Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4E86725A5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjARR5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjARR5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:57:08 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026692B085;
        Wed, 18 Jan 2023 09:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674064627; x=1705600627;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a2bY/K3MV1nGZNslJAsRd2Srfyw3ubd/fdA69ta9Y5U=;
  b=b5WtfSxOaDBt+cJPfOGUCpv3D3tKPggGPj7mYEySumovxaFCWbOzyI/L
   QsEjmb5ohN93jDeCkdlIusEnJOR/PxzN2M2IrDoiypr6A8Ok+mszj2uJO
   9rZlRJLgkNyhQIoHYeD7JlOK4AP0Wfz3ABbJBItYX0VemQAnOIUqiBKHb
   Y+8NcU0RXliumPZAnN8MMpj81TU0S3HeiVugzB+zWncI11GAjFcMqYbp1
   CM7JDTQ0zdwwsNxt2yIi/TTrw53yJcsY3QUW/S+tedMYFBFxArPrJ/SsJ
   9b9X0TJzWa1G4rZDvnGhWRXqm180SWVWZ+OHfsJuIM9aTnskvncz0oVhh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="352303090"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="352303090"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 09:57:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="748558916"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="748558916"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2023 09:57:05 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     artem.bityutskiy@linux.intel.com, andi.kleen@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf vendor events intel: Add Emerald Rapids
Date:   Wed, 18 Jan 2023 09:56:32 -0800
Message-Id: <20230118175632.3165217-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The event list of the Emerald Rapids is the same as the Sapphire
Rapids. Add the CPU model ID of Emerald Rapids into the mapfile.csv and
point it to the event list of Sapphire Rapids.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 711a4ef05fdf..5facdac6fe8e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -21,7 +21,7 @@ GenuineIntel-6-A[AC],v1.00,meteorlake,core
 GenuineIntel-6-1[AEF],v3,nehalemep,core
 GenuineIntel-6-2E,v3,nehalemex,core
 GenuineIntel-6-2A,v17,sandybridge,core
-GenuineIntel-6-8F,v1.09,sapphirerapids,core
+GenuineIntel-6-(8F|CF),v1.09,sapphirerapids,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v14,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v53,skylake,core
 GenuineIntel-6-55-[01234],v1.28,skylakex,core
-- 
2.35.1

