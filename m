Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB3C69F9A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjBVRIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjBVRIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:08:32 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3531A641
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:08:30 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id by8so3631950ljb.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZb8L4QDDdkYPXU8SkBkrJ6UxbW+D93NO8jg40+5d7s=;
        b=QRCaO1sUeso18Xtjg133IWSlskZ5TSvlznqwRk0juzcr4mFVM+rtaxODeJFoU8/Y/K
         FTwbR4bvF7UubYsn3+UrMed39zW1sQstJg2uK8YCScnvNkcYXYBRJZBx9Hlh/UoVXMf7
         B1gk6RrgosO8DZzo+mr4devZrMGcxoAtZCYqqmu3sD4Fbpx95AvQoxKjaTb4E7bcIwCF
         kcUaLSu4AiMluEY4yQOaHymRmDZIXzTpimeFDSoZgIgnvKMOfRnMHyCmSEAkiabgZ2cJ
         CSj9LOf3KumCfmX1ujkV/PqvjAuv/vWMBEg4gp0ZE3VOPcamRYsIysogXqHaH32K/zFR
         5sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZb8L4QDDdkYPXU8SkBkrJ6UxbW+D93NO8jg40+5d7s=;
        b=k6I+mu0O409iUOEykQIlvRaVVxLDKItCMFgIWiaZAsl7irRIDwDQHZ1jpvp7SkGKRc
         +LuIQTklV+6Kj56OSaIsfG8kPXjnAA9GSkUDTDJ73rA0aneDnaczV6BITeoHso10GsNT
         me+awyVCDtIRV2iYa0XCMdmuGluwAfkry8PM8MDJIWGILoOtNMPhYxvjXMMJvOrBVtDG
         doiplG9eoN9Lym9SUnBSLo2KzeX1LW2UziqcD03ubzi69Mb5dzLVgg9ESUbh0PAgY6xL
         jjcKUvJrNx+oG/EM2yM2Hd71VyqYpLNV2qY8FsLRw4Kyguk7pbPFedPYq4xptHUWTIhh
         32Kg==
X-Gm-Message-State: AO0yUKXJh1Ha9Fg/a71boy1qX8VhnpCqWfY/91PnAMWRLDQJoMcwrHVj
        INwz4EXMc8fuO3Kc73XTEVwpuA==
X-Google-Smtp-Source: AK7set8lPGUeg0zgDxPOykEW0LdHZj1RveJyxVsZxemxEUYbtbBzeRtOxtzUy8r4CyXnM0cf77TmNw==
X-Received: by 2002:a2e:9c43:0:b0:28b:6f21:d929 with SMTP id t3-20020a2e9c43000000b0028b6f21d929mr2935765ljj.32.1677085708249;
        Wed, 22 Feb 2023 09:08:28 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id h23-20020a2ea497000000b0029599744c02sm196635lji.75.2023.02.22.09.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 09:08:27 -0800 (PST)
Message-ID: <56ed6a30-9815-002f-8174-95e7e9fc0954@linaro.org>
Date:   Wed, 22 Feb 2023 18:08:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v6 2/5] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
 <20230222120411.55197-3-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230222120411.55197-3-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.02.2023 13:04, Bryan O'Donoghue wrote:
> Add msm8939 a derivative SoC of msm8916. This SoC contains a number of key
> differences to msm8916.
> 
> - big.LITTLE Octa Core - quad 1.5GHz + quad 1.0GHz
> - DRAM 1x800 LPDDR3
> - Camera 4+4 lane CSI
> - Venus @ 1080p60 HEVC
> - DSI x 2
> - Adreno A405
> - WiFi wcn3660/wcn3680b 802.11ac
> 
> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Co-developed-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Co-developed-by: Benjamin Li <benl@squareup.com>
> Signed-off-by: Benjamin Li <benl@squareup.com>
> Co-developed-by: James Willcox <jwillcox@squareup.com>
> Signed-off-by: James Willcox <jwillcox@squareup.com>
> Co-developed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Co-developed-by: Joseph Gates <jgates@squareup.com>
> Signed-off-by: Joseph Gates <jgates@squareup.com>
> Co-developed-by: Max Chen <mchen@squareup.com>
> Signed-off-by: Max Chen <mchen@squareup.com>
> Co-developed-by: Zac Crosby <zac@squareup.com>
> Signed-off-by: Zac Crosby <zac@squareup.com>
> Co-developed-by: Vincent Knecht <vincent.knecht@mailoo.org>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
Couple of nits below

>  arch/arm64/boot/dts/qcom/msm8939.dtsi | 2454 +++++++++++++++++++++++++
>  1 file changed, 2454 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
[...]


> +		mpss: remoteproc@4080000 {
> +			compatible = "qcom,msm8916-mss-pil";
> +			reg = <0x04080000 0x100>,
> +			      <0x04020000 0x040>;
I see veeery aggressive line wrapping in reg/compatible :P

> +
Unnecessary newline
> +			reg-names = "qdsp6", "rmb";
> +
> +			interrupts-extended = <&intc GIC_SPI 24 IRQ_TYPE_EDGE_RISING>,
> +					      <&hexagon_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&hexagon_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&hexagon_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&hexagon_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready",
> +					  "handover", "stop-ack";
This should be a vertical list

> +
> +			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
> +				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
> +				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "iface", "bus", "mem", "xo";
This could also be one

> +
> +			power-domains = <&rpmpd MSM8939_VDDMDCX>,
> +					<&rpmpd MSM8939_VDDMX>;
> +			power-domain-names = "cx", "mx";
> +
> +			qcom,smem-states = <&hexagon_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			resets = <&scm 0>;
> +			reset-names = "mss_restart";
> +
> +			qcom,halt-regs = <&tcsr 0x18000 0x19000 0x1a000>;
> +
> +			status = "disabled";
> +
> +			mba {
> +				memory-region = <&mba_mem>;
> +			};
> +
> +			mpss {
> +				memory-region = <&mpss_mem>;
> +			};
> +
> +			smd-edge {
> +				interrupts = <GIC_SPI 25 IRQ_TYPE_EDGE_RISING>;
> +
> +				qcom,smd-edge = <0>;
> +				mboxes = <&apcs1_mbox 12>;
> +				qcom,remote-pid = <1>;
> +
> +				label = "hexagon";
> +			};
> +		};
> +
[...]

> +
> +		blsp1_uart1: serial@78af000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078af000 0x200>;
> +			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp_dma 0>, <&blsp_dma 1>;
> +			dma-names = "tx", "rx";
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&blsp1_uart1_default>;
> +			pinctrl-1 = <&blsp1_uart1_sleep>;
property
property-names


> +			status = "disabled";
> +		};
> +
[...]

> +		usb: usb@78d9000 {
> +			compatible = "qcom,ci-hdrc";
> +			reg = <0x078d9000 0x200>,
> +			      <0x078d9200 0x200>;
> +			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
> +				 <&gcc GCC_USB_HS_SYSTEM_CLK>;
> +			clock-names = "iface", "core";
> +			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
> +			assigned-clock-rates = <80000000>;
> +			resets = <&gcc GCC_USB_HS_BCR>;
> +			reset-names = "core";
> +			#reset-cells = <1>;
> +			phy_type = "ulpi";
> +			dr_mode = "otg";
> +			ahb-burst-config = <0>;
> +			phy-names = "usb-phy";
> +			phys = <&usb_hs_phy>;
> +			status = "disabled";
> +
> +			ulpi {
> +				usb_hs_phy: phy {
> +					compatible = "qcom,usb-hs-phy-msm8916",
> +						     "qcom,usb-hs-phy";
> +					clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
This could be wrapped

> +					clock-names = "ref", "sleep";
> +					resets = <&gcc GCC_USB2A_PHY_BCR>, <&usb 0>;
> +					reset-names = "phy", "por";
> +					#phy-cells = <0>;
> +					qcom,init-seq = /bits/ 8 <0x0 0x44>,
> +								 <0x1 0x6b>,
> +								 <0x2 0x24>,
> +								 <0x3 0x13>;
> +				};
> +			};
> +		};
[...]

> +
> +		pronto: remoteproc@a204000 {
> +			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
> +			reg = <0x0a204000 0x2000>,
> +			      <0x0a202000 0x1000>,
> +			      <0x0a21b000 0x3000>;
> +			reg-names = "ccu", "dxe", "pmu";
> +
> +			interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
Long enough to be a vertical list


Konrad
> +
> +			memory-region = <&wcnss_mem>;
> +
> +			power-domains = <&rpmpd MSM8939_VDDCX>,
> +					<&rpmpd MSM8939_VDDMX>;
> +			power-domain-names = "cx", "mx";
> +
> +			qcom,smem-states = <&wcnss_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&wcnss_pin_a>;
> +
> +			status = "disabled";
> +
> +			iris {
> +				compatible = "qcom,wcn3620";
> +				clocks = <&rpmcc RPM_SMD_RF_CLK2>;
> +				clock-names = "xo";
> +			};
> +
> +			smd-edge {
> +				interrupts = <GIC_SPI 142 1>;
> +				qcom,ipc = <&apcs1_mbox 8 17>;
> +				qcom,smd-edge = <6>;
> +				qcom,remote-pid = <4>;
> +
> +				label = "pronto";
> +
> +				wcnss {
> +					compatible = "qcom,wcnss";
> +					qcom,smd-channels = "WCNSS_CTRL";
> +
> +					qcom,mmio = <&pronto>;
> +
> +					bluetooth {
> +						compatible = "qcom,wcnss-bt";
> +					};
> +
> +					wifi {
> +						compatible = "qcom,wcnss-wlan";
> +
> +						interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +							     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> +						interrupt-names = "tx", "rx";
> +
> +						qcom,smem-states = <&apps_smsm 10>,
> +								   <&apps_smsm 9>;
> +						qcom,smem-state-names = "tx-enable",
> +									"tx-rings-empty";
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	thermal_zones: thermal-zones {
> +		cpu0-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 5>;
> +
> +			trips {
> +				cpu0_alert: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu0_crit: trip1 {
> +					temperature = <115000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu0_alert>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu1-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 6>;
> +
> +			trips {
> +				cpu1_alert: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu1_crit: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu1_alert>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu2-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 7>;
> +
> +			trips {
> +				cpu2_alert: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu2_crit: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu2_alert>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu3-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 8>;
> +
> +			trips {
> +				cpu3_alert: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu3_crit: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu3_alert>;
> +					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		cpu4567-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 9>;
> +
> +			trips {
> +				cpu4567_alert: trip0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu4567_crit: trip1 {
> +					temperature = <110000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu4567_alert>;
> +					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		gpu-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 3>;
> +
> +			trips {
> +				gpu_alert0: trip-point0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				gpu_crit: gpu_crit {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		modem1-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 0>;
> +
> +			trips {
> +				modem1_alert0: trip-point0 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		modem2-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 2>;
> +
> +			trips {
> +				modem2_alert0: trip-point0 {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +
> +		camera-thermal {
> +			polling-delay-passive = <250>;
> +			polling-delay = <1000>;
> +
> +			thermal-sensors = <&tsens 1>;
> +
> +			trips {
> +				cam_alert0: trip-point0 {
> +					temperature = <75000>;
> +					hysteresis = <2000>;
> +					type = "hot";
> +				};
> +			};
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +};
