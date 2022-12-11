Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612C264961E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiLKUMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLKUL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:11:58 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4904CD2E1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:11:55 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 1so15299467lfz.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A0OWNKlbeOkPe9L1NS206ZBEmQO1vAikJVPG0qmLgEk=;
        b=xNq0tno4eHxGvl6EDMTGkeWOKGQIIB86C4Sy5Gro6+3AAJAmXYRrS9DHabRwDJVfbF
         VmVlAHx3jY4fjfkQpHCakOm0+2Z/ml46g6LOPd13KnVoaStQEMcsrXpzQ2jWoUAF+ugX
         g+WTVx44A5WWL5btufRAzJnJcKnUgpqlpP612Fm6GZWsVjx92v8DYUmbq9vCQuU3zsq0
         T/xIjwmuFhBYpn/sjCVx2dkzM8tjfcHhJie3obN6scgNSTRjDc6SWZbbIhBVVqKn3ytP
         vbf/CdS+x8mITi0tNTFPzMR88zJ30pCcK9j86jisKE4rV2+eqDpYQKjTe01ueE8iLmLe
         SVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0OWNKlbeOkPe9L1NS206ZBEmQO1vAikJVPG0qmLgEk=;
        b=0zyOsMRrv5MV4fEElX8SpI5/RsLPpd+JDw7jYBZrilvp7XuFk9WxJZP07r0Rvgi2qL
         eKOx1Ezyk8gIFJuKRGu1aHBLFht0U1e3WS66lQwIztR58Ljaobd2yGBiXeIKYickRFvy
         ELaXYp15mCjxjimrlq0voSkgTIgANZXbcBFpIYJTPTQ/1EAc0WpO1Fuk07CLwtj3nGql
         IqHtPWYublIMfbZhWp8bB1CEf0M+YzHNohAmHTynUNTCTrKP3H3smbRZj94r5zCvuZSf
         FHIbnHoUsBywgrZr01P7ncBorWwUDJf6p1EOQySySmX9M04y+AKypzuzK/hgOgHnCRO9
         xJ8g==
X-Gm-Message-State: ANoB5pnFEbC/sNNzDRJT2HH1ay7HuuiLCtc0SMEnk/7zBcLh8YldXlND
        ZEUctzQEkCLjJQikeOpP2mEBzA==
X-Google-Smtp-Source: AA0mqf6ECTxubNG56VQO3fJn67Skx7uGGKuWK9StzoRZc5C/F5YoeODZ0IIbj5+badtCnmtBjQtQpQ==
X-Received: by 2002:a05:6512:3495:b0:4b5:5616:ecd2 with SMTP id v21-20020a056512349500b004b55616ecd2mr3323177lfr.55.1670789513224;
        Sun, 11 Dec 2022 12:11:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j5-20020a056512028500b004b59871f457sm1315412lfp.247.2022.12.11.12.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 12:11:52 -0800 (PST)
Message-ID: <cd23d45c-f0a0-d81f-5230-a7de2bb90c07@linaro.org>
Date:   Sun, 11 Dec 2022 21:11:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add configuration for PMI8950
 peripheral
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20221101161801.1058969-1-luca@z3ntu.xyz>
 <36eb03e8-aace-f7ce-edc8-53715021c0ea@linaro.org>
 <20221208112055.m7sqg3ysxzskqjp4@SoMainline.org> <5740737.DvuYhMxLoT@g550jk>
 <20221209203851.sy37qqzczoaruuyb@SoMainline.org>
 <4846bb5f-79a9-e199-6a1c-5021e975e7ee@linaro.org>
 <20221210163121.woacrjuicb3vuzcn@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221210163121.woacrjuicb3vuzcn@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
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

On 10/12/2022 17:31, Marijn Suijten wrote:
> On 2022-12-10 11:58:24, Krzysztof Kozlowski wrote:
>> On 09/12/2022 21:38, Marijn Suijten wrote:
>>> On 2022-12-09 17:54:50, Luca Weiss wrote:
>>>> On Donnerstag, 8. Dezember 2022 12:20:55 CET Marijn Suijten wrote:
>>>>> On 2022-12-08 11:23:17, Krzysztof Kozlowski wrote:
>>>>>> On 08/12/2022 11:12, Marijn Suijten wrote:
>>>>>>> On 2022-12-04 17:19:05, Luca Weiss wrote:
>>>>>>>> On Freitag, 2. Dezember 2022 10:36:58 CET Marijn Suijten wrote:
>>>>>>>> [..]
>>>>>>>>
>>>>>>>> So the way this patch does it is good or does it need changes?
>>>>>>>
>>>>>>> Except the typo(s?) pointed out in my first reply, this is good to go.
>>>>>>>
>>>>>>> If we stick with generic adc-chan node names that should be documented
>>>>>>> in the bindings IMO, as it is currently only captured implicitly in the
>>>>>>> examples.  Krzysztof, what is your thought on this?
>>>>>>
>>>>>> If I understand correctly, the outcome of other discussion [1] was to
>>>>>> use labels and generic node names.
>>>>>
>>>>> The outcome was to use labels in the driver and disregard node names as
>>>>> the new fwnode API clobbers those names by including the @xx register
>>>>> bit.
>>>>>
>>>>> (I'll follow up with Jonathan whether or not to remove the current
>>>>> fallback to node names, as [1] ended up discussing many different issues
>>>>> and nits)
>>>>>
>>>>>> In such case the patch was correct
>>>>>> (except other comments).
>>>>>
>>>>> As a consequence it _doesn't matter_ how nodes are named, and we _can_
>>>>> use generic node names.  My question for you is whether we should, and
>>>>> if we should lock that in via dt-bindings to guide everyone towards
>>>>> using labels (which i did _not_ do in the recently-landed PM8950 and
>>>>> PM6125, but will send followup for).
>>>>
>>>> FYI the patch has been merged already and is now in linux-next
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm64/boot/dts/qcom/pmi8950.dtsi?id=0d97fdf380b478c358c94f50f1b942e87f407b9b
>>>>
>>>> If you have any changes that need to be done please send a follow-up patch.
>>>
>>> Unfortunately saw that today as well, well after sending this reply.  I
>>> would've loved to correct the pmi8950_gpio label _gpios before someone
>>
>> I don't understand what is there to correct. The "pmi8950_gpio" is a
>> correct label. There is no single rule saying label should have "s" at
>> the end. The only rules are: using underscores and having similar naming
>> (e.g. mdss_ for all display labels).
> 
> If we were able to have rules for labels, would I then be allowed to
> "correct" this?

If we had rules, yes. But we do not have. That's like - I will rename
all variables because of some non-existing rules... There is no rule, no
coding style (except what I wrote)...

>  The inconsistency between DTs is /super/ annoying (and
> it looks wrong to have a singular _gpio named thing contain /multiple
> gpios/), 

What do you mean - looks wrong? It's just a label which does not matter,
so how it can be wrong?

> but just because we can't express this in dt-bindings (or so I
> think) we shouldn't change it?

No, it just does not matter, so there is no benefit to change it, in my
opinion, if label is readable and follows generic convention
(underscores). Of course someone might treat its readability different
and maybe for someone the missing "s" at the end is important. I am just
saying that, unlike the node names, the label has little impact/effect.

However just be clear - this change also does not harm, so I am
perfectly fine with it.

Best regards,
Krzysztof

