Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A4C649E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiLLMDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiLLMDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:03:31 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEE810FDB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:03:29 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id c1so18167607lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xf14pM0b5U57IWVbVbV1HRSrmNIXUqQ8Nr7URb7N2U0=;
        b=XZUyuF4uZPnmYtJUEZYSdFQJrcxoavWViar9FRWlHV17tX/JrUloH2NEQ98pR1hOAB
         OHtAdbR/Apx3MMHZ2l+wTo33O7j7GJWK4IxUDfxVr4Dpwbm84NKO5XDo/ZGRMlWMMsIP
         nnE2v5gbFlPwv0h6Jb5HWp1Qmv22rluj/5QU6GdznUWOmlGr5humaE+zCfyYQ2wU8s7h
         wD2pBJUPFqQ7VHBNB9f6ouFTPvGkDtdPIYoXaJkL172CceT/BV53d0inMQwpSBR4/Y5E
         9JPXVIB2jUkq5hDsFQoXiwst7sG3iTpYR7jpHLrSHAeLuUvDbQcGuJ9RrZPwT1+yWRVz
         A3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xf14pM0b5U57IWVbVbV1HRSrmNIXUqQ8Nr7URb7N2U0=;
        b=mzHPStbkl+SxaUiXyBC5wQNXqGzVjUeGVVoHfFpJwnlOfXqs9yhygH+a8aCVL6108M
         pOXLZ8irug4y94hK8b7kRAXC1An8NPknANgQdP8yOHdCzsZTSCp8NpUIZtdMoGBEAg4i
         E2ib99FKZV3FXZJrduzF7tqIEQxw03QtpwDfpu7rSQlONGnSj2PY5Qdaz48ZoxhqNeXo
         gBmVPFwgNB81d2di0b3FnRR3YybAHFb5MqVO4xUeWoboOgKDEAQKLf9rSDcFZigvHXm3
         spcjjTuLhGWuvBle9LxS5aXBErBNeRDlBQgtpchl5WStLohhGgeZGXFzNjOfLys1mUFZ
         TCiA==
X-Gm-Message-State: ANoB5pkEzwEO1Zqd0eN5b01Y31Q/xPofQFSLKweJxQKBWP9EE31NvXRl
        CEuVZVRvv5vgI+i/93KJGIcH9A==
X-Google-Smtp-Source: AA0mqf5su+tUBMYlcTTPEg7VG4wD1RqOYjUi4cuCtf9iu37n6KKsLx8loeOdjLrk1I3QVpDSnf/5JA==
X-Received: by 2002:a05:6512:1593:b0:4af:eabc:ad01 with SMTP id bp19-20020a056512159300b004afeabcad01mr4910288lfb.56.1670846607911;
        Mon, 12 Dec 2022 04:03:27 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id e12-20020a056512090c00b004947984b385sm1605855lft.87.2022.12.12.04.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 04:03:27 -0800 (PST)
Message-ID: <6d3ad4d9-bbb5-4533-9c8c-7263c5fab073@linaro.org>
Date:   Mon, 12 Dec 2022 13:03:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/6] arm64: dts: qcom: sc7180: order top-level nodes
 alphabetically
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org>
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



On 12.12.2022 11:02, Krzysztof Kozlowski wrote:
> Order top-level nodes like memory, reserved-memory, opp-table-cpu
> alphabetically for easier code maintenance.  No functional change (same
> dtx_diff).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> 1. New patch
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 144 +++++++++++++--------------
>  1 file changed, 72 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index ea886cf08b4d..6d3e86ce2936 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -27,8 +27,6 @@ / {
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> -	chosen { };
> -
>  	aliases {
>  		mmc1 = &sdhc_1;
>  		mmc2 = &sdhc_2;
> @@ -54,6 +52,8 @@ aliases {
>  		spi11 = &spi11;
>  	};
>  
> +	chosen { };
> +
>  	clocks {
>  		xo_board: xo-board {
>  			compatible = "fixed-clock";
> @@ -68,62 +68,6 @@ sleep_clk: sleep-clk {
>  		};
>  	};
>  
> -	reserved_memory: reserved-memory {
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -		ranges;
> -
> -		hyp_mem: memory@80000000 {
> -			reg = <0x0 0x80000000 0x0 0x600000>;
> -			no-map;
> -		};
> -
> -		xbl_mem: memory@80600000 {
> -			reg = <0x0 0x80600000 0x0 0x200000>;
> -			no-map;
> -		};
> -
> -		aop_mem: memory@80800000 {
> -			reg = <0x0 0x80800000 0x0 0x20000>;
> -			no-map;
> -		};
> -
> -		aop_cmd_db_mem: memory@80820000 {
> -			reg = <0x0 0x80820000 0x0 0x20000>;
> -			compatible = "qcom,cmd-db";
> -			no-map;
> -		};
> -
> -		sec_apps_mem: memory@808ff000 {
> -			reg = <0x0 0x808ff000 0x0 0x1000>;
> -			no-map;
> -		};
> -
> -		smem_mem: memory@80900000 {
> -			reg = <0x0 0x80900000 0x0 0x200000>;
> -			no-map;
> -		};
> -
> -		tz_mem: memory@80b00000 {
> -			reg = <0x0 0x80b00000 0x0 0x3900000>;
> -			no-map;
> -		};
> -
> -		ipa_fw_mem: memory@8b700000 {
> -			reg = <0 0x8b700000 0 0x10000>;
> -			no-map;
> -		};
> -
> -		rmtfs_mem: memory@94600000 {
> -			compatible = "qcom,rmtfs-mem";
> -			reg = <0x0 0x94600000 0x0 0x200000>;
> -			no-map;
> -
> -			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> -		};
> -	};
> -
>  	cpus {
>  		#address-cells = <2>;
>  		#size-cells = <0>;
> @@ -398,6 +342,18 @@ CLUSTER_SLEEP_0: cluster-sleep-0 {
>  		};
>  	};
>  
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-sc7180", "qcom,scm";
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the size */
> +		reg = <0 0x80000000 0 0>;
> +	};
> +
>  	cpu0_opp_table: opp-table-cpu0 {
>  		compatible = "operating-points-v2";
>  		opp-shared;
> @@ -538,20 +494,69 @@ cpu6_opp16: opp-2553600000 {
>  		};
>  	};
>  
> -	memory@80000000 {
> -		device_type = "memory";
> -		/* We expect the bootloader to fill in the size */
> -		reg = <0 0x80000000 0 0>;
> -	};
> -
>  	pmu {
>  		compatible = "arm,armv8-pmuv3";
>  		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> -	firmware {
> -		scm {
> -			compatible = "qcom,scm-sc7180", "qcom,scm";
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		hyp_mem: memory@80000000 {
> +			reg = <0x0 0x80000000 0x0 0x600000>;
> +			no-map;
> +		};
> +
> +		xbl_mem: memory@80600000 {
> +			reg = <0x0 0x80600000 0x0 0x200000>;
> +			no-map;
> +		};
> +
> +		aop_mem: memory@80800000 {
> +			reg = <0x0 0x80800000 0x0 0x20000>;
> +			no-map;
> +		};
> +
> +		aop_cmd_db_mem: memory@80820000 {
> +			reg = <0x0 0x80820000 0x0 0x20000>;
> +			compatible = "qcom,cmd-db";
> +			no-map;
> +		};
> +
> +		sec_apps_mem: memory@808ff000 {
> +			reg = <0x0 0x808ff000 0x0 0x1000>;
> +			no-map;
> +		};
> +
> +		smem_mem: memory@80900000 {
> +			reg = <0x0 0x80900000 0x0 0x200000>;
> +			no-map;
> +		};
> +
> +		tz_mem: memory@80b00000 {
> +			reg = <0x0 0x80b00000 0x0 0x3900000>;
> +			no-map;
> +		};
> +
> +		ipa_fw_mem: memory@8b700000 {
> +			reg = <0 0x8b700000 0 0x10000>;
> +			no-map;
> +		};
> +
> +		rmtfs_mem: memory@94600000 {
> +			compatible = "qcom,rmtfs-mem";
> +			reg = <0x0 0x94600000 0x0 0x200000>;
> +			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <15>;
>  		};
>  	};
>  
> @@ -640,11 +645,6 @@ ipa_smp2p_in: ipa-modem-to-ap {
>  		};
>  	};
>  
> -	psci {
> -		compatible = "arm,psci-1.0";
> -		method = "smc";
> -	};
> -
>  	soc: soc@0 {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
