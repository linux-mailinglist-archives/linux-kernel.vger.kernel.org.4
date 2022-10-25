Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD38A60C7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiJYJVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiJYJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:20:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431E957E25;
        Tue, 25 Oct 2022 02:15:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so8026732wmb.2;
        Tue, 25 Oct 2022 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=L3cL9hwVxxgYxbdvufURLKd+4fQ6tHsN/7T//5flfK4=;
        b=ApoeYpc3MysTAdWPnaqpsoMjEaLM61adiuDH3vZ7v42DONj59KZ6P8takrH2S98ccp
         Fcjzz4saLkRk/3y6KpSWVmyL4HnQreYHj6M8mSn8lfo59EQMhFxBiRyShW21mYb/dbDL
         ZoLQhsvqbnkekkmsug6El//bmytnJlnE53ltFWurA2ftntoYNVLlHufKeYoq4SZ+2nCv
         BpuCXswqUAcOB4CO5r6GPRoG26+r/O/MhhzM5UMx437Z9YNYXVzf175s/4TEkaLUCk6b
         l/GdsD+VZGhT8wGuHoRn/qKdv9cnWyaAjr5r9II3boaXzXNGq4tA9YGCQ6DnafuIpeAQ
         r9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3cL9hwVxxgYxbdvufURLKd+4fQ6tHsN/7T//5flfK4=;
        b=KqXqqQ6L3LRtO2t9znwa8RBeBT4SPxPXXaxt0+sqRchpgYrPpsmtW5XZiZkT/KeC3W
         4qkmZgLSI7/Hbm/VqJOkQQwPtZU64wlH+dY5IZRlehnKn85mrehpfpATAVh4oCPdtNoq
         DHOZ7TB52iCapzsbpl/6/PO4/Xk3iZcePaO0RTrrZCBCMmZ3b5SzIF76gwYJ27uoUvAO
         MeWGtKX6VAu/RauS7uvO1QIUZNVQDH3DNFd7IIPZJML+FPs3ou1Vre/MMcMs0R0LQYKR
         aeDLAd1bCzYJwwKEAWOWSN2Ukdto6hgok4Aovd/AnmPuQqSiLXPK5JuswODwob7gyOj+
         PS+g==
X-Gm-Message-State: ACrzQf1kZNA7dY2KuKE5uzhA3Lj+5kYaLXRbkdd8Tj3O9GWeSfVnVvjv
        Wvm2+BzEmGY48LsPQtv8Lns=
X-Google-Smtp-Source: AMsMyM6+HxgSs8qN0tuLYvmcnvB8cVpip/9nCa1nA2ZJc3CfAuicjU8aMKdwWBbMyPQeFCRdA7Ob/Q==
X-Received: by 2002:a05:600c:4e45:b0:3cd:f141:b7d8 with SMTP id e5-20020a05600c4e4500b003cdf141b7d8mr7755802wmq.196.1666689300075;
        Tue, 25 Oct 2022 02:15:00 -0700 (PDT)
Received: from localhost (188.29.212.253.threembb.co.uk. [188.29.212.253])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b003c6cd82596esm10907736wmo.43.2022.10.25.02.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 02:14:59 -0700 (PDT)
References: <20221022162742.21671-1-aidanmacdonald.0x0@gmail.com>
 <20221022162742.21671-2-aidanmacdonald.0x0@gmail.com>
 <ef6a326b-5c61-988b-2ec2-cd8e233e5d28@linaro.org>
 <GMvEU8xVTkjIoQ518XWAaLkhldSZHlk7@localhost>
 <4ef59d94-d045-55fc-d531-c84e7edb8333@linaro.org>
 <hXRpArckbrXUelDdaJ3Y2SErmKiuycXt@localhost>
 <66c1a100-922e-4a33-e80c-fc80866acf03@linaro.org>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: ASoC: simple-card: Add
 system-clock-id property
In-reply-to: <66c1a100-922e-4a33-e80c-fc80866acf03@linaro.org>
Date:   Tue, 25 Oct 2022 10:14:59 +0100
Message-ID: <jZCUALhj8PoqVkuWdtLf8LnPAj1wDakF@localhost>
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

> On 24/10/2022 19:38, Aidan MacDonald wrote:
>>
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
>>
>>> On 23/10/2022 09:47, Aidan MacDonald wrote:
>>>>
>>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
>>>>
>>>>> On 22/10/2022 12:27, Aidan MacDonald wrote:
>>>>>> This is a new per-DAI property used to specify the clock ID argument
>>>>>> to snd_soc_dai_set_sysclk().
>>>>>
>>>>> You did no show the use of this property and here you refer to some
>>>>> specific Linux driver implementation, so in total this does no look like
>>>>>  a hardware property.
>>>>>
>>>>> You also did not explain why do you need it (the most important piece of
>>>>> commit msg).
>>>>>
>>>>>>
>>>>>> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/sound/simple-card.yaml | 8 ++++++++
>>>>>>  1 file changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
>>>>>> index ed19899bc94b..cb7774e235d0 100644
>>>>>> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
>>>>>> @@ -57,6 +57,12 @@ definitions:
>>>>>>        single fixed sampling rate.
>>>>>>      $ref: /schemas/types.yaml#/definitions/flag
>>>>>>
>>>>>> +  system-clock-id:
>>>>>> +    description: |
>>>>>> +      Specify the clock ID used for setting the DAI system clock.
>>>>>
>>>>>
>>>>> With lack of explanation above, I would say - use common clock framework
>>>>> to choose a clock...
>>>>>
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>
>>>> Sorry, I didn't explain things very well. The system clock ID is indeed
>>>> a property of the DAI hardware. The ID is not specific to Linux in any
>>>> way, and really it's an enumeration that requires a dt-binding.
>>>>
>>>> A DAI may support multiple system clock inputs or outputs identified by
>>>> the clock ID. In the case of outputs, these could be distinct clocks
>>>> that have their own I/O pins, or the clock ID could select the internal
>>>> source clock used for a clock generator. For inputs, the system clock ID
>>>> may inform the DAI how or where the system clock is being provided so
>>>> hardware registers can be configured appropriately.
>>>>
>>>> Really the details do not matter, except that in a particular DAI link
>>>> configuration a specific clock ID must be used. This is determined by
>>>> the actual hardware connection between the DAIs; if the wrong clock is
>>>> used, the DAI may not function correctly.
>>>>
>>>> Currently the device tree is ambiguous as to which system clock should
>>>> be used when the DAI supports more than one, because there is no way to
>>>> specify which clock was intended. Linux just treats the ID as zero, but
>>>> that's currently a Linux-specific numbering so there's guarantee that
>>>> another OS would choose the same clock as Linux.
>>>>
>>>> The system-clock-id property is therefore necessary to fully describe
>>>> the hardware connection between DAIs in a DAI link when a DAI offers
>>>> more than one choice of system clock.
>>>>
>>>> I will resend the patch with the above in the commit message.
>>>
>>> For example if you want to define which input pin to use (so you have
>>> internal mux), it's quite unspecific to give them some indexes. What is
>>> 0? What is 1? Number of pin? Number of pin counting from where?
>>>
>>> Since this is unanswered, the IDs are also driver and implementation
>>> dependent, thus you still have the same problem - another OS can choose
>>> different clock. That's not then a hardware description, but software
>>> configuration.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> I answered this already. The enumeration is arbitrary. Create some
>> dt-bindings and voila, it becomes standardized and OS-independent.
>
> Hm, then I missed something. Can you point me to DTS and bindings
> (patches or in-tree) which show this standardized indices of clock inputs?
>
> Best regards,
> Krzysztof

Device trees already use standardized enumerations in other areas so it
isn't a new idea. Look under include/dt-bindings/clock. Every header
there contains an arbitrary enumeration of a device's clocks. In fact
most of include/dt-bindings is exactly for this purpose, to define
standard values that are not "just numbers" but an enum, a flag, etc,
with a special meaning. It is not specific to clocks.

There is no dt-binding for system clock ID, because prior to this patch
they were not exposed to DT in any way. But the enumerations themselves
already exist, eg. the IDs for nau8821 codec:

    /* System Clock Source */
    enum {
        NAU8821_CLK_DIS,
        NAU8821_CLK_MCLK,
        NAU8821_CLK_INTERNAL,
        NAU8821_CLK_FLL_MCLK,
        NAU8821_CLK_FLL_BLK,
        NAU8821_CLK_FLL_FS,
    };

We would just be moving these into dt-bindings if somebody wants to
use a codec with simple-card. Future drivers would add the enum into
dt-bindings from the start because that's where it belongs.

Regards,
Aidan
