Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816A163B197
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiK1SsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiK1Srt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:47:49 -0500
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA8214030;
        Mon, 28 Nov 2022 10:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=SjEaXE1aM3sAT5W9UJJ2Ph7aLEZJwNJ56ePTNEKDEp4=; b=JZ3xP6egL8IFaecQFMD0ZYq98a
        WSandbky0gC70lDUDTuk55mDMvkKQPKjgFzNRd+9t94FWS7D/F9JAnjrrtxGGKmQQZq9/uZ5Sf7xr
        1LiQ7jaZrGODgM3ZN+V4sWPG63QVMk3DdbEAYhUzsKHsLu+QBNCyZ4PpkB06op3vkkSUVHk7Jsp+/
        r2GChUmEYRxuAfTERjUntLDl6sk+yfRZir1/i7UIKS4E7T6wi0XJw9QuDZwlkT+RX7YHt+7RGWD2d
        GonXMaGZyhFwcnJVvRVz6zgwbDXTfxHNf427/dI0aREvS6pbr+i8LwK355xc22+8P5AP1pIlfwvy1
        etqxjBBw==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ozjA2-006BVA-Ij; Mon, 28 Nov 2022 19:47:22 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1ozjA1-008Elv-29;
        Mon, 28 Nov 2022 19:47:21 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>
Cc:     linux-crypto@vger.kernel.org (open list:HARDWARE RANDOM NUMBER
        GENERATOR CORE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list),
        Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: add DT entry for RNG to RK356x
Date:   Mon, 28 Nov 2022 19:47:18 +0100
Message-Id: <20221128184718.1963353-4-aurelien@aurel32.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221128184718.1963353-1-aurelien@aurel32.net>
References: <20221128184718.1963353-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the just added Rockchip RNG driver for RK356x SoCs.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 164708f1eb67..4be94ff45180 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1770,6 +1770,15 @@ usb2phy1_otg: otg-port {
 		};
 	};
 
+	rng: rng@fe388000 {
+		compatible = "rockchip,rk3568-rng";
+		reg = <0x0 0xfe388000 0x0 0x4000>;
+		clocks = <&cru CLK_TRNG_NS>, <&cru HCLK_TRNG_NS>;
+		clock-names = "trng_clk", "trng_hclk";
+		resets = <&cru SRST_TRNG_NS>;
+		reset-names = "reset";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3568-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.35.1

