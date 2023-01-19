Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88EB673AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjASOCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjASOBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:01:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D05D7497D;
        Thu, 19 Jan 2023 06:01:48 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y19so2992377edc.2;
        Thu, 19 Jan 2023 06:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NapgBQpV8EOK/qEREONNW/kBlocdhbxkdr9Xp/TagqQ=;
        b=fJ3F4lVzbkxoMgzKHcJHmzdkPmRVVgH5rkAtYTnUJda0/DnaCtff0f0w52mYa3JLba
         XEFmwx3TYCFFaNG8ayrn8d0wzFIxV85jOmYXZbx+Mij1Xlf+N9I/DFqANyvZqd+LZxcS
         LS/Mja28bdOYk3MfhXXLzbgoR4cJZ+CWKX+LSn2DAgAhfBAD6PM0U+Z7mEDMy1QV2FZl
         MkSOyuGT48R+DiMB/+5Pqns++vdzEK8D+qMI0liZC3y5Yxrgtrn6/cel/xVJ3t+OEGh8
         drO057Eujn90U1e+8zS5jVx0H4JQxi+ESR4ZxW7N3x59NeN/UNS+X7R9sPSu9zlg0Pnn
         WxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NapgBQpV8EOK/qEREONNW/kBlocdhbxkdr9Xp/TagqQ=;
        b=Cilp6jblUphzOP/zsyX1xjyU8RdyNfp5jFlOYGNhOQkWmACx7gDq0LE/vIhQXhCr6c
         p2MMeDQPFZJnQpCLHoTM99gvD4u0aNkvhh7hcSV5GwTtYNad1zRYvT9bkR1GNh0Zqzh2
         ro9vMfkzDjmM/RClsb/J16vbJjCaMSrefCc/K5fuDemoEgVnYQer6w8+AYmWzAI6zyZ1
         tIGsyzOmThO3YLgOIh9c9Y1VpE8ZsTN3hIE9Lz7rvKsuCJUzf4aNxgaeeJhRlvnRqTCf
         8Xirog9VdFNeeDrzoyf8QouFPbuygLpdIc1bND3jDIGK1jtEavB1+/bvZZv89yrY1OaE
         yO/w==
X-Gm-Message-State: AFqh2ko174W/n0bURKv189mMco6A1holYZFtjx3qiUbDGBrK4Ce1PP0J
        VRczFz0/TZV/YxaBUy5XcEs=
X-Google-Smtp-Source: AMrXdXtHyUdWXtjm6C8QSlT5MO1lc8j7zHbYuLMAbRM2hcahPYx/yzhLhi+5dikiYxD789kg8JXa8Q==
X-Received: by 2002:a05:6402:2b86:b0:499:70a8:f919 with SMTP id fj6-20020a0564022b8600b0049970a8f919mr11646910edb.32.1674136906918;
        Thu, 19 Jan 2023 06:01:46 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i12-20020aa7dd0c000000b0047021294426sm15625562edv.90.2023.01.19.06.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 06:01:46 -0800 (PST)
Message-ID: <08486cbf-5c61-9005-5404-ba221f50725e@gmail.com>
Date:   Thu, 19 Jan 2023 15:01:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [RFC PATCH v1 2/3] ARM: dts: rockchip: add gpio-ranges property to
 gpio nodes
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com
References: <91a339b3-f233-d7f6-54d8-061b1cd6a6ba@gmail.com>
Content-Language: en-US
In-Reply-To: <91a339b3-f233-d7f6-54d8-061b1cd6a6ba@gmail.com>
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

Add a gpio-ranges property to Rockchip gpio nodes to be
independent from aliases and probe order for our bank id.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Number of pins per bank not checked with datasheet.
Use default 32 for now.
---
 arch/arm/boot/dts/rk3036.dtsi  | 3 +++
 arch/arm/boot/dts/rk3066a.dtsi | 6 ++++++
 arch/arm/boot/dts/rk3128.dtsi  | 4 ++++
 arch/arm/boot/dts/rk3188.dtsi  | 4 ++++
 arch/arm/boot/dts/rk322x.dtsi  | 8 ++++++++
 arch/arm/boot/dts/rk3288.dtsi  | 9 +++++++++
 arch/arm/boot/dts/rv1108.dtsi  | 4 ++++
 arch/arm/boot/dts/rv1126.dtsi  | 5 +++++
 8 files changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 78686fc72..d99e4ea31 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -582,6 +582,7 @@
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -595,6 +596,7 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -608,6 +610,7 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index de9915d94..6ff392735 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -280,6 +280,7 @@
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -293,6 +294,7 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -306,6 +308,7 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -319,6 +322,7 @@
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -332,6 +336,7 @@
 			clocks = <&cru PCLK_GPIO4>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -345,6 +350,7 @@
 			clocks = <&cru PCLK_GPIO6>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 192 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rk3128.dtsi b/arch/arm/boot/dts/rk3128.dtsi
index b63bd4ad3..0ea277eb7 100644
--- a/arch/arm/boot/dts/rk3128.dtsi
+++ b/arch/arm/boot/dts/rk3128.dtsi
@@ -476,6 +476,7 @@
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -487,6 +488,7 @@
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -498,6 +500,7 @@
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -509,6 +512,7 @@
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 44b54af0b..6677e4a10 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -231,6 +231,7 @@
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -244,6 +245,7 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -257,6 +259,7 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -270,6 +273,7 @@
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index ffc16d6b9..a87db48c5 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -955,10 +955,12 @@
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
 			#interrupt-cells = <2>;
+			rockchip,gpio-controller = <0>;
 		};

 		gpio1: gpio@11120000 {
@@ -968,10 +970,12 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
 			#interrupt-cells = <2>;
+			rockchip,gpio-controller = <1>;
 		};

 		gpio2: gpio@11130000 {
@@ -981,10 +985,12 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
 			#interrupt-cells = <2>;
+			rockchip,gpio-controller = <2>;
 		};

 		gpio3: gpio@11140000 {
@@ -994,10 +1000,12 @@
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
 			#interrupt-cells = <2>;
+			rockchip,gpio-controller = <3>;
 		};

 		pcfg_pull_up: pcfg-pull-up {
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 2ca76b69a..20567ca98 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1431,6 +1431,7 @@
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1444,6 +1445,7 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1457,6 +1459,7 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1470,6 +1473,7 @@
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1483,6 +1487,7 @@
 			clocks = <&cru PCLK_GPIO4>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1496,6 +1501,7 @@
 			clocks = <&cru PCLK_GPIO5>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 160 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1509,6 +1515,7 @@
 			clocks = <&cru PCLK_GPIO6>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 192 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1522,6 +1529,7 @@
 			clocks = <&cru PCLK_GPIO7>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 224 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1535,6 +1543,7 @@
 			clocks = <&cru PCLK_GPIO8>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 256 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index abf3006f0..d12b97ee7 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -602,6 +602,7 @@
 			clocks = <&cru PCLK_GPIO0_PMU>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -615,6 +616,7 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -628,6 +630,7 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -641,6 +644,7 @@
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rv1126.dtsi b/arch/arm/boot/dts/rv1126.dtsi
index 1f07d0a4f..68e820221 100644
--- a/arch/arm/boot/dts/rv1126.dtsi
+++ b/arch/arm/boot/dts/rv1126.dtsi
@@ -433,6 +433,7 @@
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -444,6 +445,7 @@
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -455,6 +457,7 @@
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -466,6 +469,7 @@
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -477,6 +481,7 @@
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
--
2.20.1

