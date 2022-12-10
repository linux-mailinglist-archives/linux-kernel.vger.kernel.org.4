Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF57648EA4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 13:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLJM2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 07:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLJM2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 07:28:49 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAA51C411
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:28:47 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id q6so1063466lfm.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 04:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbYb4e9be8kpfllqegCVvSoO01m33d/xvy7hUdFX4C4=;
        b=VcWV/VeEFRD4MFzYYmWit9Lhz2u9423zvkqio9TFzH6R1plOrIsgly6nIa2gn8Sefb
         D3+NyKsZmdXsj0FSClTP/6uoXP0RW670iV4Gg6sfCGeld3fqwj5zMtp+IF/TgSuvZy5a
         DNX7bHLS5RNdUkTbHgwIGBD2HpYOeVmpz6qzz6NRfVOQ8ucxJWZVlCfKP2yq/sIy9FKX
         BdLfGPFA/iY70AEy7QqHnkv4HTSkX8B0goHSZC2Lr59w6H2A+ujHNf5MSU5uauWl/ZhY
         lqlwRJkILyDv/yIF0AMPlekSrfIUTEjLNur1H6v1N8+doLObmpZRk+vkEc3uDqRdiEXL
         +oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbYb4e9be8kpfllqegCVvSoO01m33d/xvy7hUdFX4C4=;
        b=1/m/6Dy/wyG1NOUdrbJFtgANU8+ICbQvsQw+94fE4zJ4GbMUhQdeq7dn8QiPF+MGEq
         bm4Nbne78KgjbAzx9AZRvhDCR4rFDYNTkuISkl6n+Tzag4s9Ny72n6xGzslTZ7YkE1xX
         w8iCBHkr1QAI8e24feyh+Guuymc2i7znd4Bpm1a7hRdy69AkWBQO6cjgSxFEy4/d5dBg
         LhyaLeTOWTdzWLk0+OYWD4CiJ8L++o9iBhJ+IrmmzKWOJC1B19Xb8KBOcFJU2gvb0BKr
         HNtacqRvI9ldYOLJCzcSd9AyOOKRPTUcSbT841ZKooAlYsD73jFZGuayyvSH/hL+55rX
         XEaw==
X-Gm-Message-State: ANoB5pm81h0NWv7QIXkIL9WoXP504Ety7D4gg89S9jXvsaXywBOG8r7G
        nsLyxASVYlfY2LdTFxgn0ybLGA==
X-Google-Smtp-Source: AA0mqf56pRDwLn2NramMmmH1Glf2auGdQUPNcE5eW/dL1MPf/YGZv3N0fQ8OOE4NXKv4xsJZsgnSYA==
X-Received: by 2002:a05:6512:3ca0:b0:4b5:b59e:1b65 with SMTP id h32-20020a0565123ca000b004b5b59e1b65mr1387605lfv.17.1670675325525;
        Sat, 10 Dec 2022 04:28:45 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id x11-20020a056512078b00b004b5785b1d9csm701146lfr.302.2022.12.10.04.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 04:28:45 -0800 (PST)
Message-ID: <533ca235-38d1-a609-da1a-66c362c0d18a@linaro.org>
Date:   Sat, 10 Dec 2022 13:28:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sdm845: move DSI/QUP/QSPI opp
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
 <20221210115704.97614-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221210115704.97614-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.12.2022 12:57, Krzysztof Kozlowski wrote:
> The SoC node is a simple-bus and its schema expect to have nodes only
> with unit addresses:
> 
>   sdm850-lenovo-yoga-c630.dtb: soc@0: opp-table-qup: {'compatible': ['operating-points-v2'], 'phandle': [[60]], 'opp-50000000':
>   ... 'required-opps': [[55]]}} should not be valid under {'type': 'object'}
> 
> Move to top-level OPP tables:
>  - DSI and QUP which are shared between multiple nodes,
>  - QSPI which cannot be placed in its node due to address/size cells.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 154 +++++++++++++--------------
>  1 file changed, 77 insertions(+), 77 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index a63dbd12230f..573b2394e63f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -696,6 +696,83 @@ cpu4_opp32: opp-2803200000 {
>  		};
>  	};
>  
> +	dsi_opp_table: opp-table-dsi {
> +		compatible = "operating-points-v2";
> +
> +		opp-19200000 {
> +			opp-hz = /bits/ 64 <19200000>;
> +			required-opps = <&rpmhpd_opp_min_svs>;
> +		};
> +
> +		opp-180000000 {
> +			opp-hz = /bits/ 64 <180000000>;
> +			required-opps = <&rpmhpd_opp_low_svs>;
> +		};
> +
> +		opp-275000000 {
> +			opp-hz = /bits/ 64 <275000000>;
> +			required-opps = <&rpmhpd_opp_svs>;
> +		};
> +
> +		opp-328580000 {
> +			opp-hz = /bits/ 64 <328580000>;
> +			required-opps = <&rpmhpd_opp_svs_l1>;
> +		};
> +
> +		opp-358000000 {
> +			opp-hz = /bits/ 64 <358000000>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +		};
> +	};
> +
> +	qspi_opp_table: opp-table-qspi {
> +		compatible = "operating-points-v2";
> +
> +		opp-19200000 {
> +			opp-hz = /bits/ 64 <19200000>;
> +			required-opps = <&rpmhpd_opp_min_svs>;
> +		};
> +
> +		opp-100000000 {
> +			opp-hz = /bits/ 64 <100000000>;
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
> +		opp-50000000 {
> +			opp-hz = /bits/ 64 <50000000>;
> +			required-opps = <&rpmhpd_opp_min_svs>;
> +		};
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
>  	pmu {
>  		compatible = "arm,armv8-pmuv3";
>  		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1125,30 +1202,6 @@ rng: rng@793000 {
>  			clock-names = "core";
>  		};
>  
> -		qup_opp_table: opp-table-qup {
> -			compatible = "operating-points-v2";
> -
> -			opp-50000000 {
> -				opp-hz = /bits/ 64 <50000000>;
> -				required-opps = <&rpmhpd_opp_min_svs>;
> -			};
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
>  		gpi_dma0: dma-controller@800000 {
>  			#dma-cells = <3>;
>  			compatible = "qcom,sdm845-gpi-dma";
> @@ -3807,30 +3860,6 @@ opp-201500000 {
>  			};
>  		};
>  
> -		qspi_opp_table: opp-table-qspi {
> -			compatible = "operating-points-v2";
> -
> -			opp-19200000 {
> -				opp-hz = /bits/ 64 <19200000>;
> -				required-opps = <&rpmhpd_opp_min_svs>;
> -			};
> -
> -			opp-100000000 {
> -				opp-hz = /bits/ 64 <100000000>;
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
>  		qspi: spi@88df000 {
>  			compatible = "qcom,sdm845-qspi", "qcom,qspi-v1";
>  			reg = <0 0x088df000 0 0x600>;
> @@ -4428,35 +4457,6 @@ clock_camcc: clock-controller@ad00000 {
>  			clock-names = "bi_tcxo";
>  		};
>  
> -		dsi_opp_table: opp-table-dsi {
> -			compatible = "operating-points-v2";
> -
> -			opp-19200000 {
> -				opp-hz = /bits/ 64 <19200000>;
> -				required-opps = <&rpmhpd_opp_min_svs>;
> -			};
> -
> -			opp-180000000 {
> -				opp-hz = /bits/ 64 <180000000>;
> -				required-opps = <&rpmhpd_opp_low_svs>;
> -			};
> -
> -			opp-275000000 {
> -				opp-hz = /bits/ 64 <275000000>;
> -				required-opps = <&rpmhpd_opp_svs>;
> -			};
> -
> -			opp-328580000 {
> -				opp-hz = /bits/ 64 <328580000>;
> -				required-opps = <&rpmhpd_opp_svs_l1>;
> -			};
> -
> -			opp-358000000 {
> -				opp-hz = /bits/ 64 <358000000>;
> -				required-opps = <&rpmhpd_opp_nom>;
> -			};
> -		};
> -
>  		mdss: mdss@ae00000 {
>  			compatible = "qcom,sdm845-mdss";
>  			reg = <0 0x0ae00000 0 0x1000>;
