Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B665E63C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiIVNgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiIVNfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:35:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E046A063C;
        Thu, 22 Sep 2022 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663853731; x=1695389731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hbLNyRcLgu/3RSFiCT5I9SBJfhTGwgIQFfI74KmSZMA=;
  b=eLPPdpkl/aoWd5tG7LHeHfEc4m+RCCG2xmA7m/ReK6FZMtI1FRTmu6Lq
   EKQztVxPzeEaD2r8hxEffjvj37MFjzvdvC69NSi6OggKm3ruU3H1Pdt3q
   8tVm+lBUCV8Oj7AAAqYfxJ+tPNm+IK3nr8hCRF0Jmz0wVFk+soDbbMwb2
   uhCwmFae30tcohVlWm5qh1fYeCksqPYn4yC6yUqMdWVS88r6m9Vk2Y3mW
   rks2DGzmIeehXv5m70uvTwNhmlEJecE3kG8pGzaucVGEhYjSfywKoQgfX
   CWA9tusVXbL1Gz2koktkgqHBSkO44E3nZKstG8fXyZHtfg7ZJhJHgguRT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="297894189"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297894189"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="619793984"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2022 06:35:24 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH V3 8/8] Documentation: x86: Remove obsolete x86_max_dies description
Date:   Thu, 22 Sep 2022 21:38:00 +0800
Message-Id: <20220922133800.12918-9-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922133800.12918-1-rui.zhang@intel.com>
References: <20220922133800.12918-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuinfo_x86.x86_max_dies is introduced in commit 7745f03eb395
("x86/topology: Add CPUID.1F multi-die/package support") and then
removed in commit 14d96d6c06b5
("x86/topology: Create topology_max_die_per_package()").

Remove the obsolete cpuinfo_x86.x86_max_dies description.

Fixes: 14d96d6c06b5 ("x86/topology: Create topology_max_die_per_package()")
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/x86/topology.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
index c5eb5bc42380..fbef91b1ee5e 100644
--- a/Documentation/x86/topology.rst
+++ b/Documentation/x86/topology.rst
@@ -52,10 +52,6 @@ AMD nomenclature for package is 'Node'.
     The maximum possible number of cores in a package. This information is
     retrieved via CPUID.
 
-  - cpuinfo_x86.x86_max_dies:
-
-    The number of dies in a package. This information is retrieved via CPUID.
-
   - cpuinfo_x86.cpu_die_id:
 
     The physical ID of the die. This information is retrieved via CPUID.
-- 
2.25.1

