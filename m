Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C0C6C3A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCUTZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCUTY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:24:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67FB1ADE5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:24:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y20so20515050lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679426694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NwQBE2MYCQF1v4SYWqw5fgn23Mz+rAnsm7yXsaxMFlI=;
        b=RCx7d1GM/F9upQOB7cEaANvqutDnYI09t83fwsfVtvRlktKeGXM9sn5n/rKSGL9eJI
         8OjR8s0ChXJ/T/ZPTTbsrt0BqlLFsUmZcLVDGHpQxAkFYRYri4J0EbnMOL/x7jf350GA
         92lEh9snB4I05owxQR35JwEhffJ33XdRRFzGUG6kg19WntqdBk3H6s99Z3OQTjGiyls8
         J3K6aNrUF3J9W+vvnYAtMNVm4JklzgISLPr1PPGRdDDUWmkPcGnoj9fl/W1fkwLpprMW
         skg4c4a9h9QC2I25XeBzX4pweAQeUkuExdmWScrn/LkNbDyrCJ/CKzy0P03TG7SUHziG
         hA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679426694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwQBE2MYCQF1v4SYWqw5fgn23Mz+rAnsm7yXsaxMFlI=;
        b=PP8PtWM3dR1bkhPXvf8hu75kbs4gM9mdPIFUetF7IGCbUYDCbbQmaHa6p9jxEEXklh
         GGtswq5hVvZ4LKWwWrWxMeyg2isyZ/M3nTWOdjm2njyzCfaX1koLeuIDygjANoneF0oH
         9LWqsxWEQujIInrZ1UwKSq4LJiCo/P94CwhnZWOplUQ6PAub98VoAgNXYjScVde5HfIN
         1KM3QU81FMy0csQthUUXuD0CVMymKaaF3WJiku4UBdrx3TNTIm8mEr91SeVRni6YK61Q
         mJhh3CMthXm9nr465kr7IYty31M2uHlEmADNG0mt5KpIPLuEztb1AcITPVUd12WPK5Il
         bUrA==
X-Gm-Message-State: AO0yUKUKCc3SCJUOW809awPZ96HhL9bvgXhvXYrfdc7jtquhAqrsf5eR
        jCNq7bTMgeN+AaSQdsi/qbAjZw==
X-Google-Smtp-Source: AK7set/PQvxO4sL67uyAbVu8tO6ZDGiQLVN7nj9+2j2Zbs1sGvZodzuY4FAwq5wN5MbVJoeZhKkvvQ==
X-Received: by 2002:ac2:5939:0:b0:4e8:50e8:b96d with SMTP id v25-20020ac25939000000b004e850e8b96dmr1192449lfi.39.1679426693567;
        Tue, 21 Mar 2023 12:24:53 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id z2-20020ac24182000000b004dc4bb2f4bcsm2263657lfh.276.2023.03.21.12.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:24:53 -0700 (PDT)
Message-ID: <0a029829-1663-4302-bef8-ed6636387d5e@linaro.org>
Date:   Tue, 21 Mar 2023 20:24:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 02/15] arm64: dts: qcom: sa8775p: sort soc nodes by reg
 property
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
 <20230320154841.327908-3-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230320154841.327908-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2023 16:48, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Sort all children of the soc node by the first address in their reg
> property. This was mostly already the case but there were some nodes
> that didn't follow it so fix it now for consistency.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 394 +++++++++++++-------------
>  1 file changed, 197 insertions(+), 197 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 5aa28a3b12ae..296ba69b81ab 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -471,50 +471,6 @@ ipcc: mailbox@408000 {
>  			#mbox-cells = <2>;
>  		};
>  
> -		qupv3_id_1: geniqup@ac0000 {
> -			compatible = "qcom,geni-se-qup";
> -			reg = <0x0 0x00ac0000 0x0 0x6000>;
> -			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> -			clock-names = "m-ahb", "s-ahb";
> -			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> -				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> -			iommus = <&apps_smmu 0x443 0x0>;
> -			status = "disabled";
> -
> -			uart10: serial@a8c000 {
> -				compatible = "qcom,geni-uart";
> -				reg = <0x0 0x00a8c000 0x0 0x4000>;
> -				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> -				clock-names = "se";
> -				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> -				interconnect-names = "qup-core", "qup-config";
> -				interconnects = <&clk_virt MASTER_QUP_CORE_1 0
> -						 &clk_virt SLAVE_QUP_CORE_1 0>,
> -						<&gem_noc MASTER_APPSS_PROC 0
> -						 &config_noc SLAVE_QUP_1 0>;
> -				power-domains = <&rpmhpd SA8775P_CX>;
> -				operating-points-v2 = <&qup_opp_table_100mhz>;
> -				status = "disabled";
> -			};
> -
> -			uart12: serial@a94000 {
> -				compatible = "qcom,geni-uart";
> -				reg = <0x0 0x00a94000 0x0 0x4000>;
> -				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
> -				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
> -				clock-names = "se";
> -				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
> -						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
> -						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> -						 &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>;
> -				interconnect-names = "qup-core", "qup-config";
> -				power-domains = <&rpmhpd SA8775P_CX>;
> -				status = "disabled";
> -			};
> -		};
> -
>  		qupv3_id_2: geniqup@8c0000 {
>  			compatible = "qcom,geni-se-qup";
>  			reg = <0x0 0x008c0000 0x0 0x6000>;
> @@ -585,173 +541,56 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
>  			};
>  		};
>  
> -		intc: interrupt-controller@17a00000 {
> -			compatible = "arm,gic-v3";
> -			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
> -			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
> -			interrupt-controller;
> -			#interrupt-cells = <3>;
> -			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -			#redistributor-regions = <1>;
> -			redistributor-stride = <0x0 0x20000>;
> -		};
> -
> -		memtimer: timer@17c20000 {
> -			compatible = "arm,armv7-timer-mem";
> -			reg = <0x0 0x17c20000 0x0 0x1000>;
> -			ranges = <0x0 0x0 0x0 0x20000000>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -
> -			frame@17c21000 {
> -				reg = <0x17c21000 0x1000>,
> -				      <0x17c22000 0x1000>;
> -				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> -					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> -				frame-number = <0>;
> -			};
> -
> -			frame@17c23000 {
> -				reg = <0x17c23000 0x1000>;
> -				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> -				frame-number = <1>;
> -				status = "disabled";
> -			};
> -
> -			frame@17c25000 {
> -				reg = <0x17c25000 0x1000>;
> -				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> -				frame-number = <2>;
> -				status = "disabled";
> -			};
> -
> -			frame@17c27000 {
> -				reg = <0x17c27000 0x1000>;
> -				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> -				frame-number = <3>;
> -				status = "disabled";
> -			};
> -
> -			frame@17c29000 {
> -				reg = <0x17c29000 0x1000>;
> -				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> -				frame-number = <4>;
> -				status = "disabled";
> -			};
> +		qupv3_id_1: geniqup@ac0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x0 0x00ac0000 0x0 0x6000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> +			iommus = <&apps_smmu 0x443 0x0>;
> +			status = "disabled";
>  
> -			frame@17c2b000 {
> -				reg = <0x17c2b000 0x1000>;
> -				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -				frame-number = <5>;
> +			uart10: serial@a8c000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0x0 0x00a8c000 0x0 0x4000>;
> +				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +				interconnect-names = "qup-core", "qup-config";
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0
> +						 &clk_virt SLAVE_QUP_CORE_1 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0
> +						 &config_noc SLAVE_QUP_1 0>;
> +				power-domains = <&rpmhpd SA8775P_CX>;
> +				operating-points-v2 = <&qup_opp_table_100mhz>;
>  				status = "disabled";
>  			};
>  
> -			frame@17c2d000 {
> -				reg = <0x17c2d000 0x1000>;
> -				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> -				frame-number = <6>;
> +			uart12: serial@a94000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0x0 0x00a94000 0x0 0x4000>;
> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
> +				clock-names = "se";
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
> +						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
> +						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +						 &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>;
> +				interconnect-names = "qup-core", "qup-config";
> +				power-domains = <&rpmhpd SA8775P_CX>;
>  				status = "disabled";
>  			};
>  		};
>  
> -		apps_rsc: rsc@18200000 {
> -			compatible = "qcom,rpmh-rsc";
> -			reg = <0x0 0x18200000 0x0 0x10000>,
> -			      <0x0 0x18210000 0x0 0x10000>,
> -			      <0x0 0x18220000 0x0 0x10000>;
> -			reg-names = "drv-0", "drv-1", "drv-2";
> -			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> -			      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> -			      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> -			qcom,tcs-offset = <0xd00>;
> -			qcom,drv-id = <2>;
> -			qcom,tcs-config = <ACTIVE_TCS 2>,
> -					  <SLEEP_TCS 3>,
> -					  <WAKE_TCS 3>,
> -					  <CONTROL_TCS 0>;
> -			label = "apps_rsc";
> -
> -			apps_bcm_voter: bcm-voter {
> -				compatible = "qcom,bcm-voter";
> -			};
> -
> -			rpmhcc: clock-controller {
> -				compatible = "qcom,sa8775p-rpmh-clk";
> -				#clock-cells = <1>;
> -				clock-names = "xo";
> -				clocks = <&xo_board_clk>;
> -			};
> -
> -			rpmhpd: power-controller {
> -				compatible = "qcom,sa8775p-rpmhpd";
> -				#power-domain-cells = <1>;
> -				operating-points-v2 = <&rpmhpd_opp_table>;
> -
> -				rpmhpd_opp_table: opp-table {
> -					compatible = "operating-points-v2";
> -
> -					rpmhpd_opp_ret: opp-0 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> -					};
> -
> -					rpmhpd_opp_min_svs: opp-1 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> -					};
> -
> -					rpmhpd_opp_low_svs: opp2 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> -					};
> -
> -					rpmhpd_opp_svs: opp3 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> -					};
> -
> -					rpmhpd_opp_svs_l1: opp-4 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> -					};
> -
> -					rpmhpd_opp_nom: opp-5 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> -					};
> -
> -					rpmhpd_opp_nom_l1: opp-6 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> -					};
> -
> -					rpmhpd_opp_nom_l2: opp-7 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
> -					};
> -
> -					rpmhpd_opp_turbo: opp-8 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> -					};
> -
> -					rpmhpd_opp_turbo_l1: opp-9 {
> -						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> -					};
> -				};
> -			};
> -		};
> -
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x0 0x01f40000 0x0 0x20000>;
>  			#hwlock-cells = <1>;
>  		};
>  
> -		cpufreq_hw: cpufreq@18591000 {
> -			compatible = "qcom,sa8775p-cpufreq-epss",
> -				     "qcom,cpufreq-epss";
> -			reg = <0x0 0x18591000 0x0 0x1000>,
> -			      <0x0 0x18593000 0x0 0x1000>;
> -			reg-names = "freq-domain0", "freq-domain1";
> -
> -			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
> -			clock-names = "xo", "alternate";
> -
> -			#freq-domain-cells = <1>;
> -		};
> -
>  		tlmm: pinctrl@f000000 {
>  			compatible = "qcom,sa8775p-tlmm";
>  			reg = <0x0 0x0f000000 0x0 0x1000000>;
> @@ -900,6 +739,167 @@ apps_smmu: iommu@15000000 {
>  				     <GIC_SPI 892 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 891 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> +
> +		intc: interrupt-controller@17a00000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
> +			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			#redistributor-regions = <1>;
> +			redistributor-stride = <0x0 0x20000>;
> +		};
> +
> +		memtimer: timer@17c20000 {
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0 0x17c20000 0x0 0x1000>;
> +			ranges = <0x0 0x0 0x0 0x20000000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			frame@17c21000 {
> +				reg = <0x17c21000 0x1000>,
> +				      <0x17c22000 0x1000>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <0>;
> +			};
> +
> +			frame@17c23000 {
> +				reg = <0x17c23000 0x1000>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <1>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c25000 {
> +				reg = <0x17c25000 0x1000>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <2>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c27000 {
> +				reg = <0x17c27000 0x1000>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <3>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c29000 {
> +				reg = <0x17c29000 0x1000>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <4>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c2b000 {
> +				reg = <0x17c2b000 0x1000>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <5>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c2d000 {
> +				reg = <0x17c2d000 0x1000>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <6>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		apps_rsc: rsc@18200000 {
> +			compatible = "qcom,rpmh-rsc";
> +			reg = <0x0 0x18200000 0x0 0x10000>,
> +			      <0x0 0x18210000 0x0 0x10000>,
> +			      <0x0 0x18220000 0x0 0x10000>;
> +			reg-names = "drv-0", "drv-1", "drv-2";
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +			      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +			      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,tcs-offset = <0xd00>;
> +			qcom,drv-id = <2>;
> +			qcom,tcs-config = <ACTIVE_TCS 2>,
> +					  <SLEEP_TCS 3>,
> +					  <WAKE_TCS 3>,
> +					  <CONTROL_TCS 0>;
> +			label = "apps_rsc";
> +
> +			apps_bcm_voter: bcm-voter {
> +				compatible = "qcom,bcm-voter";
> +			};
> +
> +			rpmhcc: clock-controller {
> +				compatible = "qcom,sa8775p-rpmh-clk";
> +				#clock-cells = <1>;
> +				clock-names = "xo";
> +				clocks = <&xo_board_clk>;
> +			};
> +
> +			rpmhpd: power-controller {
> +				compatible = "qcom,sa8775p-rpmhpd";
> +				#power-domain-cells = <1>;
> +				operating-points-v2 = <&rpmhpd_opp_table>;
> +
> +				rpmhpd_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					rpmhpd_opp_ret: opp-0 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> +					};
> +
> +					rpmhpd_opp_min_svs: opp-1 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> +					};
> +
> +					rpmhpd_opp_low_svs: opp2 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs: opp3 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs_l1: opp-4 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					};
> +
> +					rpmhpd_opp_nom: opp-5 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					};
> +
> +					rpmhpd_opp_nom_l1: opp-6 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					};
> +
> +					rpmhpd_opp_nom_l2: opp-7 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
> +					};
> +
> +					rpmhpd_opp_turbo: opp-8 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +					};
> +
> +					rpmhpd_opp_turbo_l1: opp-9 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		cpufreq_hw: cpufreq@18591000 {
> +			compatible = "qcom,sa8775p-cpufreq-epss",
> +				     "qcom,cpufreq-epss";
> +			reg = <0x0 0x18591000 0x0 0x1000>,
> +			      <0x0 0x18593000 0x0 0x1000>;
> +			reg-names = "freq-domain0", "freq-domain1";
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
> +			clock-names = "xo", "alternate";
> +
> +			#freq-domain-cells = <1>;
> +		};
>  	};
>  
>  	arch_timer: timer {
