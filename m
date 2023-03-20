Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B526C1E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjCTRku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjCTRkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:40:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B71132EB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:36:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w9so49918560edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679333763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=10xWNgDnBn9HWAoKf1x27IbTNeZL1I1uGesMn8NoWH8=;
        b=JWhOPgDSc6WZ3jUWEhnC8MC7SFHhH2CnG61pBRzeGjsAlhWMGBMh1xN2LfnJy7TlZg
         poMrgE++XyUo3+Wjai89l5l599R6sIS5txLvzUrWSPWIWMpyIhVxPAuNp1kZ1mpZkwNR
         79HkjdapSecp5GqTlKbicdtrw47JOIHLAfnSoyIFdFK1mNSwkoB/AHIrGk1S2Vnk3exU
         y+U5CCE0TqiRVZLrYFKp7avit1Q7NUOOCcLnRxLZhxF/cHDpaLnvVarI3D/rHjTHFuZ6
         hlGcfJpk92By8aB/BHuyVccYd2deOb6j/ZBiTmrtEFuqckVpVnsELTvi/XE2+zlIvoGm
         ha/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10xWNgDnBn9HWAoKf1x27IbTNeZL1I1uGesMn8NoWH8=;
        b=x1loyBRuascBBNWeTqsfwSdZlUSi68kGrotLYnI3KAl2ZjIo/5HECcGUmnZlzgVyjA
         vHGPtO/rEO/7FUIbfXK9bpfdNRY5mxN2Ebo4Sqk/Gw6/P0sS8gJpNLf0ODyleT6TMiOa
         Ty1DxEZHvhRaNwYYDX6rot2KUu+CuuISwaMW7H9PVw0nFDRnNdbON48g+252xL6ybGZV
         nOB6yNctFh/1319UX0ICG2D53MpfcjHee15uJhqYGyNC/iyv9L8XcTg3zx2zW7GoJ+u/
         cKL51+wGcI230bVAE+eh/eeDrYeyGgkrS3uqo5ySZEG08GKj7sMEzS04tQv7/NTALZFG
         yHbw==
X-Gm-Message-State: AO0yUKW2TvuDfrnVa++VrfVWlG5G6HKdoPjdRXjoL3Dn69A9IwYRw73M
        +1MxPCpqyi111AQ4GqYdRgPqqA==
X-Google-Smtp-Source: AK7set/MlByRdbFbJOXEd4KRuZdeTqmwH3+eue8VMWmWR7leLFe8X2XSYZwCNt3OjyXEuvzbf8yo3A==
X-Received: by 2002:a17:906:7311:b0:939:5720:a2db with SMTP id di17-20020a170906731100b009395720a2dbmr1026902ejc.8.1679333763637;
        Mon, 20 Mar 2023 10:36:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id pv15-20020a170907208f00b0091ec885e016sm4671279ejb.54.2023.03.20.10.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:36:03 -0700 (PDT)
Message-ID: <d0f74721-bf5a-62de-53dc-62e7e735e2dc@linaro.org>
Date:   Mon, 20 Mar 2023 18:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, arinc.unal@arinc9.com
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com>
 <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
 <CAMhs-H8OQ9gJLsifLuHD2GN8rYwnY=Zmdb0kMEfX4UUHhjMUyQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMhs-H8OQ9gJLsifLuHD2GN8rYwnY=Zmdb0kMEfX4UUHhjMUyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 20/03/2023 18:24, Sergio Paracuellos wrote:
> Hi Krzysztof,
> 
> On Mon, Mar 20, 2023 at 5:36 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 20/03/2023 17:18, Sergio Paracuellos wrote:
>>> Adds device tree binding documentation for clocks and resets in the
>>> Mediatek MIPS and Ralink SOCs. This covers RT2880, RT3050, RT3052, RT3350,
>>> RT3883, RT5350, MT7620, MT7628 and MT7688 SoCs.
>>
>> Use subject prefixes matching the subsystem (which you can get for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching).
>>
>> Subject: drop second/last, redundant "device tree binding
>> documentation". The "dt-bindings" prefix is already stating that these
>> are bindings.
> 
> Sure, will do. Sorry for the inconvenience.
> 
>> (BTW, that's the longest redundant component I ever saw)
> 
> I thought it was better to just list compatible strings inside one
> single file than adding the same binding in multiple files.

I don't understand how this is answers about redundant piece of subject.
Amount of files are not related to repeating pieces of subject prefix.

> 
>>
>>>
>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>> ---
>>>  .../bindings/clock/mtmips-clock.yaml          | 68 +++++++++++++++++++
>>>  1 file changed, 68 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/clock/mtmips-clock.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/mtmips-clock.yaml b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
>>> new file mode 100644
>>> index 000000000000..c92969ce231d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/clock/mtmips-clock.yaml
>>
>> Filename matching compatible, so vendor prefix and device name (or
>> family of names).
> 
> I used mtmips here but list compatibles starting with ralink. As I
> have said in the cover letter I am inspired by the last merged pinctrl
> series for these SoCs.
> See:
> - https://lore.kernel.org/linux-gpio/e9e6ad87-2db5-9767-ff39-64a302b06185@arinc9.com/T/#t

21 patches, so what exactly I should see (except that I was involved in
that discussions)?

Plus nothing from this thread warrants here exception from naming style.


> 
> Not all of compatible currently exist. 

Then clearly state this.

> All of these are at the end the
> way we can properly match compatible-data to write a proper driver.
> The current ralink dtsi files which are in tree now
> are totally incomplete and not documented so we are planning to align

Nothing like this was said in commit msg, so how can we know?

> all of this with openWRT used files and others soon. That's the reason
> we are not touching
> 'arch/mips/boot/dts' at all now. I don't think anybody is using any of
> this but mt7621 which is properly completed and documented.

Anyway, none of this explains exception from naming convention - vendor,
device or family name.

> 
>>
>>> @@ -0,0 +1,68 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/clock/mtmips-clock.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MTMIPS SoCs Clock
>>
>> One clock? Are you sure these describe exactly one clock?
> 
> I will change this to 'Clocks'.

Then clock provider, but are you sure? You included there syscon and
reset controller.

> 
>>
>>> +
>>> +maintainers:
>>> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>> +
>>> +description: |
>>> +  MediaTek MIPS and Ralink SoCs have an XTAL from where the cpu clock is
>>> +  provided as well as derived clocks for the bus and the peripherals.
>>> +
>>> +  Each clock is assigned an identifier and client nodes use this identifier
>>> +  to specify the clock which they consume.
>>
>> Drop useless or obvious pieces of description. Describe the hardware.
>>
>>> +
>>> +  The clocks are provided inside a system controller node.
> 
>>
>> ???
> 
> I meant, this node is a syscon from where both clock and reset related
> registers are used. I think writing in this way was enough since it
> has a pretty similar description like the one in
> 'mediatek,mt7621-sysc.yaml'.

But what is a system controller node? Some separate device? This is
description for this device - called "Clock" or "Clocks" - and "system
controller" appears for the first time.

> 
>>
>>> +
>>> +  This node is also a reset provider for all the peripherals.
>>
>> ??? Does it mean it is not only "Clock" but also reset controller?
> 
> Yes, this node is a clock and reset controller for all the SoC.
> 
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - ralink,rt2880-sysc
>>> +          - ralink,rt3050-sysc
>>> +          - ralink,rt3052-sysc
>>> +          - ralink,rt3352-sysc
>>> +          - ralink,rt3883-sysc
>>> +          - ralink,rt5350-sysc
>>> +          - ralink,mt7620-sysc
>>> +          - ralink,mt7620a-sysc
>>> +          - ralink,mt7628-sysc'
>>> +          - ralink,mt7688-sysc
>>> +          - ralink,rt2880-reset
>>
>> That's odd. rt2880 is sysc and reset? One device with two compatibles?
> 
> This 'ralink,rt2880-reset' is for compatibility reasons. 

I don't understand why. It is used in DTS, so what this node represents
there?

> Reset related
> code was inside 'arch/mips/ralink' folder reset.c file but it is moved
> to this new driver, so we have maintained this reset stuff for the
> reset compatibility. All of the rest are the new possible stuff for
> both reset and clocks. 

We talk here about hardware, not drivers, so moving driver code around
does not help me understand the rationale behind bindings.

> Clock driver is instantiated in two phases. The
> earlier one set up the clocks via CLK_OF_DECLARE macro. Resets are set
> up as a platform driver. Is only inside this where
> 'ralink,rt2880-reset' is used. See patch 2 of the series for details.

Sure, but it is not related to bindings.

> 
>>
>> Also, order these by name.
> 
> All are ordered but I maintained the  'ralink,rt2880-reset' at the end.

No, it is not. m is before r in alphabet.

Best regards,
Krzysztof

