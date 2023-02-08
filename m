Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93F768E9A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBHIPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBHIO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:14:58 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1505743460
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:14:51 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id hx15so49110265ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 00:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sgjeZUW23x9Z3Uo5qQXOs6aPRbzAd52gyL69E20+ngU=;
        b=uLWOMzSiwNBioOlbVEGMS9FGagzk72mOcQTKDTQZmfTuatJYtmIzeMdIga9WLbOTY4
         1sY3TXQIelTaniBhNUwvrIg6ErwQi0StnrE7qFtF9TRHbcuD/epjd/sfU7K4mtDsvHeV
         j2VOoGZkK/GCudBF1f7YDaED0llItzC3PbvNAPmsXckXGtDgP/qo7uJnIchbknNcSoJp
         hRItzeg0u8GUyzOCrelytvNndPMCY3tWy/vMEs/WvsxgGTdAYBI74Dl9nlhDvnERa5xM
         Dx9eESxUM2dPVdwfD+ZVhHtPlXfKfLk5LQYyE6NuSLZsaVX0rePRlnoiQdAkHeG9Pi21
         jv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sgjeZUW23x9Z3Uo5qQXOs6aPRbzAd52gyL69E20+ngU=;
        b=5CktbpCwZKlOV6DUbui3R1GuiHTd24QBGdlad1aJ5lrk8o2IAQl8H7Vosu6KTBPVzz
         7ugx3rOMU6zNrL+LB3LLpjvnA3uO5bwunk2/DtUTQ6RInDaUdKpz/T45/FegX4o//6wc
         6TyMC5BYSU8RtQ5Wix/8O7DPIRCim7bJPsJwgxjGCSaAPykeuGrP2STg/UN5hGvs+ahE
         z5vyqME9kW6cNRV2do4mkBhJAuInPR/O41CHNAuFDwtIygSgHVqIX5L/S2+HpB6wqhUw
         o5MJAUvs+dImgq+UZe5W45r4LtXD/k8FPRHxbTV/wZX4975r2e6y9undGf8u+1r+JDZ0
         XopA==
X-Gm-Message-State: AO0yUKUxvrZU5eMNVfn0Fl+Cj8eAWZ3jbv0SeoGzZ/C/BZx7WUfknXJP
        Mea8WFbipuUwRa2+fTUC77MEvg==
X-Google-Smtp-Source: AK7set+6fn3VZiirH+RgWcqt5ou2B/TdQ8+XHS+DrNdd+dPx/PKhtmhswmFfaa5OnRquBRwg8vqisA==
X-Received: by 2002:a17:906:b2cc:b0:878:5917:601 with SMTP id cf12-20020a170906b2cc00b0087859170601mr6836543ejb.58.1675844089408;
        Wed, 08 Feb 2023 00:14:49 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id h14-20020a170906590e00b00888161349desm7936059ejq.182.2023.02.08.00.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 00:14:48 -0800 (PST)
Message-ID: <229edfec-736f-d94d-23ba-2a0649639556@linaro.org>
Date:   Wed, 8 Feb 2023 09:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230208034620.2048744-1-quic_bjorande@quicinc.com>
 <20230208034620.2048744-3-quic_bjorande@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230208034620.2048744-3-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.02.2023 04:46, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The SC8280XP CRD control over battery management and its two USB Type-C
> port using pmic_glink and two GPIO-based SBU muxes.
> 
> Enable the two DisplayPort instances, GPIO SBU mux instance and
> pmic_glink with the two connectors on the CRD.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 191 +++++++++++++++++++++-
>  1 file changed, 189 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 3f116a879e22..35b63c3962f0 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -36,6 +36,77 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	pmic-glink {
> +		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
Add a newline between the last propreties and first subnodes, please.

> +				port@0 {
> +					reg = <0>;
> +					pmic_glink_con0_hs: endpoint {
> +						remote-endpoint = <&usb_0_role_switch>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					pmic_glink_con0_ss: endpoint {
> +						remote-endpoint = <&mdss0_dp0_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					pmic_glink_con0_sbu: endpoint {
> +						remote-endpoint = <&usb0_sbu_mux>;
> +					};
> +				};
> +			};
> +		};
> +
> +		connector@1 {
> +			compatible = "usb-c-connector";
> +			reg = <1>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				port@0 {
> +					reg = <0>;
> +					pmic_glink_con1_hs: endpoint {
> +						remote-endpoint = <&usb_1_role_switch>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +					pmic_glink_con1_ss: endpoint {
> +						remote-endpoint = <&mdss0_dp1_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +					pmic_glink_con1_sbu: endpoint {
> +						remote-endpoint = <&usb1_sbu_mux>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	vreg_edp_3p3: regulator-edp-3p3 {
>  		compatible = "regulator-fixed";
>  
> @@ -139,6 +210,46 @@ linux,cma {
>  			linux,cma-default;
>  		};
>  	};
> +
> +	usb0-sbu-mux {
> +		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
> +
> +		enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
> +		select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb0_sbu_default>;
> +
> +		mode-switch;
> +		orientation-switch;
> +		svid = /bits/ 16 <0xff01>;
> +
> +		port {
> +			usb0_sbu_mux: endpoint {
> +				remote-endpoint = <&pmic_glink_con0_sbu>;
> +			};
> +		};
> +	};
> +
> +	usb1-sbu-mux {
> +		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
> +
> +		enable-gpios = <&tlmm 48 GPIO_ACTIVE_LOW>;
> +		select-gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb1_sbu_default>;
> +
> +		mode-switch;
> +		orientation-switch;
> +		svid = /bits/ 16 <0xff01>;
> +
> +		port {
> +			usb1_sbu_mux: endpoint {
> +				remote-endpoint = <&pmic_glink_con1_sbu>;
> +			};
> +		};
> +	};
>  };
>  
>  &apps_rsc {
> @@ -262,6 +373,36 @@ &mdss0 {
>  	status = "okay";
>  };
>  
> +&mdss0_dp0 {
> +	status = "okay";
> +
> +	data-lanes = <0 1>;
Status last; is this really only 2 lanes?

> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss0_dp0_out: endpoint {
> +				remote-endpoint = <&pmic_glink_con0_ss>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss0_dp1 {
> +	status = "okay";
> +
> +	data-lanes = <0 1>;
Ditto

> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss0_dp1_out: endpoint {
> +				remote-endpoint = <&pmic_glink_con1_ss>;
> +			};
> +		};
> +	};
> +};
> +
>  &mdss0_dp3 {
>  	compatible = "qcom,sc8280xp-edp";
>  	/delete-property/ #sound-dai-cells;
> @@ -480,8 +621,13 @@ &usb_0 {
>  };
>  
>  &usb_0_dwc3 {
> -	/* TODO: Define USB-C connector properly */
>  	dr_mode = "host";
> +
> +	port {
> +		usb_0_role_switch: endpoint {
> +			remote-endpoint = <&pmic_glink_con0_hs>;
> +		};
This should be defined in the SoC DTSI, it's a standard dwc3 binding
with usb HS / SS / SBU ports. Especially since we can feed the endpoint
from any device now, as pmic-glink should work everywhere.

Or /omit-if-no-ref/, I suppose.

> +	};
>  };
>  
>  &usb_0_hsphy {
> @@ -504,8 +650,13 @@ &usb_1 {
>  };
>  
>  &usb_1_dwc3 {
> -	/* TODO: Define USB-C connector properly */
>  	dr_mode = "host";
> +
> +	port {
> +		usb_1_role_switch: endpoint {
> +			remote-endpoint = <&pmic_glink_con1_hs>;
> +		};
> +	};
>  };
>  
>  &usb_1_hsphy {
> @@ -709,4 +860,40 @@ reset-n-pins {
>  			drive-strength = <16>;
>  		};
>  	};
> +
> +	usb0_sbu_default: usb0-sbu-state {
> +		oe-n-pins {
> +			pins = "gpio101";
> +			function = "gpio";
No drive-strength/bias/i/o?

Konrad
> +		};
> +
> +		sel-pins {
> +			pins = "gpio164";
> +			function = "gpio";
> +		};
> +
> +		mode-pins {
> +			pins = "gpio167";
> +			function = "gpio";
> +			output-high;
> +		};
> +	};
> +
> +	usb1_sbu_default: usb1-sbu-state {
> +		oe-n-pins {
> +			pins = "gpio48";
> +			function = "gpio";
> +		};
> +
> +		sel-pins {
> +			pins = "gpio47";
> +			function = "gpio";
> +		};
> +
> +		mode-pins {
> +			pins = "gpio50";
> +			function = "gpio";
> +			output-high;
> +		};
> +	};
>  };
