Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF2268D4D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjBGKvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjBGKvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:51:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BC218170;
        Tue,  7 Feb 2023 02:50:32 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B4559660206C;
        Tue,  7 Feb 2023 10:50:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675767030;
        bh=gk3nv5Wp6sOvvNknpB4/fAb2bjtwP+iuNtzzSzevSEU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mACiSeic8ZVcfPGTpBv4aZMhtGPzCsIAJyKpUSsSloRLv4GC5nwfxS0valjfRDixq
         pnUhACV8+0C+rzwSk9q7rE0hcruNMY4ZTuwNOKGOTwoekuHmt22mghJ82cseucS1NC
         SRbHXmsxxz22CDSlRP5Hseh9jBjE2C3L0eYxkNdWStY70TxzXDwumfijcCCEnf+yME
         50VqsPmjJVoeqySZofUn9s/7GEOTAXBiwOYBHThFVAaV8pENXK80GmaCjpQW+8FbrG
         9TIlR+061qqC3aNQMucs8eJUO83RLc3zrpufJe9k8bh7VD2hC+XY2Y5uxaTiqtsD0N
         iEjjBdZl1wkhw==
Message-ID: <d07156bd-95e6-5c7d-b88e-1c4a5dfc3a07@collabora.com>
Date:   Tue, 7 Feb 2023 11:50:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 09/45] clk: mediatek: mt2712: Change to use
 module_platform_driver macro
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
 <20230206152928.918562-10-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GfwY2+55UupTUNYVudg3-YDQtkkfhT=M53CJwdqG=ERg@mail.gmail.com>
 <b7b35901-59aa-5342-1bd1-5ed591a0469c@collabora.com>
 <CAGXv+5HNs-74COE_5V4O_ykLJN=K4YVR-5SNwcPTBcxFMoRm5g@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5HNs-74COE_5V4O_ykLJN=K4YVR-5SNwcPTBcxFMoRm5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/02/23 10:30, Chen-Yu Tsai ha scritto:
> On Tue, Feb 7, 2023 at 5:00 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 07/02/23 07:33, Chen-Yu Tsai ha scritto:
>>> On Mon, Feb 6, 2023 at 11:29 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Now that all of the clocks in clk-mt2712.c are using the common
>>>> mtk_clk_simple_{probe,remove}() callbacks we can safely migrate
>>>> to module_platform_driver.
>>>
>>> Instead of splitting the conversion into a module among many patches,
>>> I'd do it in one go. With one patch we get a working module instead
>>> of a half-baked one half way through the series.
>>>
>>
>> If you really want I can eventually do that in one go - in any case, the
>> sense of having this split in multiple commits is:
>>    - Bisectability: topckgen/mcucfg migration being faulty would point at
>>                     one commit doing just that, making it easier for whoever
>>                     is trying to debug that to find what could've gone wrong;
> 
> This part I agree with.
> 
>>    - Slow changes:  A driver being a platform_driver doesn't mean that it *has*
>>                     to be compiled as a module: infact, we can use the .remove()
>>                     callback even with built-in drivers (as you can remove one
>>                     and re-add it during runtime from sysfs)
> 
> I think the part that tripped me up was that in this patch's case it
> was already a platform driver, just a builtin one (without the
> builtin_platform_driver sugar).
> 
>>    - Signaling completion:
>>                     Saying "this is complete" in this case is performed in the
>>                     last patches of the series, where only the Kconfig is being
>>                     changed to allow the module build for (most)all.
> 
> I'm concerned about people randomly cherry-picking patches. Unfortunately
> not everyone lives on mainline, us included. (I'm sure Android has it
> worse.) Many won't see the complete patch series, doubly so if we merge
> it in stages. Better we give one complete patch that converts the
> boilerplate code from "can't work as module" to "can work as module".
> I do agree we should keep all the other cleanups and migration to
> simple/pdev_probe separate for bisectability.
> 

One complete patch meaning that migrating to mtk_clk_simple_probe() should be
squashed with moving apmixedsys away?

So one patch doing the *big* change, and then one changing the driver to use
the module_platform_driver() macro and tristate in Kconfig?

I would be more comfortable changing the order of commits at this point,
apmixedsys error handling Fixes -> apmixedsys moved in its own file ->
migrate others to mtk_clk_simple_probe() *and* Kconfig changes

What do you think?

Thing is, apmixedsys is not a simple_probe driver and will never be, so
it feels wrong to move that inside of a commit that converts to simple_probe()...

>>> The subject could say "Convert X driver from builtin to module". And
>>> instead of "migrate to module_platform_driver", the body could say
>>> "convert to module by switching to module_platform_driver, and adding
>>> missing MODULE_* statements". I believe this constitutes one logical
>>> change. Maybe the accompanying Kconfig change should be included as
>>> well?
>>>
>>
>> But again, I don't have *really strong* opinions on this, if not preferences
>> for how I'd like to see the changes getting in: this series brings big changes
>> that would be done in many more commits if they were scattered in more series.
>> Another point about having this conversion performed in multiple commits is
>> showing how it was done and how to replicate it for a different driver...
> 
> In the past I've seen some comments from other maintainers about keeping
> (module|builtin)_X_driver consistent with its Kconfig entry. That sort of
> plays into my argument that this bit should be kept atomic.
> 
> There are a couple patches where you convert directly from CLK_OF_DECLARE
> to module_platform_driver. We could work those out case by case?
> 
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    drivers/clk/mediatek/clk-mt2712.c | 10 ++--------
>>>>    1 file changed, 2 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
>>>> index c5fd76d1b9df..65c1cbcbd54e 100644
>>>> --- a/drivers/clk/mediatek/clk-mt2712.c
>>>> +++ b/drivers/clk/mediatek/clk-mt2712.c
>>>> @@ -1028,7 +1028,7 @@ static const struct of_device_id of_match_clk_mt2712_simple[] = {
>>>>           { /* sentinel */ }
>>>>    };
>>>>
>>>> -static struct platform_driver clk_mt2712_simple_drv = {
>>>> +static struct platform_driver clk_mt2712_drv = {
>>>
>>> Why the name change? If you do change the name, could you also change
>>> the of match table's name as well to be consistent, and also mention
>>> the change in the commit log?
>>
>> It simply looked like being a good idea, as "simple" made sense when we had two
>> platform_driver in one file, one using simple_probe, one using a custom probe
>> function.
>> The latter going away forever means that there's no more distinction to do
>> between the two, hence my rename here...
>>
>> Regarding the of_match_table name change... I'm sorry, I genuinely forgot to
>> change it, my intention was infact to actually be consistent... :-)
>>
>>>
>>> I'd just leave it alone though.
>>
>> I had to explain my reasoning about all of the above, so I'll just wait for
>> your opinion again before going for a v2! :-)
> 
> Thanks again for working on this.
> 
> ChenYu



