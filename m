Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEC45B903A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiINVrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiINVrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:47:15 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351BD82747;
        Wed, 14 Sep 2022 14:47:13 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 91A89201B33;
        Wed, 14 Sep 2022 23:47:11 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4DC64201AD0;
        Wed, 14 Sep 2022 23:47:11 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id EE42840AA5;
        Wed, 14 Sep 2022 14:47:09 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 05/11] arm64: dts: ls1043a: Add big-endian property for PCIe nodes
Date:   Wed, 14 Sep 2022 16:46:57 -0500
Message-Id: <20220914214703.29706-6-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220914214703.29706-1-leoyang.li@nxp.com>
References: <20220914214703.29706-1-leoyang.li@nxp.com>
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add the big-endian property for LS1043A PCIe nodes for accessing PEX_LUT
and PF register block.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index e1c5d685a9e3..3cf6722e7555 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -902,6 +902,7 @@ pcie1: pcie@3400000 {
 					<0000 0 0 3 &gic 0 112 0x4>,
 					<0000 0 0 4 &gic 0 113 0x4>;
 			fsl,pcie-scfg = <&scfg 0>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -929,6 +930,7 @@ pcie2: pcie@3500000 {
 					<0000 0 0 3 &gic 0 122 0x4>,
 					<0000 0 0 4 &gic 0 123 0x4>;
 			fsl,pcie-scfg = <&scfg 1>;
+			big-endian;
 			status = "disabled";
 		};
 
@@ -956,6 +958,7 @@ pcie3: pcie@3600000 {
 					<0000 0 0 3 &gic 0 156 0x4>,
 					<0000 0 0 4 &gic 0 157 0x4>;
 			fsl,pcie-scfg = <&scfg 2>;
+			big-endian;
 			status = "disabled";
 		};
 
-- 
2.37.1

