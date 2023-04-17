Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CC46E5404
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDQVkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDQVkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:40:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E2F4C28;
        Mon, 17 Apr 2023 14:40:40 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-191-155.ewe-ip-backbone.de [91.248.191.155])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 06E126603239;
        Mon, 17 Apr 2023 22:40:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681767639;
        bh=JaiGX/zKLMMzlVpGom/T53NzObIEnY5d4OtYAaV22XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBC4My2jOefTtSE40zQd5Zg2VO3ms+tO9845Oz4F7aCh3uJ7OxO/LgWe/WlbVz7te
         pG7XgSmDV83dQklr8xLw0oLlZtbeLZSJW5PJhHzBxnvd8CppU6qtSKf3XxJXbQF0aK
         K45SpXQe5879AxpkTVfBAukjduR09sIJhKplpLmN/XkQpxiKY7CM2xIRbo+JN4CNow
         Q1ktK0PrThXvY9P2DmKwYI8MYJ5VJafqG2pVKKchdCUlHy2Q/vZFYSPfk80/X4pnFC
         VFXF7TgJjasFNTWudpFPI9JQjcu2v3TMp4/QW8YLQgfP8osQ7IT17BihdVC0jtMTTE
         GE3BO0lkHXR+w==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 039E94807EF; Mon, 17 Apr 2023 23:40:36 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marc Zyngier <maz@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        XiaoDong Huang <derrick.huang@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 2/2] arm64: dts: rockchip: rk3588: add GIC ITS support
Date:   Mon, 17 Apr 2023 23:40:35 +0200
Message-Id: <20230417214035.101190-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417214035.101190-1-sebastian.reichel@collabora.com>
References: <20230417214035.101190-1-sebastian.reichel@collabora.com>
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

Add the two Interrupt Translation Service (ITS) IPs that are part of the
GIC-600. They are mainly required for PCIe Message Signalled Interrupts
(MSI).

Co-developed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 2124c654f665..62204b96b0b4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1741,7 +1741,24 @@ gic: interrupt-controller@fe600000 {
 		mbi-alias = <0x0 0xfe610000>;
 		mbi-ranges = <424 56>;
 		msi-controller;
+		ranges;
+		#address-cells = <2>;
 		#interrupt-cells = <4>;
+		#size-cells = <2>;
+
+		its0: msi-controller@fe640000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			#msi-cells = <1>;
+			reg = <0x0 0xfe640000 0x0 0x20000>;
+		};
+
+		its1: msi-controller@fe660000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			#msi-cells = <1>;
+			reg = <0x0 0xfe660000 0x0 0x20000>;
+		};
 
 		ppi-partitions {
 			ppi_partition0: interrupt-partition-0 {
-- 
2.39.2

