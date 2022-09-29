Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB0B5EF1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiI2JZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiI2JZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:25:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E8E6D57F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:25:15 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q17so860559lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AZJetzueARLV/R2uCxssAIqr1V78CxcsKnl1/QIBe9s=;
        b=LaRUPVxPmy/1yQ/y4DqAMqycQ69cAR1PBC9V0Bi/Y1f/4d7gr5PAsxfsmdvpadbUhj
         LrrcZQQBE+FGjVI/ErHtQMC+FZNh1YVzQozidXKyGmK2VQB24rce5ItoDIaFoIeHdwwY
         YPtl8Xpv4e+gApUQbXBDKgn/IKdBB8rFZqeyihwHNIL7I7YYo3ss79Kp+hpDDyiW//rA
         RTDTbyouNqhXUbVqJ6GjcsG0YFgk7xBq+TPcvCeKpTo/X8KQ4+j0Mqx/qhO/lDMyok3j
         dms6keyqyMo4oCjFHoqVzqCsDHBj0gJsIb/fd0do1uWNkI27ANjWTr9Px6ec7n5NcvQW
         LTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AZJetzueARLV/R2uCxssAIqr1V78CxcsKnl1/QIBe9s=;
        b=JEIT07BQqrgtpzoF7XCj+g3dy0L9RW1WhWeJxaP35DqiQ2bzVvicmsy64BsQpoTxT9
         dS22qPosQFjiDXSLpGXYnNILbqhsAnNZToWqF3wOAwJ7Nei+pWD/sFxGM561E3a1DzCu
         b7Qs7TAubMVs8F9dcq9nzF2tMemLSNDogX3bwd7xguCnhL5hUfTn8k4kjobA+nLvvxKM
         WnVyuNLkc67QUUUcZMlYMzV/XfJKtpWt/KmstXyn1M/X3WN83hMHgDhHhcOOJuAirPyM
         BTGS5HKXS13ePl+3Fw6GhHlgWEKBdEBcFrIbuRGVCm0iasa9aStOcBPzauAKyKqdcHk+
         1iKw==
X-Gm-Message-State: ACrzQf0GmsLH14W0Sr3BALGgIAiDrqO5UW9ZWkIkskgQzDIgWtSvbQZv
        xrcQzwWY8S4qe5i4r0LEm6w4UA==
X-Google-Smtp-Source: AMsMyM4E4VCyaWuksnRP1K7pxpKAweoB3Gml7b93OCxy9fZY15W0aj9uoRb8X11MthVpzeheTGrZ1Q==
X-Received: by 2002:a05:651c:178d:b0:261:bd23:a5f8 with SMTP id bn13-20020a05651c178d00b00261bd23a5f8mr738896ljb.411.1664443513480;
        Thu, 29 Sep 2022 02:25:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id e3-20020a05651c038300b0026c3975f488sm654437ljp.26.2022.09.29.02.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:25:13 -0700 (PDT)
Message-ID: <92a5e439-fe78-5072-a3fb-78625c7442b8@linaro.org>
Date:   Thu, 29 Sep 2022 11:25:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 2/4] arm64: dts: qcom: msm8916-samsung-j5-common: Add
 initial common device tree
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        devicetree@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Julian Ribbeck <julian.ribbeck@gmx.de>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220928184155.186632-1-linmengbo0689@protonmail.com>
 <20220928184302.186746-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928184302.186746-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 20:44, Lin, Meng-Bo wrote:
> The smartphones below are using the MSM8916 SoC,
> which are released in 2015-2016:
> 
> Samsung Galaxy J5 2015 (SM-J500*)
> Samsung Galaxy J5 2016 (SM-J510*)
> Samsung Galaxy J3 2016
> - SM-J3109/SM-J320Y/SM-J320YZ
> - SM-J320N0/SM-J320ZN
> - SM-J320P/SM-J320R4/SM-J320V/SM-S320VL
> 
> Add a common device tree for with initial support for:
> 
> - GPIO keys
> - SDHCI (internal and external storage)
> - USB Device Mode
> - UART (on USB connector via the SM5703 MUIC)
> - WCNSS (WiFi/BT)
> - Regulators
> 
> The three devices (some varints of J3, all other variants of J5 released
> in 2015 and J5X released in 2016) are very similar, with some differences
> in display and GPIO pins. The common parts are shared in
> msm8916-samsung-j5-common.dtsi to reduce duplication.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  ...-j5.dts => msm8916-samsung-j5-common.dtsi} |   9 +-
>  .../boot/dts/qcom/msm8916-samsung-j5.dts      | 224 ++----------------
>  2 files changed, 16 insertions(+), 217 deletions(-)
>  copy arch/arm64/boot/dts/qcom/{msm8916-samsung-j5.dts => msm8916-samsung-j5-common.dtsi} (94%)
>  rewrite arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts (93%)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
> similarity index 94%
> copy from arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> copy to arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
> index eabeed18cfaa..502b38d4a61e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
> @@ -1,15 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
> -/dts-v1/;
> -
>  #include "msm8916-pm8916.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>  
>  / {
> -	model = "Samsung Galaxy J5 (2015)";
> -	compatible = "samsung,j5", "qcom,msm8916";
> -	chassis-type = "handset";
> -
>  	aliases {
>  		serial0 = &blsp1_uart2;
>  	};
> @@ -92,7 +86,6 @@ &usb {
>  
>  &usb_hs_phy {
>  	extcon = <&pm8916_usbin>;
> -	qcom,init-seq = /bits/ 8 <0x1 0x19 0x2 0x0b>;
>  };
>  
>  &smd_rpm_regulators {
> @@ -199,7 +192,7 @@ l18 {
>  };
>  
>  &msmgpio {
> -	gpio_keys_default: gpio-keys-default {
> +	gpio_keys_default: gpio-keys-default-state {
>  		pins = "gpio107", "gpio109";

This change looks unrelated, so probably should be a separate patch. I
requested name change on your previous version when you were duplicating
diff hunks, so it was not clear that it is a copy.

The truth is that msm8916 bindings were not yet converted to schema and
other nodes were not aligned with common Qualcomm pinctrl schema, thus
this is not actually necessary if you simply copy files.

Anyway, fine by me:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

