Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A8629731
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiKOLUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbiKOLT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:19:58 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FCCFAF3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:19:53 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id x21so17067649ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4lKo+V+/mxDO3/qsvAi0/ZbXKoyl3LFK1hw6LW1/SD8=;
        b=Ni6gjYbZtjVFN8KdLvdVDlSwoDI41ZswrAC60GP3jV7437Wo0E5qhMPq4QHGz8cCSt
         +kAsWdipvjGZY1J2qOyiSnvYZsH3hsIiNVelr0n04FvVB7umXE+DRoXwQps8tyVl1TcW
         NRH3K0yL/PAqPrTfN3KlPOP/uX63BiFSBMapGzjbhVo1Y+pjJ1OYVnBMCLFP7mQjcblH
         vnq7zjFcYy21+I4hR39J3fOKewlfvbwjNPQv6xwugCA0VLa65UDt3iXTE0g4iDs0RHTi
         Nx9jURgrKi0/d/lAxEQL28dNfsonGf1pYGFEWbyxLVO8FIUoNfoR7pQL4/b4UOmhhi/1
         bMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lKo+V+/mxDO3/qsvAi0/ZbXKoyl3LFK1hw6LW1/SD8=;
        b=zfyebXxtgdf+2jiiIfCBU2SbRJ8trFjnq+H9ehDVHWrWihmA8z95AimYAmyFlYEK4X
         0lTtWzKmyq4PicQPUynkbbs/vJxpCyPiWPlBMO1DV4d+SWc/vDJqLZRuEQ2qgXZYk6Z3
         AhZcgootNHMCgMoQh2UU0ou0rVDClkfyYV33e6Pa8PIZh1JX0mvC4BHiLIHh9Xo1OtGJ
         U2bELqGdNzGS+8QoVuQ2ruqEvItnOeTO2OrPxtMEkD1JmwgPD6Zc0Fm+Gf3AIBnfxzVC
         cahR+7eitbB4FEaUNpcdz5QE13knI+CtYcShadV1gQ/aRjlOTQ2M/ZKvnfRBEcvivQ4J
         ZbmA==
X-Gm-Message-State: ANoB5pkg7JHua/snRK4cHLrMjbmbLw7f7Ut6NTUMnAxy+X85drQjd4B1
        NWYTo5E0KQZ/pgojTTXgtUYj8A==
X-Google-Smtp-Source: AA0mqf5X3GLTOwnVF3dsvfXWXrL8B0nguCYLMx/GK80WZHGuGrNNrShlI1/bwnNFEU7NAoyrYWGeeA==
X-Received: by 2002:a2e:94cb:0:b0:277:3df:90d0 with SMTP id r11-20020a2e94cb000000b0027703df90d0mr5512248ljh.234.1668511191641;
        Tue, 15 Nov 2022 03:19:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a10-20020a056512020a00b004a45f2e49b1sm2160514lfo.273.2022.11.15.03.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 03:19:51 -0800 (PST)
Message-ID: <e98df1b0-b91e-ff15-d20a-487d513d70f6@linaro.org>
Date:   Tue, 15 Nov 2022 12:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8450: add Soundwire and LPASS
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221115110053.110319-1-krzysztof.kozlowski@linaro.org>
 <20221115110053.110319-3-krzysztof.kozlowski@linaro.org>
 <4045756e-eff8-bdbe-7165-e21d28504cab@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4045756e-eff8-bdbe-7165-e21d28504cab@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 12:17, Konrad Dybcio wrote:
> 
> 
> On 15/11/2022 12:00, Krzysztof Kozlowski wrote:
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
>> Changes since v1:
>> 1. Whitespace cleanups.
>> 2. Correct include - do not use deprecated one.
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 295 +++++++++++++++++++++++++++
>>   1 file changed, 295 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 4b0a1eee8bd9..e80a7d09646f 100644
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
>> +			qcom,ports-hstart =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
>> +			qcom,ports-hstop =		/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
>> +			qcom,ports-word-length =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
>> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xFF 0xFF 0x01 0xFF 0xFF 0x01 0xFF 0xFF>;
>> +			qcom,ports-block-group-count =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
>> +			qcom,ports-lane-control =	/bits/ 8 <0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF>;
> You didn't normalize the constants to be all-uppercase or all-lowercase.
> I think lowercase is what's generally used in DTs.
> 
> The rest looks good though.

Uh, yeah, you said it last time. Sorry, I missed to implement it.


Best regards,
Krzysztof

