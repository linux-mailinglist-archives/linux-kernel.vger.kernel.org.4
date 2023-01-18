Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67663671CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjARMwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjARMvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:51:54 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1439137572;
        Wed, 18 Jan 2023 04:15:04 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hw16so70904771ejc.10;
        Wed, 18 Jan 2023 04:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gEm5pfEFxLU82heBKI27UAFcsZk4bHDY3wzooSXrcko=;
        b=VaFHPja+bPQ5/gm1MJ2pBOe+AJxl9fP51w3flhiEtvNn+z7klWeMihJ3F4LhurbmIz
         yhPRLCjCd0Fb9XnBOunXGr+ljgkoTC4aGXj2nvDKlG5uHf1B2ndiDzSjpSNf+/D85qct
         22P5GEXeV4k9BwwwUqcl5SAFGfXkutYeF4/DX27j6hvDgeQlT+eDCk6KbisRsgWtZdrb
         aylEKrJT3HjBYFrtYGKKLH7h8dEeUUnHqkuEKVOu+tP7Mbrw5PZ6aOJYMobD58ctCWJB
         bEZL7GrP+Sxlf5VfQkbLjd5QTc1/WMa3AOiB+58zYyMThmol6M+/JOWERSD6aL9hjgUx
         5YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEm5pfEFxLU82heBKI27UAFcsZk4bHDY3wzooSXrcko=;
        b=HIQcYK29RPBBM/yb1FxwCmvN4YrCZfNh6JVRkDJlBu4kqmd73yOWEQCCJCM8NeeQk/
         yVO9oUx1hu3du6BNOD2au5FW9kgTJp6tyUaVh9n/SOlJCybnz7E9EbqbajAWQq6NqlIt
         9lXum/JWlZ6TREyRJ4s/oNyI8uvl5GL4YV4l6Di/GeN8+jDcrfe/ujs5H+2MBzBxqHD2
         w6tDDijVvc/6HJ0WPpXBQNhC/oz2XvfHR4/2+1EstkOMfEsFTTjxGkiNOlJ26vD13C2y
         i0Ag7oJzHMW4m2W6seWCvQodBi2XbfaXYRQ84HM7nPXTAPbOO6bhwsQJPBBTiGd/aQL0
         V/CQ==
X-Gm-Message-State: AFqh2kp9+DfqtFqUqmDZCCH71CtX16Q9EngTb/Ba8Bnjx79M08HaZtJp
        qt9fuEPkTxM1bkw9McRROQk=
X-Google-Smtp-Source: AMrXdXuR92gcbp4hn7cE2LekysEtufuYMovpGlHBXJlIchtwkyTzi+t6R6oiE/mgZZnpPVX+vy2pWg==
X-Received: by 2002:a17:906:eb8e:b0:871:6b9d:dbc with SMTP id mh14-20020a170906eb8e00b008716b9d0dbcmr6731822ejb.21.1674044102576;
        Wed, 18 Jan 2023 04:15:02 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906c31800b0086dee4e5555sm5251042ejz.87.2023.01.18.04.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 04:15:02 -0800 (PST)
Message-ID: <8bf935cf-8f99-d30e-e92c-bff58da0018c@gmail.com>
Date:   Wed, 18 Jan 2023 13:15:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 3/4] ARM: dts: rockchip: replace compatible gpio nodes
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
 arch/arm/boot/dts/rk3036.dtsi            |  6 +++---
 arch/arm/boot/dts/rk3066a.dtsi           | 12 ++++++------
 arch/arm/boot/dts/rk3128.dtsi            |  8 ++++----
 arch/arm/boot/dts/rk3188.dtsi            |  6 +++---
 arch/arm/boot/dts/rk322x.dtsi            |  8 ++++----
 arch/arm/boot/dts/rk3288.dtsi            | 18 +++++++++---------
 arch/arm/boot/dts/rv1108.dtsi            |  8 ++++----
 arch/arm/boot/dts/rv1126.dtsi            | 10 +++++-----
 arch/arm64/boot/dts/rockchip/px30.dtsi   |  8 ++++----
 arch/arm64/boot/dts/rockchip/rk3328.dtsi |  8 ++++----
 10 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 78686fc72..6b1fe6054 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -576,7 +576,7 @@
 		ranges;

 		gpio0: gpio@2007c000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3036-gpio-bank";
 			reg = <0x2007c000 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -589,7 +589,7 @@
 		};

 		gpio1: gpio@20080000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3036-gpio-bank";
 			reg = <0x20080000 0x100>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -602,7 +602,7 @@
 		};

 		gpio2: gpio@20084000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3036-gpio-bank";
 			reg = <0x20084000 0x100>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index de9915d94..59cdc2893 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -274,7 +274,7 @@
 		ranges;

 		gpio0: gpio@20034000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3066a-gpio-bank";
 			reg = <0x20034000 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -287,7 +287,7 @@
 		};

 		gpio1: gpio@2003c000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3066a-gpio-bank";
 			reg = <0x2003c000 0x100>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -300,7 +300,7 @@
 		};

 		gpio2: gpio@2003e000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3066a-gpio-bank";
 			reg = <0x2003e000 0x100>;
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -313,7 +313,7 @@
 		};

 		gpio3: gpio@20080000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3066a-gpio-bank";
 			reg = <0x20080000 0x100>;
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
@@ -326,7 +326,7 @@
 		};

 		gpio4: gpio@20084000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3066a-gpio-bank";
 			reg = <0x20084000 0x100>;
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>;
@@ -339,7 +339,7 @@
 		};

 		gpio6: gpio@2000a000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3066a-gpio-bank";
 			reg = <0x2000a000 0x100>;
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO6>;
diff --git a/arch/arm/boot/dts/rk3128.dtsi b/arch/arm/boot/dts/rk3128.dtsi
index b63bd4ad3..384230279 100644
--- a/arch/arm/boot/dts/rk3128.dtsi
+++ b/arch/arm/boot/dts/rk3128.dtsi
@@ -471,7 +471,7 @@
 		ranges;

 		gpio0: gpio@2007c000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3128-gpio-bank";
 			reg = <0x2007c000 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -482,7 +482,7 @@
 		};

 		gpio1: gpio@20080000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3128-gpio-bank";
 			reg = <0x20080000 0x100>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -493,7 +493,7 @@
 		};

 		gpio2: gpio@20084000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3128-gpio-bank";
 			reg = <0x20084000 0x100>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -504,7 +504,7 @@
 		};

 		gpio3: gpio@20088000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3128-gpio-bank";
 			reg = <0x20088000 0x100>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 44b54af0b..09540d779 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -238,7 +238,7 @@
 		};

 		gpio1: gpio@2003c000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3188-gpio-bank";
 			reg = <0x2003c000 0x100>;
 			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -251,7 +251,7 @@
 		};

 		gpio2: gpio@2003e000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3188-gpio-bank";
 			reg = <0x2003e000 0x100>;
 			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -264,7 +264,7 @@
 		};

 		gpio3: gpio@20080000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3188-gpio-bank";
 			reg = <0x20080000 0x100>;
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index ffc16d6b9..c1a6bab37 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -949,7 +949,7 @@
 		ranges;

 		gpio0: gpio@11110000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3228-gpio-bank";
 			reg = <0x11110000 0x100>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -962,7 +962,7 @@
 		};

 		gpio1: gpio@11120000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3228-gpio-bank";
 			reg = <0x11120000 0x100>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -975,7 +975,7 @@
 		};

 		gpio2: gpio@11130000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3228-gpio-bank";
 			reg = <0x11130000 0x100>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -988,7 +988,7 @@
 		};

 		gpio3: gpio@11140000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3228-gpio-bank";
 			reg = <0x11140000 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 2ca76b69a..ad2ea13c6 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1425,7 +1425,7 @@
 		ranges;

 		gpio0: gpio@ff750000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank";
 			reg = <0x0 0xff750000 0x0 0x100>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -1438,7 +1438,7 @@
 		};

 		gpio1: gpio@ff780000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank";
 			reg = <0x0 0xff780000 0x0 0x100>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -1451,7 +1451,7 @@
 		};

 		gpio2: gpio@ff790000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank";
 			reg = <0x0 0xff790000 0x0 0x100>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -1464,7 +1464,7 @@
 		};

 		gpio3: gpio@ff7a0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank";
 			reg = <0x0 0xff7a0000 0x0 0x100>;
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
@@ -1477,7 +1477,7 @@
 		};

 		gpio4: gpio@ff7b0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank";
 			reg = <0x0 0xff7b0000 0x0 0x100>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>;
@@ -1490,7 +1490,7 @@
 		};

 		gpio5: gpio@ff7c0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank";
 			reg = <0x0 0xff7c0000 0x0 0x100>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO5>;
@@ -1503,7 +1503,7 @@
 		};

 		gpio6: gpio@ff7d0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank";
 			reg = <0x0 0xff7d0000 0x0 0x100>;
 			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO6>;
@@ -1516,7 +1516,7 @@
 		};

 		gpio7: gpio@ff7e0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank";
 			reg = <0x0 0xff7e0000 0x0 0x100>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO7>;
@@ -1529,7 +1529,7 @@
 		};

 		gpio8: gpio@ff7f0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3288-gpio-bank";
 			reg = <0x0 0xff7f0000 0x0 0x100>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO8>;
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index abf3006f0..2b459506e 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -596,7 +596,7 @@
 		ranges;

 		gpio0: gpio@20030000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1108-gpio-bank";
 			reg = <0x20030000 0x100>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0_PMU>;
@@ -609,7 +609,7 @@
 		};

 		gpio1: gpio@10310000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1108-gpio-bank";
 			reg = <0x10310000 0x100>;
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -622,7 +622,7 @@
 		};

 		gpio2: gpio@10320000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1108-gpio-bank";
 			reg = <0x10320000 0x100>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -635,7 +635,7 @@
 		};

 		gpio3: gpio@10330000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1108-gpio-bank";
 			reg = <0x10330000 0x100>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
diff --git a/arch/arm/boot/dts/rv1126.dtsi b/arch/arm/boot/dts/rv1126.dtsi
index 1f07d0a4f..d30deb73e 100644
--- a/arch/arm/boot/dts/rv1126.dtsi
+++ b/arch/arm/boot/dts/rv1126.dtsi
@@ -428,7 +428,7 @@
 		ranges;

 		gpio0: gpio@ff460000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1126-gpio-bank";
 			reg = <0xff460000 0x100>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
@@ -439,7 +439,7 @@
 		};

 		gpio1: gpio@ff620000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1126-gpio-bank";
 			reg = <0xff620000 0x100>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
@@ -450,7 +450,7 @@
 		};

 		gpio2: gpio@ff630000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1126-gpio-bank";
 			reg = <0xff630000 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
@@ -461,7 +461,7 @@
 		};

 		gpio3: gpio@ff640000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1126-gpio-bank";
 			reg = <0xff640000 0x100>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
@@ -472,7 +472,7 @@
 		};

 		gpio4: gpio@ff650000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rv1126-gpio-bank";
 			reg = <0xff650000 0x100>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 4f6959eb5..6c7a6817c 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1382,7 +1382,7 @@
 		ranges;

 		gpio0: gpio@ff040000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,px30-gpio-bank";
 			reg = <0x0 0xff040000 0x0 0x100>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0_PMU>;
@@ -1394,7 +1394,7 @@
 		};

 		gpio1: gpio@ff250000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,px30-gpio-bank";
 			reg = <0x0 0xff250000 0x0 0x100>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -1406,7 +1406,7 @@
 		};

 		gpio2: gpio@ff260000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,px30-gpio-bank";
 			reg = <0x0 0xff260000 0x0 0x100>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -1418,7 +1418,7 @@
 		};

 		gpio3: gpio@ff270000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,px30-gpio-bank";
 			reg = <0x0 0xff270000 0x0 0x100>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 6d7a7bf72..868e5e6b5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -1045,7 +1045,7 @@
 		ranges;

 		gpio0: gpio@ff210000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3328-gpio-bank";
 			reg = <0x0 0xff210000 0x0 0x100>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -1058,7 +1058,7 @@
 		};

 		gpio1: gpio@ff220000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3328-gpio-bank";
 			reg = <0x0 0xff220000 0x0 0x100>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -1071,7 +1071,7 @@
 		};

 		gpio2: gpio@ff230000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3328-gpio-bank";
 			reg = <0x0 0xff230000 0x0 0x100>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -1084,7 +1084,7 @@
 		};

 		gpio3: gpio@ff240000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3328-gpio-bank";
 			reg = <0x0 0xff240000 0x0 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
--
2.20.1

