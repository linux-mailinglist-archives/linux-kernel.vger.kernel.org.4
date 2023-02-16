Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F156699D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBPTjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBPTjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:39:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C8F442FB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 11:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676576372; x=1708112372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xq7PzGRFJXNRENxpggbaArCxrhxaAEEyM6L5bdDgF+w=;
  b=DCWH27s2beXy/k8+90EWzxTA5L3g/rAOhDEI5/K60OqT4TNTNzlmusl7
   0jUP3iXxvRAGTDfNC7JQWe3Gn90NIpNR/BkOY3GTWUm+1+FEczcgJknTv
   B3e5yB40gFdyvvy5KvXT7OuTlmL8WR+pEbPipc6UwkEXGxd0PGZpDQDdb
   wyxP0usSjhaCPEOFKjEAiwvwV283hBC88EBmKQXi1/k7bEpx81yxxmXEA
   1fQVB7NPZiTitSvHwO7ZAsCr6CwlHb1RX1/YRFMeNZDGXI1mTsckDrScz
   afepzH9ylPNru75Y4Ka1KGWZHHZBgU33lVCAklcyMZBwTF9zni6bIHEn/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="418040254"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="418040254"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 11:39:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="844301303"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="844301303"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 16 Feb 2023 11:39:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B8421A6; Thu, 16 Feb 2023 21:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v1 1/1] x86/platform/intel-mid: Remove unused definitions from intel-mid.h
Date:   Thu, 16 Feb 2023 21:39:58 +0200
Message-Id: <20230216193958.2971-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

After a few rounds of removal and refactoring Intel MID related code
some artifacts are left untouched. However, they are not used anywhere.
Remove them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel-mid.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index c201083b34f6..a3abdcd89a32 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -20,25 +20,4 @@ extern void intel_mid_pwr_power_off(void);
 
 extern int intel_mid_pwr_get_lss_id(struct pci_dev *pdev);
 
-#ifdef CONFIG_X86_INTEL_MID
-
-extern void intel_scu_devices_create(void);
-extern void intel_scu_devices_destroy(void);
-
-#else /* !CONFIG_X86_INTEL_MID */
-
-static inline void intel_scu_devices_create(void) { }
-static inline void intel_scu_devices_destroy(void) { }
-
-#endif /* !CONFIG_X86_INTEL_MID */
-
-/* Bus Select SoC Fuse value */
-#define BSEL_SOC_FUSE_MASK		0x7
-/* FSB 133MHz */
-#define BSEL_SOC_FUSE_001		0x1
-/* FSB 100MHz */
-#define BSEL_SOC_FUSE_101		0x5
-/* FSB 83MHz */
-#define BSEL_SOC_FUSE_111		0x7
-
 #endif /* _ASM_X86_INTEL_MID_H */
-- 
2.39.1

