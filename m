Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7506F7738
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjEDUju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjEDUjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:39:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAF714E6A;
        Thu,  4 May 2023 13:34:02 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9FCAF6605704;
        Thu,  4 May 2023 21:07:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683230840;
        bh=AwLdMI2guFpG/vA2CRiv4Le+UC8eSUAMFfhScPFNJkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaHfg5Laf5SSLYlmXIzZS2f4+r3H37WatrEOUsZ1pCFtSD1FX2E00sbD389SjlD6W
         WrXqiYlFm2xNab0Te++19xgXRzeTDfcsQT464YM6ZdDct9Fp9GL2FKRnmJpLrI2pAa
         x36YbyILRzPo69Za8Om4Xl1KCDw4UXrZkvg5KukdpzyjL0CVaFOXaYNTMX7am7nEys
         JxTqbHpaMXayhcpXhxHoblvOSWfth1Ri8YSJZqC1wlC2EMuEe+D1pcDHxS7MGaBk5v
         9He++Q3njHS2zQpUBiqePbHqMS6+touTJ9jyotgO3HmkvEI/Vd+iaKCn3bQq4r2tcZ
         wXPU5sAugpgTQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 8/8] arm64: dts: rockchip: Add rk3588 OTP node
Date:   Thu,  4 May 2023 23:06:48 +0300
Message-Id: <20230504200648.1119866-9-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
References: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for Rockchip RK3588/RK3588S OTP memory.

Co-developed-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 767084a1ec43..d842988af418 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1822,6 +1822,60 @@ spi4: spi@fecb0000 {
 		status = "disabled";
 	};
 
+	otp: efuse@fecc0000 {
+		compatible = "rockchip,rk3588-otp";
+		reg = <0x0 0xfecc0000 0x0 0x400>;
+		clocks = <&cru CLK_OTPC_NS>, <&cru PCLK_OTPC_NS>,
+			 <&cru CLK_OTP_PHY_G>, <&cru CLK_OTPC_ARB>;
+		clock-names = "otp", "apb_pclk", "phy", "arb";
+		resets = <&cru SRST_OTPC_NS>, <&cru SRST_P_OTPC_NS>,
+			 <&cru SRST_OTPC_ARB>;
+		reset-names = "otp", "apb", "arb";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		cpu_code: cpu-code@2 {
+			reg = <0x02 0x2>;
+		};
+
+		otp_id: id@7 {
+			reg = <0x07 0x10>;
+		};
+
+		otp_cpu_version: cpu-version@1c {
+			reg = <0x1c 0x1>;
+			bits = <3 3>;
+		};
+
+		cpub0_leakage: cpu-leakage@17 {
+			reg = <0x17 0x1>;
+		};
+
+		cpub1_leakage: cpu-leakage@18 {
+			reg = <0x18 0x1>;
+		};
+
+		cpul_leakage: cpu-leakage@19 {
+			reg = <0x19 0x1>;
+		};
+
+		log_leakage: log-leakage@1a {
+			reg = <0x1a 0x1>;
+		};
+
+		gpu_leakage: gpu-leakage@1b {
+			reg = <0x1b 0x1>;
+		};
+
+		npu_leakage: npu-leakage@28 {
+			reg = <0x28 0x1>;
+		};
+
+		codec_leakage: codec-leakage@29 {
+			reg = <0x29 0x1>;
+		};
+	};
+
 	dmac2: dma-controller@fed10000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x0 0xfed10000 0x0 0x4000>;
-- 
2.40.0

