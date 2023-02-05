Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C4368AE19
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 03:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBEC7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 21:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBEC7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 21:59:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81829B453;
        Sat,  4 Feb 2023 18:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675565949; x=1707101949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I3BGngmmBEZ0lLQWVZaoZsoRC/zgFFie5uMa6sF5wUE=;
  b=hop91wox/Mtcm7LLwjllwyySoThJo6RXdbJlA1+pUQFUP8Vl++ZWMvru
   IjQLe93303K90/GriNyiP8Jferj0AfgCtRqAVEMCYafUoeKuz/I/Um+eM
   dUTCI9O9CAkJckc+1pLboaCBoeP5Lwqs5470unAzptKFlvqeg+FgGwfXm
   7ODV7QQ3GWYerua4z1jFit9S8xNn0oTNyZ56OgjE1MGAft5bO5ocvUf28
   Vzkaw2HxM2LCzbRkOuBpw1XdoIfmwYXO+zlMUEOXj9cEoopPFTkIS6G0y
   Gzq1/JTuHrxXobCGbCDiQCZvT+cnSPgv4pxOfjIs0BSwnlK1f2QOK2n8P
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="326705489"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="326705489"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2023 18:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10611"; a="666142168"
X-IronPort-AV: E=Sophos;i="5.97,274,1669104000"; 
   d="scan'208";a="666142168"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 04 Feb 2023 18:59:08 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/2] Documentation:admin-guide: Move intel_powerclamp documentation
Date:   Sat,  4 Feb 2023 18:59:01 -0800
Message-Id: <20230205025902.2899734-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230205025902.2899734-1-srinivas.pandruvada@linux.intel.com>
References: <20230205025902.2899734-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a folder "thermal" under Documentation/admin-guide and move
intel_powerclamp documentation to this folder.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/admin-guide/index.rst                              | 1 +
 .../{driver-api => admin-guide}/thermal/intel_powerclamp.rst     | 0
 Documentation/driver-api/thermal/index.rst                       | 1 -
 MAINTAINERS                                                      | 1 +
 4 files changed, 2 insertions(+), 1 deletion(-)
 rename Documentation/{driver-api => admin-guide}/thermal/intel_powerclamp.rst (100%)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 5bfafcbb9562..c872a8a1ddfa 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -116,6 +116,7 @@ configure specific aspects of kernel behavior to your liking.
    svga
    syscall-user-dispatch
    sysrq
+   thermal
    thunderbolt
    ufs
    unicode
diff --git a/Documentation/driver-api/thermal/intel_powerclamp.rst b/Documentation/admin-guide/thermal/intel_powerclamp.rst
similarity index 100%
rename from Documentation/driver-api/thermal/intel_powerclamp.rst
rename to Documentation/admin-guide/thermal/intel_powerclamp.rst
diff --git a/Documentation/driver-api/thermal/index.rst b/Documentation/driver-api/thermal/index.rst
index 030306ffa408..a886028014ab 100644
--- a/Documentation/driver-api/thermal/index.rst
+++ b/Documentation/driver-api/thermal/index.rst
@@ -14,7 +14,6 @@ Thermal
 
    exynos_thermal
    exynos_thermal_emulation
-   intel_powerclamp
    nouveau_thermal
    x86_pkg_temperature_thermal
    intel_dptf
diff --git a/MAINTAINERS b/MAINTAINERS
index b4043f72dfac..28fd62eacaf3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20714,6 +20714,7 @@ S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pm/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
 F:	Documentation/ABI/testing/sysfs-class-thermal
+F:	Documentation/admin-guide/thermal/
 F:	Documentation/devicetree/bindings/thermal/
 F:	Documentation/driver-api/thermal/
 F:	drivers/thermal/
-- 
2.39.1

