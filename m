Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD62746945
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGDF5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGDF52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:57:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F791E5B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 22:57:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso6150964a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 22:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688450245; x=1691042245;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ArafajhkK4cFBXCxi4x8GmLW6nX9wjFH15qR/2p7CyM=;
        b=NtZsucGnDSuql+9fvbmGD0BxyvMogak6Y5smEqXX8YVtwaMtHZZ1C/TGlyDDoMak1a
         haGaMkG1VU2aV8G9ouvmhF2bUT4R7l4z7IpK6rWEsQOIASdpe/ETlyxhdNMHA1K0IAXI
         nuqu7D3vk1N5XXGoxqp97McDiFeIx/d2WDA8EXrw/d4mjEHvqQ9Xm/NQoidg4jGB/4tn
         LQyQINMHJ0B6gUmy6EKdTmk9v8aoK/SbhVsxA7v90azH6n7VT5YSeuUuoLCFlvH9R0G4
         ovqIMFrBmkbIyBLF5UOq/9OGMltcQdmd2K73ozPB/ooxRpFAkVe78oy5UYKqy/j5tswu
         V7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688450245; x=1691042245;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArafajhkK4cFBXCxi4x8GmLW6nX9wjFH15qR/2p7CyM=;
        b=LY6oaGwOt15tqONljtame3giQFD+y9XZSSLJkMYtZWZYzN6KHEj9rsBk0woG69LzJ+
         RkLYvRDmQaUea5hxLRPlIoyKODGReVoyFVZ1SLDQz+kFuPpsy8ji7AF2inw/hIONcRlH
         +N8KRp5jNB9zmTKeWENmXuhpgsooT9ddGA3ndxDoaEB3ufwjlvRsFpQG+OctVeraf4SN
         2Im37TUoFE7Siw3xE/C2U18U+HGx28ICg+Vx10BTIKrvd8Uo2qHrEPfXirl6Uo+Olxrk
         57SH4RL0LgdwZ+7s+WeHmneUZkILtXloppoqaeL0DritoeoP/RNKqM5s+CWGj3DNmRcE
         SYhQ==
X-Gm-Message-State: ABy/qLYldo6whYHLg7kpOomhjM9Gbb/frBZYyAYy7bn3r4R23babHuAy
        TsZVlvEwbaYeU53IbgDcSkeONQ==
X-Google-Smtp-Source: APBJJlGLdz4OnkPHg9QESQPK4xkTqc+rD1zI9xMSBTVlJ3pUKrE8wYmXdm39x7xyr77A57uxd3eyPg==
X-Received: by 2002:a05:6402:5149:b0:51d:9bf3:40c5 with SMTP id n9-20020a056402514900b0051d9bf340c5mr8832051edd.20.1688450245125;
        Mon, 03 Jul 2023 22:57:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i21-20020a05640200d500b0051bfc7763c2sm11462697edu.25.2023.07.03.22.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 22:57:24 -0700 (PDT)
Message-ID: <f0609361-6fb6-a446-4e23-646201943923@linaro.org>
Date:   Tue, 4 Jul 2023 07:57:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 08/21] dt-bindings: reserved-memory: Add qcom,ramoops
 binding
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-9-git-send-email-quic_mojha@quicinc.com>
 <CAL_JsqJ_TTnGjjB2d8_FKHpWBRG5GHLoWnabCKjsdeZ4QFdNEg@mail.gmail.com>
 <cacbbb02-732e-076e-50bf-292d20a4d722@quicinc.com>
 <58a26b9e-a48d-d567-c310-193a2c52521e@linaro.org>
 <5447f9f8-55b4-8bed-66a6-1c9d62b02c79@quicinc.com>
 <CAGE=qrq0CuO4J-6yC=YZ4xjL67o9QTqpei0ovX-X_8MLVeEH6g@mail.gmail.com>
 <ba04bb7b-6599-6f41-09a8-834ee280830d@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ba04bb7b-6599-6f41-09a8-834ee280830d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 17:55, Mukesh Ojha wrote:
> 
> 
> On 7/3/2023 12:50 PM, Krzysztof Kozlowski wrote:
>> On Mon, 3 Jul 2023 at 08:22, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>> On 7/2/2023 1:42 PM, Krzysztof Kozlowski wrote:
>>>>>> The big difference is if firmware is not deciding where this log
>>>>>> lives, then it doesn't need to be in DT. How does anything except the
>>>>>> kernel that allocates the log find the logs?
>>>>>
>>>>> Yes, you are correct, firmware is not deciding where the logs lives
>>>>> instead here, Kernel has reserved the region where the ramoops region
>>>>> lives and later with the minidump registration where, physical
>>>>> address/size/virtual address(for parsing) are passed and that is how
>>>>> firmware is able to know and dump those region before triggering system
>>>>> reset.
>>>>
>>>> Your explanation does not justify storing all this in DT. Kernel can
>>>> allocate any memory it wishes, store there logs and pass the address to
>>>> the firmware. That's it, no need for DT.
>>>
>>> If you go through the driver, you will know that what it does, is
>>
>> We talk about bindings and I should not be forced to look at the
>> driver to be able to understand them. Bindings should stand on their
>> own.
> 
> Why can't ramoops binding have one more feature where it can add a flag 
> *dynamic* to indicate the regions are dynamic and it is for platforms
> where there is another entity 'minidump' who is interested in these
> regions.

Because we do not define dynamic stuff in Devicetree. Dynamic means
defined by SW or runtime configurable. It is against the entire idea of
Devicetree which is for non-discoverable hardware.

> 
>>
>>> just create platform device for actual ramoops driver to probe and to
>>
>> Not really justification for Devicetree anyway. Whatever your driver
>> is doing, is driver's business, not bindings.
>>
>>> provide this it needs exact set of parameters of input what original
>>> ramoops DT provides, we need to keep it in DT as maintaining this in
>>> driver will not scale well with different size/parameter size
>>> requirement for different targets.
>>
>> Really? Why? I don't see a problem in scaling. At all.
> 
> I had attempted it here,
> 
> https://lore.kernel.org/lkml/1683133352-10046-10-git-send-email-quic_mojha@quicinc.com/
> 
> but got comments related to hard coding and some in favor of having
> the same set of properties what ramoops has/provides
> 
> https://lore.kernel.org/lkml/e25723bf-be85-b458-a84c-1a45392683bb@gmail.com/
> 
> https://lore.kernel.org/lkml/202305161347.80204C1A0E@keescook/

Then you were tricked. I don't get why someone else suggests that
non-hardware property should be part of Devicetree, but anyway it's the
call of Devicetree binding maintainers, not someone else. DT is not
dumping ground for all the system configuration variables.


>>
>>>
>>>>
>>>>>
>>>>> A part of this registration code you can find in 11/21
>>>>>
>>>>>> I'm pretty sure I already said all this before.
>>>>>
>>>>> Yes, you said this before but that's the reason i came up with vendor
>>>>> ramoops instead of changing traditional ramoops binding.
>>>>
>>>> That's unexpected conclusion. Adding more bindings is not the answer to
>>>> comment that it should not be in the DTS in the first place.
>>>
>>> Please suggest, what is the other way being above text as requirement..
>>
>> I do not see any requirement for us there. Forcing me to figure out
>> how to add non-hardware property to DT is not the way to convince
>> reviewers. But if you insist - we have ABI for this, called sysfs. If
>> it is debugging feature, then debugfs.
> 
> ramoops already support module params and a way to pass these parameters
> from bootargs but it also need to know the hard-codes addresses, so, 
> doing something in sysfs will be again duplication with ramoops driver..

Why do you need hard-coded addresses?

> 
> If this can be accommodated under ramoops, this will be very small 
> change, like this
> 
> https://lore.kernel.org/lkml/20230622005213.458236-1-isaacmanjarres@google.com/

That's also funny patch - missing bindings updated, missing CC DT
maintainers.

Best regards,
Krzysztof

