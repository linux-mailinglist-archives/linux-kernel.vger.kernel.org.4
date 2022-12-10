Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64F9648EA8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 13:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLJMaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 07:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLJM35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 07:29:57 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D1C1C411
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:29:56 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g7so11144275lfv.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/S/tLvSZxZXHVY0JERCLfAZM29sEkAUhJTgc/unddeg=;
        b=iauLDumAo/9BqlF8TA/G/2S9JBoyEusl15pJ3gg50C7J1fSv78be/eFAcJG5O8QWdq
         sod5RBsIA4OB0yMwgVeMMKLIq6LhmVWFCV2YnEbs9C5UOzpPf2y4WIqjlbnVeKlPJ24C
         dTYJzQ8WzqoBF/u4WUbAcJh5OisyalfDe836QklvQkxCRwDm1Nv50lUopRhGPkPARFxc
         /Uk1vZS8v7YRiptj403pTlzV6UBhmkfhE1Vzw/zUUBT4JRCxA9I7n5B3Alw6I2zYFDKJ
         FvZGBc76v/FqLSZBgIkpCSc83KR4yZChsLjOozyL/IYzB4CvV+mBrCmYNMucyNODIQOB
         qY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/S/tLvSZxZXHVY0JERCLfAZM29sEkAUhJTgc/unddeg=;
        b=vuBY3eD7tFHQh1yufQHCFpsNJulPlWoh75EQWueZ/Y0umgb3OvNUULJnWxGQd+41bK
         C4emqMJF9iuzxgn5KlMhal2qO3tsWNnH6AdYPxdKZ++NGJOgyDk51loJfDGbHBdRNEG/
         SVzLsZsIOQ7+t19y6FUVO8eYag5WTz9iVd1Sgpm4MugFTAlcIw0p8Vwhy1AbE2mkP8GN
         HwTuXwitlnBDR2e7612zPDKttN9aMw2KK0FXKaSsTMxFpdbzo1ZBnCvDZHiyfkgtZNPz
         D5Ngil0Tl72Xxi5A9aWKWa5M0tJ0uJemxjvhqdxOzNORbvdsHGSp8iQy466iFl9O/Wya
         As6g==
X-Gm-Message-State: ANoB5plPe1awT88/N+Q9wv6pRO326Dy1mZtJHObtT/J1IEsSoQhp87Ie
        Oe6Q0eu3JlUlYdgls7Jwld1hdA==
X-Google-Smtp-Source: AA0mqf7FHhmSa/SqG52Sj+exHj3rmyDJ05oDcK2GL1lNSyKRfWlYtiG1fw09Kd331nbceG3Zho5QDg==
X-Received: by 2002:a05:6512:6d1:b0:4b1:8830:85e8 with SMTP id u17-20020a05651206d100b004b1883085e8mr3247569lff.26.1670675394733;
        Sat, 10 Dec 2022 04:29:54 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id v17-20020ac25b11000000b004a2550db9ddsm706160lfn.245.2022.12.10.04.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 04:29:54 -0800 (PST)
Message-ID: <f38f0bfd-858e-1995-167c-de747e57597b@linaro.org>
Date:   Sat, 10 Dec 2022 13:29:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc7180: move QUP and QSPI opp
 tables out of SoC node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.12.2022 12:57, Krzysztof Kozlowski wrote:
> The SoC node is a simple-bus and its schema expect to have nodes only
> with unit addresses:
> 
>   sc7180-trogdor-lazor-r3.dtb: soc@0: opp-table-qspi: {'compatible': ['operating-points-v2'], 'phandle': [[186]], 'opp-75000000':
>     ...  'required-opps': [[47]]}} should not be valid under {'type': 'object'}
> 
> Move to top-level OPP tables:
>  - QUP which is shared between multiple nodes,
>  - QSPI which cannot be placed in its node due to address/size cells.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 76 ++++++++++++++--------------
>  1 file changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index ea886cf08b4d..735581097295 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -538,6 +538,44 @@ cpu6_opp16: opp-2553600000 {
>  		};
>  	};
>  
> +	qspi_opp_table: opp-table-qspi {
> +		compatible = "operating-points-v2";
> +
> +		opp-75000000 {
> +			opp-hz = /bits/ 64 <75000000>;
> +			required-opps = <&rpmhpd_opp_low_svs>;
> +		};
> +
> +		opp-150000000 {
> +			opp-hz = /bits/ 64 <150000000>;
> +			required-opps = <&rpmhpd_opp_svs>;
> +		};
> +
> +		opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +		};
> +	};
> +
> +	qup_opp_table: opp-table-qup {
> +		compatible = "operating-points-v2";
> +
> +		opp-75000000 {
> +			opp-hz = /bits/ 64 <75000000>;
> +			required-opps = <&rpmhpd_opp_low_svs>;
> +		};
> +
> +		opp-100000000 {
> +			opp-hz = /bits/ 64 <100000000>;
> +			required-opps = <&rpmhpd_opp_svs>;
> +		};
> +
> +		opp-128000000 {
> +			opp-hz = /bits/ 64 <128000000>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +		};
> +	};
> +
>  	memory@80000000 {
Sidenote: memory@ should be moved above opp-*, alphabetically

For this:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  		device_type = "memory";
>  		/* We expect the bootloader to fill in the size */
> @@ -739,25 +777,6 @@ opp-384000000 {
>  			};
>  		};
>  
> -		qup_opp_table: opp-table-qup {
> -			compatible = "operating-points-v2";
> -
> -			opp-75000000 {
> -				opp-hz = /bits/ 64 <75000000>;
> -				required-opps = <&rpmhpd_opp_low_svs>;
> -			};
> -
> -			opp-100000000 {
> -				opp-hz = /bits/ 64 <100000000>;
> -				required-opps = <&rpmhpd_opp_svs>;
> -			};
> -
> -			opp-128000000 {
> -				opp-hz = /bits/ 64 <128000000>;
> -				required-opps = <&rpmhpd_opp_nom>;
> -			};
> -		};
> -
>  		qupv3_id_0: geniqup@8c0000 {
>  			compatible = "qcom,geni-se-qup";
>  			reg = <0 0x008c0000 0 0x6000>;
> @@ -2655,25 +2674,6 @@ opp-202000000 {
>  			};
>  		};
>  
> -		qspi_opp_table: opp-table-qspi {
> -			compatible = "operating-points-v2";
> -
> -			opp-75000000 {
> -				opp-hz = /bits/ 64 <75000000>;
> -				required-opps = <&rpmhpd_opp_low_svs>;
> -			};
> -
> -			opp-150000000 {
> -				opp-hz = /bits/ 64 <150000000>;
> -				required-opps = <&rpmhpd_opp_svs>;
> -			};
> -
> -			opp-300000000 {
> -				opp-hz = /bits/ 64 <300000000>;
> -				required-opps = <&rpmhpd_opp_nom>;
> -			};
> -		};
> -
>  		qspi: spi@88dc000 {
>  			compatible = "qcom,sc7180-qspi", "qcom,qspi-v1";
>  			reg = <0 0x088dc000 0 0x600>;
