Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F44D671CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjARMxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjARMvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:51:55 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2548D47EDC;
        Wed, 18 Jan 2023 04:15:15 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ss4so75467069ejb.11;
        Wed, 18 Jan 2023 04:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rY2dhN6VM8uIQ/kU2pyaCHeRarUbTmENra0xJ5LCaDk=;
        b=eMLrMHme1tSAjFfNRARv0F24d/PKkbFHuQFqgCIaE/6J2P0I5VVv30UcRbhXM5xk//
         wh9Ril8dIvu97wTPhEzZ7ej31pKddKbIr+gDPBgmuH5ZLCyBzjkYTqw0R0XHafTbYLEI
         J1NgWu+mfkqtIr6+Zouyvu/SfN6ILjxch0cJhMLkgglT69AXHwkWysdqseixoKh69dvQ
         BFYB05Rfi8sHUJKEB3InOMCb9tNC1knUnlR9oZS/twaLfZ6E+SAcenGd8qLsumGCfTZm
         TXbJUZh5wMbx7siyXv6Szn04pBR6defyzG6EFnWc97z1h/uRVWkt+Bdx81BJM+H8w5R1
         TItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rY2dhN6VM8uIQ/kU2pyaCHeRarUbTmENra0xJ5LCaDk=;
        b=uCViiZlLjdtMUaJzWZpDFMadLUx/Wt3fzQ6+15BQN5Hr2DQvPjzSJSG5Pljoqi+Uoe
         xSoXylp0J1H+AIvb29zRoLhzhsUZKdc9FdaZG/O7n51h/60Gp6owoUSLeuHKJ25hk4g9
         HMlACvNt/vE83vROpVdsAWQnpKc5tCmJ/ZTUDiQHDf/WkiwLZ4SurOrur4DO3eGvdD4H
         hbgytX6L0M4unWvAB16uuiBwef+LkJNjV0UpSxy5NzQdYiizVI9OK20Kx/w8XFAzVj29
         d4xopMBswCrrsLFLjoQkFrJRfd/WCVhRnSYA/6D/D39+JIvKteUZaR5cHFEkdfz7WXhM
         Japg==
X-Gm-Message-State: AFqh2krndArkWpoREnknZA2ebhF17u+1fUUF8h7EaMWN28yxQxyul+5D
        EKVVtBdGaC8l9eLrUyLaCL4=
X-Google-Smtp-Source: AMrXdXuzbG6ppRnk5GARH3nRK0UuNec2TrCyfx0xSG3GCM165Vguiqz0djqrphF8ZHtvrlELBRQMaA==
X-Received: by 2002:a17:907:86a5:b0:870:d4f3:61b3 with SMTP id qa37-20020a17090786a500b00870d4f361b3mr8614201ejc.12.1674044114443;
        Wed, 18 Jan 2023 04:15:14 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x25-20020a170906b09900b0080345493023sm14348963ejy.167.2023.01.18.04.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 04:15:14 -0800 (PST)
Message-ID: <3e1e8687-ef64-8e96-df7f-fb28bf6ba547@gmail.com>
Date:   Wed, 18 Jan 2023 13:15:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 4/4] arm64: dts: rockchip: replace compatible gpio nodes
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu
References: <08de3f4b-e33f-95c8-3297-814ea107272a@gmail.com>
Content-Language: en-US
In-Reply-To: <08de3f4b-e33f-95c8-3297-814ea107272a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all Rockchip gpio nodes have the same compatible.
Replace all the compatibles in gpio nodes to be able to
give them a consistent ID independent from probe order or alias.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/rockchip/rk3368.dtsi  |  8 ++++----
 arch/arm64/boot/dts/rockchip/rk3399.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/rockchip/rk356x.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 10 +++++-----
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index dd228a256..fe3e665a9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -793,7 +793,7 @@
 		ranges;

 		gpio0: gpio@ff220000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3308-gpio-bank";
 			reg = <0x0 0xff220000 0x0 0x100>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -804,7 +804,7 @@
 		};

 		gpio1: gpio@ff230000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3308-gpio-bank";
 			reg = <0x0 0xff230000 0x0 0x100>;
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -815,7 +815,7 @@
 		};

 		gpio2: gpio@ff240000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3308-gpio-bank";
 			reg = <0x0 0xff240000 0x0 0x100>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -826,7 +826,7 @@
 		};

 		gpio3: gpio@ff250000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3308-gpio-bank";
 			reg = <0x0 0xff250000 0x0 0x100>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
@@ -837,7 +837,7 @@
 		};

 		gpio4: gpio@ff260000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3308-gpio-bank";
 			reg = <0x0 0xff260000 0x0 0x100>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index a4c5aaf1f..322836326 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -978,7 +978,7 @@
 		ranges;

 		gpio0: gpio@ff750000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3368-gpio-bank";
 			reg = <0x0 0xff750000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO0>;
 			interrupts = <GIC_SPI 0x51 IRQ_TYPE_LEVEL_HIGH>;
@@ -991,7 +991,7 @@
 		};

 		gpio1: gpio@ff780000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3368-gpio-bank";
 			reg = <0x0 0xff780000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO1>;
 			interrupts = <GIC_SPI 0x52 IRQ_TYPE_LEVEL_HIGH>;
@@ -1004,7 +1004,7 @@
 		};

 		gpio2: gpio@ff790000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3368-gpio-bank";
 			reg = <0x0 0xff790000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO2>;
 			interrupts = <GIC_SPI 0x53 IRQ_TYPE_LEVEL_HIGH>;
@@ -1017,7 +1017,7 @@
 		};

 		gpio3: gpio@ff7a0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3368-gpio-bank";
 			reg = <0x0 0xff7a0000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO3>;
 			interrupts = <GIC_SPI 0x54 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 1881b4b71..0bb2ab134 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2085,7 +2085,7 @@
 		ranges;

 		gpio0: gpio@ff720000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3399-gpio-bank";
 			reg = <0x0 0xff720000 0x0 0x100>;
 			clocks = <&pmucru PCLK_GPIO0_PMU>;
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2098,7 +2098,7 @@
 		};

 		gpio1: gpio@ff730000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3399-gpio-bank";
 			reg = <0x0 0xff730000 0x0 0x100>;
 			clocks = <&pmucru PCLK_GPIO1_PMU>;
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2111,7 +2111,7 @@
 		};

 		gpio2: gpio@ff780000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3399-gpio-bank";
 			reg = <0x0 0xff780000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO2>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2124,7 +2124,7 @@
 		};

 		gpio3: gpio@ff788000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3399-gpio-bank";
 			reg = <0x0 0xff788000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO3>;
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2137,7 +2137,7 @@
 		};

 		gpio4: gpio@ff790000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3399-gpio-bank";
 			reg = <0x0 0xff790000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO4>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index eed0059a6..401095ae9 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1803,7 +1803,7 @@
 		ranges;

 		gpio0: gpio@fdd60000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3568-gpio-bank";
 			reg = <0x0 0xfdd60000 0x0 0x100>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
@@ -1814,7 +1814,7 @@
 		};

 		gpio1: gpio@fe740000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3568-gpio-bank";
 			reg = <0x0 0xfe740000 0x0 0x100>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
@@ -1825,7 +1825,7 @@
 		};

 		gpio2: gpio@fe750000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3568-gpio-bank";
 			reg = <0x0 0xfe750000 0x0 0x100>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
@@ -1836,7 +1836,7 @@
 		};

 		gpio3: gpio@fe760000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3568-gpio-bank";
 			reg = <0x0 0xfe760000 0x0 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
@@ -1847,7 +1847,7 @@
 		};

 		gpio4: gpio@fe770000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3568-gpio-bank";
 			reg = <0x0 0xfe770000 0x0 0x100>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 005cde61b..adfb0dbbe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1639,7 +1639,7 @@
 		#size-cells = <2>;

 		gpio0: gpio@fd8a0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3588-gpio-bank";
 			reg = <0x0 0xfd8a0000 0x0 0x100>;
 			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&cru PCLK_GPIO0>, <&cru DBCLK_GPIO0>;
@@ -1651,7 +1651,7 @@
 		};

 		gpio1: gpio@fec20000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3588-gpio-bank";
 			reg = <0x0 0xfec20000 0x0 0x100>;
 			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
@@ -1663,7 +1663,7 @@
 		};

 		gpio2: gpio@fec30000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3588-gpio-bank";
 			reg = <0x0 0xfec30000 0x0 0x100>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
@@ -1675,7 +1675,7 @@
 		};

 		gpio3: gpio@fec40000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3588-gpio-bank";
 			reg = <0x0 0xfec40000 0x0 0x100>;
 			interrupts = <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
@@ -1687,7 +1687,7 @@
 		};

 		gpio4: gpio@fec50000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3588-gpio-bank";
 			reg = <0x0 0xfec50000 0x0 0x100>;
 			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
--
2.20.1

