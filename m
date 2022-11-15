Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315E36295A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbiKOKTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiKOKTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:19:53 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709A913D5B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:19:52 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g12so23743715lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYrT9Brqn6UtjqQy0f2wcD8We2xi1ytM62MKdkElEIc=;
        b=zPOwLqNRx+Rvcg06eNoUDm7x/jiIf5hrEQuvGceAw7mabXYpnSVhCUaLumgEULiu5p
         aZzNQF6L5r4sv5UEKlYAuObSWFcjY+e2G6c/+8IkI6cipfXQ06IcwfMMwkpfu+Z/y3fi
         /T2THfTowctZUoEoKpG5vkY7Kcvg4iOVQw76BxFMiBovpIGhkSf4GVVkXIhZEpsxU2hE
         eV6wIIsb0J8mxt+ELF3hMNKCy8TlFOB8Hr3edPoxQw8xWtSiX+WNS07sNfH/N5Am3GhG
         nG3BzFlB0txIWlKUzv263qPf6uDJHut4XYqvMx6xAKF5TTihSk195dLXbNp/5O1I/nLW
         mfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mYrT9Brqn6UtjqQy0f2wcD8We2xi1ytM62MKdkElEIc=;
        b=4lsuaCSBGL1l4eA+SKNlWqGJUFhlTMC88RYkYWeDla5Al686YoXQF+JsRCN/v3zl0G
         CetaX9wrZWXvT3/PiuhVn52ub+fdfNUYmRJ6azB41C3H0DEUJxpziuhZDtU7H6Ttxdo5
         Z3zpgQ7SEkC1pFCUn5o4L9mQG/parf3U45eVIc+zomaKgHNARdYxWooBPMVNTvtniqkN
         l10q4s2d/W16tKVJkRWdM8n+yZShKLyzxl6Bh+L+CV+mVBzHDqnUsDgChFmt4uA1gpXi
         hqVOaXrX7ut736EbMpSY6ib1AjO97UrlNT/2x3Lzx3oqlbW5/WVK9kYmBX9eKaIS3+P1
         EoPQ==
X-Gm-Message-State: ANoB5pkucbRrSTKCR2n9VTIbfM1SDHkF1vi2Ll2/n6B8Kh1/7kexbZVU
        V4cdDBU4SVf8knIMyEedJ8RF/Q==
X-Google-Smtp-Source: AA0mqf6OSY+BxeZ/rDrQTLVfmBTjbBE796KQVAihHAavbB/aVKpB9sHlRYPkhEnCzazf32e/rEIXcA==
X-Received: by 2002:a05:6512:3414:b0:4a2:2b23:f17f with SMTP id i20-20020a056512341400b004a22b23f17fmr4998120lfr.688.1668507590808;
        Tue, 15 Nov 2022 02:19:50 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id i15-20020a056512340f00b004b4a0482a48sm490918lfr.139.2022.11.15.02.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 02:19:50 -0800 (PST)
Message-ID: <096f390b-39e7-302b-ec54-3301cadd39aa@linaro.org>
Date:   Tue, 15 Nov 2022 11:19:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8450: add Soundwire and LPASS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221114152130.385871-1-krzysztof.kozlowski@linaro.org>
 <20221114152130.385871-3-krzysztof.kozlowski@linaro.org>
 <fbf1fc09-31a9-a08f-6ffd-551fdd317ec0@linaro.org>
 <d1177e53-a4f2-70e5-9214-671910ea28ac@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <d1177e53-a4f2-70e5-9214-671910ea28ac@linaro.org>
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



On 15/11/2022 11:15, Krzysztof Kozlowski wrote:
> On 14/11/2022 16:37, Konrad Dybcio wrote:
>>
>> On 14/11/2022 16:21, Krzysztof Kozlowski wrote:
>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>
>>> Add Soundwire controllers, Low Power Audio SubSystem (LPASS) devices and
>>> LPASS pin controller.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 295 +++++++++++++++++++++++++++
>>>    1 file changed, 295 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> index 4b0a1eee8bd9..c99740591467 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>> @@ -15,6 +15,7 @@
>>>    #include <dt-bindings/interconnect/qcom,sm8450.h>
>>>    #include <dt-bindings/soc/qcom,gpr.h>
>>>    #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>> +#include <dt-bindings/sound/qcom,q6afe.h>
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
>> The sorting will be off, as adsp and cdsp have been mistakenly put in
>> the wrong place (notice adsp @ 32300000 is actually at an address
>> that's 8 hex digits long, but the reg addr is padded to 9 hex digits..).
> 
> I don't get it. This has address:
> 31e0000
> ADSP has
> 30000000
> 
> so why sorting is odd?
It's gonna be fine, you're right, I can't read properly...

Konrad
> 
>>> Could you submit a fix for that as well?
> 
> For 9 digits, sure, but this is independent issue.
> 
>>
>>> +			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +				 <&vamacro>;
>>> +			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
>>> +			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>>> +					  <&q6prmcc LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK  LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>>
>> Remove the duplicated space before LPASS_CLK_ATTRIBUTE_COUPLE_NO.
> 
> Ack.
> 
> 
> Best regards,
> Krzysztof
> 
