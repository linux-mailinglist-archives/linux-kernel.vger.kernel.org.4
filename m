Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5D7673B06
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjASOCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjASOCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:02:41 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B147ED6C;
        Thu, 19 Jan 2023 06:02:08 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kt14so5933217ejc.3;
        Thu, 19 Jan 2023 06:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5kHbDEn6Sxe+uk86dDydXegy6EfeykEDiCkIcsYDge4=;
        b=BBgdG2kq5VvTXe5sXyyRylMRItJBtYHf/OTyz3R9Eg/Wb5SOhXw9tqQaWJgER6yrhT
         HQCHP86oaoCNQPdEsMsSNstp7ZT8ygSCx7THCOnVgsIx9cg49UmS6iH+oOt1QOMMwbk3
         d24kfbm7r37Lq30YXJm6bZzzkOyveDJRreCMnlCAQX+lJutiyDaUV3IYtxh40e/SMT/5
         j42rqCIfckKosyf+gYJeTdifCs4bSCyEb7b3g9AkbTiswiQvyFNUrh9ibOSi4W2/jt0M
         7At2wEHxGwwk3mOIl2crUOpzon1VyUWoFvpWhqcr4CbfHwC3nubzb4Tj1akiwTdCad3m
         L+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kHbDEn6Sxe+uk86dDydXegy6EfeykEDiCkIcsYDge4=;
        b=0ZErx7RlpkypN3EQZbmy/EHLIAY+PtP2XPVyPCxOs71EJPnoI6TUw8BqFMl4aQeQV0
         MZKZLWRVPD6bjhk2jZ40zx6KxTfVpgbdI2DSs7Il15recbfsI78Zy4YiA5qxJ2Thf97T
         SvGOgL/jYWAS2NU6huMvRJz0R+5lsnSIAfrqaZB6nzRCcY6gBNizKVAXPNRtvqT4cKEW
         nW8e+VOxtZkAAq4wQ6gGK6uEP2LXOUxQG/jsRl9MgCTsOhBuDH9Ept4RnqlhZAQf2g3t
         9iR13tV5ANzbtDRTEX33ZIEfCPqBdtrNduXxLrFHoxc6WxuCfEWgFTLbzAOoWMpzWl2b
         LA1g==
X-Gm-Message-State: AFqh2krYrPCQMeacyhhH/iGFT7PFSCyaCD1chB/EelHjgS7heMktcY6f
        rAQlmOXFoiwC1PUkgUaB7OI=
X-Google-Smtp-Source: AMrXdXvkf9BGaYt7OUJJWW3+FUYSgrinvN+X6OZp4IrfSfz8ARnEosaoym+MVxI1FkLLdbfeOTBIgw==
X-Received: by 2002:a17:907:c606:b0:870:d9a:9ebb with SMTP id ud6-20020a170907c60600b008700d9a9ebbmr7594811ejc.38.1674136926957;
        Thu, 19 Jan 2023 06:02:06 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id la17-20020a170907781100b0084d3f3f9984sm14614436ejc.114.2023.01.19.06.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 06:02:06 -0800 (PST)
Message-ID: <bf2f27cf-b0bc-a867-9f2f-c161f72a46c8@gmail.com>
Date:   Thu, 19 Jan 2023 15:02:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [RFC PATCH v1 3/3] arm64: dts: rockchip: add gpio-ranges property to
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
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 5 +++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 5 +++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 5 +++++
 6 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 4f6959eb5..9fcc0d0f3 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1387,6 +1387,7 @@
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0_PMU>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1399,6 +1400,7 @@
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1411,6 +1413,7 @@
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1423,6 +1426,7 @@
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index dd228a256..38976f413 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -798,6 +798,7 @@
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -809,6 +810,7 @@
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -820,6 +822,7 @@
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -831,6 +834,7 @@
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -842,6 +846,7 @@
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 6d7a7bf72..7ba695728 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -1051,6 +1051,7 @@
 			clocks = <&cru PCLK_GPIO0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1064,6 +1065,7 @@
 			clocks = <&cru PCLK_GPIO1>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1077,6 +1079,7 @@
 			clocks = <&cru PCLK_GPIO2>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
@@ -1090,6 +1093,7 @@
 			clocks = <&cru PCLK_GPIO3>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;

 			interrupt-controller;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index a4c5aaf1f..5a008ed18 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -984,6 +984,7 @@
 			interrupts = <GIC_SPI 0x51 IRQ_TYPE_LEVEL_HIGH>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -997,6 +998,7 @@
 			interrupts = <GIC_SPI 0x52 IRQ_TYPE_LEVEL_HIGH>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -1010,6 +1012,7 @@
 			interrupts = <GIC_SPI 0x53 IRQ_TYPE_LEVEL_HIGH>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -1023,6 +1026,7 @@
 			interrupts = <GIC_SPI 0x54 IRQ_TYPE_LEVEL_HIGH>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 1881b4b71..7eb96fcc6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2091,6 +2091,7 @@
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH 0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -2104,6 +2105,7 @@
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH 0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -2117,6 +2119,7 @@
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH 0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -2130,6 +2133,7 @@
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
@@ -2143,6 +2147,7 @@
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;

 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
 			#gpio-cells = <0x2>;

 			interrupt-controller;
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index eed0059a6..870b4d9c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1808,6 +1808,7 @@
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -1819,6 +1820,7 @@
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -1830,6 +1832,7 @@
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -1841,6 +1844,7 @@
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -1852,6 +1856,7 @@
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
--
2.20.1

