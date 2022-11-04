Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D362619361
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiKDJVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiKDJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC8025296;
        Fri,  4 Nov 2022 02:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECEA262110;
        Fri,  4 Nov 2022 09:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5978DC433B5;
        Fri,  4 Nov 2022 09:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667553675;
        bh=l9ouLc59eP5YzEVZSBgkam6/h5cQtwOSfXADrCbIK80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jntuttOuk6uYrgx4J2ZDUOqMSm27PLU+uyMsAAnihqCSZ3o8eKn7rGcd/qGLcmRDZ
         +VMRTEG/YZGqQFnFH5/PR3vHI9AHK9jRkomXiJaUxmoDE/0AQL/v+yEwmrSDUx1WmH
         RWOaFDX7MbWfE1q4HMnm4o4uuZbLXCikPWJ/sw2g8oJo/61r+7j7H1HGGK7jc3XzCz
         xF+ffMzFvVpryhMV5ykfPNqSfY6NEXx4+/BcaqbENeawoTj6Kd+6UVb321NxxYk2O7
         y8oDNiZ0JHgAKYLUoL3Emttto5FX8dp97qWxyzwPIl/+CZImtVqF9GegUL0DXzV1ab
         PybQl/6G5vd5Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oqssi-0004Xb-Lo; Fri, 04 Nov 2022 10:20:56 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <bmasney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sc8280xp: update UFS PHY nodes
Date:   Fri,  4 Nov 2022 10:20:45 +0100
Message-Id: <20221104092045.17410-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221104092045.17410-1-johan+linaro@kernel.org>
References: <20221104092045.17410-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the UFS PHY nodes to match the new binding.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 49 +++++++++-----------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index e0d0fb6994b5..1b309fa93484 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -896,7 +896,7 @@ ufs_mem_hc: ufs@1d84000 {
 				     "jedec,ufs-2.0";
 			reg = <0 0x01d84000 0 0x3000>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
-			phys = <&ufs_mem_phy_lanes>;
+			phys = <&ufs_mem_phy>;
 			phy-names = "ufsphy";
 			lanes-per-direction = <2>;
 			#reset-cells = <1>;
@@ -937,27 +937,20 @@ ufs_mem_hc: ufs@1d84000 {
 
 		ufs_mem_phy: phy@1d87000 {
 			compatible = "qcom,sc8280xp-qmp-ufs-phy";
-			reg = <0 0x01d87000 0 0x1c8>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-			clock-names = "ref",
-				      "ref_aux";
+			reg = <0 0x01d87000 0 0x1000>;
+
 			clocks = <&gcc GCC_UFS_CARD_CLKREF_CLK>,
 				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+			clock-names = "ref", "ref_aux";
+
+			power-domains = <&gcc UFS_PHY_GDSC>;
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-			status = "disabled";
 
-			ufs_mem_phy_lanes: phy@1d87400 {
-				reg = <0 0x01d87400 0 0x108>,
-				      <0 0x01d87600 0 0x1e0>,
-				      <0 0x01d87c00 0 0x1dc>,
-				      <0 0x01d87800 0 0x108>,
-				      <0 0x01d87a00 0 0x1e0>;
-				#phy-cells = <0>;
-			};
+			#phy-cells = <0>;
+
+			status = "disabled";
 		};
 
 		ufs_card_hc: ufs@1da4000 {
@@ -965,7 +958,7 @@ ufs_card_hc: ufs@1da4000 {
 				     "jedec,ufs-2.0";
 			reg = <0 0x01da4000 0 0x3000>;
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
-			phys = <&ufs_card_phy_lanes>;
+			phys = <&ufs_card_phy>;
 			phy-names = "ufsphy";
 			lanes-per-direction = <2>;
 			#reset-cells = <1>;
@@ -1005,28 +998,20 @@ ufs_card_hc: ufs@1da4000 {
 
 		ufs_card_phy: phy@1da7000 {
 			compatible = "qcom,sc8280xp-qmp-ufs-phy";
-			reg = <0 0x01da7000 0 0x1c8>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-			clock-names = "ref",
-				      "ref_aux";
+			reg = <0 0x01da7000 0 0x1000>;
+
 			clocks = <&gcc GCC_UFS_1_CARD_CLKREF_CLK>,
 				 <&gcc GCC_UFS_CARD_PHY_AUX_CLK>;
+			clock-names = "ref", "ref_aux";
+
+			power-domains = <&gcc UFS_CARD_GDSC>;
 
 			resets = <&ufs_card_hc 0>;
 			reset-names = "ufsphy";
 
-			status = "disabled";
+			#phy-cells = <0>;
 
-			ufs_card_phy_lanes: phy@1da7400 {
-				reg = <0 0x01da7400 0 0x108>,
-				      <0 0x01da7600 0 0x1e0>,
-				      <0 0x01da7c00 0 0x1dc>,
-				      <0 0x01da7800 0 0x108>,
-				      <0 0x01da7a00 0 0x1e0>;
-				#phy-cells = <0>;
-			};
+			status = "disabled";
 		};
 
 		tcsr_mutex: hwlock@1f40000 {
-- 
2.37.3

