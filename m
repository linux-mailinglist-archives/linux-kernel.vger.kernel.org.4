Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C169C72D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjBTJCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjBTJBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:01:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A745613DEA;
        Mon, 20 Feb 2023 01:01:37 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C5266600872;
        Mon, 20 Feb 2023 09:01:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676883696;
        bh=wRsFQ2JC/MDhBdv1WWKTeDTXi0UHILH+uiTslXRktbo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DoA8WQ4Pg5/JafFh2rMOi4m2dKIDVwaIaM2iRRWSOQ7edl76MpAnqTs4zBOL5/2JM
         9gHlW3TO6Ihgta4vrcb1BnWgnb6agHzu9sbDbhrjRTvAza0fusJr9zQTKKnWFMLgU+
         9T5DRcCagczrZqyzzlyzXAqxJlPbAcyK7kUIKWpg1Z8LxbugK27+S8hzr4Bf9ZP1Rz
         mbW2372OqFoXA3cUXtAtNhLxLW/3Vh/iFhbNZFWOgZj7HDq+nw7BdRct+VGzgT5jWq
         x8vfkV4u9cn2PpnMoOc0iWhJ4UMycJ+J9wlMhn827dNPWzxgsAJOyqkl2DJKSnga2r
         /0L7KlHOjifuw==
Message-ID: <dd25fddb-5c62-2dc7-6095-861499a5d21d@collabora.com>
Date:   Mon, 20 Feb 2023 10:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 36/47] clk: mediatek: mt2712: Change Kconfig options to
 allow module build
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
 <20230214134127.59273-37-angelogioacchino.delregno@collabora.com>
 <CAGXv+5FxnsJaVw2MzeH+-Z3yEPzPCRtTukp7FDhsBoKHfx=m=g@mail.gmail.com>
 <37690521-4d24-ce55-f81e-30ad931dfe95@collabora.com>
 <CAGXv+5FM_pxu4Ms1mbvpdJLxkOZe2ZXjNoiOCfANpdxLme+_Lg@mail.gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5FM_pxu4Ms1mbvpdJLxkOZe2ZXjNoiOCfANpdxLme+_Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/02/23 16:19, Chen-Yu Tsai ha scritto:
> On Fri, Feb 17, 2023 at 7:25 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 17/02/23 05:24, Chen-Yu Tsai ha scritto:
>>> On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> All of the mt2712 drivers have been converted to platform drivers!
>>>> Change the Kconfig options for all MT2712 clocks to tristate to allow
>>>> building all clock drivers as modules.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    drivers/clk/mediatek/Kconfig | 16 ++++++++--------
>>>>    1 file changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
>>>> index b9c0a9e21cf1..45b7aea7648d 100644
>>>> --- a/drivers/clk/mediatek/Kconfig
>>>> +++ b/drivers/clk/mediatek/Kconfig
>>>> @@ -75,7 +75,7 @@ config COMMON_CLK_MT2701_G3DSYS
>>>>             This driver supports MediaTek MT2701 g3dsys clocks.
>>>>
>>>>    config COMMON_CLK_MT2712
>>>> -       bool "Clock driver for MediaTek MT2712"
>>>> +       tristate "Clock driver for MediaTek MT2712"
>>>
>>> Hmm... How does that work out if mt2712-apmixedsys is a
>>> builtin_platform_driver?
>>>
>>> ChenYu
>>
>> That doesn't. Thanks for catching that, I've added a .remove() callback
>> and changed it to module_platform_driver() for v3!
> 
> Actually, I thought that if it were built as a module, then the
> builtin_platform_driver would then expand to a module_init() without
> module_exit(). So it would become a loadable module that cannot be
> unloaded.
> 
> That was just looking at the header files, so I could be mistaken.
> 
> Side note: IIRC a missing .remove() driver callback doesn't actually
> block driver removal or unbinding.
> 

It doesn't, but we'd leak memory because of the kzalloc() that happened
at the beginning of the probe function... so adding the .remove() callback
was pretty much necessary :-)

Thanks,
Angelo

> ChenYu
> 

