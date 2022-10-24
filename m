Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5936260BC18
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiJXVZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiJXVZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:25:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69B22D8731;
        Mon, 24 Oct 2022 12:31:17 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-096-059-109.ewe-ip-backbone.de [91.96.59.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E68FF6602831;
        Mon, 24 Oct 2022 17:55:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666630556;
        bh=IQfA/rjSC8iXKiLYxLYySHd/9TLQ9kJX50bPBRU+wQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=duef4a48j43UXRDooZFg5Tcx+c7cHP8CYaHz/I3gN3ng1rU7jHSNzOL/hHP40fJ3i
         gNsrEohcKR6z6xnBmvOB2yqzw/dKkmj5Sr2hhTIMn53Z+nHPVk9kKa5hDjCtBOBPNJ
         qLz//IwJQnK5No1loN2JbkyBlo6YeXlx0dfAQEWc2G1rsXevEFiRi0IQZuf7EOFB2N
         e3T5+5ln7bFV8fQPrOqPTomoy44YZcopKhKCGs64/N9A4mp9Z+GaMkmH5Ko0nYK5sh
         b8hjHERCtLiRaywWUXUjbAq44qf5cGYG1pq6TAgxS93SaIML4k7qI8n/977Iydr6fi
         cC6Ru2rV2M8sg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id F38C3480AEE; Mon, 24 Oct 2022 18:55:53 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 2/6] arm64: dts: rockchip: remove clock-frequency from rtc
Date:   Mon, 24 Oct 2022 18:55:45 +0200
Message-Id: <20221024165549.74574-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221024165549.74574-1-sebastian.reichel@collabora.com>
References: <20221024165549.74574-1-sebastian.reichel@collabora.com>
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

'clock-frequency' is not part of the DT binding and not supported by the
Linux driver.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts | 1 -
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts            | 1 -
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts    | 1 -
 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi  | 1 -
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts     | 1 -
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts        | 1 -
 6 files changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
index 0e88e9592c1c..81d1064fdb21 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
@@ -212,7 +212,6 @@ hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
-		clock-frequency = <32768>;
 		clock-output-names = "xin32k";
 		/* rtc_int is not connected */
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index e147d6f8b43e..5589f3db6b36 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -196,7 +196,6 @@ hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
-		clock-frequency = <32768>;
 		clock-output-names = "xin32k";
 		/* rtc_int is not connected */
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
index 18b5050c6cd3..7ba1c28f70a9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
@@ -104,7 +104,6 @@ hym8563: rtc@51 {
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PA5 IRQ_TYPE_EDGE_FALLING>;
 		#clock-cells = <0>;
-		clock-frequency = <32768>;
 		clock-output-names = "xin32k";
 		pinctrl-names = "default";
 		pinctrl-0 = <&hym8563_int>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
index 6c168566321b..bf9eb0405b62 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
@@ -301,7 +301,6 @@ hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
-		clock-frequency = <32768>;
 		clock-output-names = "hym8563";
 		pinctrl-names = "default";
 		pinctrl-0 = <&hym8563_int>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index c282f6e79960..26d7fda275ed 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -500,7 +500,6 @@ hym8563: rtc@51 {
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PD3 IRQ_TYPE_EDGE_FALLING>;
 		#clock-cells = <0>;
-		clock-frequency = <32768>;
 		clock-output-names = "rtcic_32kout";
 		pinctrl-names = "default";
 		pinctrl-0 = <&hym8563_int>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index fb87a168fe96..539ef8cc7792 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -509,7 +509,6 @@ hym8563: rtc@51 {
 		interrupt-parent = <&gpio0>;
 		interrupts = <RK_PD3 IRQ_TYPE_LEVEL_LOW>;
 		#clock-cells = <0>;
-		clock-frequency = <32768>;
 		clock-output-names = "rtcic_32kout";
 		pinctrl-names = "default";
 		pinctrl-0 = <&hym8563_int>;
-- 
2.35.1

