Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8739662DEC7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbiKQO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240193AbiKQO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:57:24 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163D476173
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:57:21 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j16so3159930lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdCfv431jqwhM+KQDL4GlLi43icmR8iSXxt/gu6+Rys=;
        b=bJEOYJfW0rPbshF9PevRR/1b2MUlMwGPv9+wzegp26kkKXz8OGV00PoqtO/hZPQ4NY
         gMPiuDdgIKSsQn4xC5PNlFinxOoqwdoDzzEPgy+jo8LS/luRy/in73v+KWvbKvjKTTbS
         ujFrqIpfBrbAth+G3xhpPy4t3HP0CCnOSKpm2k/jgfuFWkN+zDkcSyC5jQGpa/Mj/ooW
         tyT8QckqWM5o/vh8kSZY8Kx0nlmoZnHNg6zIYfH1qUal+73CeqEeGfS3L3jkVV2hq7E5
         bejJKH1vQR5DcvTaYvI/r29KUPRl5OF8daRNht81IVG17V+E09l9dT9UiJd7mrAN7Uod
         ee0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UdCfv431jqwhM+KQDL4GlLi43icmR8iSXxt/gu6+Rys=;
        b=WHRl3z8RxaFnkJpvs2R2+v/80zurN0jKbH8PswGcVb4zHhnJ73nfzF/bz2RnEvcw6m
         ee1jERYw+IGsap7ZOk5S1a8HIoiHH7zwKB8B/cD9g1Lj1UiJ9omqS99om4OXiKrvkU+c
         mkdnaIbI2lQdkfE0rHYJk0MyC5UPSeL/Is8DLf+RIvwofvzP/YEXqtMoqemCAbSg0bJF
         CH2eu/CSQgp07HF7DE77a48pHwFXZo0SezU8dEiOh7cfNFkj4kgqGkNd1vGskL73kgpw
         ffhu3oUOUzJRiDDaphMMNULhCxPTBJux5tkVg0PnAT4alKhgmTnXPmFTSGN/StBTdv2A
         OeKQ==
X-Gm-Message-State: ANoB5plbmrAOlQzxJzl31YhqT62MHodF65UYwsH7HiL41p+OIZqmKZp+
        TNbNy/roDrB6YrYyTk0Ui11J9A==
X-Google-Smtp-Source: AA0mqf5HMqFOprUrMQnUCqgvwsJ2g3LSERRqqOVcIoJZdsRxNdb+AYnvNJd+sDHEhnT7NKIuQg3wTg==
X-Received: by 2002:a05:6512:c29:b0:4b1:b061:4815 with SMTP id z41-20020a0565120c2900b004b1b0614815mr959380lfu.18.1668697039485;
        Thu, 17 Nov 2022 06:57:19 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id b12-20020ac247ec000000b004a93b8508edsm181303lfp.181.2022.11.17.06.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 06:57:18 -0800 (PST)
Message-ID: <b5fcd010-76bf-9ec3-bf52-6ed51c655afa@linaro.org>
Date:   Thu, 17 Nov 2022 15:57:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 10/13] arm64: dts: qcom: sm8450: add spmi node
To:     Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211209103505.197453-1-vkoul@kernel.org>
 <20211209103505.197453-11-vkoul@kernel.org>
 <5035b6a3-164b-afa0-b714-4deb886f9f90@linaro.org>
 <9f696023-f2b4-ccd0-34a0-6f4d5848e862@linaro.org>
 <8c1428a6-f268-cb03-3e55-887d30236924@linaro.org>
 <3af48606-731f-6047-92ca-80435f401ae3@linaro.org>
 <d5726896-e62b-d19d-454b-700dd1c42222@linaro.org>
 <CAA8EJpovd0D154QUG1_EtCnCrffJBt+SPWQtLEZWb=dc_PLGjA@mail.gmail.com>
 <Y1jGjCU47+tOBLus@matsya>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Y1jGjCU47+tOBLus@matsya>
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



On 26/10/2022 07:33, Vinod Koul wrote:
> On 24-10-22, 21:58, Dmitry Baryshkov wrote:
>> On Mon, 24 Oct 2022 at 21:56, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 24/10/2022 12:48, Dmitry Baryshkov wrote:
>>>> On 24/10/2022 19:46, Krzysztof Kozlowski wrote:
>>>>> On 24/10/2022 12:45, Dmitry Baryshkov wrote:
>>>>>> On 24/10/2022 17:56, Krzysztof Kozlowski wrote:
>>>>>>> On 09/12/2021 05:35, Vinod Koul wrote:
>>>>>>>> Add the spmi bus as found in the SM8450 SoC
>>>>>>>>
>>>>>>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>>>>>> ---
>>>>>>>>     arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
>>>>>>>>     1 file changed, 18 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>>>>> index f75de777f6ea..b80e34fd3fe1 100644
>>>>>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>>>>> @@ -645,6 +645,24 @@ pdc: interrupt-controller@b220000 {
>>>>>>>>                            interrupt-controller;
>>>>>>>>                    };
>>>>>>>>
>>>>>>>> +         spmi_bus: spmi@c42d000 {
>>>>>>>> +                 compatible = "qcom,spmi-pmic-arb";
>>>>>>>> +                 reg = <0x0 0x0c400000 0x0 0x00003000>,
>>>>>>>> +                       <0x0 0x0c500000 0x0 0x00400000>,
>>>>>>>> +                       <0x0 0x0c440000 0x0 0x00080000>,
>>>>>>>> +                       <0x0 0x0c4c0000 0x0 0x00010000>,
>>>>>>>> +                       <0x0 0x0c42d000 0x0 0x00010000>;
>>>>>>>
>>>>>>> This is a patch from December 2021. Is there anything blocking it from
>>>>>>> being merged?
>>>>>>>
>>>>>>> The same applies to several other patches here.
>>>>>>
>>>>>> As far as I know, Stephen still didn't pick up the spmi-pmic-arb support
>>>>>> for the PMIC on the SM8450 platform. Thus we also can not merge the DT
>>>>>> parts.
>>>>>
>>>>> Why we cannot merge DTS? How is DTS with new nodes depending on any
>>>>> driver changes?
>>>>
>>>> In this particular case, there was an open question, what should be the
>>>> bindings for the PMIC ARB v7.
>>>
>>> Ah, so it is about PMIC ARB v7 bindings? Then it's reasonable to wait
>>> with this one. I just had an impression that it's about driver changes...
>>
>> Yes, it's about binding. Thus we have been waiting for quite some time.
> 
> Yes sadly Steven has stopped responding to emails or IRC.. I am not
> sure whats going on!
> 
> Even the SPMI tree is not being actively maintained with only few
> patches which were picked in last cycle since this year!
It's in -next now and 8450 boots and works fine. If the binding 
situation has been resolved, I say merge this ASAP! :)

Konrad
> 
