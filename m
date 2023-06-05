Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8008C722FF7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjFEToB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjFETn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:43:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD06F3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:43:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so6681060e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685994233; x=1688586233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jirhBMad9whqGW3PMuvmJXaHpQEXSJLMb7YJoRTkwsA=;
        b=fa1Md4hFBbtpYqCsOom3BncWGXVLvSGyvj6LW6YJy3YRenA0pTi74LdSDXdg8lhZn+
         st79Hna3ISxK8rgyYFqTXoxuFypxmWkfA9PGHiJcN9WmsZr8Mp3P/0hojv7PQ5437eQt
         wZcQJ5vYQTaovDrBP+iEjKQORWltUVK1n3N8yzlsjcyUbDCvSx0w+usBjf3DbE8M/uB5
         ucbUkvOavB9WEmCFPwhbatR1Y/mMQ1JcSi2Cbxr9NiFagPnnt9TwwNABrmTfyuDOqsOq
         LN5V8OmBSe4hSj0O3eKjWyxaftHwwbQqlGxRxateSwLeRUm8KfyjlkSNASmdetA4SkT9
         IMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994233; x=1688586233;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jirhBMad9whqGW3PMuvmJXaHpQEXSJLMb7YJoRTkwsA=;
        b=EpQjPG2gxparg7qhbgAY+P7lt1ugreqXVssWXwTj6yllXTLGhfQ8S/G/OxhatEhMoo
         UcF3lh9qHDa7AhG3CfoONNcEc7+DfEyikz+kqkce5CeImU0wGQEUSzQnw0ACTVR9SDGe
         0ipzg+kF1oFx2vv/Fr+jCrG4P6UF9fJrtYe2lRCzR/rg8xjo329vtHhO4w7LH//g6sLT
         2idNnxtfCiApfBMq2pxZBNeY+SHN0D4ap2q83oShLBgvlKRFKxIqHT6474ruKWhTsdDr
         6tGxULO06ti6jwp4e8DgRHAYOY/5VvE2bp9foYsB1WPxmwvaeKQYxGOUaixLiNDMqNGt
         HpNQ==
X-Gm-Message-State: AC+VfDydrK4JrqUCgO4PakgKCNx6Hmh+x6v9P0OfkDoK2BHKNYPR1B3c
        w5PtmXxhejSq5c+g19ogbUkDww==
X-Google-Smtp-Source: ACHHUZ6qr8MSkiREqgZtI8DYcDkQPVRFFwElqGaUBTODwIQ5AWCJdWVAi4708nHiTmDpDvIg7oOnLw==
X-Received: by 2002:a05:6512:508:b0:4f3:a3e0:850e with SMTP id o8-20020a056512050800b004f3a3e0850emr6615006lfb.35.1685994232797;
        Mon, 05 Jun 2023 12:43:52 -0700 (PDT)
Received: from [192.168.1.101] (abyj96.neoplus.adsl.tpnet.pl. [83.9.29.96])
        by smtp.gmail.com with ESMTPSA id q4-20020ac24a64000000b004f60d26e1d2sm1211906lfp.80.2023.06.05.12.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:43:52 -0700 (PDT)
Message-ID: <9b6d4356-300b-176f-84ef-8a073e8cfe9b@linaro.org>
Date:   Mon, 5 Jun 2023 21:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 12/14] arm64: dts: qcom: Add rpm-proc node for GLINK
 gplatforms
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-12-e0a3b6de1f14@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230531-rpm-rproc-v1-12-e0a3b6de1f14@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.06.2023 09:08, Stephan Gerhold wrote:
> Rather than having the RPM GLINK channels as the only child of a dummy
> top-level rpm-glink node, switch to representing the RPM as remoteproc
> like all the other remoteprocs (modem DSP, ...).
> 
> This allows assigning additional subdevices to it like the MPM
> interrupt-controller or rpm-master-stats.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi |  48 ++++++-----
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi |  28 ++++---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 113 ++++++++++++-------------
>  arch/arm64/boot/dts/qcom/msm8998.dtsi |  98 +++++++++++-----------
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 126 ++++++++++++++--------------
>  arch/arm64/boot/dts/qcom/qcs404.dtsi  | 152 +++++++++++++++++-----------------
>  arch/arm64/boot/dts/qcom/sdm630.dtsi  | 132 +++++++++++++++--------------
>  arch/arm64/boot/dts/qcom/sm6115.dtsi  | 128 ++++++++++++++--------------
>  arch/arm64/boot/dts/qcom/sm6125.dtsi  | 140 ++++++++++++++++---------------
>  arch/arm64/boot/dts/qcom/sm6375.dtsi  | 126 ++++++++++++++--------------
>  10 files changed, 564 insertions(+), 527 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 7355f266742a..fff4a4014bd8 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -146,6 +146,32 @@ psci: psci {
>  		method = "smc";
>  	};
>  
> +	rpm: remoteproc-rpm {
Krzysztof, is this fine or should this be just `remoteproc {`?

in any case:
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM6375

Konrad
> +		compatible = "qcom,ipq6018-rpm-proc", "qcom,rpm-proc";
> +
> +		glink-rpm {
> +			compatible = "qcom,glink-rpm";
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +			mboxes = <&apcs_glb 0>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-ipq6018";
> +				qcom,glink-channels = "rpm_requests";
> +
> +				regulators {
> +					compatible = "qcom,rpm-mp5496-regulators";
> +
> +					ipq6018_s2: s2 {
> +						regulator-min-microvolt = <725000>;
> +						regulator-max-microvolt = <1062500>;
> +						regulator-always-on;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -182,28 +208,6 @@ q6_region: memory@4ab00000 {
>  		};
>  	};
>  
> -	rpm-glink {
> -		compatible = "qcom,glink-rpm";
> -		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> -		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> -		mboxes = <&apcs_glb 0>;
> -
> -		rpm_requests: rpm-requests {
> -			compatible = "qcom,rpm-ipq6018";
> -			qcom,glink-channels = "rpm_requests";
> -
> -			regulators {
> -				compatible = "qcom,rpm-mp5496-regulators";
> -
> -				ipq6018_s2: s2 {
> -					regulator-min-microvolt = <725000>;
> -					regulator-max-microvolt = <1062500>;
> -					regulator-always-on;
> -				};
> -			};
> -		};
> -	};
> -
>  	smem {
>  		compatible = "qcom,smem";
>  		memory-region = <&smem_region>;
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 0baeb10bbdae..3222568ac4cf 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -151,6 +151,22 @@ psci {
>  		method = "smc";
>  	};
>  
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,ipq9574-rpm-proc", "qcom,rpm-proc";
> +
> +		glink-rpm {
> +			compatible = "qcom,glink-rpm";
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +			mboxes = <&apcs_glb 0>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-ipq9574";
> +				qcom,glink-channels = "rpm_requests";
> +			};
> +		};
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -169,18 +185,6 @@ smem@4aa00000 {
>  		};
>  	};
>  
> -	rpm-glink {
> -		compatible = "qcom,glink-rpm";
> -		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> -		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> -		mboxes = <&apcs_glb 0>;
> -
> -		rpm_requests: rpm-requests {
> -			compatible = "qcom,rpm-ipq9574";
> -			qcom,glink-channels = "rpm_requests";
> -		};
> -	};
> -
>  	soc: soc@0 {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index f75932cc2a30..50ede09d6368 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -398,6 +398,63 @@ psci {
>  		method = "smc";
>  	};
>  
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,msm8996-rpm-proc", "qcom,rpm-proc";
> +
> +		glink-rpm {
> +			compatible = "qcom,glink-rpm";
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +			mboxes = <&apcs_glb 0>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-msm8996";
> +				qcom,glink-channels = "rpm_requests";
> +
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-msm8996", "qcom,rpmcc";
> +					#clock-cells = <1>;
> +					clocks = <&xo_board>;
> +					clock-names = "xo";
> +				};
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,msm8996-rpmpd";
> +					#power-domain-cells = <1>;
> +					operating-points-v2 = <&rpmpd_opp_table>;
> +
> +					rpmpd_opp_table: opp-table {
> +						compatible = "operating-points-v2";
> +
> +						rpmpd_opp1: opp1 {
> +							opp-level = <1>;
> +						};
> +
> +						rpmpd_opp2: opp2 {
> +							opp-level = <2>;
> +						};
> +
> +						rpmpd_opp3: opp3 {
> +							opp-level = <3>;
> +						};
> +
> +						rpmpd_opp4: opp4 {
> +							opp-level = <4>;
> +						};
> +
> +						rpmpd_opp5: opp5 {
> +							opp-level = <5>;
> +						};
> +
> +						rpmpd_opp6: opp6 {
> +							opp-level = <6>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -472,62 +529,6 @@ mdata_mem: mpss-metadata {
>  		};
>  	};
>  
> -	rpm-glink {
> -		compatible = "qcom,glink-rpm";
> -
> -		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> -
> -		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> -
> -		mboxes = <&apcs_glb 0>;
> -
> -		rpm_requests: rpm-requests {
> -			compatible = "qcom,rpm-msm8996";
> -			qcom,glink-channels = "rpm_requests";
> -
> -			rpmcc: clock-controller {
> -				compatible = "qcom,rpmcc-msm8996", "qcom,rpmcc";
> -				#clock-cells = <1>;
> -				clocks = <&xo_board>;
> -				clock-names = "xo";
> -			};
> -
> -			rpmpd: power-controller {
> -				compatible = "qcom,msm8996-rpmpd";
> -				#power-domain-cells = <1>;
> -				operating-points-v2 = <&rpmpd_opp_table>;
> -
> -				rpmpd_opp_table: opp-table {
> -					compatible = "operating-points-v2";
> -
> -					rpmpd_opp1: opp1 {
> -						opp-level = <1>;
> -					};
> -
> -					rpmpd_opp2: opp2 {
> -						opp-level = <2>;
> -					};
> -
> -					rpmpd_opp3: opp3 {
> -						opp-level = <3>;
> -					};
> -
> -					rpmpd_opp4: opp4 {
> -						opp-level = <4>;
> -					};
> -
> -					rpmpd_opp5: opp5 {
> -						opp-level = <5>;
> -					};
> -
> -					rpmpd_opp6: opp6 {
> -						opp-level = <6>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -
>  	smem {
>  		compatible = "qcom,smem";
>  		memory-region = <&smem_mem>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index f0e943ff0046..bc51fa6a18aa 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -321,68 +321,72 @@ psci {
>  		method = "smc";
>  	};
>  
> -	rpm-glink {
> -		compatible = "qcom,glink-rpm";
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,msm8998-rpm-proc", "qcom,rpm-proc";
>  
> -		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> -		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> -		mboxes = <&apcs_glb 0>;
> +		glink-rpm {
> +			compatible = "qcom,glink-rpm";
>  
> -		rpm_requests: rpm-requests {
> -			compatible = "qcom,rpm-msm8998";
> -			qcom,glink-channels = "rpm_requests";
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +			mboxes = <&apcs_glb 0>;
>  
> -			rpmcc: clock-controller {
> -				compatible = "qcom,rpmcc-msm8998", "qcom,rpmcc";
> -				#clock-cells = <1>;
> -			};
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-msm8998";
> +				qcom,glink-channels = "rpm_requests";
>  
> -			rpmpd: power-controller {
> -				compatible = "qcom,msm8998-rpmpd";
> -				#power-domain-cells = <1>;
> -				operating-points-v2 = <&rpmpd_opp_table>;
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-msm8998", "qcom,rpmcc";
> +					#clock-cells = <1>;
> +				};
>  
> -				rpmpd_opp_table: opp-table {
> -					compatible = "operating-points-v2";
> +				rpmpd: power-controller {
> +					compatible = "qcom,msm8998-rpmpd";
> +					#power-domain-cells = <1>;
> +					operating-points-v2 = <&rpmpd_opp_table>;
>  
> -					rpmpd_opp_ret: opp1 {
> -						opp-level = <RPM_SMD_LEVEL_RETENTION>;
> -					};
> +					rpmpd_opp_table: opp-table {
> +						compatible = "operating-points-v2";
>  
> -					rpmpd_opp_ret_plus: opp2 {
> -						opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
> -					};
> +						rpmpd_opp_ret: opp1 {
> +							opp-level = <RPM_SMD_LEVEL_RETENTION>;
> +						};
>  
> -					rpmpd_opp_min_svs: opp3 {
> -						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> -					};
> +						rpmpd_opp_ret_plus: opp2 {
> +							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
> +						};
>  
> -					rpmpd_opp_low_svs: opp4 {
> -						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> -					};
> +						rpmpd_opp_min_svs: opp3 {
> +							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> +						};
>  
> -					rpmpd_opp_svs: opp5 {
> -						opp-level = <RPM_SMD_LEVEL_SVS>;
> -					};
> +						rpmpd_opp_low_svs: opp4 {
> +							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> +						};
>  
> -					rpmpd_opp_svs_plus: opp6 {
> -						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> -					};
> +						rpmpd_opp_svs: opp5 {
> +							opp-level = <RPM_SMD_LEVEL_SVS>;
> +						};
>  
> -					rpmpd_opp_nom: opp7 {
> -						opp-level = <RPM_SMD_LEVEL_NOM>;
> -					};
> +						rpmpd_opp_svs_plus: opp6 {
> +							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> +						};
>  
> -					rpmpd_opp_nom_plus: opp8 {
> -						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> -					};
> +						rpmpd_opp_nom: opp7 {
> +							opp-level = <RPM_SMD_LEVEL_NOM>;
> +						};
>  
> -					rpmpd_opp_turbo: opp9 {
> -						opp-level = <RPM_SMD_LEVEL_TURBO>;
> -					};
> +						rpmpd_opp_nom_plus: opp8 {
> +							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> +						};
> +
> +						rpmpd_opp_turbo: opp9 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO>;
> +						};
>  
> -					rpmpd_opp_turbo_plus: opp10 {
> -						opp-level = <RPM_SMD_LEVEL_BINNING>;
> +						rpmpd_opp_turbo_plus: opp10 {
> +							opp-level = <RPM_SMD_LEVEL_BINNING>;
> +						};
>  					};
>  				};
>  			};
> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> index b29bc4e4b837..ad1b721d1e1e 100644
> --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> @@ -137,6 +137,71 @@ psci {
>  		method = "smc";
>  	};
>  
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,qcm2290-rpm-proc", "qcom,rpm-proc";
> +
> +		glink-rpm {
> +			compatible = "qcom,glink-rpm";
> +			interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +			mboxes = <&apcs_glb 0>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-qcm2290";
> +				qcom,glink-channels = "rpm_requests";
> +
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-qcm2290", "qcom,rpmcc";
> +					clocks = <&xo_board>;
> +					clock-names = "xo";
> +					#clock-cells = <1>;
> +				};
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,qcm2290-rpmpd";
> +					#power-domain-cells = <1>;
> +					operating-points-v2 = <&rpmpd_opp_table>;
> +
> +					rpmpd_opp_table: opp-table {
> +						compatible = "operating-points-v2";
> +
> +						rpmpd_opp_min_svs: opp1 {
> +							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> +						};
> +
> +						rpmpd_opp_low_svs: opp2 {
> +							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> +						};
> +
> +						rpmpd_opp_svs: opp3 {
> +							opp-level = <RPM_SMD_LEVEL_SVS>;
> +						};
> +
> +						rpmpd_opp_svs_plus: opp4 {
> +							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> +						};
> +
> +						rpmpd_opp_nom: opp5 {
> +							opp-level = <RPM_SMD_LEVEL_NOM>;
> +						};
> +
> +						rpmpd_opp_nom_plus: opp6 {
> +							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> +						};
> +
> +						rpmpd_opp_turbo: opp7 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO>;
> +						};
> +
> +						rpmpd_opp_turbo_plus: opp8 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	reserved_memory: reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -227,67 +292,6 @@ rmtfs_mem: memory@89b01000 {
>  		};
>  	};
>  
> -	rpm-glink {
> -		compatible = "qcom,glink-rpm";
> -		interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
> -		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> -		mboxes = <&apcs_glb 0>;
> -
> -		rpm_requests: rpm-requests {
> -			compatible = "qcom,rpm-qcm2290";
> -			qcom,glink-channels = "rpm_requests";
> -
> -			rpmcc: clock-controller {
> -				compatible = "qcom,rpmcc-qcm2290", "qcom,rpmcc";
> -				clocks = <&xo_board>;
> -				clock-names = "xo";
> -				#clock-cells = <1>;
> -			};
> -
> -			rpmpd: power-controller {
> -				compatible = "qcom,qcm2290-rpmpd";
> -				#power-domain-cells = <1>;
> -				operating-points-v2 = <&rpmpd_opp_table>;
> -
> -				rpmpd_opp_table: opp-table {
> -					compatible = "operating-points-v2";
> -
> -					rpmpd_opp_min_svs: opp1 {
> -						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> -					};
> -
> -					rpmpd_opp_low_svs: opp2 {
> -						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> -					};
> -
> -					rpmpd_opp_svs: opp3 {
> -						opp-level = <RPM_SMD_LEVEL_SVS>;
> -					};
> -
> -					rpmpd_opp_svs_plus: opp4 {
> -						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> -					};
> -
> -					rpmpd_opp_nom: opp5 {
> -						opp-level = <RPM_SMD_LEVEL_NOM>;
> -					};
> -
> -					rpmpd_opp_nom_plus: opp6 {
> -						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> -					};
> -
> -					rpmpd_opp_turbo: opp7 {
> -						opp-level = <RPM_SMD_LEVEL_TURBO>;
> -					};
> -
> -					rpmpd_opp_turbo_plus: opp8 {
> -						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -
>  	smp2p-adsp {
>  		compatible = "qcom,smp2p";
>  		qcom,smem = <443>, <429>;
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 972f753847e1..329363cace5a 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -166,6 +166,84 @@ psci {
>  		method = "smc";
>  	};
>  
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,qcs404-rpm-proc", "qcom,rpm-proc";
> +
> +		glink-rpm {
> +			compatible = "qcom,glink-rpm";
> +
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +			mboxes = <&apcs_glb 0>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-qcs404";
> +				qcom,glink-channels = "rpm_requests";
> +
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-qcs404", "qcom,rpmcc";
> +					#clock-cells = <1>;
> +					clocks = <&xo_board>;
> +					clock-names = "xo";
> +				};
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,qcs404-rpmpd";
> +					#power-domain-cells = <1>;
> +					operating-points-v2 = <&rpmpd_opp_table>;
> +
> +					rpmpd_opp_table: opp-table {
> +						compatible = "operating-points-v2";
> +
> +						rpmpd_opp_ret: opp1 {
> +							opp-level = <16>;
> +						};
> +
> +						rpmpd_opp_ret_plus: opp2 {
> +							opp-level = <32>;
> +						};
> +
> +						rpmpd_opp_min_svs: opp3 {
> +							opp-level = <48>;
> +						};
> +
> +						rpmpd_opp_low_svs: opp4 {
> +							opp-level = <64>;
> +						};
> +
> +						rpmpd_opp_svs: opp5 {
> +							opp-level = <128>;
> +						};
> +
> +						rpmpd_opp_svs_plus: opp6 {
> +							opp-level = <192>;
> +						};
> +
> +						rpmpd_opp_nom: opp7 {
> +							opp-level = <256>;
> +						};
> +
> +						rpmpd_opp_nom_plus: opp8 {
> +							opp-level = <320>;
> +						};
> +
> +						rpmpd_opp_turbo: opp9 {
> +							opp-level = <384>;
> +						};
> +
> +						rpmpd_opp_turbo_no_cpr: opp10 {
> +							opp-level = <416>;
> +						};
> +
> +						rpmpd_opp_turbo_plus: opp11 {
> +							opp-level = <512>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -217,80 +295,6 @@ uefi_mem: memory@9f800000 {
>  		};
>  	};
>  
> -	rpm-glink {
> -		compatible = "qcom,glink-rpm";
> -
> -		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> -		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> -		mboxes = <&apcs_glb 0>;
> -
> -		rpm_requests: rpm-requests {
> -			compatible = "qcom,rpm-qcs404";
> -			qcom,glink-channels = "rpm_requests";
> -
> -			rpmcc: clock-controller {
> -				compatible = "qcom,rpmcc-qcs404", "qcom,rpmcc";
> -				#clock-cells = <1>;
> -				clocks = <&xo_board>;
> -				clock-names = "xo";
> -			};
> -
> -			rpmpd: power-controller {
> -				compatible = "qcom,qcs404-rpmpd";
> -				#power-domain-cells = <1>;
> -				operating-points-v2 = <&rpmpd_opp_table>;
> -
> -				rpmpd_opp_table: opp-table {
> -					compatible = "operating-points-v2";
> -
> -					rpmpd_opp_ret: opp1 {
> -						opp-level = <16>;
> -					};
> -
> -					rpmpd_opp_ret_plus: opp2 {
> -						opp-level = <32>;
> -					};
> -
> -					rpmpd_opp_min_svs: opp3 {
> -						opp-level = <48>;
> -					};
> -
> -					rpmpd_opp_low_svs: opp4 {
> -						opp-level = <64>;
> -					};
> -
> -					rpmpd_opp_svs: opp5 {
> -						opp-level = <128>;
> -					};
> -
> -					rpmpd_opp_svs_plus: opp6 {
> -						opp-level = <192>;
> -					};
> -
> -					rpmpd_opp_nom: opp7 {
> -						opp-level = <256>;
> -					};
> -
> -					rpmpd_opp_nom_plus: opp8 {
> -						opp-level = <320>;
> -					};
> -
> -					rpmpd_opp_turbo: opp9 {
> -						opp-level = <384>;
> -					};
> -
> -					rpmpd_opp_turbo_no_cpr: opp10 {
> -						opp-level = <416>;
> -					};
> -
> -					rpmpd_opp_turbo_plus: opp11 {
> -						opp-level = <512>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -
>  	smem {
>  		compatible = "qcom,smem";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 897f2440c9c8..2dfaec074c24 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -359,6 +359,74 @@ psci {
>  		method = "smc";
>  	};
>  
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,sdm660-rpm-proc", "qcom,rpm-proc";
> +
> +		glink-rpm {
> +			compatible = "qcom,glink-rpm";
> +
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +			mboxes = <&apcs_glb 0>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-sdm660";
> +				qcom,glink-channels = "rpm_requests";
> +
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-sdm660", "qcom,rpmcc";
> +					#clock-cells = <1>;
> +				};
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,sdm660-rpmpd";
> +					#power-domain-cells = <1>;
> +					operating-points-v2 = <&rpmpd_opp_table>;
> +
> +					rpmpd_opp_table: opp-table {
> +						compatible = "operating-points-v2";
> +
> +						rpmpd_opp_ret: opp1 {
> +							opp-level = <RPM_SMD_LEVEL_RETENTION>;
> +						};
> +
> +						rpmpd_opp_ret_plus: opp2 {
> +							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
> +						};
> +
> +						rpmpd_opp_min_svs: opp3 {
> +							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> +						};
> +
> +						rpmpd_opp_low_svs: opp4 {
> +							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> +						};
> +
> +						rpmpd_opp_svs: opp5 {
> +							opp-level = <RPM_SMD_LEVEL_SVS>;
> +						};
> +
> +						rpmpd_opp_svs_plus: opp6 {
> +							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> +						};
> +
> +						rpmpd_opp_nom: opp7 {
> +							opp-level = <RPM_SMD_LEVEL_NOM>;
> +						};
> +
> +						rpmpd_opp_nom_plus: opp8 {
> +							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> +						};
> +
> +						rpmpd_opp_turbo: opp9 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -440,70 +508,6 @@ zap_shader_region: gpu@fed00000 {
>  		};
>  	};
>  
> -	rpm-glink {
> -		compatible = "qcom,glink-rpm";
> -
> -		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> -		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> -		mboxes = <&apcs_glb 0>;
> -
> -		rpm_requests: rpm-requests {
> -			compatible = "qcom,rpm-sdm660";
> -			qcom,glink-channels = "rpm_requests";
> -
> -			rpmcc: clock-controller {
> -				compatible = "qcom,rpmcc-sdm660", "qcom,rpmcc";
> -				#clock-cells = <1>;
> -			};
> -
> -			rpmpd: power-controller {
> -				compatible = "qcom,sdm660-rpmpd";
> -				#power-domain-cells = <1>;
> -				operating-points-v2 = <&rpmpd_opp_table>;
> -
> -				rpmpd_opp_table: opp-table {
> -					compatible = "operating-points-v2";
> -
> -					rpmpd_opp_ret: opp1 {
> -						opp-level = <RPM_SMD_LEVEL_RETENTION>;
> -					};
> -
> -					rpmpd_opp_ret_plus: opp2 {
> -						opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
> -					};
> -
> -					rpmpd_opp_min_svs: opp3 {
> -						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> -					};
> -
> -					rpmpd_opp_low_svs: opp4 {
> -						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> -					};
> -
> -					rpmpd_opp_svs: opp5 {
> -						opp-level = <RPM_SMD_LEVEL_SVS>;
> -					};
> -
> -					rpmpd_opp_svs_plus: opp6 {
> -						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> -					};
> -
> -					rpmpd_opp_nom: opp7 {
> -						opp-level = <RPM_SMD_LEVEL_NOM>;
> -					};
> -
> -					rpmpd_opp_nom_plus: opp8 {
> -						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> -					};
> -
> -					rpmpd_opp_turbo: opp9 {
> -						opp-level = <RPM_SMD_LEVEL_TURBO>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -
>  	smem: smem {
>  		compatible = "qcom,smem";
>  		memory-region = <&smem_region>;
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 55118577bf92..d3ea67f7563d 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -341,6 +341,72 @@ CLUSTER_1_PD: power-domain-cpu-cluster1 {
>  		};
>  	};
>  
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,sm6115-rpm-proc", "qcom,rpm-proc";
> +
> +		glink-rpm {
> +			compatible = "qcom,glink-rpm";
> +
> +			interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +			mboxes = <&apcs_glb 0>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-sm6115";
> +				qcom,glink-channels = "rpm_requests";
> +
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-sm6115", "qcom,rpmcc";
> +					clocks = <&xo_board>;
> +					clock-names = "xo";
> +					#clock-cells = <1>;
> +				};
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,sm6115-rpmpd";
> +					#power-domain-cells = <1>;
> +					operating-points-v2 = <&rpmpd_opp_table>;
> +
> +					rpmpd_opp_table: opp-table {
> +						compatible = "operating-points-v2";
> +
> +						rpmpd_opp_min_svs: opp1 {
> +							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> +						};
> +
> +						rpmpd_opp_low_svs: opp2 {
> +							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> +						};
> +
> +						rpmpd_opp_svs: opp3 {
> +							opp-level = <RPM_SMD_LEVEL_SVS>;
> +						};
> +
> +						rpmpd_opp_svs_plus: opp4 {
> +							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> +						};
> +
> +						rpmpd_opp_nom: opp5 {
> +							opp-level = <RPM_SMD_LEVEL_NOM>;
> +						};
> +
> +						rpmpd_opp_nom_plus: opp6 {
> +							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> +						};
> +
> +						rpmpd_opp_turbo: opp7 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO>;
> +						};
> +
> +						rpmpd_opp_turbo_plus: opp8 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	reserved_memory: reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -440,68 +506,6 @@ rmtfs_mem: memory@89b01000 {
>  		};
>  	};
>  
> -	rpm-glink {
> -		compatible = "qcom,glink-rpm";
> -
> -		interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
> -		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> -		mboxes = <&apcs_glb 0>;
> -
> -		rpm_requests: rpm-requests {
> -			compatible = "qcom,rpm-sm6115";
> -			qcom,glink-channels = "rpm_requests";
> -
> -			rpmcc: clock-controller {
> -				compatible = "qcom,rpmcc-sm6115", "qcom,rpmcc";
> -				clocks = <&xo_board>;
> -				clock-names = "xo";
> -				#clock-cells = <1>;
> -			};
> -
> -			rpmpd: power-controller {
> -				compatible = "qcom,sm6115-rpmpd";
> -				#power-domain-cells = <1>;
> -				operating-points-v2 = <&rpmpd_opp_table>;
> -
> -				rpmpd_opp_table: opp-table {
> -					compatible = "operating-points-v2";
> -
> -					rpmpd_opp_min_svs: opp1 {
> -						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> -					};
> -
> -					rpmpd_opp_low_svs: opp2 {
> -						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> -					};
> -
> -					rpmpd_opp_svs: opp3 {
> -						opp-level = <RPM_SMD_LEVEL_SVS>;
> -					};
> -
> -					rpmpd_opp_svs_plus: opp4 {
> -						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> -					};
> -
> -					rpmpd_opp_nom: opp5 {
> -						opp-level = <RPM_SMD_LEVEL_NOM>;
> -					};
> -
> -					rpmpd_opp_nom_plus: opp6 {
> -						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> -					};
> -
> -					rpmpd_opp_turbo: opp7 {
> -						opp-level = <RPM_SMD_LEVEL_TURBO>;
> -					};
> -
> -					rpmpd_opp_turbo_plus: opp8 {
> -						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -
>  	smp2p-adsp {
>  		compatible = "qcom,smp2p";
>  		qcom,smem = <443>, <429>;
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index a596baa6ce3e..1d05ddf35e35 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -181,6 +181,78 @@ psci {
>  		method = "smc";
>  	};
>  
> +	remoteproc-rpm {
> +		compatible = "qcom,sm6125-rpm-proc", "qcom,rpm-proc";
> +
> +		glink-rpm {
> +			compatible = "qcom,glink-rpm";
> +
> +			interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +			mboxes = <&apcs_glb 0>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-sm6125";
> +				qcom,glink-channels = "rpm_requests";
> +
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-sm6125", "qcom,rpmcc";
> +					#clock-cells = <1>;
> +				};
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,sm6125-rpmpd";
> +					#power-domain-cells = <1>;
> +					operating-points-v2 = <&rpmpd_opp_table>;
> +
> +					rpmpd_opp_table: opp-table {
> +						compatible = "operating-points-v2";
> +
> +						rpmpd_opp_ret: opp1 {
> +							opp-level = <RPM_SMD_LEVEL_RETENTION>;
> +						};
> +
> +						rpmpd_opp_ret_plus: opp2 {
> +							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
> +						};
> +
> +						rpmpd_opp_min_svs: opp3 {
> +							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> +						};
> +
> +						rpmpd_opp_low_svs: opp4 {
> +							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> +						};
> +
> +						rpmpd_opp_svs: opp5 {
> +							opp-level = <RPM_SMD_LEVEL_SVS>;
> +						};
> +
> +						rpmpd_opp_svs_plus: opp6 {
> +							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> +						};
> +
> +						rpmpd_opp_nom: opp7 {
> +							opp-level = <RPM_SMD_LEVEL_NOM>;
> +						};
> +
> +						rpmpd_opp_nom_plus: opp8 {
> +							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> +						};
> +
> +						rpmpd_opp_turbo: opp9 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO>;
> +						};
> +
> +						rpmpd_opp_turbo_no_cpr: opp10 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	reserved_memory: reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -292,74 +364,6 @@ qseecom_ta_mem: memory@13fc00000 {
>  		};
>  	};
>  
> -	rpm-glink {
> -		compatible = "qcom,glink-rpm";
> -
> -		interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
> -		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> -		mboxes = <&apcs_glb 0>;
> -
> -		rpm_requests: rpm-requests {
> -			compatible = "qcom,rpm-sm6125";
> -			qcom,glink-channels = "rpm_requests";
> -
> -			rpmcc: clock-controller {
> -				compatible = "qcom,rpmcc-sm6125", "qcom,rpmcc";
> -				#clock-cells = <1>;
> -			};
> -
> -			rpmpd: power-controller {
> -				compatible = "qcom,sm6125-rpmpd";
> -				#power-domain-cells = <1>;
> -				operating-points-v2 = <&rpmpd_opp_table>;
> -
> -				rpmpd_opp_table: opp-table {
> -					compatible = "operating-points-v2";
> -
> -					rpmpd_opp_ret: opp1 {
> -						opp-level = <RPM_SMD_LEVEL_RETENTION>;
> -					};
> -
> -					rpmpd_opp_ret_plus: opp2 {
> -						opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
> -					};
> -
> -					rpmpd_opp_min_svs: opp3 {
> -						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> -					};
> -
> -					rpmpd_opp_low_svs: opp4 {
> -						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> -					};
> -
> -					rpmpd_opp_svs: opp5 {
> -						opp-level = <RPM_SMD_LEVEL_SVS>;
> -					};
> -
> -					rpmpd_opp_svs_plus: opp6 {
> -						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> -					};
> -
> -					rpmpd_opp_nom: opp7 {
> -						opp-level = <RPM_SMD_LEVEL_NOM>;
> -					};
> -
> -					rpmpd_opp_nom_plus: opp8 {
> -						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> -					};
> -
> -					rpmpd_opp_turbo: opp9 {
> -						opp-level = <RPM_SMD_LEVEL_TURBO>;
> -					};
> -
> -					rpmpd_opp_turbo_no_cpr: opp10 {
> -						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
> -					};
> -				};
> -			};
> -		};
> -	};
> -
>  	smem: smem {
>  		compatible = "qcom,smem";
>  		memory-region = <&smem_mem>;
> diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> index f8d9c34d3b2f..9834c5089fe8 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> @@ -493,67 +493,71 @@ cmdline_region: cmdline@ffd00000 {
>  		};
>  	};
>  
> -	rpm-glink {
> -		compatible = "qcom,glink-rpm";
> -		interrupts-extended = <&ipcc IPCC_CLIENT_AOP
> -					     IPCC_MPROC_SIGNAL_GLINK_QMP
> -					     IRQ_TYPE_EDGE_RISING>;
> -		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> -		mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
> -
> -		rpm_requests: rpm-requests {
> -			compatible = "qcom,rpm-sm6375";
> -			qcom,glink-channels = "rpm_requests";
> -
> -			rpmcc: clock-controller {
> -				compatible = "qcom,rpmcc-sm6375", "qcom,rpmcc";
> -				clocks = <&xo_board_clk>;
> -				clock-names = "xo";
> -				#clock-cells = <1>;
> -			};
> -
> -			rpmpd: power-controller {
> -				compatible = "qcom,sm6375-rpmpd";
> -				#power-domain-cells = <1>;
> -				operating-points-v2 = <&rpmpd_opp_table>;
> -
> -				rpmpd_opp_table: opp-table {
> -					compatible = "operating-points-v2";
> -
> -					rpmpd_opp_ret: opp1 {
> -						opp-level = <RPM_SMD_LEVEL_RETENTION>;
> -					};
> -
> -					rpmpd_opp_min_svs: opp2 {
> -						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> -					};
> -
> -					rpmpd_opp_low_svs: opp3 {
> -						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> -					};
> -
> -					rpmpd_opp_svs: opp4 {
> -						opp-level = <RPM_SMD_LEVEL_SVS>;
> -					};
> -
> -					rpmpd_opp_svs_plus: opp5 {
> -						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> -					};
> -
> -					rpmpd_opp_nom: opp6 {
> -						opp-level = <RPM_SMD_LEVEL_NOM>;
> -					};
> -
> -					rpmpd_opp_nom_plus: opp7 {
> -						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> -					};
> -
> -					rpmpd_opp_turbo: opp8 {
> -						opp-level = <RPM_SMD_LEVEL_TURBO>;
> -					};
> -
> -					rpmpd_opp_turbo_no_cpr: opp9 {
> -						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
> +	remoteproc-rpm {
> +		compatible = "qcom,sm6375-rpm-proc", "qcom,rpm-proc";
> +
> +		glink-rpm {
> +			compatible = "qcom,glink-rpm";
> +			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
> +						     IPCC_MPROC_SIGNAL_GLINK_QMP
> +						     IRQ_TYPE_EDGE_RISING>;
> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-sm6375";
> +				qcom,glink-channels = "rpm_requests";
> +
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-sm6375", "qcom,rpmcc";
> +					clocks = <&xo_board_clk>;
> +					clock-names = "xo";
> +					#clock-cells = <1>;
> +				};
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,sm6375-rpmpd";
> +					#power-domain-cells = <1>;
> +					operating-points-v2 = <&rpmpd_opp_table>;
> +
> +					rpmpd_opp_table: opp-table {
> +						compatible = "operating-points-v2";
> +
> +						rpmpd_opp_ret: opp1 {
> +							opp-level = <RPM_SMD_LEVEL_RETENTION>;
> +						};
> +
> +						rpmpd_opp_min_svs: opp2 {
> +							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> +						};
> +
> +						rpmpd_opp_low_svs: opp3 {
> +							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> +						};
> +
> +						rpmpd_opp_svs: opp4 {
> +							opp-level = <RPM_SMD_LEVEL_SVS>;
> +						};
> +
> +						rpmpd_opp_svs_plus: opp5 {
> +							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> +						};
> +
> +						rpmpd_opp_nom: opp6 {
> +							opp-level = <RPM_SMD_LEVEL_NOM>;
> +						};
> +
> +						rpmpd_opp_nom_plus: opp7 {
> +							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> +						};
> +
> +						rpmpd_opp_turbo: opp8 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO>;
> +						};
> +
> +						rpmpd_opp_turbo_no_cpr: opp9 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
> +						};
>  					};
>  				};
>  			};
> 
