Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5497F5B8FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiINVQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiINVPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:15:49 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5382E45F53;
        Wed, 14 Sep 2022 14:15:48 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 07C91201B06;
        Wed, 14 Sep 2022 23:15:47 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B8AC22004EB;
        Wed, 14 Sep 2022 23:15:46 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 4B63E40AA4;
        Wed, 14 Sep 2022 14:15:45 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Sandeep Malik <sandeep.malik@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v4 5/5] arm64: dts: ls208x: remove NXP Erratum A008585 from LS2088A.
Date:   Wed, 14 Sep 2022 16:15:38 -0500
Message-Id: <20220914211538.29473-6-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220914211538.29473-1-leoyang.li@nxp.com>
References: <20220914211538.29473-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Bansal <pankaj.bansal@nxp.com>

NXP Erratum A008585 affects A57 core cluster used in LS2085 rev1.
However this problem has been fixed in A72 core cluster used in LS2088.
Therefore remove the erratum from LS2088A. Keeping it only in LS2085.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
Reviewed-by: Sandeep Malik <sandeep.malik@nxp.com>
Acked-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
index 6f6667b70028..a2cadf757148 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
@@ -150,3 +150,7 @@ &pcie4 {
 	ranges = <0x81000000 0x0 0x00000000 0x16 0x00010000 0x0 0x00010000   /* downstream I/O */
 		  0x82000000 0x0 0x40000000 0x16 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
 };
+
+&timer {
+	fsl,erratum-a008585;
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index d76f1c42f3fa..f1b9cc8714dc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -239,13 +239,12 @@ map0 {
 		};
 	};
 
-	timer {
+	timer: timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <1 13 4>, /* Physical Secure PPI, active-low */
 			     <1 14 4>, /* Physical Non-Secure PPI, active-low */
 			     <1 11 4>, /* Virtual PPI, active-low */
 			     <1 10 4>; /* Hypervisor PPI, active-low */
-		fsl,erratum-a008585;
 	};
 
 	pmu {
-- 
2.37.1

