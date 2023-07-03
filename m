Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC213745779
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjGCIh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGCIhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:37:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B35DB6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688373475; x=1719909475;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h/E6h3hmj3tEEg/RR7iC38FoXOQ/rm382QmER4vbTJU=;
  b=BP7W3Mj1PyRQgL4pvJL/ZRZtXDhdAmLvf73x0xLFQclRKKQZOqiIFMEZ
   56pNT7PFp9hm2tR0UpcX1J6C0SM9erUKXU2hVvJY2LQv+camwOkmz0ntd
   ym03818ds/b+W9ySfYezM6aXdJqSON37szMH+yhcDgF0UFmPEFZTaM2q3
   CN/ECl4gH0C8DjOAFzhYmkZJyBdnRhFp7Z4yyyr+TdjVCvDcle/8QQH4h
   zL+XOKKHyPerWrD/rzQqC8H1P5ib9ue9BN4MhUwnzVLuT/gl2ReBNGCEd
   zHHJLX8Z5khQEFKS3MHnjtvtAguqaYr9zOQWevuFBwneo1OHlrPNJlEcD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="342419404"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="342419404"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 01:37:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="892481444"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="892481444"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga005.jf.intel.com with ESMTP; 03 Jul 2023 01:37:51 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>, catalin.marinas@arm.com,
        conor+dt@kernel.org, kah.jing.lee@intel.com,
        krzysztof.kozlowski@linaro.org, Markus.Elfring@web.de,
        robh+dt@kernel.org, will@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v4] arm64: dts: agilex/stratix10: Updated QSPI Flash layout for UBIFS
Date:   Mon,  3 Jul 2023 16:36:27 +0800
Message-Id: <20230703083626.1347969-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Non-UBIFS related boot and fpga data should be stored in qspi_boot (mtd0)
while keeping the rootfs with UBIFS in the root partition "mtd1".
Thus, update the QSPI flash layout to support UBIFS in the mtd root
partition.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
V4->V3: Drop cover letter & remove unnecessary marker line
V3->V2: Update commit messages
V2->V1: Update subject prefix

 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 8 ++++----
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
index 38ae674f2f02..12b960b9183c 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
@@ -202,12 +202,12 @@ partitions {
 
 			qspi_boot: partition@0 {
 				label = "Boot and fpga data";
-				reg = <0x0 0x03FE0000>;
+				reg = <0x0 0x04200000>;
 			};
 
-			qspi_rootfs: partition@3FE0000 {
-				label = "Root Filesystem - JFFS2";
-				reg = <0x03FE0000 0x0C020000>;
+			root: partition@4200000 {
+				label = "Root Filesystem - UBIFS";
+				reg = <0x04200000 0x0BE00000>;
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index 07c3f8876613..608017e6e36a 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -128,12 +128,12 @@ partitions {
 
 			qspi_boot: partition@0 {
 				label = "Boot and fpga data";
-				reg = <0x0 0x03FE0000>;
+				reg = <0x0 0x04200000>;
 			};
 
-			qspi_rootfs: partition@3FE0000 {
-				label = "Root Filesystem - JFFS2";
-				reg = <0x03FE0000 0x0C020000>;
+			root: partition@4200000 {
+				label = "Root Filesystem - UBIFS";
+				reg = <0x04200000 0x0BE00000>;
 			};
 		};
 	};

base-commit: dad9774deaf1cf8e8f7483310dfb2690310193d2
-- 
2.25.1

