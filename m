Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426C1692074
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjBJOFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjBJOFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:05:49 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB9F6ADC9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:05:46 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id hx15so16073649ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TwKpGyM1pObrC/t9G4svXAPUOoXfqNddF+FqrKvmVCk=;
        b=ZO355nCgFGmvmUoWG4xUBXdCaheWwro/F54tNyxIVMeGc9xG68K+63g3Fgre/5Akul
         M3xo2Mo0ZQLZCRIxgpb+Tz2LfaD1SRr4yAizvjAV8MJajMqe+gcwnY8BonljQDbvxWxk
         IzBbxFEclWTsSXFxWlOSGGYcHJtrHf5jK/iEKp71bNVXxNA7/volEaD2ZTo7mIw1BMk5
         glneXFmNx/fI56FvGzJ0Iw1U+TNfALRqPG2huVsLlF2KVysre+YaERgbU9xT8F43uRU3
         uLZ16sqToKlxsvmVh6A96UIiAFQsoBub4Kmn+XivgaRLDx69uAdFk7J8FRDv8QPJeezw
         7jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TwKpGyM1pObrC/t9G4svXAPUOoXfqNddF+FqrKvmVCk=;
        b=r5IOWv/IYpUnsTHLVbSKiaErkfsh51YD8aJtyN2sm3JVeUhtY3AMz1kRrEGtg6f2Sk
         PrFDXlqmFBN2H4GlF6ycZyziVR1VKzRR86wEbdBKj8TNtUIIjIm8EdhodCMERBeCHPuY
         tZteQCIR3Al04zKWynGpCe89cAbh3685PhmiKpmnfwJOVSfKpAwBS/tD4jBDFbhqvk0q
         k1aK9OIHnKUYZYk25EdyunlrSIsB/nSlQcm7vgccNuKsdAZt5yZVP7u6TNwGTRLkBWrV
         BVm/BM522sPvQxM5lIC5MSbODOUHPCvZETGxWGVDVk+SLzvMfFzx+DpRLR964Y17cf2g
         ANEA==
X-Gm-Message-State: AO0yUKUXW8izUdfbFGuIaiFuby0Usj+8vCAbEAD3R2of+ILiSMqSMkIz
        U7ODNlgnEi2zvCev/u/d5iAI6A==
X-Google-Smtp-Source: AK7set+hI41nrLZFE5W4UIlEZ20TSZ5xr2x9EktLcKCNuo4V+sJ7NVaEd+kVMdjgiJk9RJcRGW5oRg==
X-Received: by 2002:a17:906:1182:b0:86f:e30c:72c1 with SMTP id n2-20020a170906118200b0086fe30c72c1mr14069728eja.8.1676037945384;
        Fri, 10 Feb 2023 06:05:45 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id y16-20020a170906071000b0086dd8f20a6asm2415520ejb.77.2023.02.10.06.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 06:05:45 -0800 (PST)
Message-ID: <62053e82-5e92-b552-3f31-132df7adcd72@linaro.org>
Date:   Fri, 10 Feb 2023 15:05:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sc8280xp-x13s: Enable external
 display
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230209011325.2603663-1-quic_bjorande@quicinc.com>
 <20230209011325.2603663-4-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230209011325.2603663-4-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.02.2023 02:13, Bjorn Andersson wrote:
> Like on the CRD, add the necessary nodes to enable USB Type-C
> altmode-based external display on the Lenovo ThinkPad X13s.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - Fixed style and property sort issues
> - Moved dwc3/port to sc8280xp.dtsi, override remote-endpoint here
Excuse me, but I don't see that change..


> - Added pinconf properties to SBU control pins
> - Dropped unused mode-pins
> 
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 188 +++++++++++++++++-
>  1 file changed, 186 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index f936b020a71d..923972e54eb1 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -77,6 +77,78 @@ switch-lid {
>  		};
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
> +
> +				port@0 {
> +					reg = <0>;
Add a newline before the child nodes, please.

Konrad
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
> @@ -238,6 +310,46 @@ map1 {
>  			};
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
> @@ -377,6 +489,34 @@ &mdss0 {
>  	status = "okay";
>  };
>  
> +&mdss0_dp0 {
> +	data-lanes = <0 1>;
> +	status = "okay";
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
> +	data-lanes = <0 1>;
> +	status = "okay";
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
>  
> @@ -871,8 +1011,13 @@ &usb_0 {
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
> +	};
>  };
>  
>  &usb_0_hsphy {
> @@ -895,8 +1040,13 @@ &usb_1 {
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
> @@ -1147,6 +1297,40 @@ reset-n-pins {
>  		};
>  	};
>  
> +	usb0_sbu_default: usb0-sbu-state {
> +		oe-n-pins {
> +			pins = "gpio101";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strengh = <16>;
> +			output-high;
> +		};
> +
> +		sel-pins {
> +			pins = "gpio164";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strength = <16>;
> +		};
> +	};
> +
> +	usb1_sbu_default: usb1-sbu-state {
> +		oe-n-pins {
> +			pins = "gpio48";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strengh = <16>;
> +			output-high;
> +		};
> +
> +		sel-pins {
> +			pins = "gpio47";
> +			function = "gpio";
> +			bias-disable;
> +			drive-strength = <16>;
> +		};
> +	};
> +
>  	wcd_default: wcd-default-state {
>  		reset-pins {
>  			pins = "gpio106";
