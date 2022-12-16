Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A0964E9A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLPKom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiLPKoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:44:39 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C882420195
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:44:37 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bp15so2816687lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cascitiMZJymJK5H/7V6U/NhxDgbig8fvyO9Z0H1is=;
        b=MDRePVEZqWdRvz3zdkdDJAqx1QAVW4+M5gudltmZ4wQZSGF8BsFdraR/sViWm394yY
         sg1i2xIHFyJ+ePoQCC41w8IGoDPJZsKJHcbxa75L+ZHZbijNQ2J5mweb5FLhQBVxoJqy
         sm77dLroyQtEDD4dPLdgGKTkoZTwQ2LHlOAmzWFHKPc2nf95z6ONnHFzBGXYRGccdKSL
         ptKRrIilRbzgTaaDgJaRtw+fsQEDsUIohsJKOPRAO2fFjJWCLwe/JsoFGR3ibSrUdY5U
         Udngaz1BuYqXQdR2Z+SZ74KKL081Y5VscxfkBjF7SN9p4ut/RMYHd1iPrRVmbWed8C95
         xhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cascitiMZJymJK5H/7V6U/NhxDgbig8fvyO9Z0H1is=;
        b=PaAa11W9p8MD6H3CCXKhBgzHknlHGfa3KuuGrKy9FgcSaHHaGzwKmB3uqYZjnShgWH
         6kCyXmUxnM6dlbAqh74khlqQCRVUJG7NddjcHI8Vj2ZmT1XafevXSjjAkTxfdSZ4Q49Y
         6lZrk8bEB37SZz4KdmA+HIVrEqRSzg3Ighx2qIW7y73UzkXsM3CeRm6YOK5618yaGywO
         1Ft17YSrOBQ/kLl8uFBSaOMIDWgY8kRH4Xp9rP8WEGGGRPq/HgEAmcoOEYTr8rmT5dBa
         nP/lub9IOdgOUtw+SdtPTuyZydPjlHKArsqUELpCXWJtYsnb9ygwDB5hAJ2DM13hRw3v
         CW9w==
X-Gm-Message-State: ANoB5pnIb3s1fuz10RPFHUPuhZ1ys1j/+lrETBTXDi/gXD6yfDn6zq3v
        n0EVi6hSlSaSTJiESiNXsT4QnQ==
X-Google-Smtp-Source: AA0mqf4SY3Pf4YsUH69c+SCRnMVwvObDVtPW5qMlF4pMh1u0yMhiPgK51dE/+CzqyYNEJsrgTd0Arg==
X-Received: by 2002:a05:6512:3f04:b0:4b5:87da:8b29 with SMTP id y4-20020a0565123f0400b004b587da8b29mr11159658lfa.18.1671187476104;
        Fri, 16 Dec 2022 02:44:36 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s5-20020a05651c200500b0027a156078fesm114982ljo.100.2022.12.16.02.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 02:44:35 -0800 (PST)
Message-ID: <01f7ef3c-910e-43fc-5cbf-c4caf223dc7c@linaro.org>
Date:   Fri, 16 Dec 2022 11:44:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH] arm64: dts: qcom: Use labels with generic node names
 for ADC channels
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209215308.1781047-1-marijn.suijten@somainline.org>
 <3d5b29f3-8d8d-93a7-a485-5261e2d8891d@linaro.org>
 <20221210165434.3hhen5mgtvflghks@SoMainline.org>
 <20221211141526.463f43e6@jic23-huawei>
 <20221214204933.eo6sxodlnmcisc47@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214204933.eo6sxodlnmcisc47@SoMainline.org>
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

On 14/12/2022 21:49, Marijn Suijten wrote:
> On 2022-12-11 14:15:26, Jonathan Cameron wrote:
>> On Sat, 10 Dec 2022 17:54:34 +0100
>> Marijn Suijten <marijn.suijten@somainline.org> wrote:
>>
>>> On 2022-12-10 12:02:03, Krzysztof Kozlowski wrote:
>>>> On 09/12/2022 22:53, Marijn Suijten wrote:  
>>>>> As discussed in [1] the DT should use labels to describe ADC channels,
>>>>> with generic node names, since the IIO drivers now moved to the fwnode
>>>>> API where node names include the `@xx` address suffix.
>>>>>
>>>>> Especially for the ADC5 driver that uses extend_name - which cannot be
>>>>> removed for compatibility reasons - this results in sysfs files with the
>>>>> @xx name that wasn't previously present, and leads to an unpleasant
>>>>> file-browsing experience.
>>>>>
>>>>> Also remove all the unused channel labels in pm660.dtsi.
>>>>>
>>>>> [1]: https://lore.kernel.org/linux-arm-msm/20221106193018.270106-1-marijn.suijten@somainline.org/T/#u
>>>>>
>>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>  
>>>>
>>>> The talk was in context of bindings, not about changing all existing
>>>> users thus affecting DTS.  
>>>
>>> And as a consequence, DTS.  The already-merged transition from OF to
>>> fwnode resulted in `@xx` to be included in the ADC channel name - and in
>>> the case of ADC5 even in sysfs filenames - so this seems like a
>>> necessary change to make.
>>
>> Gah. We missed that at the time.  Arguably we should first fix that
>> particular issue as we will have lots of old DT out there.
>> (add a bit of code to strip the @xxx bit from that particular usecase).
>> It gets tricky because now we might have code relying on the new
>> broken behavior.
> 
> Before rushing to fix that, my idea was to simply only read DT labels in
> the driver, and otherwise fall back to the hardcoded names inside that
> IIO driver (again: ADC5 defines friendly names in the driver, but
> doesn't ever reference them besides a worthless non-NULL check).
> 
>>> At the very least I would have changed the bindings submitted or
>>> co-authored /by myself/ since I initially decided to rely on this (now
>>> obviously) wrong behaviour, and should have used labels from the get go.
>>>
>>>> What's more, to me "skin-temp-thermistor" is
>>>> quite generic name, maybe "thermistor" would be more and reflects the
>>>> purpose of the node, so it was more or less fine.  
>>>
>>> Are you suggesting to not use "adc-chan", but "thermistor" as node name
>>> (and still use skin_temp as label)?  Or to keep the fully-written-out
>>> "thermistor" word in the label?
>>>
>>>> Anyway I am against such changes without expressing it in the bindings.  
>>>
>>> As expressed in [1] I suggested and am all for locking this change in
>>> via bindings, and you are right to expect that to have gone paired with
>>> this patch.
>>>
>>> I'll submit that as the leading patch to this in v2, with the wildcard
>>> pattern changed to adc-chan (or something else pending the discussion
>>> above), and should I then also require the label property via `label:
>>> true`?
>>>
>>> [1]: https://lore.kernel.org/linux-arm-msm/20221208101232.536i3cmjf4uk2z52@SoMainline.org/
>>
>> So the 'fun' here is what to do with old DTS as we need to support that
>> even if we update the binding docs and all in kernel users.
> 
> Personally I have never cared about backwards compat as all my devices
> rely on the DT and drivers to be brought up in tandem, but yes that is a
> problem for others...

Yeah, but we do not accept patches with each other person point of view
of ABI. ABI rules are generic, otherwise it would not be ABI, right?

> 
>> Probably right option in driver is:
>> a) Use label if present
>> b) Use node name if it's not adc-chan but strip the @xxx off it.
> 
> Perhaps we can skip this entirely: as shown by this patch the use of
> node names instead of labels is limited to "newer" devices and SoCs,
> given their "active" development leads to the assumption they must also

Only SM8550, SC8280xp and maybe SM8450 qualify to such "active"
development platforms.

> flash their kernel and DTB updates in tandem? 

No, DTS is used outside in other projects and out of tree kernels. Just
because you use them together does not change the requirements of DTS
and kernel of not breaking other users, without clear, justified reason.

Best regards,
Krzysztof

