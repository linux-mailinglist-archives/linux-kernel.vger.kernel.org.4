Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E206872D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjBBBJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjBBBJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:09:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA331474C5;
        Wed,  1 Feb 2023 17:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675300144; x=1706836144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r3hG+Ca6d73zopTx9WXAswSjukXC6pV6ULXWYPlyX0Y=;
  b=iToKyzw60lBn0HRnLGALEPoDOAlAU0T41AuBLCmDcwOJmKZmjoGJe2Ku
   QZf5jDUJxPXNpyDIwI9nrhqzBkTnQAeshT1Ch0x1T35FWAjzHGlnU5i6N
   eGZKhExXr/wp39vJkDgunKCO+QYJYz5j+TnXOJaXZcRNUdWN4vBulrrP9
   sm1rNgCOKW3GYr0kmON+WIIChoyd9jKKJ5eLmuE3Vk9tF2IKzCF841XVj
   FAPvxe9e4teLvh0pkZpmigPWsdlh7a1VudYCqawgKNThAgXekdoiiGftc
   cC0ZeFNodD1YCO5AVCVAQaphoqrigPdU/dSmWBLgVQ1ZerCnRKxibyKpQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="355654322"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="355654322"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665087937"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="665087937"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 17:08:16 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 7/7] MAINTAINERS: Add entry for TPMI driver
Date:   Wed,  1 Feb 2023 17:07:38 -0800
Message-Id: <20230202010738.2186174-8-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
References: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
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

Add entry for TPMI (Topology Aware Register and PM Capsule Interface)
driver.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415b..6f3aaa7161d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10683,6 +10683,12 @@ S:	Maintained
 F:	arch/x86/include/asm/intel_telemetry.h
 F:	drivers/platform/x86/intel/telemetry/
 
+INTEL TPMI DRIVER
+M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/intel/tpmi.c
+
 INTEL UNCORE FREQUENCY CONTROL
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.31.1

