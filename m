Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B9762BBE9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiKPL1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239306AbiKPL1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:27:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F5648772
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:17:40 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z18so26035156edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6FBVuaNcgYE9TpGhXZnNgXgw+q9HRa9+1FBHZRkSlI=;
        b=Aio+ikiUd1IME8lwqmNXpJHmSRcpX8HLZLyJxfjtJPJzYGrBvDHT10yyUteRT8F9on
         L22X8Yk/4eCgq/REaOzifQ3yyjq6WDbK48SSa1541n9vYjsOa7JVxXIV26TMhtL7jLn1
         P9cnG1aKT+esNfCKrgVNvWrH1BnzEFxxXtCvDrPASi1HFdb2525dFMwrICEeJxgWaLJO
         dtoXN5b2VQBMd2O0Bn7L1R/FAWcHJOnnX9ANoSxN39X/C6f/Ek/rjAbaNxxcEtQMsaFv
         Yy+8gqKzqCjN+AqYXuXdvcuwNuKs7QnDkyN2sr5gc5Pd1+5pVGedxLfmfZmYTXn5AZuJ
         f9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h6FBVuaNcgYE9TpGhXZnNgXgw+q9HRa9+1FBHZRkSlI=;
        b=JADKAmih7G2hbSP5O+4gtDUDdI2K1+JxV5n3RVeSCkVqFnUI7TTHh4tvrCs6NGlu+W
         ymPN+cjwRSuUG3gxg47geGXvQEfuY1YOFmVehMFVuTsZ6RrsiFvzibLDW8hmE0QOK5N9
         D7dKdgrurS+bf6LWIvYgNwokKXYz+9hQEAA1xevOhYdld8lz47Ig3MATEKZRMMWhq2K8
         lKH4rlSXArTmc5wR+4AsoEMy5ClmRtD7rrlv3s9SQZf0MvxUwxWkOs3iUEC/lMbeSZIu
         EtRVhw5N6ZJMNeb5NkMH4uDkOrzCRKEsi1grFwXSPw7hcaIWjwIs4mk8SQLdj0GjGk6J
         51wA==
X-Gm-Message-State: ANoB5pkVQyvv16xpPGonHT7jnrBiLdRjGqX7cY5LekD+YreAFUHqcADH
        Z9y4F6yTHI2Wu3xXHFOq0WnpUg==
X-Google-Smtp-Source: AA0mqf76To+GPD2WhRt0+pnqyavhRA9ldPGOGBncYFd7Zo1zmmQ2eKDqff0D23dZudP6KWrHwVf5iQ==
X-Received: by 2002:a05:6402:c10:b0:461:9193:7278 with SMTP id co16-20020a0564020c1000b0046191937278mr19182535edb.220.1668597458559;
        Wed, 16 Nov 2022 03:17:38 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906315400b0077b2b0563f4sm6810643eje.173.2022.11.16.03.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:17:38 -0800 (PST)
Message-ID: <1ce84668-5f21-5e62-6a02-be7c6e79012e@linaro.org>
Date:   Wed, 16 Nov 2022 12:17:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8450: add Soundwire and LPASS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <bde68c28-bf4c-405f-ef2a-f56db7654d25@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <bde68c28-bf4c-405f-ef2a-f56db7654d25@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 16/11/2022 11:40, Krzysztof Kozlowski wrote:
> On 16/11/2022 11:20, Konrad Dybcio wrote:
>>
>>
>> On 16/11/2022 11:13, Krzysztof Kozlowski wrote:
>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>
>>> Add Soundwire controllers, Low Power Audio SubSystem (LPASS) devices and
>>> LPASS pin controller.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> Changes since v2:
>>> 1. Use lower-case hex.
>>>
>>> Changes since v1:
>>> 1. Whitespace cleanups.
>>> 2. Correct include - do not use deprecated one.
>>> ---
>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 295 +++++++++++++++++++++++++++
>>>    1 file changed, 295 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> index 4b0a1eee8bd9..747440d0445a 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> @@ -15,6 +15,7 @@
>>>    #include <dt-bindings/interconnect/qcom,sm8450.h>
>>>    #include <dt-bindings/soc/qcom,gpr.h>
>>>    #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>>>    #include <dt-bindings/thermal/thermal.h>
>>>    
>>>    / {
>>> @@ -2097,6 +2098,212 @@ compute-cb@3 {
>>>    			};
>>>    		};
>>>    
>>> +		wsa2macro: codec@31e0000 {
>>> +			compatible = "qcom,sm8450-lpass-wsa-macro";
>>> +			reg = <0 0x031e0000 0 0x1000>;
>>> +			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&vamacro>;
>>> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
>>> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>>> +			assigned-clock-rates = <19200000>, <19200000>;
>>> +
>>> +			#clock-cells = <0>;
>>> +			clock-output-names = "wsa2-mclk";
>>> +			#sound-dai-cells = <1>;
>> I think I'm being a bit too picky, but #-cells could go as the last
>> bunch of properties.
> 
> I was thinking about this as well, but some of other codecs which are
> very similar (also "macro") do not have pinctrls and this makes them
> unified with additions at the end.
> 
> Are you sure you still prefer alphabetical order?
Thinking about it, IMO it makes sense to add things "roughly where they 
belong", a.k.a if there was a codec that for whatever reason also 
required a power domain, we would stick it somewhere in the middle and 
not at the end..


> 
>>
>>
>>> +
>>> +			pinctrl-names = "default";
>>> +			pinctrl-0 = <&wsa2_swr_active>;
>>> +		};
>>> +
>>> +		/* WSA2 */
>>> +		swr4: soundwire-controller@31f0000 {
>>> +			reg = <0 0x031f0000 0 0x2000>;
>>> +			compatible = "qcom,soundwire-v1.7.0";
>>> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&wsa2macro>;
>>> +			clock-names = "iface";
>>> +
>>> +			qcom,din-ports = <2>;
>>> +			qcom,dout-ports = <6>;
>>> +
>>> +			qcom,ports-sinterval-low =	/bits/ 8 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x0f 0x0f>;
>>> +			qcom,ports-offset1 =		/bits/ 8 <0x01 0x02 0x0c 0x06 0x12 0x0d 0x07 0x0a>;
>>> +			qcom,ports-offset2 =		/bits/ 8 <0xff 0x00 0x1f 0xff 0x00 0x1f 0x00 0x00>;
>>> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>>> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>>> +			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>>> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0x01 0xff 0xff 0x01 0xff 0xff>;
>>> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>>> +			qcom,ports-lane-control =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>>> +
>>> +			#sound-dai-cells = <1>;
>>> +			#address-cells = <2>;
>>> +			#size-cells = <0>;
>>> +		};
>>> +
>>> +		rxmacro: codec@3200000 {
>>> +			compatible = "qcom,sm8450-lpass-rx-macro";
>>> +			reg = <0 0x3200000 0 0x1000>;
>>> +			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&vamacro>;
>>> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
>>> +
>>> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>>> +			assigned-clock-rates = <19200000>, <19200000>;
>>> +
>>> +			#clock-cells = <0>;
>>> +			clock-output-names = "mclk";
>>> +			#sound-dai-cells = <1>;
>>> +
>>> +			pinctrl-names = "default";
>>> +			pinctrl-0 = <&rx_swr_active>;
>>> +		};
>>> +
>>> +		swr1: soundwire-controller@3210000 {
>>> +			reg = <0 0x3210000 0 0x2000>;
>>> +			compatible = "qcom,soundwire-v1.7.0";
>> Some nodes have reg and compatible flipped.
> 
> Ack
> 
>>
>>> +			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>>> +			clocks = <&rxmacro>;
>>> +			clock-names = "iface";
>>> +			label = "RX";
>>> +			qcom,din-ports = <0>;
>>> +			qcom,dout-ports = <5>;
>>> +
> 
> 
> (...)
> 
>>>    		apps_smmu: iommu@15000000 {
>>>    			compatible = "qcom,sm8450-smmu-500", "arm,mmu-500";
>>>    			reg = <0 0x15000000 0 0x100000>;
>>> @@ -3507,6 +3799,9 @@ lpass_ag_noc: interconnect@3c40000 {
>>>    		};
>>>    	};
>>>    
>>> +	sound: sound {
>>> +	};
>> You asked another folk working on sa8540p to not include sound in the
>> SoC dtsi.
> 
> I asked not to put it in soc node. It can be in DTSI, but not under soc.
Oh okay, then I misread that, sorry.


Konrad
> 
> Best regards,
> Krzysztof
> 
