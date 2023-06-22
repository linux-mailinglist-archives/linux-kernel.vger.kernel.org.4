Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E016C739AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFVIye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjFVIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:54:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D41BE2;
        Thu, 22 Jun 2023 01:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687424040; x=1718960040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xt7+0eDhZXluZqNtcuchvFSf+T60q4HXLuXvNh01QUs=;
  b=fiu+KPyH7LORA2Y4kuZIPZHw9Wf11WsziPnUKX76uhnDdHdHOXCzEPRG
   zTTrEdQbsSFiLPu2xAVi2RYZZFam08PYSGI18GEIfP7sLQtwcZyG/jTIc
   QvC9sHh/TOQAKeVDWH9/h+8Smkpnku+X+y3zoHZQRxsPf73msE2zLyEXX
   Vp/poUciBRFw1WjF1LU4+LFC6Ps1olu4CmG9fBE5uv4qZZpQ/mqadZdBT
   sWxFxBekirUWIxUXPHEFbubcD+zhVFw4qx5kVTEkYdM0aJM9O3P2LBkd1
   fmxXTgWBHDC3il1re5JbcHNplFc2UuPb+xPmwvcuzraWp2CPcXiHrntL4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="363853587"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="363853587"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 01:54:00 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="749170677"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="749170677"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2023 01:53:57 -0700
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
Subject: [PATCH 1/2] arch: arm64: boot: dts: Updated QSPI Flash layout for UBIFS
Date:   Thu, 22 Jun 2023 16:53:19 +0800
Message-Id: <20230622085319.562868-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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

