Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E91F6F01D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbjD0HfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbjD0HfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:35:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66BE1735;
        Thu, 27 Apr 2023 00:35:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-2f7c281a015so5017143f8f.1;
        Thu, 27 Apr 2023 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682580903; x=1685172903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eehz0WgMbOurSIoTnBIR5YZf1U7dK+275MjB8D7bXEc=;
        b=SwqylI/doMt0gYknw43Bx8zjaJNyMHrvEpQkGw+g4Ib3newQ9JpdkJdmZ6ipTs96no
         Dp3r9iKTeeSQhoUjZ13+SEzNOuXyfwaeeI3lFai0HnN7CHm4LPqyG3S0CSqPNSDY9uk1
         50e6Ja8Qkwh2mSWflVAqgnvGn4/Ol9tEQzZ/2KRvb/kmEGIm7injuF78ugqsmZTkt5ra
         cgQVDE3ESBQZEbqh/ZnC/8EzgPtaX312ttnjQfSh6+FvJtzF0Rbug8+RvOsuz3znKPBp
         TFF1UATHxOHVncKtTmITIMvSyjNA7tCQM9YzgOaEM4MhQbcOyu7OrnZz5u8J4Q7NUi4x
         MDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682580903; x=1685172903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eehz0WgMbOurSIoTnBIR5YZf1U7dK+275MjB8D7bXEc=;
        b=kMGoT0NSnQDe0iDAjHDVq+KLrrjS+/9YFrswCY6uG5efC75ug8q6eYPwnjNCl7MH7l
         MF/gJuGEDTHBT1rFQHzbeAOXOoHiAnewx7FEYOiOYnXCXtVD31a9vs5vhQVPDsADZNqa
         FL96uTVTjCFkhzpwWxCCNzYlhYtGKc2Undno6kWEkdBumZqQLz/rovjkfwZSTPVddaV3
         RB0vJ2XRcoFyj1jCcej0iC5LZDQivOt55o1NF6e+QNMsf855XBpzqPc4zsT7c1LjgeBJ
         OH3M1NlI8AiUIlqAV/TmcJiHy6BJGnSXhOlpXd6Q71AqrNKUmMO/wYjSzDiyDlijTufB
         J0JQ==
X-Gm-Message-State: AC+VfDywJ/aLmhNpaKznpHocxyO/xaQh4osi9jya0h4Ec+W7MwFCgYhB
        j48mHRF1DMTumsdOFiYdQpzdbFI5MtBWFg==
X-Google-Smtp-Source: ACHHUZ59rjOQWXhXKCgkzaGgJ+NbkVRQ83Bem9iGHGoCtXBjm4Ktg2fzITEfCQryin68ol70bxlnKA==
X-Received: by 2002:a05:6000:510:b0:2f1:d17f:cf95 with SMTP id a16-20020a056000051000b002f1d17fcf95mr500077wrf.12.1682580902709;
        Thu, 27 Apr 2023 00:35:02 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b9-20020adfee89000000b002f777345d21sm17659980wro.95.2023.04.27.00.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 00:35:01 -0700 (PDT)
Message-ID: <273a9ff1-ceb2-bcf6-b3a5-be34746ed45f@gmail.com>
Date:   Thu, 27 Apr 2023 09:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Content-Language: en-US, ca-ES, es-ES
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CA+_ehUw3eAEHRsi1ATSKeK4jtX+EoVSwUodNL3bcpTJaX-r9cA@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CA+_ehUw3eAEHRsi1ATSKeK4jtX+EoVSwUodNL3bcpTJaX-r9cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/04/2023 00:23, Ansuel Smith wrote:
> Il giorno mar 25 apr 2023 alle ore 00:10 Rob Herring
> <robh+dt@kernel.org> ha scritto:
>>
>> On Tue, Mar 29, 2022 at 8:27 AM Ansuel Smith <ansuelsmth@gmail.com> wrote:
>>>
>>> On Tue, Mar 29, 2022 at 03:20:18PM +0200, Krzysztof Kozlowski wrote:
>>>> On 28/03/2022 02:09, Ansuel Smith wrote:
>>>>> Hi,
>>>>> as the title say, the intention of this ""series"" is to finally categorize
>>>>> the ARM dts directory in subdirectory for each oem.
>>>>>
>>>>> The main reason for this is that it became unpractical to handle 2600
>>>>> dts files and try to even understand/edit/check the situation for a
>>>>> specific target.
>>>>>
>>>>> In arm64 we already have this kind of separation and I honestly think
>>>>> that this was never proposed for ARM due to the fact that there are
>>>>> 2600+ files to sort and the fact that it will be a mess to merge this
>>>>> entirely but IMHO with a little bit of effort we can finally solve this
>>>>> problem and have a well organized directory just like arm64.
>>>>>
>>>>> Some prerequisite on how this work was done:
>>>>> - This comes entirely from a python script created by me for the task.
>>>>>    linked here [1]
>>>>> - I had to manually categorize all the different arch in the makefile
>>>>>    based on the oem. I searched every arch on the internet trying to
>>>>>    understand the correct oem. I hope they are correct but I would love
>>>>>    some comments about them.
>>>>> - This current ""series"" is all squashed in one big commit to better
>>>>>    receive comments for this. The final version ideally would have all
>>>>>    changes in separate commits. The script can already do this, it's just
>>>>>    commented.
>>>>>
>>>>> Here is a list of some discoveries while doing all the sorting.
>>>>> These are totally additional reason why we need this.
>>>>>
>>>>> While creating the script I discovered some funny things:
>>>>> - We have orphan dts! There are dts that are never compiled and are
>>>>>    there just for reference. We would never have noticed this without this
>>>>>    change and probably nobody noticed it. They are currently all listed
>>>>>    in the python script.
>>>>> - We have dtsi shared across different oem. My current solution for them
>>>>>    is: NOT SORT THEM and leave them in the generic directory and create a
>>>>>    link in each oem dts that points to these dtsi. This is to try in
>>>>>    every way possible to skip any additional changes to the dts.
>>>>>    Current dtsi that suffers from this are only 3. (listed in the script)
>>>>> - arm64 dts and dtsi reference ARM dts. Obviously this change would cause
>>>>>    broken include for these special dtsi. The script creates a dependency
>>>>>    table of the entire arm64 directory and fix every broken dependency
>>>>>    (hoping they all use a sane include logic... regex is used to parse
>>>>>    all the different dependency)
>>>>>
>>>>> So in short the script does the following steps:
>>>>> 1. Enumerate all the action to do... (dts to move, scan dependency for
>>>>>     the dts...)
>>>>> 2. Generate the arm64 dependency
>>>>> 3. Creates the Makefile
>>>>> 4. Generate the Makefiles for the current oem
>>>>> 5. Move all the related dts and dtsi for the current oem
>>>>> 6. Check broken dependency and fix them by editing the dts and writing
>>>>>     the correct include (or fix any symbolic link)
>>>>>
>>>>> This is an output that describes all the things done by the script [2]
>>>>>
>>>>> I really hope I didn't commit any logic mistake in the script but most
>>>>> of the work should be done.
>>>>>
>>>>
>>>> +Cc Arnd and Olof,
>>>>
>>>> Ansuel,
>>>> Thanks for you patch. Please cc the SoC maintainers in such submissions.
>>>> It seems that you got some quite nice discussion, but still the core
>>>> folks are not Cced, so no one would be able to take your patch...
>>>>
>>>
>>> I had some problem with gmail and sending mail too much users. I put Rob
>>> and You and all the various list to try to workaround the "gmail spam
>>> protection"
>>>
>>>> I am pretty sure we were discussing such split idea in the past and it
>>>> did not get traction, but I cannot recall the exact discussion.
>>>>
>>>
>>> I think the main issue here is how to handle bot and how problematic is
>>> to merge this. As written in the cover letter the final version of this
>>> should be a big series of 50+ patch with every commit specific to each
>>> oem. In theory we should be able to merge the different oem separately
>>> and try to at least start the categorization.
>>> Another idea I got to at least have a "migration path" is to convert
>>> every dts in the dts/ directory to a symbolic link that target the dts
>>> in the correct oem. But I assume that would fix only part of the problem
>>> and git am will still be problematic.
>>
>> I have a script[1] that does the conversion written the last time this
>> came up. Just have to agree on directory names. I think the easiest
>> would be for Arnd/Olof to run it at the end of a merge window before
>> rc1.
>>
>> I'm very much in favor of this happening especially before *any*
>> overlays are added to add to the mess (it's probably already
>> happened).
>>
>> Rob
>>
>> [1] https://lore.kernel.org/all/20181204183649.GA5716@bogus/
> 
> Hi Rob,
> thanks for recovering this. I remember also providing a script.
> 
> Anyway considering the amount of stuff to move, I feel like some
> OEM might be problematic to move due to rebase and merging problems.
> 
> We should consider accepting moving only some and keep other
> in the unsorted path. And move them at the first time possible with
> the help of the maintainers.
> 
> One main blocker of this is some qcom dts that are linked to arm64
> directory, so for some dts special care is needed.
> 

Same happens for broadcom RaspberryPi DTS. The arm64 ones include the arm ones.

Regards,
Matthias
