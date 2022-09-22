Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB045E63B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiIVNgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiIVNfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:35:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07532895CB;
        Thu, 22 Sep 2022 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663853725; x=1695389725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=u+ZvcOj9M2zkdP1mQyjcoYw0fYKI0r1gp+/88xhN1yA=;
  b=DkPDakjyJhGqFM05ZMmsRnLo1BgDFvex/U4IWdQKVEIAVRVu1VbIbX9G
   BLA+ZApXPfsMuJUlw1qIMg1L/JM39GqHIJQf5DVfAwRr4eqOQcG/JE+AK
   r2I8MoaGe8uxf89SbEvus5hnNAAk+8Qi4NM7G5tDz9Su/P4QV803kkXZy
   8Em/+njHwU7n9l8fe4hcAMBVwoV9mGO8ERVr/NH+S2oQ82tLn8uqWgZrg
   OPW7FaBu3O2lJ6SjH38OmOpnI+J328Yl0tibJPxqnReG6F2GWZ3QBTpLS
   gvTkK2NrEHXVCZxWtIkmnXzVMS7FdiUBL0Q35mxPv53dNe6TJbmyJ11Ic
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="297894170"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="297894170"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="619793972"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2022 06:35:21 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH V3 7/8] Documentation: x86: Update smp_num_siblings/x86_max_cores description
Date:   Thu, 22 Sep 2022 21:37:59 +0800
Message-Id: <20220922133800.12918-8-rui.zhang@intel.com>
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

smp_num_siblings/cpuinfo_x86.x86_max_cores are retrieved via CPUID EAX
bit_shift value, and they represent the maximum possible number of threads
in a core, and the maximum possible number of cores in a package.

Update the smp_num_siblings/cpuinfo_x86.x86_max_cores description in the
documentation.

Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/x86/topology.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
index 7f58010ea86a..c5eb5bc42380 100644
--- a/Documentation/x86/topology.rst
+++ b/Documentation/x86/topology.rst
@@ -49,7 +49,8 @@ AMD nomenclature for package is 'Node'.
 
   - cpuinfo_x86.x86_max_cores:
 
-    The number of cores in a package. This information is retrieved via CPUID.
+    The maximum possible number of cores in a package. This information is
+    retrieved via CPUID.
 
   - cpuinfo_x86.x86_max_dies:
 
@@ -102,10 +103,10 @@ AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
 
   - smp_num_siblings:
 
-    The number of threads in a core. The number of threads in a package can be
-    calculated by::
+    The maximum possible number of threads in a core. The maximum possible
+    number of threads in a package can be calculated by::
 
-	threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
+	maximum_threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
 
 
 Threads
-- 
2.25.1

