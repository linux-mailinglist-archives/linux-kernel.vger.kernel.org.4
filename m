Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB12632998
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKUQeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiKUQdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:33:22 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF172DCB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:33:21 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bp15so19613000lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7bCY/p1jGN+V4P5Z66XMF5hNOBYBBm1FqcPkoGvfxU=;
        b=OmNdLGayr0K2uHjD9IPM8w72U2KjB7+vNdAR8H2hvr+gllj/JxgNlft/VApT5Ilpxv
         W7sRS2oF2J/DMfU01xKR0ra049PEJfe/iu2YvAuG8M+uLkbzOq3Uv7Wir4qdSIL3bv4g
         sTAVIstvEl4q65oRKO69Uj5cxnag/p8MgzFsv9H5QeD2EB0TX3dcfhDLFdb9aXyetAQG
         JTC/cGqLZjjsowAYneMAPftrA/JFYuhBGywoTuRFwTmTZQEPUSAKghSRi0cLUT2Ig5Kl
         I4ivuQug/alS4j3AeafADEsDOOhaYVGojDGcR9JXaGytVpvZDsMrOn5HxIP2kk6Z3KEa
         QShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7bCY/p1jGN+V4P5Z66XMF5hNOBYBBm1FqcPkoGvfxU=;
        b=0bZgYuRi1/YcERMEUoF/p/gzM2WtSEK4Mkv3JUeWuOqOP0a8KnC9wkp6sdbwv1Sih5
         qiaHim1lfZwezyIIIruSZrKKZUWZ/BlX5tM/Fz3ELyl///WgP0jHkyCghElILGOBpXtV
         VJYQp1td46rlubBPmsqWy7mq8g7L83AvAqCzfWNvSItifKuviFJrPp0XZ7iK39JuZj07
         k67rDQgRIQPK0tmefWCnQ0zOmDtFWbCR/XuYyckdmFfp2HHbL0WkN0o5LF6NE0wIeoXV
         V8WZ6eTvggxfxbbdur+A2ESiMRHSwA72Bv3TaS5MGE4G8zyJK7mF278UHUe9nYLmxQ3E
         U2Lg==
X-Gm-Message-State: ANoB5pleQviZmGGP5g4HVsjTmnEEGma6sPbZTdNbq+OQiYOZbsr0DvKN
        SdKGcQ8bL1AkKly5DzvO9/5X9g==
X-Google-Smtp-Source: AA0mqf6hPKAKuica8wFz5ikBMwC3NwA7GHdzU+RruvrJ6fAFg9DjK/NDFmfcdHymKHVkbhlWrqLavg==
X-Received: by 2002:ac2:4e0a:0:b0:4a2:2aab:5460 with SMTP id e10-20020ac24e0a000000b004a22aab5460mr1168869lfr.62.1669048399433;
        Mon, 21 Nov 2022 08:33:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c27-20020ac25f7b000000b0049f53b65790sm2080450lfc.228.2022.11.21.08.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 08:33:19 -0800 (PST)
Message-ID: <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
Date:   Mon, 21 Nov 2022 17:33:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add
 h2mode property
Content-Language: en-US
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121165921.559d6538@bootlin.com>
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

On 21/11/2022 16:59, Herve Codina wrote:
> Hi,
> 
> On Mon, 21 Nov 2022 12:43:16 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 18/11/2022 11:23, Herve Codina wrote:
>>> Hi Krzysztof, Geert,
>>>
>>> On Tue, 15 Nov 2022 15:04:17 +0100
>>> Herve Codina <herve.codina@bootlin.com> wrote:
>>>   
>>>> Hi Krzysztof,
>>>>
>>>> On Tue, 15 Nov 2022 14:07:52 +0100
>>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>  
>>>>> On 15/11/2022 14:05, Krzysztof Kozlowski wrote:    
>>>>>> On 14/11/2022 12:15, Herve Codina wrote:      
>>>>>>> Add the h2mode property to force the USBs mode ie:
>>>>>>>  - 2 hosts
>>>>>>> or
>>>>>>>  - 1 host and 1 device
>>>>>>>
>>>>>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
>>>>>>> ---
>>>>>>>  .../bindings/clock/renesas,r9a06g032-sysctrl.yaml      | 10 ++++++++++
>>>>>>>  1 file changed, 10 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
>>>>>>> index 95bf485c6cec..f9e0a58aa4fb 100644
>>>>>>> --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
>>>>>>> @@ -39,6 +39,16 @@ properties:
>>>>>>>    '#power-domain-cells':
>>>>>>>      const: 0
>>>>>>>  
>>>>>>> +  renesas,h2mode:
>>>>>>> +    description: |
>>>>>>> +      Configure the USBs mode.
>>>>>>> +        - <0> : the USBs are in 1 host and 1 device mode.
>>>>>>> +        - <1> : the USBs are in 2 host mode.
>>>>>>> +      If the property is not present, the value used is the one already present
>>>>>>> +      in the CFG_USB register (from reset or set by the bootloader).
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>> +    enum: [0, 1]      
>>>>>>
>>>>>> 0/1 are quite cryptic. Why not making it a string which is easy to read
>>>>>> and understand? Can be something like "two-hosts" and "one-host". Or
>>>>>> anything you find more readable...      
>>>>>
>>>>> ...but actually you should rather make it a property of your USB
>>>>> controller, not clock controller. You have two controllers and we have a
>>>>> generic property for them - dr_mode.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>     
>>>>
>>>> IMHO, this property in the USB controllers does not make sense.
>>>> Indeed each controller cannot have a different 'mode'.
>>>> Some controllers are USB host only (EHCI and OHCI) and the USBF
>>>> controller I worked on is device only.
>>>> 'h2mode' allows to choose between host or device on one of the USB
>>>> but not at the USB controller level.
>>>>
>>>> This property should be handle outside the USB controller nodes.
>>>>
>>>> Currently, this node (declared as a clock node) is in fact a sysctrl
>>>> node and can do some configuration not related to clocks.
>>>>
>>>> I agree with you something related to choosing USB Host/Device in
>>>> a clock node seems strange.
>>>>
>>>> Some discussion were already opened related to this property and how
>>>> to handle it:
>>>>   https://lore.kernel.org/all/20221107182642.05a09f2f@bootlin.com/
>>>>   https://lore.kernel.org/all/20221107173614.474707d7@bootlin.com/
>>>>  
>>>
>>> We advanced on this topic.
>>>
>>> First, even if 'renesas,r9a06g032-sysctrl.yaml' is present in
>>> the devicetree/bindings/clock/ directory, this node is really
>>> a 'system controller' node:
>>> - title: Renesas RZ/N1D (R9A06G032) System Controller
>>> - compatible: renesas,r9a06g032-sysctrl
>>>
>>> It handles clocks, power domains, some DMA routing, ...
>>>
>>> Now, the property 'h2mode' allows to choose between:
>>>   - 2 USB hosts
>>> or
>>>   - 1 USB host and 1 USB device.
>>>
>>> This switching is system wide and has no reason to be done in
>>> one specific USB controller. It can impact multiple devices and
>>> PLL settings.
>>>
>>> The 'renesas,r9a06g032-sysctrl' node, as the system control
>>> node of our system, is the best candidate to handle the property.  
>>
>> Not necessarily. IIUC, you have:
>>
>> 1. sysctrl with some register(s) for choosing device mode
>> 2. usb device or host at one address
>> 3. usb host at separate address
>>
> 
> Just to clarify, usb device and host controller are not provided by
> the same IP.
> We have an USB host at some address range (PCI OHCI/EHCI USB host
> below a PCI bridge) and the USB device at some other address range
> (below a AHB to someting bridge).
> And I am not sure that only USB host or devices are affected by this
> property change.
> 
>> If so then:
>> A. Pretty often we have wrapper nodes for this purpose (USB, phy
>> wrappers or glues) which are usually needed to configure something for a
>> generic block (like Synopsys etc).
>>
>> B. Pretty often the device (so your USB host or device) needs to poke
>> something in system controller registers, e.g. for power or some other
>> setup.
> 
> And we did it for some items (clocks and power).
> 
>>
>> Your case looks a lot like (B). We have many, many of such examples
>> already. Actually it is exactly like that, except that it affects
>> possibility of another device (e.g. choosing USB device blocks having
>> host there).
>>
>> C. It looks a bit like a multi-serial-protocol interfaces (so
>> UART+I2C+SPI). The difference is that such cases have all these nodes
>> defined as a children of the protocol-wrapping device. Not here.
>>
>> I would propose to go with (B) unless of course it's causes some crazy
>> architecture/code choices. Why? Because with exception of (C) we should
>> not define properties which represent DT node choices. IOW, Choosing a
>> node and compatible (e.g. usb controller as device) is enough to
>> describe the hardware. No need for other properties to control some
>> register in other block.
> 
> The issue with h2mode is that it affects several devices and these
> devices should not be in a "running" state when the h2mode is changed.

Why the change should happen when device is running? And why this should
be anyway different than your existing hsmode property - it also will
happen when system and device are running.


> PCI devices (host controllers) itself are not described in the DT. They
> are automatically enumerated.

Aren't we talking about USB controller in a MMIO-based SoC?

> Changing the property in USB device controller can leads to hang on
> other busses. Indeed, changing this property when a device affected
> by the property is running can lead to a bus hang.>
> In order to do that from the USB device controller I need to synchronize
> the other devices to wait for this setting before running.
> 1) probe sysctrl without setting h2mode
> 2) probe some devices (USB host and probably others)
>    Stop at some point and wait for the h2mode property setting.

Why do you need to wait? Which device needs to wait? There are no such
devices... if they are then please bring entire DTS, not some pieces in
this patchset.

> 3) probe usb device -> Set h2mode property
> 4) allow devices waiting for the property setting to continue.

I don't get why do you need such order. Your sysctrl also probes any
time so old solution has exactly the same problem, doesn't it?

> This synchronization seems pretty tricky and what to do if nobody
> set the property (USB device controller not present or status="disabled"
> for instance) ?
> 
> Setting this property in sysctrl probe avoid the need for all of this
> synchronization:
> 1) probe sysctrl and set h2mode.
> 2) probe other devices (no need to wait for the setting as it is already done)

No, because other devices probe before sysctrl. If you bring here any
manual ordering, you are doing it wrong.

> The probing of the other devices (or the starting of they running state)
> is guaranteed as they all need some clocks and so cannot start without
> having the sysctrl node already probed.
> This sysctrl node handles the clocks.

Ah, so sysctrl is a clock controller for these?

Then still there are no other devices depending on your USB. The USB is
the owner of this property (specific bits in register), no one else.

Best regards,
Krzysztof

