Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0CC60B5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiJXSnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiJXSmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:42:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DB836785
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:24:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id j14so13637292ljh.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aD24Bp/fTbOiKGm+qzIYna6YYsi6ArKhPIadGs0v1CQ=;
        b=dHOEPB8sjIilqPERlDG2D//r77mo6JMgLmjhGdq5WqWnKpAePnLIbJdZkw2z/suHZq
         aUegZHRTMaTMskd5lmjhSqGq7kMB6QfVvTEcsXO19T6hYpYkgEYXl0Vh+rtrcWonZkf7
         zfDLhdxnMb3uw+xg6MVu3gincuJ6t4aOaH4SaBDY/X6LSBbbttZ4JqKqdtVjc13e/Uh9
         J7095GW//CvKwPFzCHfhoZ32K2Wib3GczfkrcBHjcrwMh2MSz/gddxFogowTtGwJwXIK
         AJXwftrCOCOKhHxkDPlgWnT99Q460GrSy9gARs/R4d5pGHDigSfUO0lh4IDGEy2tL5KU
         aL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aD24Bp/fTbOiKGm+qzIYna6YYsi6ArKhPIadGs0v1CQ=;
        b=z+ecMr9eQW672D39wkx74nEbhN1D04JN/djQtNFdUFqdE9BCVvB4adA2RtW7rwL+a0
         BwpUWDw+a0557lwUsHhHJgGh0KaHMjsg0nALFklZUla3HG1lwLUmyLORPN3zw7m2JvqU
         7cwviXbnUo1Olu8qitNMgT0qEHdVTSQ/y9umPtsihaSF4l4U7igPr9g8j9y06tQ7X2hN
         nzLOlvFnUaEX4vHod69TfulWcZXV4+0kvObiFXuMV3qAYq+kgbU9zG6J67z3Y9o5w50y
         +8LcvExQd6lKywJiBwWCqv8OHFakCZ/8YUMnsvezDOkv01en8uG2MTui/wU01eukTEBX
         zqVw==
X-Gm-Message-State: ACrzQf3qn9TBe94UJ1Tc1Fzz/Nc3OZCxGs4FDoIiIhbU7kSBhSwPSgKF
        4RjTv0kkFBp+5LlIrpXvOZ5TeEFLWY4cf4XV
X-Google-Smtp-Source: AMsMyM4qKtrgJEWf/IxUA7SiYlAHohKjfI12hYZHjh7NauNCoP+9BzJekhZ0XBXK4mNbM8g/xIbasg==
X-Received: by 2002:a05:6512:2808:b0:4a4:7cab:b28d with SMTP id cf8-20020a056512280800b004a47cabb28dmr11820707lfb.384.1666630128581;
        Mon, 24 Oct 2022 09:48:48 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id s21-20020a056512203500b00498f3ebffb2sm4616076lfs.25.2022.10.24.09.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 09:48:48 -0700 (PDT)
Message-ID: <3af48606-731f-6047-92ca-80435f401ae3@linaro.org>
Date:   Mon, 24 Oct 2022 19:48:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 10/13] arm64: dts: qcom: sm8450: add spmi node
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211209103505.197453-1-vkoul@kernel.org>
 <20211209103505.197453-11-vkoul@kernel.org>
 <5035b6a3-164b-afa0-b714-4deb886f9f90@linaro.org>
 <9f696023-f2b4-ccd0-34a0-6f4d5848e862@linaro.org>
 <8c1428a6-f268-cb03-3e55-887d30236924@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <8c1428a6-f268-cb03-3e55-887d30236924@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 19:46, Krzysztof Kozlowski wrote:
> On 24/10/2022 12:45, Dmitry Baryshkov wrote:
>> On 24/10/2022 17:56, Krzysztof Kozlowski wrote:
>>> On 09/12/2021 05:35, Vinod Koul wrote:
>>>> Add the spmi bus as found in the SM8450 SoC
>>>>
>>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
>>>>    1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> index f75de777f6ea..b80e34fd3fe1 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> @@ -645,6 +645,24 @@ pdc: interrupt-controller@b220000 {
>>>>    			interrupt-controller;
>>>>    		};
>>>>    
>>>> +		spmi_bus: spmi@c42d000 {
>>>> +			compatible = "qcom,spmi-pmic-arb";
>>>> +			reg = <0x0 0x0c400000 0x0 0x00003000>,
>>>> +			      <0x0 0x0c500000 0x0 0x00400000>,
>>>> +			      <0x0 0x0c440000 0x0 0x00080000>,
>>>> +			      <0x0 0x0c4c0000 0x0 0x00010000>,
>>>> +			      <0x0 0x0c42d000 0x0 0x00010000>;
>>>
>>> This is a patch from December 2021. Is there anything blocking it from
>>> being merged?
>>>
>>> The same applies to several other patches here.
>>
>> As far as I know, Stephen still didn't pick up the spmi-pmic-arb support
>> for the PMIC on the SM8450 platform. Thus we also can not merge the DT
>> parts.
> 
> Why we cannot merge DTS? How is DTS with new nodes depending on any
> driver changes?

In this particular case, there was an open question, what should be the 
bindings for the PMIC ARB v7.

> 
> Just like I replied to Konrad - if that's true, bindings are simply
> wrong and should be fixed.

Maybe I missed the reply. Which email are you referring to?

> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry

