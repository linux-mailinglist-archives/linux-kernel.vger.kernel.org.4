Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8651E60C05E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiJYBD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiJYBCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:02:51 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA299F74E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:00:36 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w3so6613866qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/j0Xsp8ctwAFkupwJKkm+zIMffF/UdzV3EBPlII/wU=;
        b=IuFL3U1s9yN1WOz0rYkYA9VxYXo5/AJPTDykTqJFuOWTvbPkqKX0jKoplgArSuN4OJ
         PvaPx3BkDA2gcFXaKyJyo3BhymQn/IMdzNOditFgRovZNdCJo0GfTs7b9Vu7Q+KFw5Gh
         lEWQW7yzbp/PJkKLdCrMhxBYHinjjF5Wza3OfdVDsJYKXxuItGUYencvNvKaAT/aNKZb
         QJ3cvY4lfRZ9JKtP0OmDb98NCE/SC7wub47/ycMxBq/xPxXynvpEezFkNIYsI+tW3hJ+
         w1I9WvcRLUnYJlLaEcJIObLYA2wrBvD8wjAOdpPADqq6Iif2YlApxQvSWDqI94fmZF9b
         EvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/j0Xsp8ctwAFkupwJKkm+zIMffF/UdzV3EBPlII/wU=;
        b=cKs7laoh00DtkWVmoWOxFoRkjlb2jimbS563ayUCz910XWvBCNUuI8dJn0M7MhsRmf
         28mQlZo4NtqCoa6kz1e1Xwhf6eQxneULCPcgR1ouJL0Q/4LemlTKxPImXJqVpFnGTUTI
         yqlGFjC2T1qJ3/q0dSOPrHHR0gzNGbgYNwLGlMn98vN7r7FIqgCUONK7bAWjm5B8gK9D
         aXKx5qkmZjKJcL/+tgCdV9aLB4LLlAVLL2DQxX/YCE+bbT51JwHOWn3VfCwL5QmRmz24
         jd1JRSNkRSuB/eUoC4kMdBSgT3TDEdDT7ZyHSCpKExCo/gjd5ekUSEZidBpPJq/f+/3b
         rM9A==
X-Gm-Message-State: ACrzQf23tBFZh2Q+CGqto1f6PrqVMUdlWdz3k7Y78uFRmieVmiz5uM/6
        claw5TFt7kRtAGQRlaJcCdf2MQ==
X-Google-Smtp-Source: AMsMyM42hi1tpbDf1iJoMIIxoVi507r7li3UkKjHg7v4az7A4vWtdQpOS7TAZj2KfbuAADsLcLxjtQ==
X-Received: by 2002:a05:622a:4d4:b0:39c:7e8c:d740 with SMTP id q20-20020a05622a04d400b0039c7e8cd740mr29523202qtx.282.1666656035178;
        Mon, 24 Oct 2022 17:00:35 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id d2-20020ac80602000000b0039853b7b771sm684879qth.80.2022.10.24.17.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:00:34 -0700 (PDT)
Message-ID: <66c1a100-922e-4a33-e80c-fc80866acf03@linaro.org>
Date:   Mon, 24 Oct 2022 20:00:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add
 system-clock-id property
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
 <ef6a326b-5c61-988b-2ec2-cd8e233e5d28@linaro.org>
 <GMvEU8xVTkjIoQ518XWAaLkhldSZHlk7@localhost>
 <4ef59d94-d045-55fc-d531-c84e7edb8333@linaro.org>
 <hXRpArckbrXUelDdaJ3Y2SErmKiuycXt@localhost>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <hXRpArckbrXUelDdaJ3Y2SErmKiuycXt@localhost>
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

On 24/10/2022 19:38, Aidan MacDonald wrote:
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> On 23/10/2022 09:47, Aidan MacDonald wrote:
>>>
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
>>>
>>>> On 22/10/2022 12:27, Aidan MacDonald wrote:
>>>>> This is a new per-DAI property used to specify the clock ID argument
>>>>> to snd_soc_dai_set_sysclk().
>>>>
>>>> You did no show the use of this property and here you refer to some
>>>> specific Linux driver implementation, so in total this does no look like
>>>>  a hardware property.
>>>>
>>>> You also did not explain why do you need it (the most important piece of
>>>> commit msg).
>>>>
>>>>>
>>>>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/sound/simple-card.yaml | 8 ++++++++
>>>>>  1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
>>>>> index ed19899bc94b..cb7774e235d0 100644
>>>>> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
>>>>> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
>>>>> @@ -57,6 +57,12 @@ definitions:
>>>>>        single fixed sampling rate.
>>>>>      $ref: /schemas/types.yaml#/definitions/flag
>>>>>
>>>>> +  system-clock-id:
>>>>> +    description: |
>>>>> +      Specify the clock ID used for setting the DAI system clock.
>>>>
>>>>
>>>> With lack of explanation above, I would say - use common clock framework
>>>> to choose a clock...
>>>>
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> Sorry, I didn't explain things very well. The system clock ID is indeed
>>> a property of the DAI hardware. The ID is not specific to Linux in any
>>> way, and really it's an enumeration that requires a dt-binding.
>>>
>>> A DAI may support multiple system clock inputs or outputs identified by
>>> the clock ID. In the case of outputs, these could be distinct clocks
>>> that have their own I/O pins, or the clock ID could select the internal
>>> source clock used for a clock generator. For inputs, the system clock ID
>>> may inform the DAI how or where the system clock is being provided so
>>> hardware registers can be configured appropriately.
>>>
>>> Really the details do not matter, except that in a particular DAI link
>>> configuration a specific clock ID must be used. This is determined by
>>> the actual hardware connection between the DAIs; if the wrong clock is
>>> used, the DAI may not function correctly.
>>>
>>> Currently the device tree is ambiguous as to which system clock should
>>> be used when the DAI supports more than one, because there is no way to
>>> specify which clock was intended. Linux just treats the ID as zero, but
>>> that's currently a Linux-specific numbering so there's guarantee that
>>> another OS would choose the same clock as Linux.
>>>
>>> The system-clock-id property is therefore necessary to fully describe
>>> the hardware connection between DAIs in a DAI link when a DAI offers
>>> more than one choice of system clock.
>>>
>>> I will resend the patch with the above in the commit message.
>>
>> For example if you want to define which input pin to use (so you have
>> internal mux), it's quite unspecific to give them some indexes. What is
>> 0? What is 1? Number of pin? Number of pin counting from where?
>>
>> Since this is unanswered, the IDs are also driver and implementation
>> dependent, thus you still have the same problem - another OS can choose
>> different clock. That's not then a hardware description, but software
>> configuration.
>>
>> Best regards,
>> Krzysztof
> 
> I answered this already. The enumeration is arbitrary. Create some
> dt-bindings and voila, it becomes standardized and OS-independent.

Hm, then I missed something. Can you point me to DTS and bindings
(patches or in-tree) which show this standardized indices of clock inputs?

Best regards,
Krzysztof

