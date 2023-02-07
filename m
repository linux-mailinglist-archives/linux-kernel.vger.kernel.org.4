Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E647468DEF7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjBGRcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjBGRcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:32:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C6E39B90;
        Tue,  7 Feb 2023 09:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675791142; x=1707327142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ajIBpLHwpirV6VDbct54Rv7GWwMdwgzEYYo09aMmuzk=;
  b=EQlKqtGFnheW27K3U00oYLyRtVAFRUKpIjo7zSSxVmQSkerbuJmMvnLc
   VYlHI+afq1nfCbb7y6Fd94w7CA9JcAjK6w3zV7MXVT3wF1AY5P9UgjnEH
   1gdgpg5mgV26f2zGJtMPi60a95+iD3WK97xFP08U8ex71m7JPY+i6DJHU
   wU4s9LZgyrq01NcZ/SxuKRX/D3/Dx0KNxK0rGJBXqTdfAo3lzNSBQC1WB
   35tVWypVVvQJc3KLZAgKqAE/9/3fskmuxsDc9+jTQqOT2rPj1asiKd9i5
   gsCauof2mYK7ftNLVFAlSUewgM6tbxZn5ly1J2jgEKa5H7ici0lY9bEqk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="331702655"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="331702655"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 09:32:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="699325497"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="699325497"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga001.jf.intel.com with ESMTP; 07 Feb 2023 09:32:21 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 1/2] Documentation:admin-guide: Move intel_powerclamp documentation
Date:   Tue,  7 Feb 2023 09:32:18 -0800
Message-Id: <20230207173219.4190013-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207173219.4190013-1-srinivas.pandruvada@linux.intel.com>
References: <20230207173219.4190013-1-srinivas.pandruvada@linux.intel.com>
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
v3:
No change

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

