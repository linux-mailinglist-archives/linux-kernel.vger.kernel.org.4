Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1858C6765E7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjAULJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjAULJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:09:46 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26293518F5;
        Sat, 21 Jan 2023 03:09:30 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qx13so19761609ejb.13;
        Sat, 21 Jan 2023 03:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PdVabjSkYB3NpijodRHXbgHyqgsSYQqNaQRURCL5Zlw=;
        b=MU0qEthoLO7yYg/wkIQqdKt++icqNnXu0xZLXbpTRbX8V/GjV5hF4oaOAyLvS+vhNn
         HSB2aqhGbjYQWkG+8bLaMTbYq/xAhHf9spotVCM5wzucPWP4XchnSiqPuOVI21u1N4tx
         wU7ZdkHVxp72YVLPX21y7g3hJpuUW+BKqWWqtdXQYe/foB7/xn5nfJHhAfD/1Mtr025I
         eBpjpy3a4mji/W3psFI5s3zSfSUYSQQudBdjS/xCwYmTigHxX7+o2bLm4Kkj+5/zi2L2
         eRGL6D7C/z3mXnEeehfVewiJ7c2NRqdeslMoN+Cys6+tapRGle6bdFcqE8wS4STOrE4Z
         +bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdVabjSkYB3NpijodRHXbgHyqgsSYQqNaQRURCL5Zlw=;
        b=HXCIPq501OFH+PMVSqLsOJ9adwMdr3TxHgj8gkyRsEOmtYK1ZyfMVY7NX9WJU0h6d1
         mPAvEVG06HurMlPbJLILW/0Fl3NjQ3fyUmrzf6QwejCvtEJ628wZJCAyQZQtuuLmozeZ
         afWInLxSwjCKoCd1uyh5Y1WierKb+Pe/gAM46+K+EVHqgaIuimbknV08Yk4pNuGRcuFc
         VvA3MRRLjxE2B57goSoNbQ3Qhnj/1oNYb4jVA9vzXYYhTLjE443tvH97MWAs5J2/POeG
         /vnjlVSDhi/rc10Bf/N+SkjN5gfpAbNpc3mQxo7+gXywnkhn6DsH2deAOjrPRGZD2Pjk
         w71Q==
X-Gm-Message-State: AFqh2kqzcjlflrRuoO99qeMoXJThfsN21FL6yaBOFpMngoi2c+dUAC/7
        SJ0HJmq/nH9HDNqsVOgp3YU=
X-Google-Smtp-Source: AMrXdXvKRj7nR1lgfeHWWeEho2QHec2yI4bHnrRtDi9K328KxoD2w6irc2k5dhOLFxygk6oB7JIJqQ==
X-Received: by 2002:a17:907:8b08:b0:838:9b81:1c98 with SMTP id sz8-20020a1709078b0800b008389b811c98mr20059328ejc.1.1674299368581;
        Sat, 21 Jan 2023 03:09:28 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d9-20020a1709063ec900b007bd9e683639sm19101456ejj.130.2023.01.21.03.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 03:09:28 -0800 (PST)
Message-ID: <e1b04772-2c41-ad97-7ff1-c72a17d3aec3@gmail.com>
Date:   Sat, 21 Jan 2023 12:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 6/8] ARM: dts: rockchip: replace compatible gpio nodes
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com
References: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
Content-Language: en-US
In-Reply-To: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
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
Compatible strings should be SoC related.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi  |  6 +++---
 arch/arm/boot/dts/rk3066a.dtsi | 12 ++++++------
 arch/arm/boot/dts/rk3128.dtsi  |  8 ++++----
 arch/arm/boot/dts/rk3188.dtsi  |  6 +++---
 arch/arm/boot/dts/rk322x.dtsi  |  8 ++++----
 arch/arm/boot/dts/rk3288.dtsi  | 18 +++++++++---------
 arch/arm/boot/dts/rv1108.dtsi  |  8 ++++----
 arch/arm/boot/dts/rv1126.dtsi  | 10 +++++-----
 8 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index d99e4ea31..eed21e055 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -576,7 +576,7 @@
 		ranges;

 		gpio0: gpio@2007c000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3036-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x2007c000 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -590,7 +590,7 @@
 		};

 		gpio1: gpio@20080000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3036-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x20080000 0x100>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -604,7 +604,7 @@
 		};

 		gpio2: gpio@20084000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3036-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x20084000 0x100>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 6ff392735..4d7cf6f1b 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -274,7 +274,7 @@
 		ranges;

 		gpio0: gpio@20034000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x20034000 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -288,7 +288,7 @@
 		};

 		gpio1: gpio@2003c000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x2003c000 0x100>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -302,7 +302,7 @@
 		};

 		gpio2: gpio@2003e000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x2003e000 0x100>;
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -316,7 +316,7 @@
 		};

 		gpio3: gpio@20080000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x20080000 0x100>;
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
@@ -330,7 +330,7 @@
 		};

 		gpio4: gpio@20084000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x20084000 0x100>;
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>;
@@ -344,7 +344,7 @@
 		};

 		gpio6: gpio@2000a000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x2000a000 0x100>;
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO6>;
diff --git a/arch/arm/boot/dts/rk3128.dtsi b/arch/arm/boot/dts/rk3128.dtsi
index 0ea277eb7..221f6d6ca 100644
--- a/arch/arm/boot/dts/rk3128.dtsi
+++ b/arch/arm/boot/dts/rk3128.dtsi
@@ -471,7 +471,7 @@
 		ranges;

 		gpio0: gpio@2007c000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3128-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x2007c000 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -483,7 +483,7 @@
 		};

 		gpio1: gpio@20080000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3128-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x20080000 0x100>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -495,7 +495,7 @@
 		};

 		gpio2: gpio@20084000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3128-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x20084000 0x100>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -507,7 +507,7 @@
 		};

 		gpio3: gpio@20088000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3128-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x20088000 0x100>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 6677e4a10..22187d4c7 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -239,7 +239,7 @@
 		};

 		gpio1: gpio@2003c000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3188-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x2003c000 0x100>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -253,7 +253,7 @@
 		};

 		gpio2: gpio@2003e000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3188-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x2003e000 0x100>;
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -267,7 +267,7 @@
 		};

 		gpio3: gpio@20080000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3188-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x20080000 0x100>;
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index a87db48c5..8dc30e45c 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -949,7 +949,7 @@
 		ranges;

 		gpio0: gpio@11110000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3228-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x11110000 0x100>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -964,7 +964,7 @@
 		};

 		gpio1: gpio@11120000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3228-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x11120000 0x100>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -979,7 +979,7 @@
 		};

 		gpio2: gpio@11130000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3228-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x11130000 0x100>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -994,7 +994,7 @@
 		};

 		gpio3: gpio@11140000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3228-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x11140000 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 20567ca98..3aff5955d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1425,7 +1425,7 @@
 		ranges;

 		gpio0: gpio@ff750000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff750000 0x0 0x100>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -1439,7 +1439,7 @@
 		};

 		gpio1: gpio@ff780000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff780000 0x0 0x100>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -1453,7 +1453,7 @@
 		};

 		gpio2: gpio@ff790000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff790000 0x0 0x100>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -1467,7 +1467,7 @@
 		};

 		gpio3: gpio@ff7a0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff7a0000 0x0 0x100>;
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
@@ -1481,7 +1481,7 @@
 		};

 		gpio4: gpio@ff7b0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff7b0000 0x0 0x100>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>;
@@ -1495,7 +1495,7 @@
 		};

 		gpio5: gpio@ff7c0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff7c0000 0x0 0x100>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO5>;
@@ -1509,7 +1509,7 @@
 		};

 		gpio6: gpio@ff7d0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff7d0000 0x0 0x100>;
 			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO6>;
@@ -1523,7 +1523,7 @@
 		};

 		gpio7: gpio@ff7e0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff7e0000 0x0 0x100>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO7>;
@@ -1537,7 +1537,7 @@
 		};

 		gpio8: gpio@ff7f0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff7f0000 0x0 0x100>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO8>;
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index d12b97ee7..49c33a393 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -596,7 +596,7 @@
 		ranges;

 		gpio0: gpio@20030000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1108-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x20030000 0x100>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0_PMU>;
@@ -610,7 +610,7 @@
 		};

 		gpio1: gpio@10310000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1108-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x10310000 0x100>;
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -624,7 +624,7 @@
 		};

 		gpio2: gpio@10320000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1108-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x10320000 0x100>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -638,7 +638,7 @@
 		};

 		gpio3: gpio@10330000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1108-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x10330000 0x100>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
diff --git a/arch/arm/boot/dts/rv1126.dtsi b/arch/arm/boot/dts/rv1126.dtsi
index 68e820221..68759c59a 100644
--- a/arch/arm/boot/dts/rv1126.dtsi
+++ b/arch/arm/boot/dts/rv1126.dtsi
@@ -428,7 +428,7 @@
 		ranges;

 		gpio0: gpio@ff460000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1126-gpio-bank", "rockchip,gpio-bank";
 			reg = <0xff460000 0x100>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
@@ -440,7 +440,7 @@
 		};

 		gpio1: gpio@ff620000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1126-gpio-bank", "rockchip,gpio-bank";
 			reg = <0xff620000 0x100>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
@@ -452,7 +452,7 @@
 		};

 		gpio2: gpio@ff630000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1126-gpio-bank", "rockchip,gpio-bank";
 			reg = <0xff630000 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
@@ -464,7 +464,7 @@
 		};

 		gpio3: gpio@ff640000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1126-gpio-bank", "rockchip,gpio-bank";
 			reg = <0xff640000 0x100>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
@@ -476,7 +476,7 @@
 		};

 		gpio4: gpio@ff650000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1126-gpio-bank", "rockchip,gpio-bank";
 			reg = <0xff650000 0x100>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
--
2.20.1

