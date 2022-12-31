Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A265A772
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiLaWZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiLaWZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:25:00 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC036575
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 14:24:57 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NkxWr4Lw4z1S5Dr
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 17:24:56 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1672525495;
         x=1673389496; bh=hPWCHZoK4EhXMeU+Z17CLrLgUjsvH7q+HvKSK/bO+Rk=; b=
        nHI49xvb9y1UWkr7cKoZ4Ub4JMf5qC/1DT2o9Mh0gS+fpcz1GR0NnJdTxeYP5ubm
        wJE/2ZLAeBpP312t4g8SQmQsPImlVnVvpLOTseZfd1dAQtOAvXoFObLCzn7QyTCP
        i4Ew45O+kGEZ1DG2Jb1o4tq5Gi7k1wtlc89mOy3gGrzp904etpyH2y/iH5zYKwLy
        BHsUy/RW0f66D5tiomUepPIa7xfXwo/JgWi2sqFIwaFPuOPefrHLvjEf0R6t5Zwe
        Bqukq3lbg71IHCNH/fZXhuGNH4JVS9I+Z17PQ3otXtcvwHiFSykQ69Dpk8Eec2um
        5F3F+ZVYnwpIR100yAGYuw==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P10q0SwqTsd7 for <linux-kernel@vger.kernel.org>;
        Sat, 31 Dec 2022 17:24:55 -0500 (EST)
Received: from dorothy.. (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NkxWl2xfxz1S5F6;
        Sat, 31 Dec 2022 17:24:51 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        marijn.suijten@somainline.org, Lux Aliaga <they@mint.lgbt>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] arm64: dts: qcom: sm6125: Add UFS nodes
Date:   Sat, 31 Dec 2022 19:24:18 -0300
Message-Id: <20221231222420.75233-5-they@mint.lgbt>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221231222420.75233-1-they@mint.lgbt>
References: <20221231222420.75233-1-they@mint.lgbt>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a UFS host controller node and its corresponding PHY to
the sm6125 platform.

Signed-off-by: Lux Aliaga <they@mint.lgbt>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 59 ++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/q=
com/sm6125.dtsi
index df5453fcf2b9..9cb081332849 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -511,6 +511,65 @@ sdhc_2: mmc@4784000 {
 			status =3D "disabled";
 		};
=20
+		ufs_mem_hc: ufs@4804000 {
+			compatible =3D "qcom,sm6125-ufshc", "qcom,ufshc", "jedec,ufs-2.0";
+			reg =3D <0x04804000 0x3000>, <0x04810000 0x8000>;
+			reg-names =3D "std", "ice";
+			interrupts =3D <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+			phys =3D <&ufs_mem_phy>;
+			phy-names =3D "ufsphy";
+			lanes-per-direction =3D <1>;
+			#reset-cells =3D <1>;
+			resets =3D <&gcc GCC_UFS_PHY_BCR>;
+			reset-names =3D "rst";
+			iommus =3D <&apps_smmu 0x200 0x0>;
+
+			clock-names =3D "core_clk",
+				      "bus_aggr_clk",
+				      "iface_clk",
+				      "core_clk_unipro",
+				      "ref_clk",
+				      "tx_lane0_sync_clk",
+				      "rx_lane0_sync_clk",
+				      "ice_core_clk";
+			clocks =3D <&gcc GCC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_UFS_PHY_AHB_CLK>,
+				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+			freq-table-hz =3D <50000000 240000000>,
+					<0 0>,
+					<0 0>,
+					<37500000 150000000>,
+					<0 0>,
+					<0 0>,
+					<0 0>,
+					<75000000 300000000>;
+
+			non-removable;
+			status =3D "disabled";
+		};
+
+		ufs_mem_phy: phy@4807000 {
+			compatible =3D "qcom,sm6125-qmp-ufs-phy";
+			reg =3D <0x04807000 0x1c4>;
+
+			clock-names =3D "ref", "ref_aux";
+			clocks =3D <&gcc GCC_UFS_MEM_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_C=
LK>;
+
+			power-domains =3D <&gcc UFS_PHY_GDSC>;
+
+			resets =3D <&ufs_mem_hc 0>;
+			reset-names =3D "ufsphy";
+
+			#phy-cells =3D <0>;
+
+			status =3D "disabled";
+		};
+
 		gpi_dma0: dma-controller@4a00000 {
 			compatible =3D "qcom,sm6125-gpi-dma", "qcom,sdm845-gpi-dma";
 			reg =3D <0x04a00000 0x60000>;
--=20
2.38.1

