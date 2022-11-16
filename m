Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D53462BA24
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiKPKwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiKPKvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:51:47 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08A253EC0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:40:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d6so28801105lfs.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IrEmjsTbAyDmmBQzrCearRz15mEY8+dkhhS8wuiqwIc=;
        b=oSPKtTYfLJybeX72768VldvDuwzRqmwegGx3Q/jvM4rkT8co9OSV8XP1mfBHMzuUlY
         +eGzAuWYXDhYvUbqo01ynO7+8PpciToTFiNkT/QNIWB2ObZDbP1/dIEwmFySUJVjxhcz
         jjrSGQh8o+mlJOQtlkfO6BJRqVSxK5grVINXAtOUm+iue4wfzKp35C2KEwc4+yhQWD+t
         6J71QxRe4Q49zrHO+QaX6n0siUuAyp8JefBkky73ppwVhvgL/1eGG3pmxjPJ5z5DL5Rv
         I9MhKS1ssVKEfAJKV2ZC+dx+B5c2OgyEcLID+XtlVFMBfJFdHyhUEZxVpkmw0YnB7GrS
         CO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrEmjsTbAyDmmBQzrCearRz15mEY8+dkhhS8wuiqwIc=;
        b=H210lbgOFmK4EhfsIWvpg2rxRhp4ge07u1GWrKKGEzunrVEQnqxJ+TitpQN3KMNLHW
         +0/pV5Mg7JSNVNBeAX20zo7QQtH6XrBdqM7LG4lvEaGw/NNj2WT3JmPx+sLl6+dEDt8i
         +lrVCS9WW4pbQTGN1OvE3RQk/8wjhWJfHIbzeS6X7tns+9jgc3RHfwScqVauFdBZzSYa
         7Z/jbHDwNI3WFwn/aC9ITp1ue1V5xoGuGcQpDa7fqoJM8+lSrQTIegEwdAevTOsPpaFC
         CqHp49PKs+SnnQK7rqtcaZUNGj9BhGUx9T6PJyAU2Tu4Xsn1CWFUfpquUrjSGNfe9o51
         Lftg==
X-Gm-Message-State: ANoB5pkwUaP1DWLNyy3rcs01jg/f1TfTqu3E7FXK58LC64YV6SAJeDQZ
        B87RVE+vTFFlUv+CaB756wd6CSaZFV5QIHDx
X-Google-Smtp-Source: AA0mqf6kAVPGcxhQm2lTBQE3ixDmuOtL3+QW0/MU0REJATG9RTcN14q9xz0kF+rwktinT6xgfQfQXg==
X-Received: by 2002:a19:911a:0:b0:4a2:7e2a:d2e1 with SMTP id t26-20020a19911a000000b004a27e2ad2e1mr7921522lfd.641.1668595234329;
        Wed, 16 Nov 2022 02:40:34 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o20-20020ac25e34000000b004b40c2fccfdsm2542042lfg.59.2022.11.16.02.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 02:40:33 -0800 (PST)
Message-ID: <bde68c28-bf4c-405f-ef2a-f56db7654d25@linaro.org>
Date:   Wed, 16 Nov 2022 11:40:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8450: add Soundwire and LPASS
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221116101314.52887-1-krzysztof.kozlowski@linaro.org>
 <20221116101314.52887-3-krzysztof.kozlowski@linaro.org>
 <7605af5f-a828-5df7-48b8-b543edb0f9b1@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7605af5f-a828-5df7-48b8-b543edb0f9b1@linaro.org>
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

On 16/11/2022 11:20, Konrad Dybcio wrote:
> 
> 
> On 16/11/2022 11:13, Krzysztof Kozlowski wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Add Soundwire controllers, Low Power Audio SubSystem (LPASS) devices and
>> LPASS pin controller.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes since v2:
>> 1. Use lower-case hex.
>>
>> Changes since v1:
>> 1. Whitespace cleanups.
>> 2. Correct include - do not use deprecated one.
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 295 +++++++++++++++++++++++++++
>>   1 file changed, 295 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 4b0a1eee8bd9..747440d0445a 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -15,6 +15,7 @@
>>   #include <dt-bindings/interconnect/qcom,sm8450.h>
>>   #include <dt-bindings/soc/qcom,gpr.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>>   #include <dt-bindings/thermal/thermal.h>
>>   
>>   / {
>> @@ -2097,6 +2098,212 @@ compute-cb@3 {
>>   			};
>>   		};
>>   
>> +		wsa2macro: codec@31e0000 {
>> +			compatible = "qcom,sm8450-lpass-wsa-macro";
>> +			reg = <0 0x031e0000 0 0x1000>;
>> +			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +				 <&vamacro>;
>> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
>> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>> +			assigned-clock-rates = <19200000>, <19200000>;
>> +
>> +			#clock-cells = <0>;
>> +			clock-output-names = "wsa2-mclk";
>> +			#sound-dai-cells = <1>;
> I think I'm being a bit too picky, but #-cells could go as the last 
> bunch of properties.

I was thinking about this as well, but some of other codecs which are
very similar (also "macro") do not have pinctrls and this makes them
unified with additions at the end.

Are you sure you still prefer alphabetical order?

> 
> 
>> +
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&wsa2_swr_active>;
>> +		};
>> +
>> +		/* WSA2 */
>> +		swr4: soundwire-controller@31f0000 {
>> +			reg = <0 0x031f0000 0 0x2000>;
>> +			compatible = "qcom,soundwire-v1.7.0";
>> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&wsa2macro>;
>> +			clock-names = "iface";
>> +
>> +			qcom,din-ports = <2>;
>> +			qcom,dout-ports = <6>;
>> +
>> +			qcom,ports-sinterval-low =	/bits/ 8 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x0f 0x0f>;
>> +			qcom,ports-offset1 =		/bits/ 8 <0x01 0x02 0x0c 0x06 0x12 0x0d 0x07 0x0a>;
>> +			qcom,ports-offset2 =		/bits/ 8 <0xff 0x00 0x1f 0xff 0x00 0x1f 0x00 0x00>;
>> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>> +			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0x01 0xff 0xff 0x01 0xff 0xff>;
>> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>> +			qcom,ports-lane-control =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>> +
>> +			#sound-dai-cells = <1>;
>> +			#address-cells = <2>;
>> +			#size-cells = <0>;
>> +		};
>> +
>> +		rxmacro: codec@3200000 {
>> +			compatible = "qcom,sm8450-lpass-rx-macro";
>> +			reg = <0 0x3200000 0 0x1000>;
>> +			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +				 <&vamacro>;
>> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
>> +
>> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>> +			assigned-clock-rates = <19200000>, <19200000>;
>> +
>> +			#clock-cells = <0>;
>> +			clock-output-names = "mclk";
>> +			#sound-dai-cells = <1>;
>> +
>> +			pinctrl-names = "default";
>> +			pinctrl-0 = <&rx_swr_active>;
>> +		};
>> +
>> +		swr1: soundwire-controller@3210000 {
>> +			reg = <0 0x3210000 0 0x2000>;
>> +			compatible = "qcom,soundwire-v1.7.0";
> Some nodes have reg and compatible flipped.

Ack

> 
>> +			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&rxmacro>;
>> +			clock-names = "iface";
>> +			label = "RX";
>> +			qcom,din-ports = <0>;
>> +			qcom,dout-ports = <5>;
>> +


(...)

>>   		apps_smmu: iommu@15000000 {
>>   			compatible = "qcom,sm8450-smmu-500", "arm,mmu-500";
>>   			reg = <0 0x15000000 0 0x100000>;
>> @@ -3507,6 +3799,9 @@ lpass_ag_noc: interconnect@3c40000 {
>>   		};
>>   	};
>>   
>> +	sound: sound {
>> +	};
> You asked another folk working on sa8540p to not include sound in the 
> SoC dtsi.

I asked not to put it in soc node. It can be in DTSI, but not under soc.

Best regards,
Krzysztof

