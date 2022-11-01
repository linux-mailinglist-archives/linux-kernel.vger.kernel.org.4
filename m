Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99054615201
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiKATLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiKATK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:10:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC611E71D;
        Tue,  1 Nov 2022 12:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667329857; x=1698865857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l9kRG3w3jGLZontziusyMLJGEXBiEEFAIDr6h2pUM40=;
  b=OpfCuFBSU35tXNFhJKAzWZFfW7ru2/Tz+kL/qbpBPIUftFBGva+bNY53
   lwfddZCJsSSkuqz14h7FDu7gJ5j1QH30O5g2N+GtgPC32GagMhUYjpMD/
   ryXCtXVsPcnPmoIbt5cHlV9udH54Ksw0dQma97PELyFIJmFX7qJFZ3Z/B
   ogE3ijVI1b4uqQeIlNKGB6sqrQB3qC3x+SO4J2K5nbMlJUpAx4mSSIb47
   IZBlFv/N2FIyqk4EUAN19TLfpPLM5ZGGPB8nI9DXOlsIhuPkoWLXaidRO
   fk0fCvxc5/Gb7xpIVKMBn2QJqGj/bBDrgi98FvxYUlnv4iJsk+iEdS06e
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="373440766"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="373440766"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 12:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="776605731"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="776605731"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2022 12:10:27 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.195.64])
        by linux.intel.com (Postfix) with ESMTP id 08D9A580AA7;
        Tue,  1 Nov 2022 12:10:27 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] tools/arch/x86: intel_sdsi: Add Intel On Demand text
Date:   Tue,  1 Nov 2022 12:10:20 -0700
Message-Id: <20221101191023.4150315-7-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101191023.4150315-1-david.e.box@linux.intel.com>
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Software Defined Silicon (SDSi) is now officially known as Intel
On Demand. Change text in tool to indicate this.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 9dd94014a672..3718bd0c05cb 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * sdsi: Intel Software Defined Silicon tool for provisioning certificates
- * and activation payloads on supported cpus.
+ * sdsi: Intel On Demand (formerly Software Defined Silicon) tool for
+ * provisioning certificates and activation payloads on supported cpus.
  *
  * See https://github.com/intel/intel-sdsi/blob/master/os-interface.rst
  * for register descriptions.
@@ -150,7 +150,7 @@ static void sdsi_list_devices(void)
 	}
 
 	if (!found)
-		fprintf(stderr, "No sdsi devices found.\n");
+		fprintf(stderr, "No On Demand devices found.\n");
 }
 
 static int sdsi_update_registers(struct sdsi_dev *s)
@@ -206,7 +206,7 @@ static int sdsi_read_reg(struct sdsi_dev *s)
 	printf("\n");
 	printf("PPIN:                           0x%lx\n", s->regs.ppin);
 	printf("Enabled Features\n");
-	printf("    SDSi:                       %s\n", !!s->regs.en_features.sdsi ? "Enabled" : "Disabled");
+	printf("    On Demand:                  %s\n", !!s->regs.en_features.sdsi ? "Enabled" : "Disabled");
 	printf("Authorization Failure Count\n");
 	printf("    AKC Failure Count:          %d\n", s->regs.auth_fail_count.key_failure_count);
 	printf("    AKC Failure Threshold:      %d\n", s->regs.auth_fail_count.key_failure_threshold);
@@ -428,7 +428,7 @@ static int sdsi_provision_akc(struct sdsi_dev *s, char *bin_file)
 		return ret;
 
 	if (!s->regs.en_features.sdsi) {
-		fprintf(stderr, "SDSi feature is present but not enabled. Unable to provision");
+		fprintf(stderr, "On Demand feature is present but not enabled. Unable to provision");
 		return -1;
 	}
 
@@ -458,7 +458,7 @@ static int sdsi_provision_cap(struct sdsi_dev *s, char *bin_file)
 		return ret;
 
 	if (!s->regs.en_features.sdsi) {
-		fprintf(stderr, "SDSi feature is present but not enabled. Unable to provision");
+		fprintf(stderr, "On Demand feature is present but not enabled. Unable to provision");
 		return -1;
 	}
 
-- 
2.25.1

