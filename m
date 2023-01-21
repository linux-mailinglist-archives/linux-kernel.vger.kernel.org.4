Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32396765EA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjAULKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjAULKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:10:35 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD9D518C0;
        Sat, 21 Jan 2023 03:10:08 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x36so9441293ede.13;
        Sat, 21 Jan 2023 03:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vLSqOnQH7tAVXPlFrrq1kds1lScFb1J3lJpWMqJJ15U=;
        b=HCjOC37bEyBiNZ7bgPhOwTeWmyrVjSWlRUYSWjmys3KmRcDC5dQk5wTp1nnYkK9zLZ
         9NucluJnYrNYXa+P6NW3aUzl2jDEqTHZJ+UvniaD62RiDOd/nCD7EIB2LuoIImp3i19N
         /zyFFmAGUcSK3lMN9/19TNhFn5m0n0iULXCQ415cuwZb9lPd15ZKZ4CMsl6uapqrFY9p
         XGk3kki1Fxy++E49n1oTw1eS6b1Wo6exfOpxre1BTXf/8kjd20MEVQcRzLMeM+Ea+RKK
         aJbQjzBVDFNL6yI8tXGSrS2kf7be9m6s/eYVPQ/TUjwSIHnlZ/96M3N7rAkpF2OWok5o
         sbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLSqOnQH7tAVXPlFrrq1kds1lScFb1J3lJpWMqJJ15U=;
        b=58wQ7kyYdtdEBol2tjILqE20RKx2WJ/iiQnu3RkIZjhvtJng5u+r+EBLWISdERJkt0
         vvAzTIYO6Vxo/Gl8OUL4VIMk4cYrXT8FKLtWo4s6LK7MuUF25SiHyohhdvTq5SIcVV8t
         NNr/vXXSF/d8nZn48MPpqAihAzuyR5ztHky9Ja4jMxsA+6y+jCizfUnWY7RySWxHWw8E
         65/N+LJMEmG364Z8LBVeRCXWJgWxnACsK43+MG0n5DybN1tRqskV7x5KEHTjP3fI8Zl5
         IvG8HFuLJXEq4XHJlb4ONCYJ1oVtCJffEzBpSQOEE+zL68XepVh++4pHHNPFgOy9FZ03
         LUJg==
X-Gm-Message-State: AFqh2kr96goTr+DgZxMKBM+SiEiSEcWprszof55n+9F2a9n2tU+1LErR
        ht/+YF4NzVCRln5QUOMEp0E=
X-Google-Smtp-Source: AMrXdXtYuA4UjveMnfxfd9xHqJjaF76MVLRWRKshHz33wh/9z7HuVX7pcowtmhCPo5TXUHuRy7i13A==
X-Received: by 2002:a05:6402:f07:b0:493:b55d:d7f2 with SMTP id i7-20020a0564020f0700b00493b55dd7f2mr22053870eda.14.1674299404856;
        Sat, 21 Jan 2023 03:10:04 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id kv23-20020a17090778d700b008699bacc03csm11898900ejc.14.2023.01.21.03.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 03:10:04 -0800 (PST)
Message-ID: <0266aabd-2991-2958-ab1e-55f58ab14461@gmail.com>
Date:   Sat, 21 Jan 2023 12:10:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 8/8] ARM: dts: rockchip: rk3066a: move gpio nodes to root
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

The relation between gpio and pinctrl is now described
by the gpio-ranges property. Move rk3066a gpio nodes to root.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 159 +++++++++++++++------------------
 1 file changed, 72 insertions(+), 87 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 4d7cf6f1b..ac329cf14 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -217,6 +217,18 @@
 				       <150000000>, <75000000>;
 	};

+	gpio6: gpio@2000a000 {
+		compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
+		reg = <0x2000a000 0x100>;
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_GPIO6>;
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 192 32>;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
 	timer2: timer@2000e000 {
 		compatible = "snps,dw-apb-timer";
 		reg = <0x2000e000 0x100>;
@@ -238,6 +250,18 @@
 		};
 	};

+	gpio0: gpio@20034000 {
+		compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
+		reg = <0x20034000 0x100>;
+		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_GPIO0>;
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 0 32>;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
 	timer0: timer@20038000 {
 		compatible = "snps,dw-apb-timer";
 		reg = <0x20038000 0x100>;
@@ -254,6 +278,30 @@
 		clock-names = "timer", "pclk";
 	};

+	gpio1: gpio@2003c000 {
+		compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
+		reg = <0x2003c000 0x100>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_GPIO1>;
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 32 32>;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpio2: gpio@2003e000 {
+		compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
+		reg = <0x2003e000 0x100>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_GPIO2>;
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 64 32>;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
 	tsadc: tsadc@20060000 {
 		compatible = "rockchip,rk3066-tsadc";
 		reg = <0x20060000 0x100>;
@@ -266,96 +314,33 @@
 		status = "disabled";
 	};

+	gpio3: gpio@20080000 {
+		compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
+		reg = <0x20080000 0x100>;
+		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_GPIO3>;
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 96 32>;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpio4: gpio@20084000 {
+		compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
+		reg = <0x20084000 0x100>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_GPIO4>;
+		gpio-controller;
+		gpio-ranges = <&pinctrl 0 128 32>;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3066a-pinctrl";
 		rockchip,grf = <&grf>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		gpio0: gpio@20034000 {
-			compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
-			reg = <0x20034000 0x100>;
-			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO0>;
-
-			gpio-controller;
-			gpio-ranges = <&pinctrl 0 0 32>;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio1: gpio@2003c000 {
-			compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
-			reg = <0x2003c000 0x100>;
-			interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO1>;
-
-			gpio-controller;
-			gpio-ranges = <&pinctrl 0 32 32>;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio2: gpio@2003e000 {
-			compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
-			reg = <0x2003e000 0x100>;
-			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO2>;
-
-			gpio-controller;
-			gpio-ranges = <&pinctrl 0 64 32>;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio3: gpio@20080000 {
-			compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
-			reg = <0x20080000 0x100>;
-			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO3>;
-
-			gpio-controller;
-			gpio-ranges = <&pinctrl 0 96 32>;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio4: gpio@20084000 {
-			compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
-			reg = <0x20084000 0x100>;
-			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO4>;
-
-			gpio-controller;
-			gpio-ranges = <&pinctrl 0 128 32>;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};
-
-		gpio6: gpio@2000a000 {
-			compatible = "rockchip,rk3066a-gpio-bank", "rockchip,gpio-bank";
-			reg = <0x2000a000 0x100>;
-			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cru PCLK_GPIO6>;
-
-			gpio-controller;
-			gpio-ranges = <&pinctrl 0 192 32>;
-			#gpio-cells = <2>;
-
-			interrupt-controller;
-			#interrupt-cells = <2>;
-		};

 		pcfg_pull_default: pcfg-pull-default {
 			bias-pull-pin-default;
--
2.20.1

