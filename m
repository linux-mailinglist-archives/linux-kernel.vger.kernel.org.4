Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EEA62F0D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbiKRJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241856AbiKRJQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:16:27 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811B491C1A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:16:25 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n21so11490301ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVpY7HTKInpub0ujYpomEMwnoXj914wvun46oA4sJoQ=;
        b=Xhz5XNfb3dS5vE01xwDhnNS0x2PKi9Dzud0k5uLCkF+WlXcrZ2l9BFeK45mVVkeMpB
         eV/utXTP5NvGug9m/u8SIswHG8qrJ/wBLeE5S0ih9JRXCoOWZBmktGi2CCabJB2OIQsi
         zTKoG0vFSNTUJqCijBx7QEARh3NVMx6SYSTlPWa9wdYBdeP3RKsxA9BEq3nfnBd7WJVF
         5lD4x8aOVmkv7G+X4HX6ohElmiR8U1KxHElicjDykNs2+ZJtGAng3cGrljPw2RhdXjMD
         m6T6e2AMZnMm3BE6zdbrudXsD1PWC+75pdQKZ4knW+52vEydTMDgWIIkjvZAewcTSMTD
         xdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nVpY7HTKInpub0ujYpomEMwnoXj914wvun46oA4sJoQ=;
        b=xVQS2OxRuEuU+gt/KSZtHb11CUpRyF0omu9BYc92LScaYiuF9fFHZyU54LTS79JGnT
         9D3LgGNYbOB/sKJKoRUNTV1GlLoj8ZbTqKkg/4gkZkluyQJkr3FNKJBnbNU9nJ9XGR6B
         K17qlrhjmxkYtVK3md8PlvC4Tp1DojZJ2t/JDvtrypxYZZz023L4enrYwFUqSPNaBwru
         Fk/BYEw2uVlwXYIQFWudk5xyO+jBzoQbH+uFamGvpcnV//jRBp8tn46u2LHrHz1P/M/u
         ucjg3Kjr/pir6BQEoYUVfTK5nfnDfV/wDGzaqIjHQsyo0h+s85b1iOGApUXCKLP6YCis
         vqiA==
X-Gm-Message-State: ANoB5pmWqN973yrgkM2j1152IxHm7IPDeXSaZ42XLew2Ptobt9rwLJKR
        YIkjzfOPv8yWAQXrjTLj09VqyQ==
X-Google-Smtp-Source: AA0mqf64rijyM5vvOY6oiWPW2G22yh6wist43cUewN9SRMFYULPK04Q0dJfkBi0jDPRyfCFrLbqmfg==
X-Received: by 2002:a17:906:8c4:b0:7ae:fbe6:e7ca with SMTP id o4-20020a17090608c400b007aefbe6e7camr5334368eje.408.1668762983966;
        Fri, 18 Nov 2022 01:16:23 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id a25-20020a50ff19000000b00461bd82581asm1545121edu.84.2022.11.18.01.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 01:16:23 -0800 (PST)
Message-ID: <594be897-f710-fb62-0882-8a7f01b21bfe@linaro.org>
Date:   Fri, 18 Nov 2022 10:16:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 10/13] arm64: dts: qcom: sm8450: add spmi node
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
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
 <Y1jGjCU47+tOBLus@matsya> <b5fcd010-76bf-9ec3-bf52-6ed51c655afa@linaro.org>
In-Reply-To: <b5fcd010-76bf-9ec3-bf52-6ed51c655afa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2022 15:57, Konrad Dybcio wrote:
> 
> 
> On 26/10/2022 07:33, Vinod Koul wrote:
>> On 24-10-22, 21:58, Dmitry Baryshkov wrote:
>>> On Mon, 24 Oct 2022 at 21:56, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 24/10/2022 12:48, Dmitry Baryshkov wrote:
>>>>> On 24/10/2022 19:46, Krzysztof Kozlowski wrote:
>>>>>> On 24/10/2022 12:45, Dmitry Baryshkov wrote:
>>>>>>> On 24/10/2022 17:56, Krzysztof Kozlowski wrote:
>>>>>>>> On 09/12/2021 05:35, Vinod Koul wrote:
>>>>>>>>> Add the spmi bus as found in the SM8450 SoC
>>>>>>>>>
>>>>>>>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>>>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>>>>>>> ---
>>>>>>>>>     arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
>>>>>>>>>     1 file changed, 18 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi 
>>>>>>>>> b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>>>>>> index f75de777f6ea..b80e34fd3fe1 100644
>>>>>>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>>>>>> @@ -645,6 +645,24 @@ pdc: interrupt-controller@b220000 {
>>>>>>>>>                            interrupt-controller;
>>>>>>>>>                    };
>>>>>>>>>
>>>>>>>>> +         spmi_bus: spmi@c42d000 {
>>>>>>>>> +                 compatible = "qcom,spmi-pmic-arb";
>>>>>>>>> +                 reg = <0x0 0x0c400000 0x0 0x00003000>,
>>>>>>>>> +                       <0x0 0x0c500000 0x0 0x00400000>,
>>>>>>>>> +                       <0x0 0x0c440000 0x0 0x00080000>,
>>>>>>>>> +                       <0x0 0x0c4c0000 0x0 0x00010000>,
>>>>>>>>> +                       <0x0 0x0c42d000 0x0 0x00010000>;
>>>>>>>>
>>>>>>>> This is a patch from December 2021. Is there anything blocking 
>>>>>>>> it from
>>>>>>>> being merged?
>>>>>>>>
>>>>>>>> The same applies to several other patches here.
>>>>>>>
>>>>>>> As far as I know, Stephen still didn't pick up the spmi-pmic-arb 
>>>>>>> support
>>>>>>> for the PMIC on the SM8450 platform. Thus we also can not merge 
>>>>>>> the DT
>>>>>>> parts.
>>>>>>
>>>>>> Why we cannot merge DTS? How is DTS with new nodes depending on any
>>>>>> driver changes?
>>>>>
>>>>> In this particular case, there was an open question, what should be 
>>>>> the
>>>>> bindings for the PMIC ARB v7.
>>>>
>>>> Ah, so it is about PMIC ARB v7 bindings? Then it's reasonable to wait
>>>> with this one. I just had an impression that it's about driver 
>>>> changes...
>>>
>>> Yes, it's about binding. Thus we have been waiting for quite some time.
>>
>> Yes sadly Steven has stopped responding to emails or IRC.. I am not
>> sure whats going on!
>>
>> Even the SPMI tree is not being actively maintained with only few
>> patches which were picked in last cycle since this year!
> It's in -next now and 8450 boots and works fine. If the binding 
> situation has been resolved, I say merge this ASAP! :)
> 
> Konrad
With a small nit: it needs to be rebased, and should come between 
aoss_qmp: and ipcc: address-wise (ipcc wasn't around a year ago in this 
DT, it seems). Also most (all?) other nodes in the DT use reg = <0 [..]> 
instead of reg = <0x0 [..]> so that could be fixed up as well.

Konrad
>>
