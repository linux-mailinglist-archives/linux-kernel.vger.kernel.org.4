Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62C7359FE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjFSOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjFSOqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:46:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DA318C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:45:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f87592ecaeso805578e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687185954; x=1689777954;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGh6q8YX2/fWXkHg5338c1JuUfqVUfeIziiaO9CuRyA=;
        b=TMZberxgZEP/PuQu10gXIwK7DBYB0ixRdQQLw/TmK400FmYVO9qRtMwj6HGRz5Z7RU
         vqFApHi2qsnNfC+tJFWbIiCxRsLCKaCrr3KOPuC9teq2sB+iJYRIn6Sn4bjVQ5Deu8rg
         ACg3yOGdFSxE48tZD5SiCinEXwtFqkpqDlZ2qzhZU5yTPTY2PGaKqmo1E3H9c5G5fmaw
         IvWRXha6TOCRJC5V+h7pvKj5jHJqBEbNmdrEBVP/JBsGUClnbgkabMqpFcoZZIjAE8Y+
         dzu5cbNLQMU1eaCGZjDQGp9kbax0mtNw2rbeUxDNGxrTFZU/K3m/uLwr0CF8PFbhfDvE
         eisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687185954; x=1689777954;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGh6q8YX2/fWXkHg5338c1JuUfqVUfeIziiaO9CuRyA=;
        b=URATpteKTFA4Xa5RAS/VkMW0SLcmzvdr9awq5YylC/o0iEJoRzQkkldWKbGYmVxvff
         h7sWZmXGnf03qQCSYS3XFyQLU2TjBniplbYr+Ld+5V1jiJn7icGvToqEgwxv2ffcCkx0
         dt+CIYQuEdSOQRsEwgU9L2d0rQ2SnQW2su7cVndBTQloDVnvCQf19TTSWzlWXZpAcPQv
         kbp9z7PbeyyiQ2zZtQ1/C50ry6d9sAfeI5KqBdA5VZZj5xcUbvTx9OAYeJ4ns0QqI9rL
         se6rUzs0wbSb31eo71V2EBSVQUU4T6eZil33bQnnTKOUH4noOouaarUCnK4K9bf7LFe8
         cPIw==
X-Gm-Message-State: AC+VfDzbgR3DhXWoikIwzBP1jlI3A3hqFn7E5dOTWbYdp0pWtfWy/Mcb
        LjdUqLLpQOq76WL4QmcBL5xB/w==
X-Google-Smtp-Source: ACHHUZ58xFLtIpptHAM69KQBzXtTb2dYEYCsNT4yppezElKLNkx81i5BNudAdsvN6Sa6fvflLxceWw==
X-Received: by 2002:a19:7b02:0:b0:4f8:83f:babe with SMTP id w2-20020a197b02000000b004f8083fbabemr5268988lfc.62.1687185954010;
        Mon, 19 Jun 2023 07:45:54 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id y18-20020ac255b2000000b004eb12850c40sm4294426lfg.14.2023.06.19.07.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 07:45:53 -0700 (PDT)
Message-ID: <7d85389e-3066-b031-437a-0c0b800f57ad@linaro.org>
Date:   Mon, 19 Jun 2023 16:45:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8350: add APR and LPASS TLMM
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230616190222.2251186-1-krzysztof.kozlowski@linaro.org>
 <20230616190222.2251186-3-krzysztof.kozlowski@linaro.org>
 <4e558ea5-84cf-c7d4-19c2-f6e72f497c74@linaro.org>
 <1dfcc1cd-3e71-8d02-5d5e-4b501d7ada50@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1dfcc1cd-3e71-8d02-5d5e-4b501d7ada50@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.2023 16:37, Krzysztof Kozlowski wrote:
> On 19/06/2023 15:24, Konrad Dybcio wrote:
>> On 16.06.2023 21:02, Krzysztof Kozlowski wrote:
>>> Add audio-related nodes: the APR in the ADSP (same as on SM8250) and
>>> LPASS TLMM pin controller.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> Bindings for SM8350:
>>> https://lore.kernel.org/linux-arm-msm/20230616185742.2250452-1-krzysztof.kozlowski@linaro.org/T/#t
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 82 ++++++++++++++++++++++++++++
>>>  1 file changed, 82 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> index 33b7ef8fd78a..9650cecb1370 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>>> @@ -15,7 +15,9 @@
>>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>>>  #include <dt-bindings/phy/phy-qcom-qmp.h>
>>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>> +#include <dt-bindings/soc/qcom,apr.h>
>>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>> +#include <dt-bindings/sound/qcom,q6afe.h>
>>>  #include <dt-bindings/thermal/thermal.h>
>>>  #include <dt-bindings/interconnect/qcom,sm8350.h>
>>>  
>>> @@ -1780,6 +1782,20 @@ tcsr_mutex: hwlock@1f40000 {
>>>  			#hwlock-cells = <1>;
>>>  		};
>>>  
>>> +		lpass_tlmm: pinctrl@33c0000 {
>>> +			compatible = "qcom,sm8350-lpass-lpi-pinctrl";
>>> +			reg = <0 0x033c0000 0x0 0x20000>,
>> '0' for addr, '0x0' for size :/
>>
>> The rest of the file uses '0', please do that
> It's a mixture but mostly 0x0 in both places. I don't mind switching to 0.
0x0 would be preferred (dec makes no sense for registers) but I don't
think anybody wants to do (or handle) the mess of replacing that

Konrad
> 
>>
>>> +			      <0 0x03550000 0x0 0x10000>;
>>> +
>>> +			clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>>> +			clock-names = "core", "audio";
>>> +
>>> +			gpio-controller;
>>> +			#gpio-cells = <2>;
>>> +			gpio-ranges = <&lpass_tlmm 0 0 15>;
>>> +		};
>>> +
>>>  		gpu: gpu@3d00000 {
>>>  			compatible = "qcom,adreno-660.1", "qcom,adreno";
>>>  
>>> @@ -3189,6 +3205,72 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>>>  				label = "lpass";
>>>  				qcom,remote-pid = <2>;
>>>  
>>> +				apr {
>>> +					compatible = "qcom,apr-v2";
>>> +					qcom,glink-channels = "apr_audio_svc";
>>> +					qcom,domain = <APR_DOMAIN_ADSP>;
>>> +					#address-cells = <1>;
>>> +					#size-cells = <0>;
>>> +
>>> +					service@3 {
>>> +						reg = <APR_SVC_ADSP_CORE>;
>>> +						compatible = "qcom,q6core";
>>> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>>> +					};
>>> +
>>> +					q6afe: service@4 {
>>> +						compatible = "qcom,q6afe";
>>> +						reg = <APR_SVC_AFE>;
>>> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>> Missing newline before subnodes
> 
> acks
> 
> Best regards,
> Krzysztof
> 
