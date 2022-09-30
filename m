Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C265A5F072A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiI3JFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiI3JEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:04:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E555152642;
        Fri, 30 Sep 2022 02:04:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35FEB66022C7;
        Fri, 30 Sep 2022 10:04:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664528648;
        bh=J18iGBuqpaGn9zM2HqN+2TmtTYWNCUgQ3uUpK/eAiXM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZJl0ZJj631OCOC8dYn+FQwN7Uzx55xYz3EhxEIeTxjPeftYp9rwjVTBfqaNnfbArh
         QjQ28CtYwI2idishUbtoqZLXkE+KjSlx251AZ3st6Ql9I8cBcCGaLt4KHlGRJFjfJr
         whQeSHwhjOJWq7xUxZvC7FUCMmSh0SSleJP37fWCAwq1cfdEvwD7CqXJ3kp2muASsP
         GUZ8/x7pOvR/dImz3oqx6w/G7hENy75rLo/xhnnxyDx90ZTGdc5MXTYH6iFrfnsXhB
         2rEYK5qwbN7G9F/KJFKA9jQw4F46riocXAswEEY+YHzoPs+VGQjL0gXW9hrQq+Am4Y
         yEvq0I3UpAntw==
Message-ID: <b31518f0-c8ba-11b0-ff36-b5789b92878e@collabora.com>
Date:   Fri, 30 Sep 2022 11:04:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 08/10] clk: mediatek: clk-mt8195-topckgen: Drop
 univplls from mfg mux parents
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= 
        <MandyJH.Liu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "jose.exposito89@gmail.com" <jose.exposito89@gmail.com>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        =?UTF-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        =?UTF-8?B?V2VpeWkgTHUgKOWRguWogeWEgCk=?= <Weiyi.Lu@mediatek.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?UTF-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
References: <20220927101128.44758-1-angelogioacchino.delregno@collabora.com>
 <20220927101128.44758-9-angelogioacchino.delregno@collabora.com>
 <79490e834466628a1b92e51f65aeb9e9ce82ddce.camel@mediatek.com>
 <5d8af9a1-3afc-bd69-8f34-164284a452c2@collabora.com>
 <CAGXv+5EfsdjqH-gG=wcU4mGxWKmODMw3xJpNsugZJG9hdt1jcw@mail.gmail.com>
 <5d62200e-e058-29ea-063f-91dd1fd92cf7@collabora.com>
 <CAGXv+5F-P0D5G2ydxUbwDPaW-GgDSYOUGv5+3yx8JbHL_px=EA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5F-P0D5G2ydxUbwDPaW-GgDSYOUGv5+3yx8JbHL_px=EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/09/22 11:02, Chen-Yu Tsai ha scritto:
> On Fri, Sep 30, 2022 at 4:58 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 30/09/22 10:44, Chen-Yu Tsai ha scritto:
>>> On Fri, Sep 30, 2022 at 4:29 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 30/09/22 07:59, MandyJH Liu (劉人僖) ha scritto:
>>>>> On Tue, 2022-09-27 at 12:11 +0200, AngeloGioacchino Del Regno wrote:
>>>>>> These PLLs are conflicting with GPU rates that can be generated by
>>>>>> the GPU-dedicated MFGPLL and would require a special clock handler
>>>>>> to be used, for very little and ignorable power consumption benefits.
>>>>>> Also, we're in any case unable to set the rate of these PLLs to
>>>>>> something else that is sensible for this task, so simply drop them:
>>>>>> this will make the GPU to be clocked exclusively from MFGPLL for
>>>>>> "fast" rates, while still achieving the right "safe" rate during
>>>>>> PLL frequency locking.
>>>>>>
>>>>>> Signed-off-by: AngeloGioacchino Del Regno <
>>>>>> angelogioacchino.delregno@collabora.com>
>>>>>> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>>>>>> ---
>>>>>>     drivers/clk/mediatek/clk-mt8195-topckgen.c | 9 ++++++---
>>>>>>     1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c
>>>>>> b/drivers/clk/mediatek/clk-mt8195-topckgen.c
>>>>>> index 4dde23bece66..8cbab5ca2e58 100644
>>>>>> --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
>>>>>> +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
>>>>>> @@ -298,11 +298,14 @@ static const char * const ipu_if_parents[] = {
>>>>>>        "mmpll_d4"
>>>>>>     };
>>>>>>
>>>>>> +/*
>>>>>> + * MFG can be also parented to "univpll_d6" and "univpll_d7":
>>>>>> + * these have been removed from the parents list to let us
>>>>>> + * achieve GPU DVFS without any special clock handlers.
>>>>>> + */
>>>>>>     static const char * const mfg_parents[] = {
>>>>>>        "clk26m",
>>>>>> -    "mainpll_d5_d2",
>>>>>> -    "univpll_d6",
>>>>>> -    "univpll_d7"
>>>>>> +    "mainpll_d5_d2"
>>>>>>     };
>>>>>>
>>>>>>     static const char * const camtg_parents[] = {
>>>>> There might be a problem here. Since the univpll_d6 and univpll_d7 are
>>>>> available parents in hardware design and they can be selected other
>>>>> than kernel stage, like bootloader, the clk tree listed in clk_summary
>>>>> cannot show the real parent-child relationship in such case.
>>>>
>>>> I agree about that, but the clock framework will change the parent to
>>>> the "best parent" in that case... this was done to avoid writing complicated
>>>> custom clock ops just for that one.
>>>>
>>>> This issue is present only on MT8195, so it can be safely solved this way,
>>>> at least for now.
>>>>
>>>> Should this become a thing on another couple SoCs, it'll then make sense
>>>> to write custom clock ops just for the MFG.
>>>
>>> Would CLK_SET_RATE_NO_REPARENT on the fast mux coupled with forcing
>>> the clk tree to a state that we like (mfgpll->fast_mux->gate) work?
>>
>> I'm not sure that it would, and then this would mean that we'd have to add
>> assigned-clock-parents to the devicetree and the day we will introduce the
>> "complicated custom clock ops" for that, we'll most probably have to change
>> the devicetree as well... which is something that I'm a bit reluctant to do
>> as a kernel upgrade doesn't automatically mean that you upgrade the DT with
>> it to get the "new full functionality".
> 
> You can also do it by doing clk_set_parent() in the clock driver after the
> clocks are registered, or just write to the register before the clock is
> registered.
> 

I honestly don't like doing that - but I can try if that works and, if it does,
I can send a commit with a Fixes tag later, perhaps?


> We do the latter in some of the sunxi-ng drivers, though IIRC it was to
> force a certain divider on what we expose as a fixed divider clock.
> 
> ChenYu
> 
>> Introducing the new clock ops for the mfg mux is something that will happen
>> for sure, but if we don't get new SoCs with a similar "issue", I don't feel
>> confident to write them, as I fear these won't be as flexible as needed and
>> will eventually need a rewrite; that's why I want to wait to get the same
>> situation on "something new".
>>
>> In my opinion, it is safe to keep this change as it is, even though I do
>> understand the shown concerns about the eventual unability to show the tree
>> relationship in case the bootloader chooses to initialize the mfg mux with
>> a univpll parent.
>>
>> Regards,
>> Angelo
>>



