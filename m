Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEEB6BC61D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCPGbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCPGbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:31:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4BD9FE61
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:31:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eh3so3341032edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678948273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9j8GQrtbHhtegURmxB3PLCY1oXF2JoBLNnpXVqbpVM=;
        b=DOE9hQAN6fOzn+o/ztsM5Jcw8cu/mQ/ARao0w4j1eT+bb2zW1Xf1pXHcKozM34BjwH
         iKpgLf9MjQWOBtBd7/9zvdrkX/O35KFOZH85Z4gemDZnNQwPlBAK515ba3PRctbm/MP5
         2w4qPBdmYjd1M9ZcrKkGxQE2VBsQ46hedHLo0AEol6nOoPcn7QmYTaZrnQ9SSIAzlJTo
         zc0M3tsia2kxJnZCJfV6893dKtPlRMCgQ/Eq8fl351N5NBuZgN825b/9mPvKOskwKuci
         Pl1rHnJFP+3SIZEXJ2KeWnkucKJnEnWEJfJrco2K3ltS/H3ifTat5/wpXrhYStl05lA7
         UHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678948273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9j8GQrtbHhtegURmxB3PLCY1oXF2JoBLNnpXVqbpVM=;
        b=MVyk3H/u+4+smEDVKpr+Y8sP6vX37UOh0iXxZtyNmO0DftVWU8xelA/99EiW0kz3Xo
         yfnrZpFdwhKEXCr/4K2yqwty8ilIPxBCboXtWStUBdOlJbQHIRmBZ/Wjfr3VnZURMZOK
         YjlH1myLc0MTyOQplhf1DVAyu8Se6JCWZC1kU+sz1Wv5phZaMzbewNH8waRij/Wf6Jj2
         jRAJV/xTV7VEW18gzRl7KG77GDwWP1L+WMPC/B++N/PSepz9HuyNYA/5khNBL4jGHzZB
         RkeHSw384vwx/V396NtZ7/N0Gtg597KHwwjKUAxG/b/ngUE+obHR3mUWI2Bz2hNFz9hU
         QiUQ==
X-Gm-Message-State: AO0yUKUxET17mkaPrjM61gM105uGWPU5HzM0PXDOgQ3xygHNuS4hQTEd
        3qC+ETXLjxz7tJ3vTEBcQ/LGHg==
X-Google-Smtp-Source: AK7set//6drX8/WV32h0Hq7ln8wNthIukaVT2fKbs7oH3weuhTKlatV+vwcvLqfs8GyzHamupsNjug==
X-Received: by 2002:a17:906:14c9:b0:8ab:4c4:d0f6 with SMTP id y9-20020a17090614c900b008ab04c4d0f6mr8694921ejc.56.1678948273080;
        Wed, 15 Mar 2023 23:31:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id oy17-20020a170907105100b008e385438c76sm3427088ejb.55.2023.03.15.23.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 23:31:12 -0700 (PDT)
Message-ID: <b04eb48e-c9aa-0404-33ec-bef623b8282f@linaro.org>
Date:   Thu, 16 Mar 2023 07:31:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v29 1/7] dt-bindings: mediatek: add ethdr definition for
 mt8195
To:     =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
References: <20221227081011.6426-1-nancy.lin@mediatek.com>
 <20221227081011.6426-2-nancy.lin@mediatek.com>
 <4aff6a7a3b606f26ec793192d9c75774276935e0.camel@mediatek.com>
 <2700bd6c-f00d-fa99-b730-2fcdf89089fa@linaro.org>
 <1d65e8b2de708db18b5f7a0faaa53834e1002d9f.camel@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1d65e8b2de708db18b5f7a0faaa53834e1002d9f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 07:19, Nancy Lin (林欣螢) wrote:
> On Wed, 2023-03-15 at 08:16 +0100, Krzysztof Kozlowski wrote:
>> On 15/03/2023 04:45, Nancy Lin (林欣螢) wrote:
>>
>> Trim the replies and remove unneeded context. You want to get the
>> attention of other people, not force them to read entire email.
>>
>>>> +  mediatek,gce-client-reg:>> +    $ref:
>>>> /schemas/types.yaml#/definitions/phandle-array
>>>> +    description: The register of display function block to be
>>>> set by
>>>> gce.
>>>> +      There are 4 arguments in this property, gce node, subsys
>>>> id,
>>>> offset and
>>>> +      register size. The subsys id is defined in the gce header
>>>> of
>>>> each chips
>>>> +      include/dt-bindings/gce/<chip>-gce.h, mapping to the
>>>> register
>>>> of display
>>>> +      function block.
>>>> +    items:
>>>> +      items:
>>>> +        - description: phandle of GCE
>>>> +        - description: GCE subsys id
>>>> +        - description: register offset
>>>> +        - description: register size
>>>> +    minItems: 7
>>>> +    maxItems: 7
>>>> +
>>>
>>> Hi Rob and krzysztof,
>>>
>>> I got the two messages when running dt_binding_check [1]. This
>>> binding
>>> patch was sent previously in [2]. 
>>>
>>> If I remove the following items/minItems/maxItems in the
>>> mediatek,gce-
>>> client property, the two message disappear. I don't know what's
>>> wrong
>>> with the original syntax. Do you have any suggestions for this?
>>>
>>> -    items:
>>> -      items:
>>> -        - description: phandle of GCE
>>> -        - description: GCE subsys id
>>> -        - description: register offset
>>> -        - description: register size
>>> -    minItems: 7
>>> -    maxItems: 7
>>>
>>>
>>> [1].
>>> Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.e
>>> xamp
>>> le.dtb
>>> /proj/mtk19347/cros/src/third_party/kernel/v5.10/Documentation/devi
>>> cetr
>>> ee/bindings/display/mediatek/mediatek,ethdr.example.dtb: 
>>> hdr-engine@1c114000: mediatek,gce-client-reg:0: [4294967295, 7,
>>> 16384,
>>> 4096, 4294967295, 7, 20480, 4096, 4294967295, 7, 28672, 4096,
>>> 4294967295, 7, 36864, 4096, 4294967295, 7, 40960, 4096, 4294967295,
>>> 7,
>>> 45056, 4096, 4294967295, 7, 49152, 4096] is too long
>>>         From schema:
>>
>> This looks like known issue with phandles with variable number of
>> arguments. Either we add it to the exceptions or just define it in
>> reduced way like in other cases - only maxItems: 1 without describing
>> items.
>>
>>
>> Best regards,
>> Krzysztof
> 
> 
> Hi Krzysztof,
> 
> Thanks for the comment.
> 
> But I have several items for this vendor property in the binding
> example.

Do you? I thought you have one phandle?

> Can I remove maxItems? Change the mediatek,gce-client-reg as [1].
> 
> [1]
>   mediatek,gce-client-reg:
>     $ref: /schemas/types.yaml#/definitions/phandle-array
>     description: The register of display function block to be set by
> gce.
>       There are 4 arguments in this property, gce node, subsys id,
> offset and
>       register size. The subsys id is defined in the gce header of each
> chips
>       include/dt-bindings/gce/<chip>-gce.h, mapping to the register of
> display
>       function block.

No, this needs some constraints.

Best regards,
Krzysztof

