Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA1174558B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGCGkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCGkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:40:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E71BA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 23:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688366411; x=1719902411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qRRI6WYI96+ffAms4d/TTxkbZxBfypgffVQGm3K8psA=;
  b=XovCDu1MMBLbwWzdEaU5ZP9p5qZ9nOdKATYWt0+jjdzqWjZtqM2/QCYi
   uu4NDcyyHShK+hz6IonhDAVV44UhwVdxoGfy5IzNLiF77A9CMeGSoV7Yz
   bXCxhMTNv283IGo0Zg4pPgVt28rrfvIZC4s/17Q7VqEszOOWVX91XP7fG
   zk3qLNyI/J+fSiNMNCv0Sma7YDSWGWFrFm1gXU8T+A0J2p65nqudeI1JC
   RGitrKzc6h4UNtVY/sImotyH8f3ZgLpjykDoWjDV1i75ccdlDR8TWSiSy
   e94+H3W1l+H8PY+pQKRYa/R5XvwJXcAdDCB6rsrxqBryw8DKXriMvSuQw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="366289190"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="366289190"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2023 23:40:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="695708675"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="695708675"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga006.jf.intel.com with ESMTP; 02 Jul 2023 23:40:06 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>, catalin.marinas@arm.com,
        conor+dt@kernel.org, kah.jing.lee@intel.com,
        krzysztof.kozlowski@linaro.org, Markus.Elfring@web.de,
        robh+dt@kernel.org, will@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v3 1/1] arm64: dts: agilex/stratix10: Updated QSPI Flash layout for UBIFS
Date:   Mon,  3 Jul 2023 14:38:33 +0800
Message-Id: <20230703063832.1342543-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703063309.1342330-1-kah.jing.lee@intel.com>
References: <20230703063309.1342330-1-kah.jing.lee@intel.com>
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

Non-UBIFS related boot and fpga data should be stored in qspi_boot (mtd0)
while keeping the rootfs with UBIFS in the root partition "mtd1".
Thus, update the QSPI flash layout to support UBIFS in the mtd root
partition.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>

---
v2: Update subject prefix
v3: Update commit messages
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

