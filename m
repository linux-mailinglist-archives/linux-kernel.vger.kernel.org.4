Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD2633A37
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiKVKfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbiKVKeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:34:04 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1F05F4F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:30:52 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u2so17464720ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ITFibk1D5kN6pD+TuW/Zc9FBNNeG7KecXWMUXzLtY=;
        b=Tv6UFU9BtdA2bzA1xaIgMpHGf+KWGuuoNEQiGhuaAoUtRWfOmM7z4L50kA2gT1LB/f
         7LLu51ykx5KWyMi+gXzLv3fe+HdFHwYjALXRn+ajgknC1Xgfw6nw4knYSOymopZjnXL2
         8yOTgrFLCC5IdSUtOQYe6yfvcJtL/mjO92VJUAKf+T11TqJb0Tg138Kk3a7iQbskwS6i
         VghECyydrPro+UPt4Kzot59fv/G/SYe21XwZ7lGQVH7MI02hM0heLwU8fdIxSSQaztBG
         2n6FjbjcLkcVzF1kMY5NFzUAz+vOZnZ6Nt1WatOZ7lU2mWQUAME9Bn64QOkBTNLMDi6r
         ds/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ITFibk1D5kN6pD+TuW/Zc9FBNNeG7KecXWMUXzLtY=;
        b=3XL8voI/GOW3Alwmc4UgPGwu1Zta78Xz3hVSwmC9BnBav6S+aruo53igGj8heGhIJJ
         nOzNklRFnhI5ZZZaOVJ8RGxcKCfjUMYOUgPOm/WZisJ4hQYixguexk+JqxROuN9v114z
         p/DwfFsy8CGCapLCugw+1f/IGbMXE+/eMomZNnoC0+VHhAgZ601kodLGclkR4amCQntI
         iq9UruIz9xbXp31rEtKuCbSfwBjpO8bmcc64gEaj/prnpfUrAS184m5m4E0VZIKjMZvW
         Xr5ObVZ6X40AoHSXncLeqUnIGZtKH9Ilu9n2Typn0bsgFUbPH0FdiDhM9EF/kugf/uQd
         jQGA==
X-Gm-Message-State: ANoB5pl/m+Kt+KbCjId6D4X6UtpFjrta6iTy7fOdVuOnGjDb6WvfRKV2
        IQbWjRH+iv6G6sjlmohV53jckA==
X-Google-Smtp-Source: AA0mqf4vCk0Y0fVSS2MiuBk42reQriklJL/35xBjCEdH8codYy58/kMo3JCA3+bchA5tm+Jxn28NdQ==
X-Received: by 2002:a2e:a4b4:0:b0:26c:5cf3:cc89 with SMTP id g20-20020a2ea4b4000000b0026c5cf3cc89mr7390586ljm.483.1669113050432;
        Tue, 22 Nov 2022 02:30:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g23-20020a2ea4b7000000b0026dce0a5ca9sm1803692ljm.70.2022.11.22.02.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 02:30:49 -0800 (PST)
Message-ID: <3856e2d8-1c16-a69f-4ac5-34b8e7f18c2b@linaro.org>
Date:   Tue, 22 Nov 2022 11:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
 <20221114111513.1436165-3-herve.codina@bootlin.com>
 <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
 <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
 <20221115150417.513955a7@bootlin.com> <20221118112349.7f09eefb@bootlin.com>
 <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
 <20221121165921.559d6538@bootlin.com>
 <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
 <CAMuHMdU=-ZUzHSb0Z8P3wsLK9cgGVCPdMi6AcjTH23tUQEeEBA@mail.gmail.com>
 <a3e1332e-fc15-8a78-0ddd-6d5b26197f11@linaro.org>
 <CAMuHMdXzqZB4sKMmroriq5oPp7z=yXiHk=+eQKwSyPhNbYqgYA@mail.gmail.com>
 <1f12883b-1e37-7f2b-f9e9-c8bad290a133@linaro.org>
 <CAMuHMdVbzg8y2So+A=z8nUwHMoL+XKUrvoXp9QdbCnUve1_Atw@mail.gmail.com>
 <191a7f3e-0733-8058-5829-fe170a06dd5a@linaro.org>
 <20221122100706.739cec4d@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221122100706.739cec4d@bootlin.com>
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

On 22/11/2022 10:07, Herve Codina wrote:
> On Tue, 22 Nov 2022 09:42:48 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 22/11/2022 09:25, Geert Uytterhoeven wrote:
>>> Hi Krzysztof,
>>>
>>> On Tue, Nov 22, 2022 at 8:45 AM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:  
>>>> On 21/11/2022 21:46, Geert Uytterhoeven wrote:  
>>>>>> This does not change anything. Herve wrote:
>>>>>>  
>>>>>>> probe some devices (USB host and probably others)  
>>>>>>
>>>>>> Why some can be probed earlier and some not, if there are no
>>>>>> dependencies? If there are dependencies, it's the same case with sysctrl
>>>>>> touching the register bit and the USB controller touching it (as well
>>>>>> via syscon, but that's obvious, I assume).
>>>>>>
>>>>>> Where is the synchronization problem?  
>>>>>
>>>>> The h2mode bit (and probably a few other controls we haven't figured out
>>>>> yet) in the sysctrl must be set before any of the USB devices is active.
>>>>> Hence it's safest for the sysctrl to do this before any of the USB drivers
>>>>> probes.  
>>>>
>>>> Again, this does not differ from many, many of other devices. All of
>>>> them must set something in system controller block, before they start
>>>> operating (or at specific time). It's exactly the same everywhere.  
>>>
>>> The issue here is that there are two _different drivers_ (USB host
>>> and device). When both are modular, and the driver that depends on the
>>> sysctrl setting is loaded second, you have a problem: the sysctrl change
>>> must not be done when the first driver is already using the hardware.
>>>
>>> Hence the sysctrl driver should take care of it itself during early
>>> initialization (it's the main clock controller, so it's a dependency
>>> for all other I/O device drivers).  
>>
>> I assumed you have there bit for the first device (which can switch
>> between USB host and USB device) to choose appropriate mode. The
>> bindings also expressed this - "the USBs are". Never said anything about
>> dependency between these USBs.
>>
>> Are you saying that the mode for first device cannot be changed once the
>> second device (which is only host) is started? IOW, the mode setup must
>> happen before any of these devices are started?
>>
>> Anyway with sysctrl approach you will have dependency and you cannot
>> rely on clock provider-consumer relationship to order that dependency.
>> What if you make all clocks on and do not take any clocks in USB device?
>> Broken dependency. What if you want to use this in a different SoC,
>> where the sysctrl does not provide clocks? Broken dependency.
> 
> The issue is really related to the Renesas sysctrl itself and not related
> to the USB drivers themselves.
> From the drivers themselves, the issue is not seen (I mean the driver
> takes no specific action related to this issue).
> If we change the SOC, the issue will probably not exist anymore.
>

Yeah, and in the next SoC you will bring 10 of such properties to
sysctrl arguing that if one was approved, 10 is also fine. Somehow
people on the lists like to use that argument - I saw it somewhere, so I
am allowed to do here the same.

I understand that the registers responsible for configuration are in
sysctrl block, but it does not mean that it should be described as part
of sysctrl Devicetree node. If there was no synchronization problem,
this would be regular example of register in syscon which is handled
(toggled) by the device (so USB device/host controller). Since there is
synchronization problem, you argue that it is correct representation of
hardware. No, it is not, because logically in DT you do not describe
mode or existence of other devices in some other node and it still does
not describe this ordering.

Best regards,
Krzysztof

