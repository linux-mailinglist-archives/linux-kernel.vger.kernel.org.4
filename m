Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A246C1DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjCTRXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjCTRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:23:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6272C667
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:19:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s8so15565031lfr.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679332744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZTtiE96GXaObleW3VgFhOW4Q83iKH3flYmM0JqxHbE=;
        b=G+MRPKewAqp2gtCgBQ5A/XK6++M+nhJ2EPvez0Eesd8Ldx+iN1mDbVviGLMOswMYPl
         Ot2/qJ6OUlV/buW58vQ4cN4SaGkmGIQk/ufBPSPGrgaf72kMSH7fhKnCgkonVJ13Obmm
         XoGZQUldIrFh6KoVhUUKnWVIJMdOB0nJLsmIjiEy4qc1j+w69b4TwRjZsqnk6GCAokOY
         JEhOAhUaeuDXhnXAj/OBn+jkS0EQ1kR4ri49yPYGSW6VAf20m+7rzFi3vjqMGS7MOviD
         07cOD63QWSlIDbV7g0odzArhhlM5fJ3vfoLqrl7SKHB85F05Ru8OodZKge5Dt+8It45u
         8sXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZTtiE96GXaObleW3VgFhOW4Q83iKH3flYmM0JqxHbE=;
        b=2NAnprhoZuSxZ09k8ZTkUJDu0kFEgkp5Sf+xkyt+DONjwHeIvLqcG4sOBOn4MFD/kj
         gI6yfEBwNVQSFsDthzv2kXMp9l93Ekh/uakAA8jJUNuQmCV15VZnOLYypHXkx5O+7sD/
         TObpZG3t/GvIxObWwElvpRguBFMSkVufydxlukNUlPXXYN2BLEgJV/jDtitWypqlXS/s
         PMbNW68FKcm+kMzs70TrOryWEYPlEfCgL6UNKvXXIhupoK96ZNFrlx9Z0hL1x6LcQO7v
         8P1oqcM3FZRTabxfGc9BwPKPHFstgD2gUTiBt5j/nqx+Ul8x418rKZAhUPknUPpPdL+u
         QRVA==
X-Gm-Message-State: AO0yUKVNPxyoA/JB1qjToo5GA692lk3eZ3nbruVWKrxJ1JSElRlIfH67
        bSYwzVfopPzwsnLaU1QX+Ec2vg==
X-Google-Smtp-Source: AK7set93NegE25Y8nbSzDtMHcnmyEVE7zKQUYLWwUtiS09l3qhIHjhBmTSnwZvdEYBhTH5IPbkzPuw==
X-Received: by 2002:a19:4314:0:b0:4db:5120:367 with SMTP id q20-20020a194314000000b004db51200367mr176216lfa.31.1679332744189;
        Mon, 20 Mar 2023 10:19:04 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id m24-20020a195218000000b004d85895d7e0sm1771812lfb.147.2023.03.20.10.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:19:03 -0700 (PDT)
Message-ID: <49a136d5-ac70-9c54-0c8f-16867f91da3c@linaro.org>
Date:   Mon, 20 Mar 2023 18:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 01/15] arm64: dts: qcom: sa8775p: pad reg properties to
 8 digits
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230320154841.327908-1-brgl@bgdev.pl>
 <20230320154841.327908-2-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230320154841.327908-2-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2023 16:48, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The file has inconsistent padding of the address part of soc node
> children's reg properties. Fix it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index c5b73c591e0f..5aa28a3b12ae 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -440,7 +440,7 @@ soc: soc@0 {
>  
>  		gcc: clock-controller@100000 {
>  			compatible = "qcom,sa8775p-gcc";
> -			reg = <0x0 0x100000 0x0 0xc7018>;
> +			reg = <0x0 0x00100000 0x0 0xc7018>;
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> @@ -464,7 +464,7 @@ gcc: clock-controller@100000 {
>  
>  		ipcc: mailbox@408000 {
>  			compatible = "qcom,sa8775p-ipcc", "qcom,ipcc";
> -			reg = <0x0 0x408000 0x0 0x1000>;
> +			reg = <0x0 0x00408000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
> @@ -473,7 +473,7 @@ ipcc: mailbox@408000 {
>  
>  		qupv3_id_1: geniqup@ac0000 {
>  			compatible = "qcom,geni-se-qup";
> -			reg = <0x0 0xac0000 0x0 0x6000>;
> +			reg = <0x0 0x00ac0000 0x0 0x6000>;
>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  			ranges;
> @@ -485,7 +485,7 @@ qupv3_id_1: geniqup@ac0000 {
>  
>  			uart10: serial@a8c000 {
>  				compatible = "qcom,geni-uart";
> -				reg = <0x0 0xa8c000 0x0 0x4000>;
> +				reg = <0x0 0x00a8c000 0x0 0x4000>;
>  				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>  				clock-names = "se";
>  				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> @@ -735,7 +735,7 @@ rpmhpd_opp_turbo_l1: opp-9 {
>  
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
> -			reg = <0x0 0x1f40000 0x0 0x20000>;
> +			reg = <0x0 0x01f40000 0x0 0x20000>;
>  			#hwlock-cells = <1>;
>  		};
>  
> @@ -754,7 +754,7 @@ cpufreq_hw: cpufreq@18591000 {
>  
>  		tlmm: pinctrl@f000000 {
>  			compatible = "qcom,sa8775p-tlmm";
> -			reg = <0x0 0xf000000 0x0 0x1000000>;
> +			reg = <0x0 0x0f000000 0x0 0x1000000>;
>  			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>  			gpio-controller;
>  			#gpio-cells = <2>;
