Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74616686097
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjBAHbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjBAHbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:31:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DE51F48B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:31:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h16so16338784wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpaAFspeMcPW+y1SdpNmCfK17axoT3bKoT/w2qWxIwA=;
        b=YK86wEVCAOqq90pmZYN4wljB6VM7rN5wDMC404QkcVOTKoYwMrGqwA2PI8+FBZ7jQ4
         D0wkpiO4GAveHj9a0eZRZGxXLxIb6k8J0S7kSeQfImDY43nMrEED1i8xiwwU5cqdP39f
         jeNhx75Ewd8gWJyeJLfSSkKbasIl62xa2/pcptkdBcSu+5oRix6jaSPuvsBguCzqbt32
         CTDlB0pTGH0pIVflGk6vp2k8P9xWAXnoua4NhGbqOnU2hDzdxB7fhgUxW7mPf3hxhrbE
         Lx96l+Mmoa/i0LN9Fxa8SnmsiLw/6sSFaOff5YFe/vv3kner5FxkxwEgTyPMaT1dI/Di
         4KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpaAFspeMcPW+y1SdpNmCfK17axoT3bKoT/w2qWxIwA=;
        b=FvTxVsQeduLj4s0dl4RQNmOIb9U2IGhnxnNssUihED3sU4NDD+4S0AgC2JTxYaQ9ht
         6JFFRaRnADdWXWvLBuvhd1qmpJGFQ7BnFD937MxtEwTEK/UMOLVUinTF1huZJDSRllm8
         mR8PgoAO7Z3ZGqexwV2eGCSKp2FNU5dl3djECc4CWrWA5oKb85PVSMS7yMIKAAc4xTeN
         wm9LC2h6hsGmvgM3WwSwcamn4rlgbnvD7pZTChyXpwYf8pslrbpe0zpXCe5SS6SI0kCX
         mLWuGYWrD51waNcUjrFoN5Czkt4VLTnlx/fdAviAg5BnxLEqBven+sWuYQm5Y5aFds3Q
         RNIA==
X-Gm-Message-State: AO0yUKWMcLPTwrakkoYG//ZN24tZQe4gp6d+rhHzWUHjSHt9NeWHI72L
        rz1jgWk6tFyElW7Y4WIGTtC+IA==
X-Google-Smtp-Source: AK7set9toEr3F6u4mxmOQCFbuJE81UQ1Qh0+3aegoDZvLpY0V5tMqo3s67yWA9KflVpSBYo2ptFzuw==
X-Received: by 2002:a5d:6b0e:0:b0:2c2:6541:7afa with SMTP id v14-20020a5d6b0e000000b002c265417afamr1405144wrw.57.1675236676089;
        Tue, 31 Jan 2023 23:31:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b002bdf3809f59sm16147880wrq.38.2023.01.31.23.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 23:31:15 -0800 (PST)
Message-ID: <d27188cd-f2ef-23ad-f27a-3fd1ef37018f@linaro.org>
Date:   Wed, 1 Feb 2023 08:31:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] driver: bus: simple-pm-bus: Add Freescale i.MX8qm/qxp CSR
 compatible strings
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-imx@nxp.com, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
References: <20230125083248.1305270-1-victor.liu@nxp.com>
 <CAMuHMdU0KaRyP0qxJLwit1G=7zMr1k5wpCkG-wD31958mrKRWg@mail.gmail.com>
 <7c84cbd1808dc89f9ddaece13f846c4fbd12935a.camel@nxp.com>
 <eea19462-8dfa-8e10-2638-70f6f1ecc193@linaro.org>
 <2d06468ab1274af3c84e61dbca8d172b9d64cd68.camel@nxp.com>
 <f551d663-f7b6-5ae3-89a9-af1ae0d6216e@linaro.org>
 <22399c301156a2a15c53a647ea2ec4c871860080.camel@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <22399c301156a2a15c53a647ea2ec4c871860080.camel@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 02:45, Liu Ying wrote:
> On Sun, 2023-01-29 at 11:49 +0100, Krzysztof Kozlowski wrote:
>> On 29/01/2023 09:13, Liu Ying wrote:
>>> On Thu, 2023-01-26 at 13:45 +0100, Krzysztof Kozlowski wrote:
>>>> On 26/01/2023 03:54, Liu Ying wrote:
>>>>> On Wed, 2023-01-25 at 10:05 +0100, Geert Uytterhoeven wrote:
>>>>>> Hi Liu,
>>>>>
>>>>> Hi Geert,
>>>>>
>>>>>>
>>>>>> On Wed, Jan 25, 2023 at 9:31 AM Liu Ying <victor.liu@nxp.com>
>>>>>> wrote:
>>>>>>> Freescale i.MX8qm/qxp CSR module matches with what the
>>>>>>> simple
>>>>>>> power
>>>>>>> managed bus driver does, considering it needs an IPG clock
>>>>>>> to
>>>>>>> be
>>>>>>> enabled before accessing it's child devices, the child
>>>>>>> devices
>>>>>>> need
>>>>>>> to be populated by the CSR module and the child devices'
>>>>>>> power
>>>>>>> management operations need to be propagated to their parent
>>>>>>> devices.
>>>>>>> Add the CSR module's compatible strings to
>>>>>>> simple_pm_bus_of_match[]
>>>>>>> table to support the CSR module.
>>>>>>>
>>>>>>> Suggested-by: Rob Herring <robh@kernel.org>
>>>>>>> Suggested-by: Lee Jones <lee@kernel.org>
>>>>>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>>>>>
>>>>>> Thanks for your patch!
>>>>>
>>>>> Thanks for your review!
>>>>>
>>>>>>
>>>>>>> ---
>>>>>>> The CSR module's dt-binding documentation can be found at
>>>>>>> Documentation/devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml.
>>>>>>>
>>>>>>> Suggested by Rob and Lee in this thread:
>>>>>>>
>>>>>
>>>>>
>>>
>>>
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F20221017075702.4182846-1-victor.liu%40nxp.com%2F&data=05%7C01%7Cvictor.liu%40nxp.com%7C58af8a86f0134b6bde3408db01e68522%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638105861813147063%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=mHv%2BTAHMAR8coxDmXucoMbxv%2BuMEdHWHTyLz16OUY50%3D&reserved=0
>>>>>>>
>>>>>>>  drivers/bus/simple-pm-bus.c | 2 ++
>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/bus/simple-pm-bus.c
>>>>>>> b/drivers/bus/simple-
>>>>>>> pm-
>>>>>>> bus.c
>>>>>>> index 7afe1947e1c0..4a7575afe6c6 100644
>>>>>>> --- a/drivers/bus/simple-pm-bus.c
>>>>>>> +++ b/drivers/bus/simple-pm-bus.c
>>>>>>> @@ -120,6 +120,8 @@ static const struct of_device_id
>>>>>>> simple_pm_bus_of_match[] = {
>>>>>>>         { .compatible = "simple-mfd",   .data = ONLY_BUS },
>>>>>>>         { .compatible = "isa",          .data = ONLY_BUS },
>>>>>>>         { .compatible = "arm,amba-bus", .data = ONLY_BUS },
>>>>>>> +       { .compatible = "fsl,imx8qm-lvds-csr", },
>>>>>>> +       { .compatible = "fsl,imx8qxp-mipi-lvds-csr", },
>>>>>>
>>>>>> I did read the thread linked above, and I still think you
>>>>>> should
>>>>>> just
>>>>>> add "simple-pm-bus" to the compatible value in DTS, so no
>>>>>> driver
>>>>>> change
>>>>>> is needed, cfr.
>>>>>> Documentation/devicetree/bindings/bus/renesas,bsc.yaml.
>>>>
>>>> I don't think we want to start putting specific compatibles here.
>>>> We
>>>> don't do it for simple-mfd, syscon and simple-bus, so neither
>>>> should
>>>> we
>>>> do it here.
>>>>
>>>>>
>>>>> This means that i.MX8qm/qxp CSR module dt-binding documentation
>>>>> needs
>>>>> to be changed.  I'd like to know how Rob and Krzysztof think
>>>>> about
>>>>> that.
>>>>
>>>> The fsl,imx8qxp-csr.yaml bindings are broken anyway... You have
>>>> device
>>>> specific bindings for non-simple device but use simple-mfd. You
>>>> cannot.
>>>> simple-mfd means it is simple and none of the resources are
>>>> needed
>>>> for
>>>> children, but that binding contradicts it.
>>>>
>>>> Now you kind of try to extend it even more make it more and more
>>>> broken.
>>>>
>>>> Rework the bindings keeping them backwards compatible. The
>>>> combination
>>>> with simple-mfd should be deprecated and you can add whatever is
>>>> needed
>>>> for a proper setup.
>>>
>>> I did try to rework the bindings and make the combination with
>>> simple-
>>> mfd deprecated. However, it reminds me the problem that "simple-pm-
>>> bus" 
>>> and "syscon" can not be in compatible string at the same time,
>>> otherwise, nodename should match '^syscon@[0-9a-f]+$' and '^bus@[0-
>>> 9a-
>>> f]+$' at the same time. I mentioned the problem in the same
>>> thread[1]
>>> where Rob and Lee suggest to go with this patch. "syscon" is needed
>>> since i.MX8qxp MIPI DSI/LVDS combo PHY node references the CSR
>>> module
>>> through a phandle, so dropping/deprecating "syscon" is a no-go. 
>>>
>>> Also, as Rob mentioned in [1] "if register space is all mixed
>>> together,
>>> then it is the former and an MFD", I think the CSR module should
>>> fall
>>> into the simple-mfd category. 
>>
>> You are now mixing MFD with simple-mfd. If you have clocks there or
>> any
>> other resources, it's not simple-mfd anymore.
> 
> I may try to make the combination with simple-mfd deprecated and add
> another combination with i.MX8qm/qxp CSR compatible strings and syscon
> only. Then, it will be a MFD, not simple-mfd.
> 
>>
>>> Take i.MX8qxp MIPI DSI/LVDS CSR module as
>>> an example, child device pxl2dpi register offset is 0x40, while
>>> child
>>> device ldb register offsets are 0x20 and 0xe0.
>>>
>>> Geert, Krzysztof, can you please consider to keep this patch as-is,
>>> since it seems that there is no other option?
>>
>> There are other options, why do you say there is no? Making it proper
>> binding/driver for its children without abusing simple bindings.
> 
> I don't quite understand your comment here, sorry. Here are the 3
> options I know:
> 
> 1) Add a new MFD driver for the CSR module
> I sent out a MFD driver[1] for the CSR module for review, but Rob and
> Lee provided comments there and suggested to use this patch.

Where are the clocks in that driver? Having MFD for something without
resources does not make any sense - this is why we have simple-mfd.

But I see in your [1] Rob's suggestion about adding the compatible to
simple-pm-bus.c, therefore it looks correct approach.

Best regards,
Krzysztof

