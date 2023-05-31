Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF5B718AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjEaUPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 16:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjEaUO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 16:14:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14AC133
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:14:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so7427698e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685564092; x=1688156092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/djM4DIThQkh0ZR00KI8IINzMZsz/yFsT9iAasATNE=;
        b=mGHlmKfQizrY+l8OiobCj7noM6Uh/mv60bVdscVvf3J6KJGSTIsdnmoq7dPGiEOM4E
         FS7NmjX7tjD4d2HA8oZ5z2n0/JSLlqSmtPC171VbC2nuKetxWEPNmapkLy5NN40Nf/hX
         j2Qy9mBO23RLgULeIAYeKToOqD+jCHspQ9BF1FDtYnf+X8+OQBiqzQZ8wViEQBDXVfjw
         8SwEv/HbXZiIzq4R2GhFw5CTMIZ0986fsNlZegDNRctZCVT9kqg7/3QaTDebEqcgf53U
         75sDWQQdp/W3WGV6wAV9JEQvbKruyHjgyfaERjXmnjwdJrLWw1xr7RZLY6FvEVi5QsxJ
         atSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685564092; x=1688156092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/djM4DIThQkh0ZR00KI8IINzMZsz/yFsT9iAasATNE=;
        b=ZXB4k57v4dAwHvaXDxnVMp9unZw8vw5exhPidvsgi79eVxu10B0d+ckuIL1E+h1qeE
         cORWb479uyG+dtR98TMEH5PvTq2XhF4ErD4j6tPJWpzC6qa8PHlHkCCCEksUIOoqDK5P
         tBuK2ETLrC5LP3ojgS9dXlmiWzYJkN6uAwxedKuZDNSUuXrdsi/10yGQC0mwbfgYFfSV
         oByNClWpMTSbALnNWqkyQiWQBK+HVk1Jzp6YGXG/TGs2oC6t3WQMdo9O9ZldLAVhvBuL
         3gBpXyHCnaRLFIIWLDtZzBrvcb2PQM/khq/rlbrD+g0IQUD+1YJXBAX2E7YV+Im98elW
         zFDA==
X-Gm-Message-State: AC+VfDyZdf0L5cZyyQsaYZwct803X/ONNyvRLOBNLg+484syShKEVZoA
        kaMiXw0aR5ZeyOFD4DG8eXl01A==
X-Google-Smtp-Source: ACHHUZ57xMQG+SuLqKKwNdOKgeHWktkrA4w4R2AlSFo0nr2D54gjkHcjOcN+sTvKbt1CCuTD2o/jxw==
X-Received: by 2002:ac2:42d4:0:b0:4f0:276:295b with SMTP id n20-20020ac242d4000000b004f00276295bmr58303lfl.46.1685564091950;
        Wed, 31 May 2023 13:14:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id l9-20020ac24309000000b004f00189e1dcsm825354lfh.117.2023.05.31.13.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 13:14:51 -0700 (PDT)
Message-ID: <da01a33d-a4f9-1086-3365-5a0528db16d9@linaro.org>
Date:   Wed, 31 May 2023 22:14:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: sc8280xp: add resets for
 soundwire controllers
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230525122930.17141-1-srinivas.kandagatla@linaro.org>
 <20230525122930.17141-6-srinivas.kandagatla@linaro.org>
 <542a67da-5870-dda0-3604-9367a438e51b@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <542a67da-5870-dda0-3604-9367a438e51b@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 31.05.2023 22:03, Krzysztof Kozlowski wrote:
> On 25/05/2023 14:29, Srinivas Kandagatla wrote:
>> Soundwire controllers on sc8280xp needs an explicit reset, add
>> support for this.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index 6730349e34f4..39be2e89ce05 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -6,6 +6,7 @@
>>  
>>  #include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
>>  #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
>> +#include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
>>  #include <dt-bindings/clock/qcom,rpmh.h>
>>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>  #include <dt-bindings/interconnect/qcom,sc8280xp.h>
>> @@ -2560,6 +2561,8 @@
>>  			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>>  			clocks = <&rxmacro>;
>>  			clock-names = "iface";
>> +			resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
>> +			reset-names = "swr_audio_cgcr";
>>  			label = "RX";
>>  
>>  			qcom,din-ports = <0>;
>> @@ -2634,6 +2637,8 @@
>>  			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
>>  			clocks = <&wsamacro>;
>>  			clock-names = "iface";
>> +			resets = <&lpass_audiocc LPASS_AUDIO_SWR_WSA_CGCR>;
>> +			reset-names = "swr_audio_cgcr";
>>  			label = "WSA";
>>  
>>  			qcom,din-ports = <2>;
>> @@ -2656,6 +2661,14 @@
>>  			status = "disabled";
>>  		};
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
>>  		swr2: soundwire-controller@3330000 {
>>  			compatible = "qcom,soundwire-v1.6.0";
>>  			reg = <0 0x03330000 0 0x2000>;
>> @@ -2665,6 +2678,8 @@
>>  
>>  			clocks = <&txmacro>;
>>  			clock-names = "iface";
>> +			resets = <&lpasscc LPASS_AUDIO_SWR_TX_CGCR>;
>> +			reset-names = "swr_audio_cgcr";
>>  			label = "TX";
>>  			#sound-dai-cells = <1>;
>>  			#address-cells = <2>;
>> @@ -2901,6 +2916,14 @@
>>  			};
>>  		};
>>  
>> +		lpasscc: clock-controller@33e0000 {
>> +			compatible = "qcom,sc8280xp-lpasscc";
>> +			reg = <0 0x033e0000 0 0x12000>;
>> +			qcom,adsp-pil-mode;
> 
> ... here - where do you use these properties? Driver ignores them.
> 
> AFAIR, these were only for sc7280 where we supported two variants for audio.
Smells like pure copypasta - we don't support any 8280xp chromebooks (not
even sure if any exist) and WP devices have a normal TZ+PAS setup

Konrad
> 
> Best regards,
> Krzysztof
> 
