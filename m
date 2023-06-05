Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4134722F42
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjFETHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjFETHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:07:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244ECF1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:07:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f505aace48so6702960e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685992065; x=1688584065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exXxt6rwQlXr1z7Se66/eBRcePuJerJD/5orB1txBV0=;
        b=Uf/rBZk9/vTBZmPHe2psKOhmjZd0zUooN0kALwD/2dc33pSR602GsTZjMqR8U14aQP
         Bgp9X8mDmvJ4zBCo5y41Ig31bfiP+ZEsUJEMSPaE3R+Kt9Z7i9fFJiuuWCObKIScYhzr
         T4C5rg9Np68PUjXrPaQXH5WBthJBADMZ4cTln1xD+8xPgM0+93VTD8BJXpR00rz84AD7
         VN7jX9RK+exvY6DodyIbXz8gUQuGGVODApGoEuQpt10SeRJNNPZkVp6/T+E2FlwTAovG
         CN8Q8yM6B64l7jc5hEhxjc4rGNdUuBAXRWihCh1ePzmFCfc6nLsX2Se4PcR12SvjgWy5
         DYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685992065; x=1688584065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=exXxt6rwQlXr1z7Se66/eBRcePuJerJD/5orB1txBV0=;
        b=FfBFDZNTkIWHw1JxvE2pCG9GSLxXs+JGLmj5Tp+aqDmKkOOhE35OGeJaCdPVMdcbJD
         J02Ebio1b+K+CovuAEUfnGYNg4KZ1izs+St6Ea2O8DPs/VPDK2EwW5Wb7hE0K/cPSuVX
         I8D06ApybBc1T61pHk+OLsCbOAsMGY+y06Vm9/dHwjXulKrzejDsjHtt/bQ7NAKyCbpG
         1aqlUQKoBVglhp9m0nZ++vYIqDiZ094GsjTMwsV0QPNJBa9gOhuiABinOgY9gwQ6Cc8z
         o7LgiPMeBB1oY55WX+oYLZlolMSVTB3mGWkO18JIehPKbxiW2m2mUakSRrL1Ar2Jd/W3
         8YiQ==
X-Gm-Message-State: AC+VfDw3UyRphZcMNTIbM8LD5LBzVJ/MC8nqyhjUO7E3085fUvdYrX0b
        YHqQj1QdDpdhUSc+7fF+SPvXpQ==
X-Google-Smtp-Source: ACHHUZ6uo/qo18he/ZzDKnHvqPYp5n11iS6MsXT7g9EaaGEUFr+ttfNzeHIf0QNcu1cr3UdL8Nimxg==
X-Received: by 2002:a19:f808:0:b0:4f6:b34:a02d with SMTP id a8-20020a19f808000000b004f60b34a02dmr5951447lff.54.1685992065463;
        Mon, 05 Jun 2023 12:07:45 -0700 (PDT)
Received: from [192.168.1.101] (abyj96.neoplus.adsl.tpnet.pl. [83.9.29.96])
        by smtp.gmail.com with ESMTPSA id f18-20020a19ae12000000b004f00d3d9df9sm1215706lfc.188.2023.06.05.12.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:07:45 -0700 (PDT)
Message-ID: <056c7b05-c41e-1e63-d94b-2d7b27356bc6@linaro.org>
Date:   Mon, 5 Jun 2023 21:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 11/14] arm64: dts: qcom: Add rpm-proc node for SMD
 platforms
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
 <20230531-rpm-rproc-v1-11-e0a3b6de1f14@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230531-rpm-rproc-v1-11-e0a3b6de1f14@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.06.2023 09:08, Stephan Gerhold wrote:
> Rather than having the RPM SMD channels as the only child of a dummy
> SMD node, switch to representing the RPM as remoteproc like all the
> other remoteprocs (WCNSS, modem DSP).
> 
> This allows assigning additional subdevices to it like the MPM
> interrupt-controller or rpm-master-stats.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8916.dtsi |   6 +-
>  arch/arm64/boot/dts/qcom/msm8939.dtsi | 112 ++++++++++++-------------
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 136 +++++++++++++++---------------
>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 152 +++++++++++++++++-----------------
>  arch/arm64/boot/dts/qcom/msm8994.dtsi |  99 +++++++++++-----------
>  5 files changed, 253 insertions(+), 252 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 9494b6512d87..667748612d3e 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -282,10 +282,10 @@ CLUSTER_PD: power-domain-cluster {
>  		};
>  	};
>  
> -	smd {
> -		compatible = "qcom,smd";
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
>  
> -		rpm {
> +		smd-edge {
>  			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
>  			qcom,ipc = <&apcs 8 0>;
>  			qcom,smd-edge = <15>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> index 0d9f8b951b66..f11d522586eb 100644
> --- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> @@ -240,6 +240,62 @@ pmu {
>  		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
>  	};
>  
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,msm8936-rpm-proc", "qcom,rpm-proc";
> +
> +		smd-edge {
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,ipc = <&apcs1_mbox 8 0>;
> +			qcom,smd-edge = <15>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-msm8936";
> +				qcom,smd-channels = "rpm_requests";
> +
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-msm8936", "qcom,rpmcc";
> +					#clock-cells = <1>;
> +					clock-names = "xo";
> +					clocks = <&xo_board>;
> +				};
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,msm8939-rpmpd";
> +					#power-domain-cells = <1>;
> +					operating-points-v2 = <&rpmpd_opp_table>;
> +
> +					rpmpd_opp_table: opp-table {
> +						compatible = "operating-points-v2";
> +
> +						rpmpd_opp_ret: opp1 {
> +							opp-level = <1>;
> +						};
> +
> +						rpmpd_opp_svs_krait: opp2 {
> +							opp-level = <2>;
> +						};
> +
> +						rpmpd_opp_svs_soc: opp3 {
> +							opp-level = <3>;
> +						};
> +
> +						rpmpd_opp_nom: opp4 {
> +							opp-level = <4>;
> +						};
> +
> +						rpmpd_opp_turbo: opp5 {
> +							opp-level = <5>;
> +						};
> +
> +						rpmpd_opp_super_turbo: opp6 {
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
> @@ -308,62 +364,6 @@ mba_mem: mba@8cb00000 {
>  		};
>  	};
>  
> -	smd {
> -		compatible = "qcom,smd";
> -
> -		rpm {
> -			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> -			qcom,ipc = <&apcs1_mbox 8 0>;
> -			qcom,smd-edge = <15>;
> -
> -			rpm_requests: rpm-requests {
> -				compatible = "qcom,rpm-msm8936";
> -				qcom,smd-channels = "rpm_requests";
> -
> -				rpmcc: clock-controller {
> -					compatible = "qcom,rpmcc-msm8936", "qcom,rpmcc";
> -					#clock-cells = <1>;
> -					clock-names = "xo";
> -					clocks = <&xo_board>;
> -				};
> -
> -				rpmpd: power-controller {
> -					compatible = "qcom,msm8939-rpmpd";
> -					#power-domain-cells = <1>;
> -					operating-points-v2 = <&rpmpd_opp_table>;
> -
> -					rpmpd_opp_table: opp-table {
> -						compatible = "operating-points-v2";
> -
> -						rpmpd_opp_ret: opp1 {
> -							opp-level = <1>;
> -						};
> -
> -						rpmpd_opp_svs_krait: opp2 {
> -							opp-level = <2>;
> -						};
> -
> -						rpmpd_opp_svs_soc: opp3 {
> -							opp-level = <3>;
> -						};
> -
> -						rpmpd_opp_nom: opp4 {
> -							opp-level = <4>;
> -						};
> -
> -						rpmpd_opp_turbo: opp5 {
> -							opp-level = <5>;
> -						};
> -
> -						rpmpd_opp_super_turbo: opp6 {
> -							opp-level = <6>;
> -						};
> -					};
> -				};
> -			};
> -		};
> -	};
> -
>  	smp2p-hexagon {
>  		compatible = "qcom,smp2p";
>  		qcom,smem = <435>, <428>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 7d193a467819..4b2f02850a10 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -190,6 +190,74 @@ psci {
>  		method = "smc";
>  	};
>  
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,msm8953-rpm-proc", "qcom,rpm-proc";
> +
> +		smd-edge {
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,ipc = <&apcs 8 0>;
> +			qcom,smd-edge = <15>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-msm8953";
> +				qcom,smd-channels = "rpm_requests";
> +
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-msm8953", "qcom,rpmcc";
> +					clocks = <&xo_board>;
> +					clock-names = "xo";
> +					#clock-cells = <1>;
> +				};
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,msm8953-rpmpd";
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
> @@ -263,74 +331,6 @@ rmtfs@f2d00000 {
>  		};
>  	};
>  
> -	smd {
> -		compatible = "qcom,smd";
> -
> -		rpm {
> -			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> -			qcom,ipc = <&apcs 8 0>;
> -			qcom,smd-edge = <15>;
> -
> -			rpm_requests: rpm-requests {
> -				compatible = "qcom,rpm-msm8953";
> -				qcom,smd-channels = "rpm_requests";
> -
> -				rpmcc: clock-controller {
> -					compatible = "qcom,rpmcc-msm8953", "qcom,rpmcc";
> -					clocks = <&xo_board>;
> -					clock-names = "xo";
> -					#clock-cells = <1>;
> -				};
> -
> -				rpmpd: power-controller {
> -					compatible = "qcom,msm8953-rpmpd";
> -					#power-domain-cells = <1>;
> -					operating-points-v2 = <&rpmpd_opp_table>;
> -
> -					rpmpd_opp_table: opp-table {
> -						compatible = "operating-points-v2";
> -
> -						rpmpd_opp_ret: opp1 {
> -							opp-level = <RPM_SMD_LEVEL_RETENTION>;
> -						};
> -
> -						rpmpd_opp_ret_plus: opp2 {
> -							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
> -						};
> -
> -						rpmpd_opp_min_svs: opp3 {
> -							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> -						};
> -
> -						rpmpd_opp_low_svs: opp4 {
> -							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> -						};
> -
> -						rpmpd_opp_svs: opp5 {
> -							opp-level = <RPM_SMD_LEVEL_SVS>;
> -						};
> -
> -						rpmpd_opp_svs_plus: opp6 {
> -							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> -						};
> -
> -						rpmpd_opp_nom: opp7 {
> -							opp-level = <RPM_SMD_LEVEL_NOM>;
> -						};
> -
> -						rpmpd_opp_nom_plus: opp8 {
> -							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> -						};
> -
> -						rpmpd_opp_turbo: opp9 {
> -							opp-level = <RPM_SMD_LEVEL_TURBO>;
> -						};
> -					};
> -				};
> -			};
> -		};
> -	};
> -
>  	smp2p-adsp {
>  		compatible = "qcom,smp2p";
>  		qcom,smem = <443>, <429>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> index 753b9a2105ed..6f856562923f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -232,6 +232,82 @@ psci {
>  		method = "smc";
>  	};
>  
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,msm8976-rpm-proc", "qcom,rpm-proc";
> +
> +		smd-edge {
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,ipc = <&apcs 8 0>;
> +			qcom,smd-edge = <15>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-msm8976";
> +				qcom,smd-channels = "rpm_requests";
> +
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-msm8976", "qcom,rpmcc";
> +					clocks = <&xo_board>;
> +					clock-names = "xo";
> +					#clock-cells = <1>;
> +				};
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,msm8976-rpmpd";
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
> +
> +						rpmpd_opp_turbo_high: opp111 {
> +							opp-level = <RPM_SMD_LEVEL_TURBO_HIGH>;
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
> @@ -346,82 +422,6 @@ wcnss_smp2p_in: slave-kernel {
>  		};
>  	};
>  
> -	smd {
> -		compatible = "qcom,smd";
> -
> -		rpm {
> -			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> -			qcom,ipc = <&apcs 8 0>;
> -			qcom,smd-edge = <15>;
> -
> -			rpm_requests: rpm-requests {
> -				compatible = "qcom,rpm-msm8976";
> -				qcom,smd-channels = "rpm_requests";
> -
> -				rpmcc: clock-controller {
> -					compatible = "qcom,rpmcc-msm8976", "qcom,rpmcc";
> -					clocks = <&xo_board>;
> -					clock-names = "xo";
> -					#clock-cells = <1>;
> -				};
> -
> -				rpmpd: power-controller {
> -					compatible = "qcom,msm8976-rpmpd";
> -					#power-domain-cells = <1>;
> -					operating-points-v2 = <&rpmpd_opp_table>;
> -
> -					rpmpd_opp_table: opp-table {
> -						compatible = "operating-points-v2";
> -
> -						rpmpd_opp_ret: opp1 {
> -							opp-level = <RPM_SMD_LEVEL_RETENTION>;
> -						};
> -
> -						rpmpd_opp_ret_plus: opp2 {
> -							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
> -						};
> -
> -						rpmpd_opp_min_svs: opp3 {
> -							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
> -						};
> -
> -						rpmpd_opp_low_svs: opp4 {
> -							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
> -						};
> -
> -						rpmpd_opp_svs: opp5 {
> -							opp-level = <RPM_SMD_LEVEL_SVS>;
> -						};
> -
> -						rpmpd_opp_svs_plus: opp6 {
> -							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
> -						};
> -
> -						rpmpd_opp_nom: opp7 {
> -							opp-level = <RPM_SMD_LEVEL_NOM>;
> -						};
> -
> -						rpmpd_opp_nom_plus: opp8 {
> -							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
> -						};
> -
> -						rpmpd_opp_turbo: opp9 {
> -							opp-level = <RPM_SMD_LEVEL_TURBO>;
> -						};
> -
> -						rpmpd_opp_turbo_no_cpr: opp10 {
> -							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
> -						};
> -
> -						rpmpd_opp_turbo_high: opp111 {
> -							opp-level = <RPM_SMD_LEVEL_TURBO_HIGH>;
> -						};
> -					};
> -				};
> -			};
> -		};
> -	};
> -
>  	smsm {
>  		compatible = "qcom,smsm";
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> index 5a7923d7c62a..6168d0aeff57 100644
> --- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
> @@ -178,6 +178,56 @@ psci {
>  		method = "hvc";
>  	};
>  
> +	rpm: remoteproc-rpm {
> +		compatible = "qcom,msm8994-rpm-proc", "qcom,rpm-proc";
> +
> +		smd-edge {
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,ipc = <&apcs 8 0>;
> +			qcom,smd-edge = <15>;
> +			qcom,remote-pid = <6>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-msm8994";
> +				qcom,smd-channels = "rpm_requests";
> +
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-msm8994", "qcom,rpmcc";
> +					#clock-cells = <1>;
> +				};
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,msm8994-rpmpd";
> +					#power-domain-cells = <1>;
> +					operating-points-v2 = <&rpmpd_opp_table>;
> +
> +					rpmpd_opp_table: opp-table {
> +						compatible = "operating-points-v2";
> +
> +						rpmpd_opp_ret: opp1 {
> +							opp-level = <1>;
> +						};
> +						rpmpd_opp_svs_krait: opp2 {
> +							opp-level = <2>;
> +						};
> +						rpmpd_opp_svs_soc: opp3 {
> +							opp-level = <3>;
> +						};
> +						rpmpd_opp_nom: opp4 {
> +							opp-level = <4>;
> +						};
> +						rpmpd_opp_turbo: opp5 {
> +							opp-level = <5>;
> +						};
> +						rpmpd_opp_super_turbo: opp6 {
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
> @@ -237,55 +287,6 @@ reserved@6c00000 {
>  		};
>  	};
>  
> -	smd {
> -		compatible = "qcom,smd";
> -		rpm {
> -			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> -			qcom,ipc = <&apcs 8 0>;
> -			qcom,smd-edge = <15>;
> -			qcom,remote-pid = <6>;
> -
> -			rpm_requests: rpm-requests {
> -				compatible = "qcom,rpm-msm8994";
> -				qcom,smd-channels = "rpm_requests";
> -
> -				rpmcc: clock-controller {
> -					compatible = "qcom,rpmcc-msm8994", "qcom,rpmcc";
> -					#clock-cells = <1>;
> -				};
> -
> -				rpmpd: power-controller {
> -					compatible = "qcom,msm8994-rpmpd";
> -					#power-domain-cells = <1>;
> -					operating-points-v2 = <&rpmpd_opp_table>;
> -
> -					rpmpd_opp_table: opp-table {
> -						compatible = "operating-points-v2";
> -
> -						rpmpd_opp_ret: opp1 {
> -							opp-level = <1>;
> -						};
> -						rpmpd_opp_svs_krait: opp2 {
> -							opp-level = <2>;
> -						};
> -						rpmpd_opp_svs_soc: opp3 {
> -							opp-level = <3>;
> -						};
> -						rpmpd_opp_nom: opp4 {
> -							opp-level = <4>;
> -						};
> -						rpmpd_opp_turbo: opp5 {
> -							opp-level = <5>;
> -						};
> -						rpmpd_opp_super_turbo: opp6 {
> -							opp-level = <6>;
> -						};
> -					};
> -				};
> -			};
> -		};
> -	};
> -
>  	smem {
>  		compatible = "qcom,smem";
>  		memory-region = <&smem_mem>;
> 
