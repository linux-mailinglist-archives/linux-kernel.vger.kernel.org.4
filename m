Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE2C6765E5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjAULJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjAULJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:09:48 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221CE521CB;
        Sat, 21 Jan 2023 03:09:46 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w14so9502074edi.5;
        Sat, 21 Jan 2023 03:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3iu2iOdfP6HqP+r0sK433TKAtjSOjlwjP5eXttNDkFc=;
        b=dhKoHN93BVjCcfrukNwnimP47OOcnkTdnlosfDNwMDXsHJ7zRL0SrCR0bXQJwkweXG
         ZnELRm7U4yQNW/on4653mfLoKent676SzXe7sVMMjE0NDVQmqkEyBqn3SUFKQfGDU3/R
         WJnGUf3DOv9RODImJvYDkxLK38wxynjPNlihuPe4J7zX/NmMQkxfJQdamAoijwZ4aOwL
         rOfkjosmg7skMqqBSMwvSPYg2y1BNqZq1AgwOSuaQjC3N9vIymy5KfiQioUv5Y+8k7+p
         27ENVjeQjJzWQUq+IEJzMnWSdVeUAnBdrgGW0IXPbk6ChoS/Zk+cjGC5/U9MUr508xbc
         HPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iu2iOdfP6HqP+r0sK433TKAtjSOjlwjP5eXttNDkFc=;
        b=w8yWA1Hlw+DnVbbseZ671U2KsJevpdmB0RFyedFf5y/XDRUgPG5EzA64bkvvmefLfb
         QMfZXOMHKXJlwKTnFIuYCuwgmwyRPsReVKdpErTI90kK2udahVUPoirkqzoiDFzgAH9u
         naPAZT/W9/gz5mNDcVjLjLhf2RYNEZU2gfxQ0zvisM/MOghHJZ1xMRIb9GgMd4Qfn5x6
         VCYYqDGoC9MemfgZf7ZocVdtyblR/fmPquKWOyrQvfyKEY3vHNkMKTL3eYflaiwN/GKI
         bpCsKSpP1CaSa+2hT96FS9ZE6GE5Nl63Sdc2YubiIBt14ctCpezCbFmGmy6H5rGRhlyT
         DcKw==
X-Gm-Message-State: AFqh2krmtLIsLK+Gib7Ca8JsogQlm+Nnr1dy9GnuvMpAByFBsKQLiTJ7
        aDe2ir5FJNj9SvVTtF43CVA=
X-Google-Smtp-Source: AMrXdXv1YK3xxjMAd8qsX/+Aa9oRBo6Grf5aDNciyQLEF+CVxIC5jp4sTTfuPm2hWQOzcfyOBjMMcg==
X-Received: by 2002:aa7:dcd0:0:b0:49e:c9f4:1e5b with SMTP id w16-20020aa7dcd0000000b0049ec9f41e5bmr5088085edu.7.1674299384708;
        Sat, 21 Jan 2023 03:09:44 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id fg11-20020a056402548b00b004873927780bsm18304030edb.20.2023.01.21.03.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 03:09:44 -0800 (PST)
Message-ID: <f2b52912-b6ea-5f5f-7c5b-de68225a9b3b@gmail.com>
Date:   Sat, 21 Jan 2023 12:09:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 7/8] arm64: dts: rockchip: replace compatible gpio nodes
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
 arch/arm64/boot/dts/rockchip/px30.dtsi    |  8 ++++----
 arch/arm64/boot/dts/rockchip/rk3308.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/rockchip/rk3328.dtsi  |  8 ++++----
 arch/arm64/boot/dts/rockchip/rk3368.dtsi  |  8 ++++----
 arch/arm64/boot/dts/rockchip/rk3399.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/rockchip/rk356x.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 10 +++++-----
 7 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 9fcc0d0f3..5f8886623 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1382,7 +1382,7 @@
 		ranges;

 		gpio0: gpio@ff040000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,px30-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff040000 0x0 0x100>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0_PMU>;
@@ -1395,7 +1395,7 @@
 		};

 		gpio1: gpio@ff250000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,px30-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff250000 0x0 0x100>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -1408,7 +1408,7 @@
 		};

 		gpio2: gpio@ff260000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,px30-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff260000 0x0 0x100>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -1421,7 +1421,7 @@
 		};

 		gpio3: gpio@ff270000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,px30-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff270000 0x0 0x100>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 38976f413..1e5742441 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -793,7 +793,7 @@
 		ranges;

 		gpio0: gpio@ff220000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3308-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff220000 0x0 0x100>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -805,7 +805,7 @@
 		};

 		gpio1: gpio@ff230000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3308-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff230000 0x0 0x100>;
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -817,7 +817,7 @@
 		};

 		gpio2: gpio@ff240000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3308-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff240000 0x0 0x100>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -829,7 +829,7 @@
 		};

 		gpio3: gpio@ff250000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3308-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff250000 0x0 0x100>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
@@ -841,7 +841,7 @@
 		};

 		gpio4: gpio@ff260000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3308-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff260000 0x0 0x100>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 7ba695728..b99bef14f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -1045,7 +1045,7 @@
 		ranges;

 		gpio0: gpio@ff210000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3328-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff210000 0x0 0x100>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
@@ -1059,7 +1059,7 @@
 		};

 		gpio1: gpio@ff220000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3328-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff220000 0x0 0x100>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -1073,7 +1073,7 @@
 		};

 		gpio2: gpio@ff230000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3328-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff230000 0x0 0x100>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -1087,7 +1087,7 @@
 		};

 		gpio3: gpio@ff240000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3328-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff240000 0x0 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 5a008ed18..1ece57343 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -978,7 +978,7 @@
 		ranges;

 		gpio0: gpio@ff750000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3368-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff750000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO0>;
 			interrupts = <GIC_SPI 0x51 IRQ_TYPE_LEVEL_HIGH>;
@@ -992,7 +992,7 @@
 		};

 		gpio1: gpio@ff780000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3368-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff780000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO1>;
 			interrupts = <GIC_SPI 0x52 IRQ_TYPE_LEVEL_HIGH>;
@@ -1006,7 +1006,7 @@
 		};

 		gpio2: gpio@ff790000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3368-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff790000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO2>;
 			interrupts = <GIC_SPI 0x53 IRQ_TYPE_LEVEL_HIGH>;
@@ -1020,7 +1020,7 @@
 		};

 		gpio3: gpio@ff7a0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3368-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff7a0000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO3>;
 			interrupts = <GIC_SPI 0x54 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 7eb96fcc6..e60917fff 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2085,7 +2085,7 @@
 		ranges;

 		gpio0: gpio@ff720000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3399-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff720000 0x0 0x100>;
 			clocks = <&pmucru PCLK_GPIO0_PMU>;
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2099,7 +2099,7 @@
 		};

 		gpio1: gpio@ff730000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3399-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff730000 0x0 0x100>;
 			clocks = <&pmucru PCLK_GPIO1_PMU>;
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2113,7 +2113,7 @@
 		};

 		gpio2: gpio@ff780000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3399-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff780000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO2>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2127,7 +2127,7 @@
 		};

 		gpio3: gpio@ff788000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3399-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff788000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO3>;
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -2141,7 +2141,7 @@
 		};

 		gpio4: gpio@ff790000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3399-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xff790000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO4>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 870b4d9c6..892afccfd 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1803,7 +1803,7 @@
 		ranges;

 		gpio0: gpio@fdd60000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3568-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xfdd60000 0x0 0x100>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
@@ -1815,7 +1815,7 @@
 		};

 		gpio1: gpio@fe740000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3568-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xfe740000 0x0 0x100>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
@@ -1827,7 +1827,7 @@
 		};

 		gpio2: gpio@fe750000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3568-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xfe750000 0x0 0x100>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
@@ -1839,7 +1839,7 @@
 		};

 		gpio3: gpio@fe760000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3568-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xfe760000 0x0 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
@@ -1851,7 +1851,7 @@
 		};

 		gpio4: gpio@fe770000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3568-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xfe770000 0x0 0x100>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 005cde61b..09bd4a508 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1639,7 +1639,7 @@
 		#size-cells = <2>;

 		gpio0: gpio@fd8a0000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3588-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xfd8a0000 0x0 0x100>;
 			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&cru PCLK_GPIO0>, <&cru DBCLK_GPIO0>;
@@ -1651,7 +1651,7 @@
 		};

 		gpio1: gpio@fec20000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3588-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xfec20000 0x0 0x100>;
 			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
@@ -1663,7 +1663,7 @@
 		};

 		gpio2: gpio@fec30000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3588-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xfec30000 0x0 0x100>;
 			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
@@ -1675,7 +1675,7 @@
 		};

 		gpio3: gpio@fec40000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3588-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xfec40000 0x0 0x100>;
 			interrupts = <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
@@ -1687,7 +1687,7 @@
 		};

 		gpio4: gpio@fec50000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3588-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x0 0xfec50000 0x0 0x100>;
 			interrupts = <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
--
2.20.1

