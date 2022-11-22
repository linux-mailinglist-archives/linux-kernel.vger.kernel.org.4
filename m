Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1881B633FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiKVO7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiKVO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:59:10 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87BB5D688
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:57:55 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j16so23905346lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2G5LSHSLWos4o64Yy/qVYvKcmpoCK7vfBEppoqpTno=;
        b=WSLYBc0Uhv5x1y70Wc+bcOK72gnLzXzGWQYLYwhzeFfVUxnqmBgppJfNxGkIelPiAW
         LZPC/pGtl9q/SoMerW8kXEovLqXNg5McJqQ0aUbzVkr1C1EvIjAL85gxftgLhhP/62p9
         uuqoT5BZXytkcYu2r+gqrEtNZyL9Z7ZYrLmeSUcemP+zZTYufOPnXuYyet3o9SsaYV4k
         3UdXXVOKIHAZeIL7zzEHOmX0YbiaqQFHCGwce8C9KiwKABc0VwiIVwhwq6NNghWpr61h
         PCOtSnOvdPpU11BH4jeGC8AlbxBn5d++AmtiYIb5XM2BwkctnPbkktaf1Ber7r1w9UUs
         12Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2G5LSHSLWos4o64Yy/qVYvKcmpoCK7vfBEppoqpTno=;
        b=QKSDJiqFxCwu2kfBJpvLMbY9evXXYHVsj/aJou8kO91zL7exNCzMpa+f14h6/JzsRy
         eYj98Jj6PcZgzB1d19dMV5BjAKgfMuELyIiCBnpvpz4zT2Ewlf8RyeGWau7oCJkH7ag1
         /crTPLRngow5vcBgJEOr14pDCJt2MmGq/l1P4BsiZ/iMBgTPhotQZSXaBw379JiaFJiz
         8ZE/dJjSEXR1Da7b95moXsCtvn9NTfMnZulD6TLfKlCEmTlOcTCeHIw4fpLrJX2BcCSE
         kBnWX6q1tgS8tPmfCd7V0oedCLJLJOjfiCrdQAtGOfriLNQku2EgQd7MVB5e9/Vg6XCA
         pEbw==
X-Gm-Message-State: ANoB5pmnm6ob1a/W6//Tm4Xzd1SCwBUbjSC1/nvRvJdQGrPOSGehIpxg
        VwTpSe0qw5TXD0fpbcYlLYT0Gg==
X-Google-Smtp-Source: AA0mqf5cRagWe1+0LJQH1W1DbZlV4g9CgozLMEPngBqOIdOvmMJI2ZuBIUUC8xX163GPXmUsWlvZ8w==
X-Received: by 2002:a19:6d0b:0:b0:4a2:489d:490f with SMTP id i11-20020a196d0b000000b004a2489d490fmr8335514lfc.196.1669129074184;
        Tue, 22 Nov 2022 06:57:54 -0800 (PST)
Received: from [192.168.1.101] (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e8912000000b002770eafaafbsm1949415lji.99.2022.11.22.06.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 06:57:53 -0800 (PST)
Message-ID: <844a3ebf-d7f9-a745-3444-03c1be68e239@linaro.org>
Date:   Tue, 22 Nov 2022 15:57:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RESEND PATCH v5 4/4] dts: arm64: qcom: msm8916-acer-a1-724: Add
 touchscreen
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221122132816.257717-1-linmengbo0689@protonmail.com>
 <20221122133141.258357-1-linmengbo0689@protonmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221122133141.258357-1-linmengbo0689@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.11.2022 14:32, Lin, Meng-Bo wrote:
> A1-724 uses a Focaltech FT5446 touchscreen that is connected to blsp_i2c5.
> Add it to the device tree.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
Your commit message is wrong. It should be arm64: dts:.. and not dts: arm64:...
>  .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> index bea0d022dd9a..5b216107f69b 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
> @@ -81,6 +81,30 @@ magnetometer@12 {
>  	};
>  };
>  
> +&blsp_i2c5 {
> +	status = "okay";
> +
> +	touchscreen@38 {
> +		/* Actually ft5446 */
> +		compatible = "edt,edt-ft5406";
> +		reg = <0x38>;
> +
> +		interrupt-parent = <&msmgpio>;
> +		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
> +
> +		reset-gpios = <&msmgpio 12 GPIO_ACTIVE_LOW>;
> +
> +		vcc-supply = <&pm8916_l16>;
> +		iovcc-supply = <&pm8916_l6>;
> +
> +		touchscreen-size-x = <720>;
> +		touchscreen-size-y = <1280>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touchscreen_default>;
> +	};
> +};
> +
>  &blsp1_uart2 {
>  	status = "okay";
>  };
> @@ -245,6 +269,24 @@ gpio_keys_default: gpio-keys-default-state {
>  		bias-pull-up;
>  	};
>  
> +	touchscreen_default: touchscreen-default-state {
> +		reset-pins {
> +			pins = "gpio12";
> +			function = "gpio";
Redundant new line, here and in the next subnode.

Konrad
> +
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		touchscreen-pins {
> +			pins = "gpio13";
> +			function = "gpio";
> +
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
> +	};
> +
>  	usb_id_default: usb-id-default-state {
>  		pins = "gpio110";
>  		function = "gpio";
