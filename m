Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262B86BAF9C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjCOLtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjCOLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:49:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED6E30D3;
        Wed, 15 Mar 2023 04:48:40 -0700 (PDT)
Received: from localhost (unknown [188.24.156.231])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C982766030A0;
        Wed, 15 Mar 2023 11:48:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678880918;
        bh=k/FRJRGvTyGdarAsogRNZp731ApvQsx6xU0AYFlr704=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3rF+enRW7f+4WvC+3VmjfJWpniQPsGoxe46O7GoXu3M+DddaKAmXjNopZf+ss43d
         1p+wT7bv66tZdCuaTx92PRnIVIklHSOIwN9dwv2lek92Mcjtzw6ONi/cb5WAb//rpD
         BtFpyKQMlxpXIkcfQsn8rjykq9w5WSQhyevFqcgpcHcLgH/7rlaKYMcRga1syEfSEr
         cson7+7rMw5ufAXiS7ExOiL8bmM0jmhGkVBgCY4Cyauz7+03qyaTKM1CV1ewf4/Lk+
         4tAGNA/FbcSHxU/o3eMPcMvCcFeZGxrfyMCKTIFIPIiZcYQPtiulPyCBjxX3EZFlG7
         ixm93qrKoD00Q==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 09/11] arm64: dts: rockchip: rk3588s: Add I2S nodes
Date:   Wed, 15 Mar 2023 13:48:04 +0200
Message-Id: <20230315114806.3819515-10-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are five I2S/PCM/TDM controllers and two I2S/PCM controllers
embedded in the RK3588 and RK3588S SoCs.

Add the DT nodes corresponding to the above mentioned Rockchip
controllers.

Also note RK3588 SoC contains four additional I2S/PCM/TDM controllers,
which are handled via a separate patch.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 148 ++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 005cde61b4b2..a137e3450bd6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -810,6 +810,57 @@ power-domain@RK3588_PD_SDMMC {
 		};
 	};
 
+	i2s4_8ch: i2s@fddc0000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfddc0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S4_8CH_TX>, <&cru MCLK_I2S4_8CH_TX>, <&cru HCLK_I2S4_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S4_8CH_TX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 0>;
+		dma-names = "tx";
+		power-domains = <&power RK3588_PD_VO0>;
+		resets = <&cru SRST_M_I2S4_8CH_TX>;
+		reset-names = "tx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s5_8ch: i2s@fddf0000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfddf0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S5_8CH_TX>, <&cru MCLK_I2S5_8CH_TX>, <&cru HCLK_I2S5_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S5_8CH_TX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 2>;
+		dma-names = "tx";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_M_I2S5_8CH_TX>;
+		reset-names = "tx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s9_8ch: i2s@fddfc000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfddfc000 0x0 0x1000>;
+		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S9_8CH_RX>, <&cru MCLK_I2S9_8CH_RX>, <&cru HCLK_I2S9_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S9_8CH_RX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac2 23>;
+		dma-names = "rx";
+		power-domains = <&power RK3588_PD_VO1>;
+		resets = <&cru SRST_M_I2S9_8CH_RX>;
+		reset-names = "rx-m";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	qos_gpu_m0: qos@fdf35000 {
 		compatible = "rockchip,rk3588-qos", "syscon";
 		reg = <0x0 0xfdf35000 0x0 0x20>;
@@ -1117,6 +1168,103 @@ sdhci: mmc@fe2e0000 {
 		status = "disabled";
 	};
 
+	i2s0_8ch: i2s@fe470000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfe470000 0x0 0x1000>;
+		interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S0_8CH_TX>, <&cru MCLK_I2S0_8CH_RX>, <&cru HCLK_I2S0_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		assigned-clocks = <&cru CLK_I2S0_8CH_TX_SRC>, <&cru CLK_I2S0_8CH_RX_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>, <&cru PLL_AUPLL>;
+		dmas = <&dmac0 0>, <&dmac0 1>;
+		dma-names = "tx", "rx";
+		power-domains = <&power RK3588_PD_AUDIO>;
+		resets = <&cru SRST_M_I2S0_8CH_TX>, <&cru SRST_M_I2S0_8CH_RX>;
+		reset-names = "tx-m", "rx-m";
+		rockchip,trcm-sync-tx-only;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0_lrck
+			     &i2s0_sclk
+			     &i2s0_sdi0
+			     &i2s0_sdi1
+			     &i2s0_sdi2
+			     &i2s0_sdi3
+			     &i2s0_sdo0
+			     &i2s0_sdo1
+			     &i2s0_sdo2
+			     &i2s0_sdo3>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s1_8ch: i2s@fe480000 {
+		compatible = "rockchip,rk3588-i2s-tdm";
+		reg = <0x0 0xfe480000 0x0 0x1000>;
+		interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S1_8CH_TX>, <&cru MCLK_I2S1_8CH_RX>, <&cru HCLK_I2S1_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		dmas = <&dmac0 2>, <&dmac0 3>;
+		dma-names = "tx", "rx";
+		resets = <&cru SRST_M_I2S1_8CH_TX>, <&cru SRST_M_I2S1_8CH_RX>;
+		reset-names = "tx-m", "rx-m";
+		rockchip,trcm-sync-tx-only;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s1m0_lrck
+			     &i2s1m0_sclk
+			     &i2s1m0_sdi0
+			     &i2s1m0_sdi1
+			     &i2s1m0_sdi2
+			     &i2s1m0_sdi3
+			     &i2s1m0_sdo0
+			     &i2s1m0_sdo1
+			     &i2s1m0_sdo2
+			     &i2s1m0_sdo3>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s2_2ch: i2s@fe490000 {
+		compatible = "rockchip,rk3588-i2s", "rockchip,rk3066-i2s";
+		reg = <0x0 0xfe490000 0x0 0x1000>;
+		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S2_2CH>, <&cru HCLK_I2S2_2CH>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		assigned-clocks = <&cru CLK_I2S2_2CH_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac1 0>, <&dmac1 1>;
+		dma-names = "tx", "rx";
+		power-domains = <&power RK3588_PD_AUDIO>;
+		rockchip,trcm-sync-tx-only;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s2m1_lrck
+			     &i2s2m1_sclk
+			     &i2s2m1_sdi
+			     &i2s2m1_sdo>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
+	i2s3_2ch: i2s@fe4a0000 {
+		compatible = "rockchip,rk3588-i2s", "rockchip,rk3066-i2s";
+		reg = <0x0 0xfe4a0000 0x0 0x1000>;
+		interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru MCLK_I2S3_2CH>, <&cru HCLK_I2S3_2CH>;
+		clock-names = "i2s_clk", "i2s_hclk";
+		assigned-clocks = <&cru CLK_I2S3_2CH_SRC>;
+		assigned-clock-parents = <&cru PLL_AUPLL>;
+		dmas = <&dmac1 2>, <&dmac1 3>;
+		dma-names = "tx", "rx";
+		power-domains = <&power RK3588_PD_AUDIO>;
+		rockchip,trcm-sync-tx-only;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s3_lrck
+			     &i2s3_sclk
+			     &i2s3_sdi
+			     &i2s3_sdo>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@fe600000 {
 		compatible = "arm,gic-v3";
 		reg = <0x0 0xfe600000 0 0x10000>, /* GICD */
-- 
2.39.1

