Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC61F61899B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKCUdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCUdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:33:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8495DB0E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667507599; x=1699043599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kbAnWAbxyVIXdMWdFu0N89U6At9cEfDKZjKb4yGARkk=;
  b=WNjP9U+xv5aBXIU1n7TGnsMiMf1HIlVb/3InBBv7Ytj7Bc7JHsc50/+M
   1+3KG9bJ84W5z3cp/HV8gZp6ZyA0pMKu+K4oJjCTB7a/aXJvAz1sQCkrk
   1cM0u3w8fbuIBNzvviniQ9kDkIf8qkCoOiLrz//vnfs/id7a1G586SALQ
   bqHbZoWYz4LWuOYM2hPhFkypvuCd/036IKYzXIdd8lr4sEXyUtYgA2pqf
   djGjPZEjXRmGe1V/4gcvAFZp/qBmCHz80XHopBRMWXX+7eqCx4iRiHu3T
   xTCeQXHBtynUYRmzuecQLwJ9xkGif61PwsiLEb2jAiCnwcnpSUaT7MJmu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="371901807"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="371901807"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 13:33:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="880032503"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="880032503"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 13:33:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cpu: Add several Intel server CPU mode numbers
Date:   Thu,  3 Nov 2022 13:33:10 -0700
Message-Id: <20221103203310.5058-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These servers are all on the public versions of the roadmap. The model
numbers for Grand Ridge, Granite Rapids, and Sierra Forest were included
in the September 2022 edition of the Instruction Set Extensions document.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/intel-family.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 5d75fe229342..347707d459c6 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -107,6 +107,11 @@
 
 #define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F	/* Golden Cove */
 
+#define INTEL_FAM6_EMERALDRAPIDS_X	0xCF
+
+#define INTEL_FAM6_GRANITERAPIDS_X	0xAD
+#define INTEL_FAM6_GRANITERAPIDS_D	0xAE
+
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_N		0xBE
@@ -118,7 +123,7 @@
 #define INTEL_FAM6_METEORLAKE		0xAC
 #define INTEL_FAM6_METEORLAKE_L		0xAA
 
-/* "Small Core" Processors (Atom) */
+/* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
 #define INTEL_FAM6_ATOM_BONNELL_MID	0x26 /* Silverthorne, Lincroft */
@@ -145,6 +150,10 @@
 #define INTEL_FAM6_ATOM_TREMONT		0x96 /* Elkhart Lake */
 #define INTEL_FAM6_ATOM_TREMONT_L	0x9C /* Jasper Lake */
 
+#define INTEL_FAM6_SIERRAFOREST_X	0xAF
+
+#define INTEL_FAM6_GRANDRIDGE		0xB6
+
 /* Xeon Phi */
 
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
-- 
2.38.1

