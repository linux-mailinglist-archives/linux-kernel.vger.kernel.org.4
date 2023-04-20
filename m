Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D57F6E9096
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjDTKni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjDTKnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:43:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4062B30C2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:42:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4edb9039a4cso443463e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987371; x=1684579371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QEsmrbfMQN/JXvUF1ulBijNIHsKEdCSMUCm9R17GjWQ=;
        b=Fkzqo0AGlr6VdOiAc8dcd95zCeNR+k5Uk5VIe3VPT7hKV2Fdq46e/0QZz83dQBWIYh
         KpZ2oxVpzxfbQysDRXhwOE2lDb1FLrNbJ31jG8iaE0NDWIk5Hjp9Z2flDnmUC6VGavZb
         BCR510M9AcYin2pwwOady6OThZIk8cRSHuP+C8ER30RjwHQP1MqA/ag8DkAJb1sekutu
         2kMz5CZAAUueuo5QJJ4ul5tRqFZZIKvKEowGuuQNWrw6QOwCbMZfSgtioYPfJYO6vreu
         Mw8v5u9ovJ+xliWcPVsfsxXamQM+DokI0+RZCh9cKELJVD7PP2JHOHdhYBkrr92irdz8
         pxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987371; x=1684579371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEsmrbfMQN/JXvUF1ulBijNIHsKEdCSMUCm9R17GjWQ=;
        b=jsp34irZAo14q4JHhQSujwvgoX1iDSA/8Af9JL1FjCO3tr+0QifVTxiU2+S+3wpdUo
         CTIcgG7oLjpSqMrFQ9akQZzD04Cf9IA+OCuJ55hnugHSR5ELyYICzRq4UCZK3XXxzzdJ
         zhxHzz9RF2kqarL4PH5eAws2h9xamSdE9gcI9UWf8cSUGgLDVpT+lx6liXIcwjkWOvWq
         BGSdeaczNM9gJEOQLx/CcinhRl1E+HdjQMEOrENk82RxiMUmNORtwhA5RWBPGegeCYRL
         p7hpUb0yLSRa/ClO4oEC3U1D9rN66e8eLGDBrupfqkTyhVIMzv0QT/GamlMWq2FTJ+RL
         eb7w==
X-Gm-Message-State: AAQBX9cS7QJoZLvrvo1UyTebXNc9uLlMVT7WLqaCWLKFPXgtbcPc/NhF
        1Isx3EJlb0ZUpIrg6f7+/DZi5A==
X-Google-Smtp-Source: AKy350a9MHJP/69yicnIr0zBPV16YrN9+chssnDFvD55/MbOZPQ0j9d7bZHmTEB2owx+mZblN8KyQw==
X-Received: by 2002:ac2:55ba:0:b0:4db:2ab7:43e6 with SMTP id y26-20020ac255ba000000b004db2ab743e6mr378273lfg.44.1681987371425;
        Thu, 20 Apr 2023 03:42:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id y21-20020ac24215000000b004ece331c830sm175082lfh.206.2023.04.20.03.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:42:50 -0700 (PDT)
Message-ID: <ab7c0eab-4b80-2186-de92-dea3df58c298@linaro.org>
Date:   Thu, 20 Apr 2023 12:42:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] ARM: dts: qcom: ipq4019: fix broken NAND controller
 properties override
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20230420072811.36947-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230420072811.36947-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.04.2023 09:28, Krzysztof Kozlowski wrote:
> After renaming NAND controller node name from "qpic-nand" to
> "nand-controller", the board DTS/DTSI also have to be updated:
> 
>   Warning (unit_address_vs_reg): /soc/qpic-nand@79b0000: node has a unit name, but no reg or ranges property
> 
> Cc: <stable@vger.kernel.org>
Cc: <stable@vger.kernel.org> # 5.12

(g show 9e1e00f18afc:Makefile | head, rounded up to first release)


Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Fixes: 9e1e00f18afc ("ARM: dts: qcom: Fix node name for NAND controller node")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts |  8 ++++----
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi   | 10 +++++-----
>  arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi   | 12 ++++++------
>  3 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
> index 79b0c6318e52..0993f840d1fc 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts
> @@ -11,9 +11,9 @@ soc {
>  		dma-controller@7984000 {
>  			status = "okay";
>  		};
> -
> -		qpic-nand@79b0000 {
> -			status = "okay";
> -		};
>  	};
>  };
> +
> +&nand {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
> index a63b3778636d..468ebc40d2ad 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi
> @@ -102,10 +102,10 @@ pci@40000000 {
>  			status = "okay";
>  			perst-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
>  		};
> -
> -		qpic-nand@79b0000 {
> -			pinctrl-0 = <&nand_pins>;
> -			pinctrl-names = "default";
> -		};
>  	};
>  };
> +
> +&nand {
> +	pinctrl-0 = <&nand_pins>;
> +	pinctrl-names = "default";
> +};
> diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
> index 0107f552f520..7ef635997efa 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi
> @@ -65,11 +65,11 @@ i2c@78b7000 { /* BLSP1 QUP2 */
>  		dma-controller@7984000 {
>  			status = "okay";
>  		};
> -
> -		qpic-nand@79b0000 {
> -			pinctrl-0 = <&nand_pins>;
> -			pinctrl-names = "default";
> -			status = "okay";
> -		};
>  	};
>  };
> +
> +&nand {
> +	pinctrl-0 = <&nand_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
