Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD0A5B9038
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiINVre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiINVrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:47:12 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102738274D;
        Wed, 14 Sep 2022 14:47:12 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B6643201B35;
        Wed, 14 Sep 2022 23:47:10 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 75C3B201B31;
        Wed, 14 Sep 2022 23:47:10 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 2681F4060A;
        Wed, 14 Sep 2022 14:47:09 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 04/11] arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
Date:   Wed, 14 Sep 2022 16:46:56 -0500
Message-Id: <20220914214703.29706-5-leoyang.li@nxp.com>
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

The LS1043A PCIe controller has some control registers
in SCFG block, so add the SCFG phandle for each PCIe
controller node.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index d04d4ac66d2a..e1c5d685a9e3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -901,6 +901,7 @@ pcie1: pcie@3400000 {
 					<0000 0 0 2 &gic 0 111 0x4>,
 					<0000 0 0 3 &gic 0 112 0x4>,
 					<0000 0 0 4 &gic 0 113 0x4>;
+			fsl,pcie-scfg = <&scfg 0>;
 			status = "disabled";
 		};
 
@@ -927,6 +928,7 @@ pcie2: pcie@3500000 {
 					<0000 0 0 2 &gic 0 121 0x4>,
 					<0000 0 0 3 &gic 0 122 0x4>,
 					<0000 0 0 4 &gic 0 123 0x4>;
+			fsl,pcie-scfg = <&scfg 1>;
 			status = "disabled";
 		};
 
@@ -953,6 +955,7 @@ pcie3: pcie@3600000 {
 					<0000 0 0 2 &gic 0 155 0x4>,
 					<0000 0 0 3 &gic 0 156 0x4>,
 					<0000 0 0 4 &gic 0 157 0x4>;
+			fsl,pcie-scfg = <&scfg 2>;
 			status = "disabled";
 		};
 
-- 
2.37.1

