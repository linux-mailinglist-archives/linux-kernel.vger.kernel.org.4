Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6506D68F45A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjBHRYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBHRX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:23:59 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD0530B31
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675877029; x=1707413029;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=APZX0G5IZa6GeGV9W55Z4my3mBh76dR803XupKW3Id8=;
  b=GhCK99VxDGI0tEUXUIQZQPqD72wKc5l2VLQ38vZFpvuB/TH9M7JHfTlV
   omDbuxXnK5Jj6xj4w5kR9xLdCl1VHIJt1NPgIaJjFliTYB5nS1UbpXlZN
   bN4UHQ9Ff3hDa1egbBnuPmfdYTb4xlgmgHNZeLCVshyg+4ZEmWepyvgmn
   NBxXpxvr4rGzpd39iDEI3pMxorX2xIGaiupxaK1WnwfTbNOzK0IRHjHpt
   orQ31aN/lQt6fRjCV5n71vV7m7QJJU0/OMqJg6w5g9Vqo4EcbrtnKi3Ay
   XVa7HoluQrGfEpPSRFYlPFdm/35rERxXi4Q1txSQtjBGGkknOa9C7utni
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="357262618"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="357262618"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 09:23:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="667325207"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="667325207"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 09:23:47 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cpu: Add Lunar Lake M
Date:   Wed,  8 Feb 2023 09:23:40 -0800
Message-Id: <20230208172340.158548-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Intel confirmed the existence of this CPU in Q4'2022
earnings presentation.

Add the CPU model number.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 347707d459c6..33a9682a183d 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -123,6 +123,8 @@
 #define INTEL_FAM6_METEORLAKE		0xAC
 #define INTEL_FAM6_METEORLAKE_L		0xAA
 
+#define INTEL_FAM6_LUNARLAKE_M		0xBD
+
 /* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
-- 
2.39.1

