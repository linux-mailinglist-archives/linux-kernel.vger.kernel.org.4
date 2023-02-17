Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE6C69AA5C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjBQL3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBQL3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:29:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9598E66649;
        Fri, 17 Feb 2023 03:29:28 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E457A660212C;
        Fri, 17 Feb 2023 11:29:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676633367;
        bh=8erMMp/b3F39tRE2R/nCGBBfR4DFmaNqkX8xwNyUHvg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ad/BDNeLml9CtjYisoMhW31GApcs5Se7olS8xAvVAbfNdCx3xOjcsd3yKKGxAj3uH
         +o37+8T2w6NHR7gCrRvK8l0XYX1s3JLL4rYsV6+86XXuFOg+Y48zPc4T3xcIBlWZHt
         YcZwM81Gk41I5BOX54P3RBZcF92B7Bqbt8Egrqu7IYnmSXzl2t4PZMxpjkYOF/4Yeq
         hqV3gz6IzBgVTh95pmd/P65bJrmTch+LFdDv3crW13kPBLVh74udPPQ1jsz4rIhFge
         wHALU9fOsWUFXPynqCu4GjMVgM3vcbMsGOXZjLx8H8pFe4/cn0z51D1l+aFOyf9jHz
         Kqb6cy7IbRs2Q==
Message-ID: <c9bd53f9-7d5a-6e2d-4062-297158661422@collabora.com>
Date:   Fri, 17 Feb 2023 12:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 37/47] clk: mediatek: Split MT8195 clock drivers and
 allow module build
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
 <20230214134127.59273-38-angelogioacchino.delregno@collabora.com>
 <CAGXv+5H7=rOwVK2SapqyeKHKnRJMwXFf1OSD-qhgjkbkoR=Zmw@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5H7=rOwVK2SapqyeKHKnRJMwXFf1OSD-qhgjkbkoR=Zmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/02/23 05:31, Chen-Yu Tsai ha scritto:
> On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> MT8195 clock drivers were encapsulated in one single (and big) Kconfig
>> option: there's no reason to do that, as it is totally unnecessary to
>> build in all or none of them.
>>
>> Split them out: keep boot-critical clocks as bool and allow choosing
>> non critical clocks as tristate.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/clk/mediatek/Kconfig  | 86 +++++++++++++++++++++++++++++++++++
>>   drivers/clk/mediatek/Makefile | 20 +++++---
>>   2 files changed, 99 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
>> index 45b7aea7648d..88937d111e98 100644
>> --- a/drivers/clk/mediatek/Kconfig
>> +++ b/drivers/clk/mediatek/Kconfig
>> @@ -692,6 +692,92 @@ config COMMON_CLK_MT8195
>>           help
>>             This driver supports MediaTek MT8195 clocks.
>>
>> +config COMMON_CLK_MT8195_APUSYS
>> +       tristate "Clock driver for MediaTek MT8195 apusys"
>> +       depends on COMMON_CLK_MT8195
> 
> Would something like
> 
>            default COMMON_CLK_MT8195
> 
> help with the transition?
> 
> Otherwise we'd need to add a whole lot more stuff to arm64's defconfig,
> and anyone running `make olddefconfig` would have many of their clock
> drivers no longer available.
> 
> Same applies to the MT8186 split.
> 
> Seems like not all MediaTek SoCs apply this pattern, but at least MT7986,
> MT8167, MT8173, MT8183 do this.
> 
> ChenYu

Right. Since MT8195 machines have been out in the wild for a bit of time now,
I think it's worth following your advice and add `default COMMON_CLK_MT8195`
to the new configuration options.

As for MT8186, currently, there's only one board supported upstream, which
is the "unobtainable" EVB so I would rather not do that for MT8186, unless
you have any strong opinions on that.

Regards,
Angelo
