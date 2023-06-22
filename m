Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928B973A101
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjFVMfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjFVMfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:35:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8795DE;
        Thu, 22 Jun 2023 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687437338; x=1718973338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KuWmZUFS+bzuFupSqBTPY5LMVOmTmWXNrryWlmfEZl4=;
  b=ATrMUzi8xRSmzBgtsV7xfAZGLvJPaP7MjaXTokkxsqLaoS3Oi5fL4x5p
   PxccP3sSGYoQ5LyhdIgrobRzZzDD98dZutTxgFFnHmbzxSoaxgKsZhfKm
   FR2hlci3wtbajZr/dqH3he1/xxj6E7GsEIFG4xBHcLJWnHReKVGwxtBhf
   DRpWSvDSoq15diTwtEUvsNIZlI/H5u+PiNLf2vcbBrmFAKeOkLNyYQhsB
   lp7D/8uBSAAdSh4N2EXi6jqGA5XxdutbloSK1Y//oJSkp4fPpbFOOCPeR
   EmTfsygOF4yAfxfXWpCEMmXk/hyd97UoMKC8tQD2F9ofst/XjtLu5UNRO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="340077388"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="340077388"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:35:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="714888943"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="714888943"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2023 05:35:35 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
        Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH v2 1/2] arm64: dts: agilex/stratix10: Updated QSPI Flash layout for UBIFS
Date:   Thu, 22 Jun 2023 20:34:34 +0800
Message-Id: <20230622123432.593548-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622123254.593308-1-kah.jing.lee@intel.com>
References: <20230622123254.593308-1-kah.jing.lee@intel.com>
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

This patch is to update the QSPI flash layout to support UBIFS in mtd
root partition.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
v2: Update subject prefix
---
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
-- 
2.25.1

