Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8772030C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjFBNSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbjFBNSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:18:20 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1324E6A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 06:18:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51456392cbbso6936005a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685711885; x=1688303885;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CJSu3AsQZdRU5oftVTGS98fipTM8z81jlREGCoePaq8=;
        b=zYpO1qHsCCwzE2/eTnIcPKIG2K3q0mciYhit910x9u42eD0LqBJWbl4j5xmQ8KzT5f
         aSJT0zNPVKjH6V7GKwZi0Zxkq8/7BI9AFCQjKcMpZA8gqdBDuGNaYNkVgbgrltxxhs+e
         RxejqCVcp2oN4PsPM2mNuoKOOvddKnWdvFKjk8bY2b4fFUBO1oItkcQ3fcJz7PbyKyZb
         NK3PQL9jK3RLntkG8PBppCO9YQqp6Wk9eHv5d60ubdobGYG1AktwVC9JCTOZTzwuuprR
         MV79fpfPw+xwxepbKTbe6QPIBuYK/xrRB5FDgssKEjGYWJNLtIjEZLeLwmo3f3nhXpq0
         Y1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711885; x=1688303885;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJSu3AsQZdRU5oftVTGS98fipTM8z81jlREGCoePaq8=;
        b=gOsG1Pbv21BK+22pPFafV5Le70pb4rosvn1QOVlEkpRj9JK7xZ/BXhE+7m9cp+7E68
         1XG0ieWJ39R1Ht9VC1plUPTPRR2zJKuXGcqi7nLU1HIpJok2oRzbvvwzHa0ZF6QLZEtQ
         4T/l43b5liCpLwYvNFnKRbdF4FV9aF0Eq/Wzf7O+xQRzABGU0slE8/2LaDwO9NivY4To
         oEagsxruENjrkES9DSdmtAzy2nMH8Xmx0BVkyK0VzNiVENfmWjxpx4rqWGlPZuJ7Ajix
         HcIEuQTKfXOVP9FdePoIR4MlKBgie2/3R2BldtXXHMdpyaZE3S5NoU6O+HNTb45evtOy
         AjSQ==
X-Gm-Message-State: AC+VfDyPI+G1vOgNTr2i5VHPd/TiPFv2B/8UrL+in+Ss2ECn7lNR0LAH
        LW/xtmVozUv49SkoIxuNQN683A==
X-Google-Smtp-Source: ACHHUZ4a3PczmBUd5Upr++tQnwXTM68qCwyR1itmINtvHFgnQ04yVJDTQSYcKtYDnQU8UkPzft2Frw==
X-Received: by 2002:a17:907:9289:b0:96f:ddaa:c30d with SMTP id bw9-20020a170907928900b0096fddaac30dmr4502642ejc.26.1685711885389;
        Fri, 02 Jun 2023 06:18:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id sa25-20020a170906edb900b00965f98eefc1sm742937ejb.116.2023.06.02.06.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 06:18:04 -0700 (PDT)
Message-ID: <c99c4533-1c29-b788-be6b-444f59e22cbd@linaro.org>
Date:   Fri, 2 Jun 2023 15:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: sc8280xp: add resets for
 soundwire controllers
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-6-srinivas.kandagatla@linaro.org>
Content-Language: en-US
In-Reply-To: <20230525122930.17141-6-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending as my previous email probably got lost. If you got it twice,
apologies.

On 25/05/2023 14:29, Srinivas Kandagatla wrote:
> Soundwire controllers on sc8280xp needs an explicit reset, add
> support for this.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 6730349e34f4..39be2e89ce05 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -6,6 +6,7 @@
>  
>  #include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
>  #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
> +#include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>  #include <dt-bindings/interconnect/qcom,sc8280xp.h>
> @@ -2560,6 +2561,8 @@
>  			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&rxmacro>;
>  			clock-names = "iface";
> +			resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
> +			reset-names = "swr_audio_cgcr";
>  			label = "RX";
>  
>  			qcom,din-ports = <0>;
> @@ -2634,6 +2637,8 @@
>  			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&wsamacro>;
>  			clock-names = "iface";
> +			resets = <&lpass_audiocc LPASS_AUDIO_SWR_WSA_CGCR>;
> +			reset-names = "swr_audio_cgcr";
>  			label = "WSA";
>  
>  			qcom,din-ports = <2>;
> @@ -2656,6 +2661,14 @@
>  			status = "disabled";
>  		};
>  
> +		lpass_audiocc: clock-controller@32a9000 {
> +			compatible = "qcom,sc8280xp-lpassaudiocc";
> +			reg = <0 0x032a9000 0 0x1000>;
> +			qcom,adsp-pil-mode;

Here and...

> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
>  		swr2: soundwire-controller@3330000 {
>  			compatible = "qcom,soundwire-v1.6.0";
>  			reg = <0 0x03330000 0 0x2000>;
> @@ -2665,6 +2678,8 @@
>  
>  			clocks = <&txmacro>;
>  			clock-names = "iface";
> +			resets = <&lpasscc LPASS_AUDIO_SWR_TX_CGCR>;
> +			reset-names = "swr_audio_cgcr";
>  			label = "TX";
>  			#sound-dai-cells = <1>;
>  			#address-cells = <2>;
> @@ -2901,6 +2916,14 @@
>  			};
>  		};
>  
> +		lpasscc: clock-controller@33e0000 {
> +			compatible = "qcom,sc8280xp-lpasscc";
> +			reg = <0 0x033e0000 0 0x12000>;
> +			qcom,adsp-pil-mode;

... here - where do you use these properties? Driver ignores them.

AFAIR, these were only for sc7280 where we supported two variants for audio.

Best regards,
Krzysztof

