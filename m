Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC83D6A10D4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBWTtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBWTtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:49:11 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21E92699;
        Thu, 23 Feb 2023 11:49:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ec43so45842988edb.8;
        Thu, 23 Feb 2023 11:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qzt8yxD7MB84K4NU+FdHUSQig+TVrzn7l2Slui+HDWU=;
        b=NFZxhAJwbG9c1mm6PENk+YaRTbcAGk7rFmIEguiDAS7zDD+lZcNxg+YF2M5e8rXQCg
         fBI0RKNRf1MQrBTIDFBuRbKwqGjmeb9MUlvgzTFTh8K5I9gs+zTihlvoNZUZuPi47l0f
         DYN9upkpGqrPMKVmeAd8aPSGmSNZIalg+AozRJIjWWWIwii552WVhwler6JEatIKsY4R
         udrTLSXqncSfmS9FhSC4voeN6n+a+69xdtHwipfwWTu03Hqno8l5Hh7fOkLQkwMQ/+S6
         cgkkq9wEoJ/4JwaV0n4dJiPZN3yCcQ1ViLbmT/7W+H7gcsuV0ksM7OM/A7WP+F5M4ksU
         Mizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzt8yxD7MB84K4NU+FdHUSQig+TVrzn7l2Slui+HDWU=;
        b=erCtRFkwTjKcgTOlYCSEt0ENclBYCBhQn7lJKz4lqtTfcxvfaDCUaE9eyKDE1QokDb
         pcIufIDnBmrs7/Fi8VMojUe+Nsy1sNlZp2g1I4apvohKeyFxAO4mkYX7+q4rqMXnx1ht
         Pksk8qXkMFJkJP2WguRduJZUA7Vqal5yG5bXwnx/zF0NmJml2L/QgY4I1zqiEtJfRHwv
         V+bn0+590ue1taQl/hMxFJdi9QlRB9O+Ouu4MreEN4uxF44N9sVUc6QX6rLBoaMjHKps
         xjvwxEq2YBVU4mIMIh5bpVZa8luINZ8tl6Y2GYQ6AqObboJDDkHCdP8YAEZY1/+bbUlg
         v8Kg==
X-Gm-Message-State: AO0yUKWqHfQKJ7H4p0TVaoSKqSMRRJjdfqEi8LlumTFx9Hu8h70VebFo
        tO049BYS5GZXYCZAExkM7j0=
X-Google-Smtp-Source: AK7set9nzFpd/ej2J6fHpIUzMxxfa3fl0pqc2KHvwsmT47yQbyweX3maz1est/wZCeRedQI1xFoSmw==
X-Received: by 2002:a17:906:e59:b0:88e:2ff5:85d2 with SMTP id q25-20020a1709060e5900b0088e2ff585d2mr20235437eji.25.1677181743139;
        Thu, 23 Feb 2023 11:49:03 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q20-20020a170906771400b008e57b5e0ce9sm2634435ejm.108.2023.02.23.11.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 11:49:02 -0800 (PST)
Message-ID: <7425b6bc-8cfd-4db0-9545-89e2951d2a26@gmail.com>
Date:   Thu, 23 Feb 2023 20:48:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 6/7] ARM: dts: rockchip: replace compatible gpio nodes
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <3eeaa940-9d40-5e33-bc36-c9b0449ded9f@gmail.com>
Content-Language: en-US
In-Reply-To: <3eeaa940-9d40-5e33-bc36-c9b0449ded9f@gmail.com>
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
index ef748dc5d..fc71801bd 100644
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
index cc20b4214..92f48a9eb 100644
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
index 01c8a6b33..78e43a0b5 100644
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
index 583ba942c..b414eb7ac 100644
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
index e03203bc1..a1d76e53c 100644
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
@@ -963,7 +963,7 @@
 		};

 		gpio1: gpio@11120000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3228-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x11120000 0x100>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
@@ -977,7 +977,7 @@
 		};

 		gpio2: gpio@11130000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3228-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x11130000 0x100>;
 			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
@@ -991,7 +991,7 @@
 		};

 		gpio3: gpio@11140000 {
-			compatible = "rockchip,gpio-bank";
+			compatible = "rockchip,rk3228-gpio-bank", "rockchip,gpio-bank";
 			reg = <0x11140000 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 937fec4b8..8faf7445b 100644
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
index 0dca27d09..3db2dbf1b 100644
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
index 51e8e1741..0b2d2af87 100644
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

