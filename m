Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2596F6C74
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjEDMz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjEDMzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:55:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A83D7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:55:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f315735514so62020415e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683204921; x=1685796921;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TwKH5OHkDV/MpZ9yrdw81ApCoAA4gk5I47srjkhQU+0=;
        b=YpPw9mHfAJxQ6CjbhpKohzqG56cQCfKAsDGoAtpjQT/Ev9QAxQYnrL4ZV1Askhy9PI
         T941FhMz6i+3/qDiHy4zFYgu3EIVivdVq7QIyouI2OKNpDAzqG2H4XhR0cd+3FR+yJcw
         hjBqp7/5UVTKhenkIVvXOYwzXB/HzQJHyif3BM1SWkUolIv+S+e6ddSWctMztZ9tzcWP
         W4W6beeMjzo4XVjpMQxo0hhE0k3TZFuq9PTu5jBsqSfugZT8LlPCIQHgHIYVKB42VZfs
         9sjcq+T0ekua36zu4GAL4svoSk8byRqO9AkRxKEDPQZA4IL2jc90PlkTy6FBtxwVK2a4
         xdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683204921; x=1685796921;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwKH5OHkDV/MpZ9yrdw81ApCoAA4gk5I47srjkhQU+0=;
        b=HLY25x9JHf4LbM4va17vXNq3LjvyQkWtUt7hBgXjyYFHKzt09MBAT1WrM98X16Sv3Y
         2I5AcLQUR35dU3asxdUTUqu7cX4XTePeTRGPAhfm8i0XNkvZBEz/+NsWQVoxbEILlwbj
         bmWlZEz/QflqoktbfuNwlsFpdO8PC0In0HJ1jTAw0CP8qI4y7V9HHa4hhO+t27QdF51Y
         GMeRG1gfSfk2yHPXyLO/6F0IEM4z2e60i9mR5c+1xGui8Ik5N6f0HkyqTddzb6d6NSSi
         7VZ43zFpJqg/OkrBkQgc422U4fGsDgK64Q4usAaIKsO/WQ81Qocu+cO0TGpiAaHKN8r8
         ok3g==
X-Gm-Message-State: AC+VfDwd8TlYIwcFVQMJ+tAicApOTEVoyUD46JEJrG7+xA3NMSnhMNDE
        NAJValEwup1ORENiVuPyyS36hw==
X-Google-Smtp-Source: ACHHUZ6CDWxhk+dhSH8qLQE79fBassliV0GQlKPgAAM0MVDziCfBXEKP0mKuYXtpd45JN7ujvYKCxw==
X-Received: by 2002:a5d:61d1:0:b0:306:2be3:6d40 with SMTP id q17-20020a5d61d1000000b003062be36d40mr2268666wrv.35.1683204920678;
        Thu, 04 May 2023 05:55:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:52fb:80bd:bee3:f741? ([2a01:e0a:982:cbb0:52fb:80bd:bee3:f741])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d63cb000000b003062cdc6ac5sm11554084wrw.89.2023.05.04.05.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 05:55:20 -0700 (PDT)
Message-ID: <b18a22c0-2cc2-d361-262c-2e5cf802641b@linaro.org>
Date:   Thu, 4 May 2023 14:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sm8350-hdk: Add QMP & DP to
 SuperSpeed graph
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230503-topic-sm8450-graphics-dp-next-v1-0-d1ee9397f2a6@linaro.org>
 <20230503-topic-sm8450-graphics-dp-next-v1-3-d1ee9397f2a6@linaro.org>
 <c985201e-6916-1ad8-4a11-cfc3bc288733@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <c985201e-6916-1ad8-4a11-cfc3bc288733@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 08:53, Konrad Dybcio wrote:
> 
> 
> On 3.05.2023 15:10, Neil Armstrong wrote:
>> With support for the QMP combo phy to react to USB Type-C switch events,
>> introduce it as the next hop for the SuperSpeed lanes of the Type-C
>> connector, and connect the output of the DisplayPort controller
>> to the QMP combo phy.
>>
>> This allows the TCPM to perform orientation switching of both USB and
>> DisplayPort signals.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 74 ++++++++++++++++++++++++++++++++-
>>   1 file changed, 72 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
>> index 2ee1b121686a..fa835bdb7408 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
>> @@ -58,7 +58,15 @@ port@1 {
>>   					reg = <1>;
>>   
>>   					pmic_glink_ss_in: endpoint {
>> -						remote-endpoint = <&usb_1_dwc3_ss>;
>> +						remote-endpoint = <&usb_1_qmpphy_out>;
>> +					};
>> +				};
>> +
>> +				port@2 {
>> +					reg = <2>;
>> +
>> +					pmic_glink_sbu: endpoint {
>> +						remote-endpoint = <&fsa4480_sbu_mux>;
>>   					};
>>   				};
>>   			};
>> @@ -326,6 +334,36 @@ zap-shader {
>>   	};
>>   };
>>   
>> +&i2c13 {
>> +	status = "okay";
>> +	clock-frequency = <100000>;
> Status last

Ack

> 
>> +
>> +	fsa4480@42 {
>> +		compatible = "fcs,fsa4480";
>> +		reg = <0x42>;
>> +
>> +		interrupts-extended = <&tlmm 2 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +		vcc-supply = <&vreg_bob>;
>> +		mode-switch;
>> +		orientation-switch;
>> +		svid = /bits/ 16 <0xff01>;
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +
>> +				fsa4480_sbu_mux: endpoint {
>> +					remote-endpoint = <&pmic_glink_sbu>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>   &i2c15 {
>>   	clock-frequency = <400000>;
>>   	status = "okay";
>> @@ -370,6 +408,20 @@ &mdss {
>>   	status = "okay";
>>   };
>>   
>> +&mdss_dp {
>> +	status = "okay";
>> +
>> +	ports {
>> +		port@1 {
>> +			reg = <1>;
> missing newline
> 
>> +			mdss_dp0_out: endpoint {
>> +				data-lanes = <0 1>;
>> +				remote-endpoint = <&usb_1_qmpphy_dp_in>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>   &mdss_mdp {
>>   	status = "okay";
>>   };
>> @@ -416,6 +468,10 @@ &qupv3_id_0 {
>>   	status = "okay";
>>   };
>>   
>> +&qupv3_id_1 {
>> +	status = "okay";
>> +};
>> +
>>   &qupv3_id_2 {
>>   	status = "okay";
>>   };
>> @@ -716,7 +772,7 @@ &usb_1_dwc3_hs {
>>   };
>>   
>>   &usb_1_dwc3_ss {
>> -	remote-endpoint = <&pmic_glink_ss_in>;
>> +	remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
>>   };
>>   
>>   &usb_1_hsphy {
>> @@ -732,6 +788,20 @@ &usb_1_qmpphy {
>>   
>>   	vdda-phy-supply = <&vreg_l6b_1p2>;
>>   	vdda-pll-supply = <&vreg_l1b_0p88>;
>> +
>> +	orientation-switch;
> this is a common property which will/should be ignored if no
> usbc is present

So, do you mean it should be in the common dtsi ? I don't see why since
it's only true if there's an USB-C connector

> 
>> +};
>> +
>> +&usb_1_qmpphy_out {
>> +	remote-endpoint = <&pmic_glink_ss_in>;
>> +};
>> +
>> +&usb_1_qmpphy_usb_ss_in {
>> +	remote-endpoint = <&usb_1_dwc3_ss>;
>> +};
>> +
>> +&usb_1_qmpphy_dp_in {
>> +	remote-endpoint = <&mdss_dp0_out>;
> 'd' < 'o' < 'u'
Exact...

> 
> with that fixed
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
>>   };
>>   
>>   &usb_2 {
>>

