Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70CA6FDB4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjEJKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbjEJKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:05:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A2C65BF
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:05:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bd875398dso10675092a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683713144; x=1686305144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jKt286KS5/9lbpQtTUhslsELt909PREUjMgX9aHY/0=;
        b=ZJhtXTPDbi/qNTFrKEFjdK9wa0NbOmtBAiFmWdwJ4+yB3TAgtsXreIz9C46zJUANnG
         PtFcuzYgiVVMd4ddD1fo1k2dRnj9JFFmOtgOfXVAy4v9BSQv5lUtMKXXLslhQOyZc54H
         HMW6/35OjPJV0RtysX0CY14uDchv7N6IOyuVSZM4HEZB24p00Kb9MSyqp0ymQNdgJYf7
         d/aS4vabah+cej+ReS8uFrUnZwVyNibT5Vk7bt6kTpMMi/aB2Ea4irCb+NoAGzYi+As+
         YRsE9vFoTTExz5OfkBuqw0FBKBS4/QiHWOonL6z/eH9ClxZLFBvNjfepmzEuuL6LZfzm
         W77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683713144; x=1686305144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jKt286KS5/9lbpQtTUhslsELt909PREUjMgX9aHY/0=;
        b=EfE+YE3Omez/NYDewrL0T4MESA32uEa52sbiRKJYpPf3OO0rNiwistNV7Nlmjtx+s1
         AOla+8ShcLj+kJ4h+3nUT0IW/HxQDPKPGlc8/VV126meiHktQxSen9teHygTRimVMquu
         9vj/Vv9THEFkMdWyj8FMSntxu/JU2OIuAIm1VSwbEZLAQ4pHqj4u/fiA9+Xq/mglz86P
         RKIIsmosWx9rU5ofmzwencwRo861b4JIQjTaIYsxZjLiwHhWBxFpy85HGSM6VuY2RMor
         lEBp9Ev+BK9QUPw9rgBW/j7oWsb+qp5hjFagxXNWWwRxwb7tTd/J1ENUA4UYHisNOXO8
         WPhQ==
X-Gm-Message-State: AC+VfDy3CS2HNvgoJnYc+HFSLWyKN3ng846xWDAj4UvD+97F1BTc1hV2
        yFe4LB0DF4TBU2fuXci6IjjoOqphkzh9q74CV7A=
X-Google-Smtp-Source: ACHHUZ6SJaggu0T0c984P/D1GIbEYGJVgoI0k1sVocoNl6b/3/Uew6h6W3G9uDRyFOra5RgbUVd/5A==
X-Received: by 2002:a50:fb92:0:b0:50b:d270:6b6f with SMTP id e18-20020a50fb92000000b0050bd2706b6fmr15433060edq.4.1683713144236;
        Wed, 10 May 2023 03:05:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id w17-20020aa7d291000000b0050c524253dasm1767577edq.20.2023.05.10.03.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 03:05:43 -0700 (PDT)
Message-ID: <9040e9bb-a16c-0186-edba-da986350340c@linaro.org>
Date:   Wed, 10 May 2023 12:05:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: pm7250b: make SID configurable
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230407-pm7250b-sid-v1-0-fc648478cc25@fairphone.com>
 <20230407-pm7250b-sid-v1-2-fc648478cc25@fairphone.com>
 <f52524da-719b-790f-ad2c-0c3f313d9fe9@linaro.org>
 <CSIE9TYTQUHL.3E769C2Y4RAAO@otso>
 <c9eea8ec-b289-334c-9c0b-7c992184a265@linaro.org>
 <CAA8EJpoSpytSTm=y7oPD_SC+0-bd735KEczR1JgMc7RuMZ+A+g@mail.gmail.com>
 <CSIGK60CQSD8.1Q4SOANJRMASF@otso>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CSIGK60CQSD8.1Q4SOANJRMASF@otso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 10:34, Luca Weiss wrote:
> On Wed May 10, 2023 at 10:07 AM CEST, Dmitry Baryshkov wrote:
>> On Wed, 10 May 2023 at 09:55, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 10/05/2023 08:47, Luca Weiss wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On Fri Apr 7, 2023 at 10:27 AM CEST, Krzysztof Kozlowski wrote:
>>>>> On 07/04/2023 09:45, Luca Weiss wrote:
>>>>>> Like other Qualcomm PMICs the PM7250B can be used on different addresses
>>>>>> on the SPMI bus. Use similar defines like the PMK8350 to make this
>>>>>> possible.
>>>>>>
>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>>> ---
>>>>>>  arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
>>>>>>  1 file changed, 16 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>>>> index daa6f1d30efa..eeb476edc79a 100644
>>>>>> --- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
>>>>>> @@ -7,6 +7,15 @@
>>>>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>>>>  #include <dt-bindings/spmi/spmi.h>
>>>>>>
>>>>>> +/* This PMIC can be configured to be at different SIDs */
>>>>>> +#ifndef PM7250B_SID
>>>>>> +   #define PM7250B_SID 2
>>>>>
>>>>> Drop indentation, although anyway I am against this. Please don't bring
>>>>> new patterns of this at least till we settle previous discussion.
>>>>>
>>>>> https://lore.kernel.org/linux-arm-msm/46658cbb-fff5-e98b-fdad-88fa683a9c75@linaro.org/
>>>>
>>>> What's the outcome of the discussion? For this PMIC it's totally enough
>>>> to have the SID configurable like in this patch, I don't think this PMIC
>>>> will be included twice in a board - at least I'm not aware of such a
>>>> configuration.
>>>
>>> We did not reach consensus and I still disagree with complex macros or
>>> macros depending on order of inclusion.
>>
>> I still think we should find a way to parametrise PMIC dtsi, however I
>> agree with Krzysztof that complex CPP is not a way to go.
> 
> What about the macro already used in-tree and proposed with this patch?
> I wouldn't say this is a "complex macro" since it's just a single number
> being replaced in a few places.

Are you talking about the macro to which I responded: "or macros
depending on order of inclusion." or something else?

Best regards,
Krzysztof

