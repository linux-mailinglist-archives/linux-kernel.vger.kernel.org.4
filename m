Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A048B60C03F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiJYAzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJYAys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:54:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1410C1D3753;
        Mon, 24 Oct 2022 16:38:59 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu30so18376022wrb.8;
        Mon, 24 Oct 2022 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=uINnN2GHQROVBHy0xs24WDA9fdZGIwwuHPSB6D8DuTs=;
        b=AdE3d4TO018237MR782/QXsf+J0r9dEceAgrDW1PFNxiBs+UkjSYSQOlK+Av988gSq
         pC2fBlVd6LZgxxl8Q6D4ub06f1IYV7gP1B1R5CbqQw6ZM2B+pXt10cHUfTIbZah7QKC4
         NYNiLAWhZjKkaDkMX6Sv4LBkW1w4/IQxp232LUnXgIP/dQ7QyJCChjXYXMRBlj5VQ9SH
         bsvuexK4/+bwRB9U8gpCZ+8eNiHWRu+iAj9pmbdOxx7DsbybOLo6l1N03F/lpL8lzXXb
         A0FyXPeseFkeuRzvAXjAPJAIl6rszM0fV9SOE/q5NUbnZu2qIsMoGj+z10fJG5zj+9Go
         P2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uINnN2GHQROVBHy0xs24WDA9fdZGIwwuHPSB6D8DuTs=;
        b=1SxItpg4ZKfwOv7jLTBk6p+IQ1IuGbGWywO4kcPzE04K3V2Tdf6Gu1T5UszDUeor6I
         L220QBKBD2wCeIt9UOHET+NpbtZRkzwZYimVwJtXZxyJ/57t4EDTCxWemZZz/cFc7W3i
         hq7Jnd4DySQaitJ/YAEayeILKUL24rGOWfdE8v7fIJNk4ZxqKS+KJjq1M7tpLGmXlnzJ
         IuMmb1+QDggeZjCi/qnAFqPT22O+WxagKiNXUbFPh3WO1E3XCVXkaRpve9PxQyh7fzaV
         hjLfAtXXTCrdH+wR5YUI4tkfgzXU1bT9Ior17KKk9emhyCMJP162ObMTf8x61AipAZ3m
         ekIQ==
X-Gm-Message-State: ACrzQf06mJ+ZwGx92kikKouh7oou6Gh6C6WAQeZkw7xIdLFFxLamIr2A
        Sfw9ojzQGI7uDfmSriLqIKs=
X-Google-Smtp-Source: AMsMyM5u2rmG+7GZxp9w2eyvFqjRuht6OLVy3tzVXAe4A+h8TiDnquvfZC2i4xAvYj1QXrV/4tQLwA==
X-Received: by 2002:a05:6000:184:b0:236:7685:7e6d with SMTP id p4-20020a056000018400b0023676857e6dmr3918668wrx.305.1666654738132;
        Mon, 24 Oct 2022 16:38:58 -0700 (PDT)
Received: from localhost (94.197.2.59.threembb.co.uk. [94.197.2.59])
        by smtp.gmail.com with ESMTPSA id a15-20020adffacf000000b002366e3f1497sm916284wrs.6.2022.10.24.16.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 16:38:57 -0700 (PDT)
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
 <ef6a326b-5c61-988b-2ec2-cd8e233e5d28@linaro.org>
 <GMvEU8xVTkjIoQ518XWAaLkhldSZHlk7@localhost>
 <4ef59d94-d045-55fc-d531-c84e7edb8333@linaro.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add
 system-clock-id property
In-reply-to: <4ef59d94-d045-55fc-d531-c84e7edb8333@linaro.org>
Date:   Tue, 25 Oct 2022 00:38:56 +0100
Message-ID: <hXRpArckbrXUelDdaJ3Y2SErmKiuycXt@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 23/10/2022 09:47, Aidan MacDonald wrote:
>>
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
>>
>>> On 22/10/2022 12:27, Aidan MacDonald wrote:
>>>> This is a new per-DAI property used to specify the clock ID argument
>>>> to snd_soc_dai_set_sysclk().
>>>
>>> You did no show the use of this property and here you refer to some
>>> specific Linux driver implementation, so in total this does no look like
>>>  a hardware property.
>>>
>>> You also did not explain why do you need it (the most important piece of
>>> commit msg).
>>>
>>>>
>>>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/sound/simple-card.yaml | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
>>>> index ed19899bc94b..cb7774e235d0 100644
>>>> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
>>>> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
>>>> @@ -57,6 +57,12 @@ definitions:
>>>>        single fixed sampling rate.
>>>>      $ref: /schemas/types.yaml#/definitions/flag
>>>>
>>>> +  system-clock-id:
>>>> +    description: |
>>>> +      Specify the clock ID used for setting the DAI system clock.
>>>
>>>
>>> With lack of explanation above, I would say - use common clock framework
>>> to choose a clock...
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Sorry, I didn't explain things very well. The system clock ID is indeed
>> a property of the DAI hardware. The ID is not specific to Linux in any
>> way, and really it's an enumeration that requires a dt-binding.
>>
>> A DAI may support multiple system clock inputs or outputs identified by
>> the clock ID. In the case of outputs, these could be distinct clocks
>> that have their own I/O pins, or the clock ID could select the internal
>> source clock used for a clock generator. For inputs, the system clock ID
>> may inform the DAI how or where the system clock is being provided so
>> hardware registers can be configured appropriately.
>>
>> Really the details do not matter, except that in a particular DAI link
>> configuration a specific clock ID must be used. This is determined by
>> the actual hardware connection between the DAIs; if the wrong clock is
>> used, the DAI may not function correctly.
>>
>> Currently the device tree is ambiguous as to which system clock should
>> be used when the DAI supports more than one, because there is no way to
>> specify which clock was intended. Linux just treats the ID as zero, but
>> that's currently a Linux-specific numbering so there's guarantee that
>> another OS would choose the same clock as Linux.
>>
>> The system-clock-id property is therefore necessary to fully describe
>> the hardware connection between DAIs in a DAI link when a DAI offers
>> more than one choice of system clock.
>>
>> I will resend the patch with the above in the commit message.
>
> For example if you want to define which input pin to use (so you have
> internal mux), it's quite unspecific to give them some indexes. What is
> 0? What is 1? Number of pin? Number of pin counting from where?
>
> Since this is unanswered, the IDs are also driver and implementation
> dependent, thus you still have the same problem - another OS can choose
> different clock. That's not then a hardware description, but software
> configuration.
>
> Best regards,
> Krzysztof

I answered this already. The enumeration is arbitrary. Create some
dt-bindings and voila, it becomes standardized and OS-independent.

Regards,
Aidan
