Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E67F6F2F64
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjEAIpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjEAIoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:44:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C55510CA;
        Mon,  1 May 2023 01:44:29 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7776C66031C9;
        Mon,  1 May 2023 09:44:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682930668;
        bh=rxSmyDetIZGvppZUNfAhus6ErLEiFJ3xF8DbQXYz7ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GOIXfJMWPnN+iB38HSKAo06ZeYvHke9DTjRs95PihjrzCHA8Z9/9v9acS5hdPHKBW
         Pf2vJ47cHYzPOP5Tz/2YHeu2EsMMALzj4bZ8980EoquE+7GcfQUfkov3FXTt8XyvdS
         ggr8sQIXcnWYvaCVjgmpxnxwLj2bYlxta/IUVVpV8uV4m8x965N/zpwf9uQ0mEHjMT
         ICnbSZQy1ItIsmMaYWrzK8gkTaVgWuF80l18vDx4F5vXKVX6HLxkpN4bRjiVTM+RB7
         AycotF6qNKY703ZhMgJIvL80ObyB2x7YAtRZiZUDLXR7V1xQ8UgNgrWVIxej/29tTf
         7BmAtbsvY/gVQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 8/8] arm64: dts: rockchip: Add rk3588 OTP node
Date:   Mon,  1 May 2023 11:44:00 +0300
Message-Id: <20230501084401.765169-9-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for Rockchip RK3588/RK3588S OTP memory.

Co-developed-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 767084a1ec43..0abcd51d7d66 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1822,6 +1822,60 @@ spi4: spi@fecb0000 {
 		status = "disabled";
 	};
 
+	otp: efuse@fecc0000 {
+		compatible = "rockchip,rk3588-otp";
+		reg = <0x0 0xfecc0000 0x0 0x400>;
+		clocks = <&cru CLK_OTPC_NS>, <&cru PCLK_OTPC_NS>,
+			 <&cru CLK_OTPC_ARB>, <&cru CLK_OTP_PHY_G>;
+		clock-names = "otpc", "apb", "arb", "phy";
+		resets = <&cru SRST_OTPC_NS>, <&cru SRST_P_OTPC_NS>,
+			 <&cru SRST_OTPC_ARB>;
+		reset-names = "otpc", "apb", "arb";
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

