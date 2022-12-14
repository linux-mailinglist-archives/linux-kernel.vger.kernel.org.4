Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177D64C602
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 10:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbiLNJcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 04:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbiLNJcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 04:32:24 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Dec 2022 01:32:21 PST
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A486A18C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 01:32:20 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NX9BC1qbrz1S5Ct
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:32:19 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:x-mailer:message-id:date
        :subject:to:from; s=dkim; t=1671010338; x=1671874339; bh=ExGToJ7
        5nnlb4ThQE07j68EgUs+RvHQuBzqSRQC+m2k=; b=PcNvze/w387CEfQnLff5lRf
        4JXsDRpnST4Vf+U9v8EPfDTEr1iugxcXpHECYaWoLAJCjxKrqVB4dijZzSYCkzWA
        IdlfmwSWo6YIoJ/8f1N1OZQMxRXFZHfXCE7Z/mqbYPCBEMTzRLo2X5kcj1IxQQOI
        x30TtvX/J1kiK2tEYMyxtUOEp/uGf8CqBWWuCzxpZepWBh8wKfDb8RBoUiRLvGi1
        5oLSoHjZ2G+L+GXUPDKBRg1Sztg/2II8HuKvSsJyqeEXd7wrQKrzYkpOh2QdJ7iQ
        RW10PlINh3005X5lyys7FDT2vq5YvQZ/GJNzz07sSLuHJKmZjCalOXwZijOklFw=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cNJXnzvW959h for <linux-kernel@vger.kernel.org>;
        Wed, 14 Dec 2022 04:32:18 -0500 (EST)
Received: from dorothy.. (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NX9B73Qqxz1S4yf;
        Wed, 14 Dec 2022 04:32:15 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
Cc:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: qcom: sm6125: Add UFS nodes
Date:   Wed, 14 Dec 2022 06:32:09 -0300
Message-Id: <20221214093209.152991-1-they@mint.lgbt>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a UFS host controller node and its corresponding PHY to
the sm6125 platform.

Signed-off-by: Lux Aliaga <they@mint.lgbt>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 70 ++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/q=
com/sm6125.dtsi
index 1fe3fa3ad877..f43b005b9454 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -506,6 +506,76 @@ sdhc_2: mmc@4784000 {
 			status =3D "disabled";
 		};
=20
+		ufs_mem_hc: ufshc@4804000 {
+			compatible =3D "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
+			reg =3D <0x04804000 0x3000>, <0x04810000 0x8000>;
+			reg-names =3D "std", "ice";
+			interrupts =3D <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+			phys =3D <&ufs_mem_phy_lanes>;
+			phy-names =3D "ufsphy";
+			lanes-per-direction =3D <1>;
+			#reset-cells =3D <1>;
+			resets =3D <&gcc GCC_UFS_PHY_BCR>;
+			reset-names =3D "rst";
+
+			clock-names =3D
+				"core_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro",
+				"core_clk_ice",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk";
+			clocks =3D
+				<&gcc GCC_UFS_PHY_AXI_CLK>, // 200m
+				<&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>, // 200m
+				<&gcc GCC_UFS_PHY_AHB_CLK>, // 0
+				<&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>, // 150m
+				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>, // 300m
+				<&rpmcc RPM_SMD_XO_CLK_SRC>, // 19.2m
+				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>, // 0
+				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>; // 0
+
+			freq-table-hz =3D
+				<50000000 240000000>,
+				<0 0>,
+				<0 0>,
+				<37500000 150000000>,
+				<75000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+
+			non-removable;
+			status =3D "disabled";
+		};
+
+		ufs_mem_phy: phy@4807000 {
+			compatible =3D "qcom,sm6115-qmp-ufs-phy";
+			reg =3D <0x04807000 0x1c4>;
+			#address-cells =3D <1>;
+			#size-cells =3D <1>;
+			ranges;
+
+			power-domains =3D <&gcc UFS_PHY_GDSC>;
+
+			clock-names =3D "ref", "ref_aux";
+			clocks =3D <&gcc GCC_UFS_MEM_CLKREF_CLK>,
+					 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+
+			resets =3D <&ufs_mem_hc 0>;
+			reset-names =3D "ufsphy";
+			status =3D "disabled";
+
+			ufs_mem_phy_lanes: lanes@4807400 {
+				reg =3D <0x4807400 0x098>,
+				      <0x4807600 0x130>,
+				      <0x4807c00 0x16c>;
+				#phy-cells =3D <0>;
+			};
+		};
+
 		usb3: usb@4ef8800 {
 			compatible =3D "qcom,sm6125-dwc3", "qcom,dwc3";
 			reg =3D <0x04ef8800 0x400>;
--=20
2.38.1

