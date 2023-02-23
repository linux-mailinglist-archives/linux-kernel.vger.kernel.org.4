Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830606A10C7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjBWTr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjBWTrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:47:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7632057D05;
        Thu, 23 Feb 2023 11:47:22 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id h16so46516223edz.10;
        Thu, 23 Feb 2023 11:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=07h6Vdlg5BXBW6Sf5yZUF1nhr8tbTqNR0BC4zVhT3/k=;
        b=RMdCjFuo8u/zsA9CZ1/AHf7vAj20C9E8B3RadzyddSsIKjiwu8xV0481ueCEJo8YDE
         ESSWodsfgOb1Nkso54OdH39yGMQhAO+MnjJiwW8N4dpL6iPC+sWl8WkRpNoSNeIdjyva
         YsPRAyVaQTHHT0t1k0Hivs0WABagH1fesPjB9ZxosA+XbOIJM7BSimn9OjGAwIhunU84
         uc4M6dbZu5RaE6dIVWF85G/9sVk7F+Vf7LWjXkIkRYm5hkGfo4+tbx41ACzlAsLoeIk1
         7fWOoHCVGthYAruwNDy7t4FKXXwTEr091j2ovvZdKnufWK7dvlw2Xj1G6UsdpiOzjaGf
         1pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07h6Vdlg5BXBW6Sf5yZUF1nhr8tbTqNR0BC4zVhT3/k=;
        b=V+cENLLc3KuznG4f16ZZGyNlbnpCZzNKnqOaGpSt1tX/z+Z8PQG9Lt34wYh/jskXGA
         bbB6jGmJwaSohpmeUsuRCQQOULn1xdgfo5dkEm5dxYDOKclD05BeauRHj2TvrV34pj91
         rMisFdQcW2pQyAnhBcf8PM2mno+GqBjtsI+7VUarYYVxfJcLoK4p446nGpwRDB5IX+1a
         SX4wfv9sLZekgtgLo+8U/EZtRdH6EHo/8IO+dFefj24xgzJTZ8aZCoHZmUwv34UJytg6
         0LlrDwAaieiD3fCiCIN4te5Trn4z27YXtCenyHBKyvfdCvMbmjjR746WKoJbQSHjBG3h
         aSGg==
X-Gm-Message-State: AO0yUKVGb11q1EcXLCrKJzc/RwcXTwztq9EaDtJimlKYH93WoyVar3N5
        rivMXz/6iqEtIhKWb8EnhQReCwntzng=
X-Google-Smtp-Source: AK7set88gO/KQ+HYBuDGpPxjjQCZTAhVyM0J35FQrRvD2S4K6wzlvfIEwp2Z8fwW7Wk0SyCl1Ik3sg==
X-Received: by 2002:a17:907:9849:b0:8b2:37b5:cc9 with SMTP id jj9-20020a170907984900b008b237b50cc9mr22358689ejc.17.1677181640902;
        Thu, 23 Feb 2023 11:47:20 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906591500b008def483cf79sm3683747ejq.168.2023.02.23.11.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 11:47:09 -0800 (PST)
Message-ID: <b35fbb4c-910e-6145-cbed-56962394fa76@gmail.com>
Date:   Thu, 23 Feb 2023 20:47:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 4/7] ARM: dts: rockchip: add rockchip,gpio-controller
 property to gpio nodes
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

Add a rockchip,gpio-controller property to Rockchip gpio nodes to be
independent from aliases and probe order for our bank id.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
---
 arch/arm/boot/dts/rk3036.dtsi  | 3 +++
 arch/arm/boot/dts/rk3066a.dtsi | 6 ++++++
 arch/arm/boot/dts/rk3128.dtsi  | 4 ++++
 arch/arm/boot/dts/rk3188.dtsi  | 4 ++++
 arch/arm/boot/dts/rk322x.dtsi  | 4 ++++
 arch/arm/boot/dts/rk3288.dtsi  | 9 +++++++++
 arch/arm/boot/dts/rv1108.dtsi  | 4 ++++
 arch/arm/boot/dts/rv1126.dtsi  | 5 +++++
 8 files changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 78686fc72..ef748dc5d 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -582,6 +582,7 @@
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			rockchip,gpio-controller = <0>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -595,6 +596,7 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			rockchip,gpio-controller = <1>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -608,6 +610,7 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			rockchip,gpio-controller = <2>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index de9915d94..cc20b4214 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -280,6 +280,7 @@
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			rockchip,gpio-controller = <0>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -293,6 +294,7 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			rockchip,gpio-controller = <1>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -306,6 +308,7 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			rockchip,gpio-controller = <2>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -319,6 +322,7 @@
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			rockchip,gpio-controller = <3>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -332,6 +336,7 @@
 			clocks = <&cru PCLK_GPIO4>;

 			gpio-controller;
+			rockchip,gpio-controller = <4>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -345,6 +350,7 @@
 			clocks = <&cru PCLK_GPIO6>;

 			gpio-controller;
+			rockchip,gpio-controller = <6>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rk3128.dtsi b/arch/arm/boot/dts/rk3128.dtsi
index b63bd4ad3..01c8a6b33 100644
--- a/arch/arm/boot/dts/rk3128.dtsi
+++ b/arch/arm/boot/dts/rk3128.dtsi
@@ -476,6 +476,7 @@
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
 			gpio-controller;
+			rockchip,gpio-controller = <0>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -487,6 +488,7 @@
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
 			gpio-controller;
+			rockchip,gpio-controller = <1>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -498,6 +500,7 @@
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
 			gpio-controller;
+			rockchip,gpio-controller = <2>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -509,6 +512,7 @@
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
 			gpio-controller;
+			rockchip,gpio-controller = <3>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 44b54af0b..583ba942c 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -231,6 +231,7 @@
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			rockchip,gpio-controller = <0>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -244,6 +245,7 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			rockchip,gpio-controller = <1>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -257,6 +259,7 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			rockchip,gpio-controller = <2>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -270,6 +273,7 @@
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			rockchip,gpio-controller = <3>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index ffc16d6b9..e03203bc1 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -955,6 +955,7 @@
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			rockchip,gpio-controller = <0>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -968,6 +969,7 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			rockchip,gpio-controller = <1>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -981,6 +983,7 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			rockchip,gpio-controller = <2>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -994,6 +997,7 @@
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			rockchip,gpio-controller = <3>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 2ca76b69a..937fec4b8 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1431,6 +1431,7 @@
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			rockchip,gpio-controller = <0>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1444,6 +1445,7 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			rockchip,gpio-controller = <1>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1457,6 +1459,7 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			rockchip,gpio-controller = <2>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1470,6 +1473,7 @@
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			rockchip,gpio-controller = <3>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1483,6 +1487,7 @@
 			clocks = <&cru PCLK_GPIO4>;

 			gpio-controller;
+			rockchip,gpio-controller = <4>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1496,6 +1501,7 @@
 			clocks = <&cru PCLK_GPIO5>;

 			gpio-controller;
+			rockchip,gpio-controller = <5>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1509,6 +1515,7 @@
 			clocks = <&cru PCLK_GPIO6>;

 			gpio-controller;
+			rockchip,gpio-controller = <6>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1522,6 +1529,7 @@
 			clocks = <&cru PCLK_GPIO7>;

 			gpio-controller;
+			rockchip,gpio-controller = <7>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1535,6 +1543,7 @@
 			clocks = <&cru PCLK_GPIO8>;

 			gpio-controller;
+			rockchip,gpio-controller = <8>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index abf3006f0..0dca27d09 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -602,6 +602,7 @@
 			clocks = <&cru PCLK_GPIO0_PMU>;

 			gpio-controller;
+			rockchip,gpio-controller = <0>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -615,6 +616,7 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			rockchip,gpio-controller = <1>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -628,6 +630,7 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			rockchip,gpio-controller = <2>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -641,6 +644,7 @@
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			rockchip,gpio-controller = <3>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm/boot/dts/rv1126.dtsi b/arch/arm/boot/dts/rv1126.dtsi
index 1f07d0a4f..51e8e1741 100644
--- a/arch/arm/boot/dts/rv1126.dtsi
+++ b/arch/arm/boot/dts/rv1126.dtsi
@@ -433,6 +433,7 @@
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
 			gpio-controller;
+			rockchip,gpio-controller = <0>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -444,6 +445,7 @@
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
 			gpio-controller;
+			rockchip,gpio-controller = <1>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -455,6 +457,7 @@
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
 			gpio-controller;
+			rockchip,gpio-controller = <2>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -466,6 +469,7 @@
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
 			gpio-controller;
+			rockchip,gpio-controller = <3>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -477,6 +481,7 @@
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
 			gpio-controller;
+			rockchip,gpio-controller = <4>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
--
2.20.1

