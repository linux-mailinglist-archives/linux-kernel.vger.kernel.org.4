Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BBD695169
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBMUJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMUJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:09:52 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FDEBDD8;
        Mon, 13 Feb 2023 12:09:49 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-16df32f2ffdso5844299fac.1;
        Mon, 13 Feb 2023 12:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=keWRQ4szvOwPFbZbF1Ui5qQNlX/UlTv/StqQt6kumgc=;
        b=L7SJFj+XMJNn/dhU+K5jOdhTtaTD4Zqa5+dt2TNaW+9BAEoS02cHGCe6Z1a+9/eS4e
         2cFBjQHTciYMh/DCEvOR43dfZkF82yArRzU/Jdrk7boHSBp4tWte9ayMsAHXKpJr0C3q
         YDONSYVeUYr9enGbTqYd6WzJL/pK+lOtgL5QyPTxGjN208iL29ahOpM7KdoDAWU/ODmO
         0ix4USoYm+PXu2fhh3yLDI41Cx7Ng0xEutD/Vu0994wpBA/fz8XOr2XBZdxzeG7YGmB5
         WeGQk7OLh0KWo8G8OYs+Q0y8OOAq1RLxUGre4cZjjh/152vGRIxAiAqFIodNp5UZXWDC
         2Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=keWRQ4szvOwPFbZbF1Ui5qQNlX/UlTv/StqQt6kumgc=;
        b=trVzfOhsAyaVPxlYScsjDDZYV20uAOG/rhF414bauA8F7mtGHxTtqPsi2juwz6zUW7
         WHedtEYxQWpK+6IrR2NXBC4genNpjAojcsWK3P1Fpf9JVlknjoRRbl5MYHW5VwJsiEEo
         8/H62cQf7GlttiSmtpbGgVnJrj5jkGmFWO/+YWCpyUV3SGpsLD+Ga3M3zRxORaS4fS5y
         jnXrvuKLNXsEOb2++520BcH8W6jKJwXArWMw2/yONODMxfI1WcUgf4dsVQyhV9QPRYyq
         yQwkDmenm4yH/PugE4i49Il1ibkvP1btaFD5BCB8juxtua1hx96PDf20lIFIkOo6eWQA
         +2Aw==
X-Gm-Message-State: AO0yUKXNYTsMjnTG0xAOtSI11ATdt0fDwu3hYOZiOpAXH2dEGOxEa6rj
        2WJzNsG2+o5gyBCF+8oQhLquCw2bSzc=
X-Google-Smtp-Source: AK7set9Mkd4MrrpIilX+EQg1ctVfwNedOE7PkvTp63BLzESlU6CBw8dnjY3xAW6QmVdVuoawQOEd7g==
X-Received: by 2002:a05:6870:568c:b0:16d:eab9:3d58 with SMTP id p12-20020a056870568c00b0016deab93d58mr4427545oao.2.1676318988298;
        Mon, 13 Feb 2023 12:09:48 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v14-20020a056870954e00b0016de5bcd020sm2452100oal.45.2023.02.13.12.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 12:09:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <68131735-005b-890f-4052-12f598e2bce6@roeck-us.net>
Date:   Mon, 13 Feb 2023 12:09:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
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
 <afe68663-8ade-ae5a-00a1-083b2f263cb0@roeck-us.net>
 <CAMhs-H9BkQNwNyYQQgSig9vkW-_+i0+x8CLogXNgkRyi9Un6xw@mail.gmail.com>
 <20230213193613.GA371102@roeck-us.net>
 <CAMhs-H9UW=zkLs+cPkzXUj=TEytH75Y0dX_7NP1E2s-JeoANzA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAMhs-H9UW=zkLs+cPkzXUj=TEytH75Y0dX_7NP1E2s-JeoANzA@mail.gmail.com>
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

On 2/13/23 11:57, Sergio Paracuellos wrote:
> On Mon, Feb 13, 2023 at 8:36 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Mon, Feb 13, 2023 at 09:59:35AM +0100, Sergio Paracuellos wrote:
>>> On Sun, Feb 12, 2023 at 4:27 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 2/12/23 00:13, Sergio Paracuellos wrote:
>>>>> On Sat, Feb 11, 2023 at 12:42 PM Krzysztof Kozlowski
>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>
>>>>>> On 11/02/2023 12:01, Sergio Paracuellos wrote:
>>>>>>> On Sat, Feb 11, 2023 at 11:47 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>>>>>>>
>>>>>>>> On 11.02.2023 13:41, Sergio Paracuellos wrote:
>>>>>>>>> On Sat, Feb 11, 2023 at 10:10 AM Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Is this mediatek,sysctl property required after your changes on the
>>>>>>>>>> watchdog code?
>>>>>>>>>
>>>>>>>>> I don't really understand the question :-) Yes, it is. Since we have
>>>>>>>>> introduced a new phandle in the watchdog node to be able to access the
>>>>>>>>> reset status register through the 'sysc' syscon node.
>>>>>>>>> We need the bindings to be aligned with the mt7621.dtsi file and we
>>>>>>>>> are getting the syscon regmap handler via
>>>>>>>>> 'syscon_regmap_lookup_by_phandle()'. See PATCH 5 of the series, Arınç.
>>>>>>>>
>>>>>>>> I believe you need to put mediatek,sysctl under "required:".
>>>>>>>
>>>>>>> Ah, I understood your question now :-). You meant 'required' property.
>>>>>>> I need more coffee, I guess :-). I am not sure if you can add
>>>>>>> properties as required after bindings are already mainlined for
>>>>>>> compatibility issues. The problem with this SoC is that drivers become
>>>>>>> mainlined before the device tree was so if things are properly fixed
>>>>>>> now this kind of issues appear.  Let's see Krzysztof and Rob comments
>>>>>>> for this.
>>>>>>
>>>>>> If your driver fails to probe without mediatek,sysctl, you already made
>>>>>> it required (thus broke the ABI) regardless what dt-binding is saying.
>>>>>> In such case you should update dt-binding to reflect reality.
>>>>>>
>>>>>> Now ABI break is different case. Usually you should not break it without
>>>>>> valid reasons (e.g. it was never working before). Your commit msg
>>>>>> suggests that you only improve the code, thus ABI break is not really
>>>>>> justified. In such case - binding is correct, driver should be reworked
>>>>>> to accept DTS without the new property.
>>>>>
>>>>> Thanks for clarification, Krzysztof. Ok, so if this is the case I need
>>>>> to add this property required (as Arinc was properly pointing out in
>>>>> previous mail) since without it the driver is going to fail on probe
>>>>> (PATCH 5 of the series). I understand the "it was never working
>>>>> before" argument reason for ABI breaks. What happens if the old driver
>>>>> code was not ideal and totally dependent on architecture specific
>>>>> operations when this could be totally avoided and properly make arch
>>>>> independent agnostic drivers? This driver was added in 2016 [0]. There
>>>>> was not a device tree file in the kernel for this SoC mainlined until
>>>>> 2022 [1]. I also personally migrated this watchdog binding in 2022
>>>>> from text to YAML and maintained it without changes [2]. When this was
>>>>> mainlined not all drivers were properly reviewed and the current code
>>>>> was just maintained as it is. Most users of this SoC are in the
>>>>> openWRT community where the dtsi of the mainline is not used yet and
>>>>> they maintain their own mt7621.dtsi files. Also, when a new version of
>>>>> the openWRT selected kernel is added they also modify and align with
>>>>> its mt7621.dtsi file without maintaining previous dtb's. If "make the
>>>>> driver arch independent to be able to be compile tested" and this kind
>>>>> of arguments are not valid at all I need to know because I have
>>>>> started to review driver code for this SoC and other drivers also have
>>>>> the same arch dependency that ideally should be avoided in the same
>>>>> way. This at the end means to break the ABI again in the future for
>>>>> those drivers / bindings. So I can just let them be as it is and not
>>>>> provide any change at all and continue without being compile tested
>>>>> and other beneficial features to detect future driver breakage.
>>>>>
>>>>
>>>> Problem is that there are (presumably) shipped systems out there with
>>>> the old devicetree file. The watchdog driver would no longer instantiate
>>>> on those systems.
>>>
>>> Ok, I will maintain only the PATCH that changes the driver to not use
>>> globals and send v5.
>>>
>>
>> Other options might be to search for the "syscon" node name or to search
>> for the "mediatek,mt7621-sysc" compatible.
> 
> Thanks for the hint. I didn't know about
> 'syscon_regmap_lookup_by_compatible()'. I will use this to avoid DTB
> ABI breakage and allow the driver to be selected for COMPILE_TEST..
> 

I didn't know about that one either. I thought about of_find_compatible_node()
or of_find_node_by_name(). syscon_regmap_lookup_by_compatible() is widely used,
though, so it seems to be a much better option.

Thanks,
Guenter

