Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D4168F39A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjBHQmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjBHQlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:41:39 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DB44F86C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:40:48 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gr7so52583749ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 08:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LObr7gBxJJLuAm58cDH53OW5o2VqgZ2xVXFRFbYi3SI=;
        b=wJ2jChJRBtL7dspuJpFA07C0AIH8fRDu3mXb2fBFWHnM7b6IXUyRmHQ7GAcc1rx49+
         xG5jTAZmltiv+dTMFUsjqWAr6+CcUQo9skGoMMXW7nQS18OnixpfQj23SUYZiJVGIHyu
         M7aHOGuWTe44oeQsEmwA6rLd9UDrcj9WujNCBfzetCrqJem4ltMI2V5ANoqk2wwKNLz6
         IdtZk2IqkvP81w7wKoYMl3EyNuyYrlQskXMhc97GtSnitpdrHkyjc/f6P+vyWI3Mxj7M
         SfeYYW5pIZPHq3hSR7/k12zlB9F0S3F2HGK1Cf5L5+WWNJZIbw3i07977gS5qCuSxbcx
         Ylaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LObr7gBxJJLuAm58cDH53OW5o2VqgZ2xVXFRFbYi3SI=;
        b=PDlzWdjtO28WThcTpyDv4GbVV5NgMnXwdIijOGFaiGwj1UIsaz8J+Ap/QEFZjpaU9W
         dRHtXvCt3swKQFltNDSGgIBqTN2voGZZ0KE4xMb0JC5qumZZMQQzOc+XhyyCqyp4HJ9l
         pb10iNd1xBiPpwLKe45cSGBDpaJsLOIVxx619YfglqqsSj3A00V0eftInz+7+bJgs6Eh
         JjqGE4Y3wsji8hXNzgez3Y9ASPu+NThH62+pxUd0XZiwOG+KLfwpkL58haL3qVzSZVGT
         APhl/tvnHeYnyJBfSQ2qDHkekNmDT48EuwpKzoQihMLLJmpUhc2cA9QWJ7xrmdoVzAec
         pl3g==
X-Gm-Message-State: AO0yUKXT/t9c5ncLWJTSq1pBpXJpf2DWuHhgKAmEdD1NmTthsLC56q6A
        GugKyelBr0KiLQE8Hvy03zrkdZTdEZFaD4D3
X-Google-Smtp-Source: AK7set/5VkiBitpPOdwM2VF8WFCyFN7BYkNRz3Lu6n0/nh3M/I2D+HEp6/OlYu+MrtHMczL/XG9BCA==
X-Received: by 2002:a17:906:c44e:b0:87b:daf7:e03b with SMTP id ck14-20020a170906c44e00b0087bdaf7e03bmr3216246ejb.18.1675874447021;
        Wed, 08 Feb 2023 08:40:47 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id p2-20020a170906498200b00878803d4049sm8547889eju.93.2023.02.08.08.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 08:40:46 -0800 (PST)
Message-ID: <e9b6cdcc-079d-497a-6e8b-c2d69a393597@linaro.org>
Date:   Wed, 8 Feb 2023 17:40:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230208034620.2048744-1-quic_bjorande@quicinc.com>
 <20230208034620.2048744-3-quic_bjorande@quicinc.com>
 <229edfec-736f-d94d-23ba-2a0649639556@linaro.org>
 <20230208155720.GA2397622@hu-bjorande-lv.qualcomm.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230208155720.GA2397622@hu-bjorande-lv.qualcomm.com>
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



On 8.02.2023 16:57, Bjorn Andersson wrote:
> On Wed, Feb 08, 2023 at 09:14:46AM +0100, Konrad Dybcio wrote:
>>
>>
>> On 8.02.2023 04:46, Bjorn Andersson wrote:
>>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>
>>> The SC8280XP CRD control over battery management and its two USB Type-C
>>> port using pmic_glink and two GPIO-based SBU muxes.
>>>
>>> Enable the two DisplayPort instances, GPIO SBU mux instance and
>>> pmic_glink with the two connectors on the CRD.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 191 +++++++++++++++++++++-
>>>  1 file changed, 189 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>>> index 3f116a879e22..35b63c3962f0 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>>> @@ -36,6 +36,77 @@ chosen {
>>>  		stdout-path = "serial0:115200n8";
>>>  	};
>>>  
>>> +	pmic-glink {
>>> +		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
>>> +
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		connector@0 {
>>> +			compatible = "usb-c-connector";
>>> +			reg = <0>;
>>> +			power-role = "dual";
>>> +			data-role = "dual";
>>> +
>>> +			ports {
>>> +				#address-cells = <1>;
>>> +				#size-cells = <0>;
>> Add a newline between the last propreties and first subnodes, please.
>>
>>> +				port@0 {
>>> +					reg = <0>;
>>> +					pmic_glink_con0_hs: endpoint {
>>> +						remote-endpoint = <&usb_0_role_switch>;
>>> +					};
>>> +				};
>>> +
>>> +				port@1 {
>>> +					reg = <1>;
>>> +					pmic_glink_con0_ss: endpoint {
>>> +						remote-endpoint = <&mdss0_dp0_out>;
>>> +					};
>>> +				};
>>> +
>>> +				port@2 {
>>> +					reg = <2>;
>>> +					pmic_glink_con0_sbu: endpoint {
>>> +						remote-endpoint = <&usb0_sbu_mux>;
>>> +					};
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		connector@1 {
>>> +			compatible = "usb-c-connector";
>>> +			reg = <1>;
>>> +			power-role = "dual";
>>> +			data-role = "dual";
>>> +
>>> +			ports {
>>> +				#address-cells = <1>;
>>> +				#size-cells = <0>;
>>> +				port@0 {
>>> +					reg = <0>;
>>> +					pmic_glink_con1_hs: endpoint {
>>> +						remote-endpoint = <&usb_1_role_switch>;
>>> +					};
>>> +				};
>>> +
>>> +				port@1 {
>>> +					reg = <1>;
>>> +					pmic_glink_con1_ss: endpoint {
>>> +						remote-endpoint = <&mdss0_dp1_out>;
>>> +					};
>>> +				};
>>> +
>>> +				port@2 {
>>> +					reg = <2>;
>>> +					pmic_glink_con1_sbu: endpoint {
>>> +						remote-endpoint = <&usb1_sbu_mux>;
>>> +					};
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> +
>>>  	vreg_edp_3p3: regulator-edp-3p3 {
>>>  		compatible = "regulator-fixed";
>>>  
>>> @@ -139,6 +210,46 @@ linux,cma {
>>>  			linux,cma-default;
>>>  		};
>>>  	};
>>> +
>>> +	usb0-sbu-mux {
>>> +		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
>>> +
>>> +		enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
>>> +		select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
>>> +
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&usb0_sbu_default>;
>>> +
>>> +		mode-switch;
>>> +		orientation-switch;
>>> +		svid = /bits/ 16 <0xff01>;
>>> +
>>> +		port {
>>> +			usb0_sbu_mux: endpoint {
>>> +				remote-endpoint = <&pmic_glink_con0_sbu>;
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	usb1-sbu-mux {
>>> +		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
>>> +
>>> +		enable-gpios = <&tlmm 48 GPIO_ACTIVE_LOW>;
>>> +		select-gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
>>> +
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&usb1_sbu_default>;
>>> +
>>> +		mode-switch;
>>> +		orientation-switch;
>>> +		svid = /bits/ 16 <0xff01>;
>>> +
>>> +		port {
>>> +			usb1_sbu_mux: endpoint {
>>> +				remote-endpoint = <&pmic_glink_con1_sbu>;
>>> +			};
>>> +		};
>>> +	};
>>>  };
>>>  
>>>  &apps_rsc {
>>> @@ -262,6 +373,36 @@ &mdss0 {
>>>  	status = "okay";
>>>  };
>>>  
>>> +&mdss0_dp0 {
>>> +	status = "okay";
>>> +
>>> +	data-lanes = <0 1>;
>> Status last; is this really only 2 lanes?
>>
>>> +
>>> +	ports {
>>> +		port@1 {
>>> +			reg = <1>;
>>> +			mdss0_dp0_out: endpoint {
>>> +				remote-endpoint = <&pmic_glink_con0_ss>;
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&mdss0_dp1 {
>>> +	status = "okay";
>>> +
>>> +	data-lanes = <0 1>;
>> Ditto
>>
>>> +
>>> +	ports {
>>> +		port@1 {
>>> +			reg = <1>;
>>> +			mdss0_dp1_out: endpoint {
>>> +				remote-endpoint = <&pmic_glink_con1_ss>;
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>> +
>>>  &mdss0_dp3 {
>>>  	compatible = "qcom,sc8280xp-edp";
>>>  	/delete-property/ #sound-dai-cells;
>>> @@ -480,8 +621,13 @@ &usb_0 {
>>>  };
>>>  
>>>  &usb_0_dwc3 {
>>> -	/* TODO: Define USB-C connector properly */
>>>  	dr_mode = "host";
>>> +
>>> +	port {
>>> +		usb_0_role_switch: endpoint {
>>> +			remote-endpoint = <&pmic_glink_con0_hs>;
>>> +		};
>> This should be defined in the SoC DTSI, it's a standard dwc3 binding
>> with usb HS / SS / SBU ports. Especially since we can feed the endpoint
>> from any device now, as pmic-glink should work everywhere.
>>
> 
> The sa8295p/sa8540p boards, derived from sc8280xp does not implement
> pmic_glink, so it seems moving this to the soc.dtsi would be messy.
> 
>> Or /omit-if-no-ref/, I suppose.
>>
> 
> Or you're saying I should put the skeleton of the port definition in the
> soc.dtsi and then fill it out the remote-endpoint here; and mark it
> omit-if-no-ref to avoid binding warnings?
I thought omit-if-no-ref actually omits the node before resolving phandles
that it references, but it seems to not be the case.. Still, we can define
the ports in the SoC DTSI and assign endpoints per-device (like we do with
DSI for example).

Konrad
> 
>>> +	};
>>>  };
>>>  
>>>  &usb_0_hsphy {
>>> @@ -504,8 +650,13 @@ &usb_1 {
>>>  };
>>>  
>>>  &usb_1_dwc3 {
>>> -	/* TODO: Define USB-C connector properly */
>>>  	dr_mode = "host";
>>> +
>>> +	port {
>>> +		usb_1_role_switch: endpoint {
>>> +			remote-endpoint = <&pmic_glink_con1_hs>;
>>> +		};
>>> +	};
>>>  };
>>>  
>>>  &usb_1_hsphy {
>>> @@ -709,4 +860,40 @@ reset-n-pins {
>>>  			drive-strength = <16>;
>>>  		};
>>>  	};
>>> +
>>> +	usb0_sbu_default: usb0-sbu-state {
>>> +		oe-n-pins {
>>> +			pins = "gpio101";
>>> +			function = "gpio";
>> No drive-strength/bias/i/o?
>>
> 
> Seems like a reasonable ask...
> 
> Thanks,
> Bjorn
> 
>> Konrad
>>> +		};
>>> +
>>> +		sel-pins {
>>> +			pins = "gpio164";
>>> +			function = "gpio";
>>> +		};
>>> +
>>> +		mode-pins {
>>> +			pins = "gpio167";
>>> +			function = "gpio";
>>> +			output-high;
>>> +		};
>>> +	};
>>> +
>>> +	usb1_sbu_default: usb1-sbu-state {
>>> +		oe-n-pins {
>>> +			pins = "gpio48";
>>> +			function = "gpio";
>>> +		};
>>> +
>>> +		sel-pins {
>>> +			pins = "gpio47";
>>> +			function = "gpio";
>>> +		};
>>> +
>>> +		mode-pins {
>>> +			pins = "gpio50";
>>> +			function = "gpio";
>>> +			output-high;
>>> +		};
>>> +	};
>>>  };
