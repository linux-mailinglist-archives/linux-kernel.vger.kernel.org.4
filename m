Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B696A56DE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjB1KgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjB1KgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:36:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC620D31;
        Tue, 28 Feb 2023 02:36:18 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D8EE66021F9;
        Tue, 28 Feb 2023 10:36:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677580577;
        bh=76t+fzjT2/wIqxMWU7rwXik9LpuADrrJG6sBa8kaQD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XeknhX51WTygsqlSaC4hpkGHlVLSTt+duAmPzf4o7+NhUq76fjf9sHzkGPxv5/IJW
         +w29JoQYS0IUw226UmZySi2XHAbpO1mOGXQdgUr2D/HUU6IJr/WB8PyDZkemWo+h1C
         DyJVPVlEn0FyhgXleD3KaR/H4Y+zDgkkIMG4q7rTSejzm3vN9trMoe2YtMCVM/GnSJ
         mr/oSGmyUQESoFPTOMFl1B/a6iSpudWxMkcHiDbmuJn8sutF/7xQ2U1CvcZy0TaP1U
         sYKxnfUKSaz81GdQTIWtlPugcPtSDAL/vTwNpTqepBHAF01X9Ev9WNgzONc3NGAwhj
         wLsx+auVGYrfA==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     lucas.tanure@collabora.com
Cc:     devicetree@vger.kernel.org, heiko@sntech.de, kernel@collabora.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, shawn.lin@rock-chips.com,
        ulf.hansson@linaro.org
Subject: [PATCH v2] arm64: dts: rockchip: rk3588: Add sdmmc node
Date:   Tue, 28 Feb 2023 10:36:10 +0000
Message-Id: <20230228103610.25108-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230213152740.359055-2-lucas.tanure@collabora.com>
References: <20230213152740.359055-2-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SD Card node for RK3588s and RK3588.

Co-developed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
Changes Since v1:
  None. Re-submitting this patch alone as the first patch of this series was
  already accepted.
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 005cde61b4b2..fca8503aed8c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1099,6 +1099,21 @@ gmac1_mtl_tx_setup: tx-queues-config {
 		};
 	};
 
+	sdmmc: mmc@fe2c0000 {
+		compatible = "rockchip,rk3588-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x0 0xfe2c0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&scmi_clk SCMI_HCLK_SD>, <&scmi_clk SCMI_CCLK_SD>,
+			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
+		fifo-depth = <0x100>;
+		max-frequency = <200000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_det &sdmmc_bus4>;
+		power-domains = <&power RK3588_PD_SDMMC>;
+		status = "disabled";
+	};
+
 	sdhci: mmc@fe2e0000 {
 		compatible = "rockchip,rk3588-dwcmshc";
 		reg = <0x0 0xfe2e0000 0x0 0x10000>;
-- 
2.39.2

