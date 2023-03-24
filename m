Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7EC6C8678
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjCXUAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjCXUAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:00:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613681F5F1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679687987; x=1711223987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sNVllBtmU8q7PqMLUiVSP/EAmHPB6Rm0X9oOm1Judio=;
  b=RfeyQW9uQgP6iXzV7pd2Du1S422CMmIp+QL3e0dfZU0gxEIfzJ0TjV4z
   qrFYl9spKonSK+NernpWl3WQlhPHUgWVak1Qh+HO8Dib9sgXeJQwIQ4IG
   lKozOQfKpPC9Pi0KIMRrzKgz/KI3dNwHoR87CEnAAYMIjU34TL7gIF5uX
   Tw5Q1VRp2vUMXEAUl/QJR1JONyR/cOBFiqWl/vExPuFjwAZxmJeNm4D+/
   p3CeFmkGrsiLS4Xow+JI4B2ccHSALQMMERLpm/jxQAyDETfF+sNPG7Yoq
   ntgP8KMSojQDp5VI3xeNsq2NH/5T1HSywZpJTYvexhlKFXNqb4JxgF6NB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="341443992"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="341443992"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 12:59:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="685298887"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="685298887"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 12:59:37 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cpu: Add model number for Intel Arrow Lake processor
Date:   Fri, 24 Mar 2023 12:59:32 -0700
Message-Id: <20230324195932.241441-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://www.intel.com/content/www/us/en/newsroom/news/intel-technology-roadmaps-milestones.html
says this will be built on Intel 20A tiles and launch in 2024.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index cbaf174d8efd..b3af2d45bbbb 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -125,6 +125,8 @@
 
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
 
+#define INTEL_FAM6_ARROWLAKE		0xC6
+
 /* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
-- 
2.39.2

