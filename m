Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49206E60B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDRMI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjDRMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:08:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20192B75A;
        Tue, 18 Apr 2023 05:06:39 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C125E660320E;
        Tue, 18 Apr 2023 13:06:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681819598;
        bh=TQcB5X4iZIViJGyWOJ/d+KxnISkUh4MekvbHwYmTdXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFDWMnpZdoO3UisFSu/SMZB0jfMFuAlpH18h+bsJa8M+zrtPMfDOCYA6Whd8lcZTY
         rRPbnp2pBY1oFfAtEi52kGJnz3moIECfOzNLDViBcUfevkKAIQCy1TLUYxw6SGwsnq
         IFsMYYrSIy50dnRLUZoGxhbcWukNgm3/mDGe+lkKVlrWlgeo0i1asK6Se+NHdOYkMz
         QG8aT1X/GC36M9hz+E+s0qmIVwt7pdecBa2NACIskLnH67ITi1RcsqkLcDPwxLmZCv
         KLV8M13KYk/fo0TLTrHz9kbBmzYQ9UvItdZTtYnb0OkoFs9wv1sYjyqGDyclq9LF5b
         2jlEX/8tWz6SQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Add rk3588 timer
Date:   Tue, 18 Apr 2023 15:06:24 +0300
Message-Id: <20230418120624.284551-4-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418120624.284551-1-cristian.ciocaltea@collabora.com>
References: <20230418120624.284551-1-cristian.ciocaltea@collabora.com>
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

Add DT node for Rockchip RK3588/RK3588S SoC timer.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 657c019d27fa..767084a1ec43 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1400,6 +1400,14 @@ i2c5: i2c@fead0000 {
 		status = "disabled";
 	};
 
+	timer0: timer@feae0000 {
+		compatible = "rockchip,rk3588-timer", "rockchip,rk3288-timer";
+		reg = <0x0 0xfeae0000 0x0 0x20>;
+		interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_BUSTIMER0>, <&cru CLK_BUSTIMER0>;
+		clock-names = "pclk", "timer";
+	};
+
 	wdt: watchdog@feaf0000 {
 		compatible = "rockchip,rk3588-wdt", "snps,dw-wdt";
 		reg = <0x0 0xfeaf0000 0x0 0x100>;
-- 
2.40.0

