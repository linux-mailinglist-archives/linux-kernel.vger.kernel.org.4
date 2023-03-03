Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E2B6A8E48
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCCAsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjCCAsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:48:07 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF98116315
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 16:48:02 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s22so1556436lfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 16:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677804481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3cyGxW8ui97HVK3mUGfF7ZKUtT+dnfhOrXubMs7ap9o=;
        b=uuu6ybV2zUDTsLjHM2g9jFlT36/H0snddZivYWBVkCHmmHkEy3M4p2bN62toiU+EwT
         XhNSuzrYrT8zLHPbrCPyudO3IVf+CEl93kECNbIzyIz0vwngk2aN8H865ENfNWCadLTl
         WX58XiyUQj4aAQMFjjssB1rPVf4jZxsa3RvP2ChuJZq48narMg2XeUxKFhHWVjMwivEo
         dQ3q7JwKmAx72F/lpVh4sYsmxBzsJsEvm5fbgNKI8FRBsO02R7wo2b1oSUagKxerBFW0
         UY+C8Va2OrBZBiMoC1WTMF3x/Ii5pTi56WRimnLhqCJidWzM/PRYdh+LSihjpVfGzxmy
         ES/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677804481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cyGxW8ui97HVK3mUGfF7ZKUtT+dnfhOrXubMs7ap9o=;
        b=RuYVSR8Jp+TllTgAt1nf8Rxn5ooXYSXN71DzGvq7u0lDdIUTqUkTd2dNj0pm8kxM0Q
         EWNvV9rGfVdpfViZLq63cKMJ2sdwWlcTxev8EOmi1Aik35kB6Bjx9oork7Zj9efT69IN
         BtihwuV33cvxO+LdVusSfTUmSaYf6fOyUS+tbV6O7WPJe6DoNBjTRwAtMp0VmNpBOH5i
         nA4Gj5ID5NEQWYbcTKPwZSYpnjEuQe0e5yZg/DHGmLwkdWpmXyDxvSJykHwM4SQHB3PU
         7/kEN80SSkP/wwBtDRqEGLDJVagjbk4UnvoKUFECQm5qb+9zfMFZUK8wNUXpgVv5GSWg
         897w==
X-Gm-Message-State: AO0yUKVM16kiybsIfkQPL1C4UElOBk4QrPDwwS9pz8qKlr0LR949vyd0
        Anx7h52HpqbRBSIwJ3EnEnP2Pw==
X-Google-Smtp-Source: AK7set+KwQBLeRXWjuE4ZSIgisZlKnZ6wxOYXxkoXh3hxONhHEQ/gUKnBJPyOYDaV3GLvdIqEq7FCw==
X-Received: by 2002:a19:a416:0:b0:4e1:8309:1db5 with SMTP id q22-20020a19a416000000b004e183091db5mr56628lfc.2.1677804481071;
        Thu, 02 Mar 2023 16:48:01 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id x14-20020a19f60e000000b004d5a720e689sm151078lfe.126.2023.03.02.16.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 16:48:00 -0800 (PST)
Message-ID: <0a4683b9-0f33-ab19-e4dc-c99f90b04f33@linaro.org>
Date:   Fri, 3 Mar 2023 01:47:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: sc7180: Delete wormdingler-rev0
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     mka@chromium.org, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230302211108.2129598-1-dianders@chromium.org>
 <20230302131031.v2.1.Id0cd5120469eb200118c0c7b8ee8209f877767b4@changeid>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230302131031.v2.1.Id0cd5120469eb200118c0c7b8ee8209f877767b4@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.03.2023 22:11, Douglas Anderson wrote:
> The earliest wormdingler I could find in my pile of hardware is
> -rev1. I believe that -rev0 boards were just distributed as a pile of
> components with no case. At this point I can't imagine anyone needing
> to make wormdingler-rev0 work, so let's delete support for it.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes in v2:
> - Also delete "sc7180-trogdor-wormdingler-rev0.dtsi" (Konrad)
> 
>  arch/arm64/boot/dts/qcom/Makefile             |  2 --
>  .../sc7180-trogdor-wormdingler-rev0-boe.dts   | 22 ------------
>  .../sc7180-trogdor-wormdingler-rev0-inx.dts   | 22 ------------
>  .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi | 36 -------------------
>  4 files changed, 82 deletions(-)
>  delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
>  delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
>  delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 31aa54f0428c..a51060378ddc 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -118,8 +118,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-quackingstick-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-quackingstick-r0-lte.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev0-boe.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev0-inx.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
> deleted file mode 100644
> index d6ed7d0afe4a..000000000000
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Google Wormdingler board device tree source
> - *
> - * Copyright 2021 Google LLC.
> - *
> - * SKU: 0x10 => 16
> - *  - bits 7..4: Panel ID: 0x1 (BOE)
> - */
> -
> -/dts-v1/;
> -
> -#include "sc7180-trogdor-wormdingler-rev0.dtsi"
> -
> -/ {
> -	model = "Google Wormdingler rev0 BOE panel board";
> -	compatible = "google,wormdingler-rev0-sku16", "qcom,sc7180";
> -};
> -
> -&panel {
> -	compatible = "boe,tv110c9m-ll3";
> -};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
> deleted file mode 100644
> index c03525ea64ca..000000000000
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Google Wormdingler board device tree source
> - *
> - * Copyright 2021 Google LLC.
> - *
> - * SKU: 0x0 => 0
> - *  - bits 7..4: Panel ID: 0x0 (INX)
> - */
> -
> -/dts-v1/;
> -
> -#include "sc7180-trogdor-wormdingler-rev0.dtsi"
> -
> -/ {
> -	model = "Google Wormdingler rev0 INX panel board";
> -	compatible = "google,wormdingler-rev0-sku0", "qcom,sc7180";
> -};
> -
> -&panel {
> -	compatible = "innolux,hj110iz-01a";
> -};
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
> deleted file mode 100644
> index 7f272c6e95f6..000000000000
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Google Wormdingler board device tree source
> - *
> - * Copyright 2021 Google LLC.
> - *
> - */
> -
> -/dts-v1/;
> -
> -#include "sc7180-trogdor-wormdingler.dtsi"
> -
> -&avdd_lcd {
> -	gpio = <&tlmm 80 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&panel {
> -	enable-gpios = <&tlmm 76 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&v1p8_mipi {
> -	gpio = <&tlmm 81 GPIO_ACTIVE_HIGH>;
> -};
> -
> -/* PINCTRL - modifications to sc7180-trogdor-wormdingler.dtsi */
> -&avdd_lcd_en {
> -	pins = "gpio80";
> -};
> -
> -&mipi_1800_en {
> -	pins = "gpio81";
> -};
> -
> -&vdd_reset_1800 {
> -	pins = "gpio76";
> -};
