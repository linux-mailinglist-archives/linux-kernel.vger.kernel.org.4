Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929E972614C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbjFGNbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbjFGNbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:31:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204DE198C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:31:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso73838005e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686144678; x=1688736678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1M24Nb0Jfn6VdAiAglm1uA5NvezRPZanQjJa6TxIdW8=;
        b=MLJdW3MLn6oHWVjQz9AQQUy0BaZUszJRw2G+IehTMMlpDeniUzS9Ep4jdZJ4P1zdzz
         +WGY8XDipLtFNo7KX7WUQa4yEb1BE7gEELCGoAhEfMCBLvvyZFNaKmnPAMoDNWteWU1S
         i5+M/70aLYc/N7wc11TCwjSGTezfDMBJRDnocuIyZUo/lCwSTrISy1PbvV9ZED79pR8W
         D1e2UwxbJ0OANwTbxkNRkBB0BLd2yR2iCjKRv9W2NgNKoDq1sYB3ZbKZQOi/Vs9miagc
         lMgmlEfBq1+y1jnW1J5bz5e4Tp+mB4gKKRF5lZnbvZK95elgHzDmCjaoVQlRou+l6Dt8
         f10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686144678; x=1688736678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1M24Nb0Jfn6VdAiAglm1uA5NvezRPZanQjJa6TxIdW8=;
        b=NVPLwF5q8kIdrmRztFJw28OhaR55MMoVqgmd/+JshWEQftGagDvLrntLgS4fYzoxz4
         NwJawPncCjlzmBgU67BxPt/kysxD+BiTPuwvN6AJUq5b0dOSByBoHkIdgeI6SEM2T39q
         S9ht3YgK9LMJYYeWiCYh8xX4UVjFgrAFOJPxVVy9yQLMMVqn3IQgoIg1ETrCcRqQ1oY4
         9Ik45mdB+wTcTHdrKlAgl7cmcCp3yZ6hQ5RILXI5DRYp/bNuxzw/oSRs1Yb8OU+w3Fc3
         VJwkMCvVsbuqSL+OrXH2UkFcDFh0PrrYenjjyPoHj+VFl2xSW1lFdKNQ4xS48cCXdcSo
         xw/A==
X-Gm-Message-State: AC+VfDzZzR4WkFVQVIbdrKEUsb1MzH2BHJP8v/espcxQ+QGQIutmq1FC
        u4AjnfzgxCQtv1T2DjQyNvnTjA==
X-Google-Smtp-Source: ACHHUZ6W71GYITYJYfS1W3bqNiXWxZgpM814OxgwDwV+N6HrClGkpDrnH6yMsgi6vHPGK7+lrAiV8A==
X-Received: by 2002:a1c:7c0d:0:b0:3f4:f7c2:d681 with SMTP id x13-20020a1c7c0d000000b003f4f7c2d681mr7365641wmc.29.1686144678500;
        Wed, 07 Jun 2023 06:31:18 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id g7-20020a5d5407000000b0030903371ef9sm15475471wrv.22.2023.06.07.06.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:31:17 -0700 (PDT)
Message-ID: <fea749a7-ef17-097b-847a-d73f965c841b@linaro.org>
Date:   Wed, 7 Jun 2023 14:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: sc8280xp: add resets for
 soundwire controllers
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-6-srinivas.kandagatla@linaro.org>
 <542a67da-5870-dda0-3604-9367a438e51b@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <542a67da-5870-dda0-3604-9367a438e51b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/05/2023 21:03, Krzysztof Kozlowski wrote:
> On 25/05/2023 14:29, Srinivas Kandagatla wrote:
>> Soundwire controllers on sc8280xp needs an explicit reset, add
>> support for this.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index 6730349e34f4..39be2e89ce05 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -6,6 +6,7 @@
>>   
>>   #include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
>>   #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
>> +#include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>>   #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>   #include <dt-bindings/interconnect/qcom,sc8280xp.h>
>> @@ -2560,6 +2561,8 @@
>>   			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>>   			clocks = <&rxmacro>;
>>   			clock-names = "iface";
>> +			resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
>> +			reset-names = "swr_audio_cgcr";
>>   			label = "RX";
>>   
>>   			qcom,din-ports = <0>;
>> @@ -2634,6 +2637,8 @@
>>   			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
>>   			clocks = <&wsamacro>;
>>   			clock-names = "iface";
>> +			resets = <&lpass_audiocc LPASS_AUDIO_SWR_WSA_CGCR>;
>> +			reset-names = "swr_audio_cgcr";
>>   			label = "WSA";
>>   
>>   			qcom,din-ports = <2>;
>> @@ -2656,6 +2661,14 @@
>>   			status = "disabled";
>>   		};
>>   
>> +		lpass_audiocc: clock-controller@32a9000 {
>> +			compatible = "qcom,sc8280xp-lpassaudiocc";
>> +			reg = <0 0x032a9000 0 0x1000>;
>> +			qcom,adsp-pil-mode;
> 
> Here and...
> 
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>>   		swr2: soundwire-controller@3330000 {
>>   			compatible = "qcom,soundwire-v1.6.0";
>>   			reg = <0 0x03330000 0 0x2000>;
>> @@ -2665,6 +2678,8 @@
>>   
>>   			clocks = <&txmacro>;
>>   			clock-names = "iface";
>> +			resets = <&lpasscc LPASS_AUDIO_SWR_TX_CGCR>;
>> +			reset-names = "swr_audio_cgcr";
>>   			label = "TX";
>>   			#sound-dai-cells = <1>;
>>   			#address-cells = <2>;
>> @@ -2901,6 +2916,14 @@
>>   			};
>>   		};
>>   
>> +		lpasscc: clock-controller@33e0000 {
>> +			compatible = "qcom,sc8280xp-lpasscc";
>> +			reg = <0 0x033e0000 0 0x12000>;
>> +			qcom,adsp-pil-mode;
> 
> ... here - where do you use these properties? Driver ignores them.
Wil add a check in driver.

> 
> AFAIR, these were only for sc7280 where we supported two variants for audio.
> 
we can drop this property altogether, But having this flag will make 
sure that the bindings are in a ready state to accommodate a new variant 
of sc8280xp with dsp bypass.

--srini



> Best regards,
> Krzysztof
> 
