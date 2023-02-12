Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E896937F2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBLP1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBLP1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:27:32 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CD872A5;
        Sun, 12 Feb 2023 07:27:31 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id e12-20020a0568301e4c00b0068bc93e7e34so3055436otj.4;
        Sun, 12 Feb 2023 07:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NX5etp7sNgQW31W+eS3Z/fP5ehJy19HrlSlAqRah7P8=;
        b=TtkAj4YRsTE3UnTPmJN8IdU5AEtV4HK2NkFkA6YYbn2vtmOJn2KgBRgYMASyll6S7c
         LR6eXAlIALnXBqula2hZI/kT7EeP1lAlPWC4CwetoELWcrweqI3WuWwW4TbcAoLFM567
         pQLA0VsPzTBTkLA1Ur1vw3MkWZUK7h51jF6bEprmq7n+hAb2lmKkA0vxloH+dZSR+F3n
         cgyFpM1gDkWniZxHxOH7l6AZAkQM6FYm8Togl5OEr5NOeXxzE8vqahOtPYSOwpJ/Vq6N
         BooDnoihKKejL5d21ex6ryanbMOC3RjbvqpUn1eonen6a1UYMICeztkDPloAy83HtMyF
         4Dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NX5etp7sNgQW31W+eS3Z/fP5ehJy19HrlSlAqRah7P8=;
        b=Vlv3j5pgKCv8BIvpg+xZvwSzVngLaYIgINr4YH3I/ZobhLgsSriLMLuAUrtBkKUWqK
         1fK+5bikWIXfDF/A0SyLw9o2nu/IZQHwGkWZHcRK3TGm3g2hpN/r4B+ARx/LNO1t9JlK
         jK453v+eXObsLFDbiqpaC5gMn/MwrjLeCYKlHyX/3TMVo8FANHHvpUb59UjAdMmXwGk7
         aZ0UPFNUSA2OU0ec6SsgnR1YnLVt2W/QRy/r05i7sX3qDqSa1hKEwKUZq/4pCstYJ+Vv
         F+x9agxb3r1FRjmnk5vrlFQjOLOF6ywS5S5kLIHHfkWKGp7M2g3Hwv4aa3K9tzrYmadc
         6mvA==
X-Gm-Message-State: AO0yUKUKki6ygL76mbYE7mhHiQ1RZ7biAYNJHz1LlwWZB8LHmTQ2OJ3o
        va9io6K81zV8I61dPNvKTes=
X-Google-Smtp-Source: AK7set9IpjmklLbVpbBSq6Mef69hw8Oe9HBpaZJYrzGrqv7C4aVPYZj6CQo4rq3xKN1KdYvPDkW2VQ==
X-Received: by 2002:a9d:7d01:0:b0:68b:ce98:1f9f with SMTP id v1-20020a9d7d01000000b0068bce981f9fmr12218060otn.34.1676215651177;
        Sun, 12 Feb 2023 07:27:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9-20020a056830044900b0068be372babfsm4385983otc.47.2023.02.12.07.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 07:27:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <afe68663-8ade-ae5a-00a1-083b2f263cb0@roeck-us.net>
Date:   Sun, 12 Feb 2023 07:27:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-2-sergio.paracuellos@gmail.com>
 <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
 <CAMhs-H8tehOWvYKmFtW_LHNb62h5mnzVGN_bfGOtLgNE9qUxqw@mail.gmail.com>
 <d14f0065-e8d3-50ed-7ea4-ba57dbd18d51@arinc9.com>
 <CAMhs-H_1dtdAmeNW9arK9JxhdWaQJwcMU1Pk7TOW1f5MREzzug@mail.gmail.com>
 <76353597-0170-e0d9-9f5d-f208a03e44e8@linaro.org>
 <CAMhs-H-JGZMR6mB=USywAh4aRS9ZFOVebwLv8=N2f3uvWpcXDA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAMhs-H-JGZMR6mB=USywAh4aRS9ZFOVebwLv8=N2f3uvWpcXDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/23 00:13, Sergio Paracuellos wrote:
> On Sat, Feb 11, 2023 at 12:42 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 11/02/2023 12:01, Sergio Paracuellos wrote:
>>> On Sat, Feb 11, 2023 at 11:47 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>>>
>>>> On 11.02.2023 13:41, Sergio Paracuellos wrote:
>>>>> On Sat, Feb 11, 2023 at 10:10 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>>>>>
>>>>>> Is this mediatek,sysctl property required after your changes on the
>>>>>> watchdog code?
>>>>>
>>>>> I don't really understand the question :-) Yes, it is. Since we have
>>>>> introduced a new phandle in the watchdog node to be able to access the
>>>>> reset status register through the 'sysc' syscon node.
>>>>> We need the bindings to be aligned with the mt7621.dtsi file and we
>>>>> are getting the syscon regmap handler via
>>>>> 'syscon_regmap_lookup_by_phandle()'. See PATCH 5 of the series, Arınç.
>>>>
>>>> I believe you need to put mediatek,sysctl under "required:".
>>>
>>> Ah, I understood your question now :-). You meant 'required' property.
>>> I need more coffee, I guess :-). I am not sure if you can add
>>> properties as required after bindings are already mainlined for
>>> compatibility issues. The problem with this SoC is that drivers become
>>> mainlined before the device tree was so if things are properly fixed
>>> now this kind of issues appear.  Let's see Krzysztof and Rob comments
>>> for this.
>>
>> If your driver fails to probe without mediatek,sysctl, you already made
>> it required (thus broke the ABI) regardless what dt-binding is saying.
>> In such case you should update dt-binding to reflect reality.
>>
>> Now ABI break is different case. Usually you should not break it without
>> valid reasons (e.g. it was never working before). Your commit msg
>> suggests that you only improve the code, thus ABI break is not really
>> justified. In such case - binding is correct, driver should be reworked
>> to accept DTS without the new property.
> 
> Thanks for clarification, Krzysztof. Ok, so if this is the case I need
> to add this property required (as Arinc was properly pointing out in
> previous mail) since without it the driver is going to fail on probe
> (PATCH 5 of the series). I understand the "it was never working
> before" argument reason for ABI breaks. What happens if the old driver
> code was not ideal and totally dependent on architecture specific
> operations when this could be totally avoided and properly make arch
> independent agnostic drivers? This driver was added in 2016 [0]. There
> was not a device tree file in the kernel for this SoC mainlined until
> 2022 [1]. I also personally migrated this watchdog binding in 2022
> from text to YAML and maintained it without changes [2]. When this was
> mainlined not all drivers were properly reviewed and the current code
> was just maintained as it is. Most users of this SoC are in the
> openWRT community where the dtsi of the mainline is not used yet and
> they maintain their own mt7621.dtsi files. Also, when a new version of
> the openWRT selected kernel is added they also modify and align with
> its mt7621.dtsi file without maintaining previous dtb's. If "make the
> driver arch independent to be able to be compile tested" and this kind
> of arguments are not valid at all I need to know because I have
> started to review driver code for this SoC and other drivers also have
> the same arch dependency that ideally should be avoided in the same
> way. This at the end means to break the ABI again in the future for
> those drivers / bindings. So I can just let them be as it is and not
> provide any change at all and continue without being compile tested
> and other beneficial features to detect future driver breakage.
> 

Problem is that there are (presumably) shipped systems out there with
the old devicetree file. The watchdog driver would no longer instantiate
on those systems.

Guenter

