Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23E268D2D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjBGJbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjBGJa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:30:59 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C86810C8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:30:58 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e204so5452236iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zGPdj3+0FQHNiPlabma7Fo13cRWsc/bEceVgDPVg2Rs=;
        b=J4tfCPx1y44l8NRf6xJpVwWLh9GHJZKYvOJaxHtIncPoZNTdRIMKnKX7k3na0U9tJr
         Rsu0Nz94cH73T58Ufkl4WZmz1tBAFO5GRltdajj0I19fAa0EPKSg9Z7iQ58GW1DTZFUZ
         AnoJweCalPXKyU718fyK+jh5ZrLVjHGwo1d3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGPdj3+0FQHNiPlabma7Fo13cRWsc/bEceVgDPVg2Rs=;
        b=fYncBWAFL0oZDc8Ypne3VJve/6NJJjSvcHvgLF+ON3WAs3b0rC8/IL1/3dH8C3fpI5
         VUCu86Q5qdKrdrMvN6xVEGDBtapa61Wb26zsyGsHUjW4NcHKHT46Y/1r8qN1U0/ye9AG
         1hON79rMxD2xSZboffnVOhyiuYbyuJx+KJE1qN0H8Z16N2ixgc74jm0uBHaTiLj3PzsZ
         FCUULMKIZbSj2Y/3VZj52/p6zrVXMgjtVGvMQEneprHQGCWdEIlelBF9sADAgR3KWBwm
         lMZY4EPc/zIa/8O91iphawGQTJtcgKTNVtp5UDv/As2x1e0LkMei4RRN5e4Aqt5920zT
         SAjQ==
X-Gm-Message-State: AO0yUKUlwyR8FQoLEQRqttsiWsYRSrIzmOj+WuQn1NhbXtGGf78Xjl9c
        AvdhjZzeFVInfo27FNI/b/mweHhlpAm4eGIo1ZkfZw==
X-Google-Smtp-Source: AK7set9upZf6hhkKYsM0jB1B7IVVQUghW9jQDrSwas90o37+8CzNkccZTDjq+kvkxMrya0irHJOrnaVm7dIRvhwz/aQ=
X-Received: by 2002:a02:8795:0:b0:3b2:7985:6624 with SMTP id
 t21-20020a028795000000b003b279856624mr1884923jai.32.1675762257571; Tue, 07
 Feb 2023 01:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
 <20230206152928.918562-10-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GfwY2+55UupTUNYVudg3-YDQtkkfhT=M53CJwdqG=ERg@mail.gmail.com> <b7b35901-59aa-5342-1bd1-5ed591a0469c@collabora.com>
In-Reply-To: <b7b35901-59aa-5342-1bd1-5ed591a0469c@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 17:30:45 +0800
Message-ID: <CAGXv+5HNs-74COE_5V4O_ykLJN=K4YVR-5SNwcPTBcxFMoRm5g@mail.gmail.com>
Subject: Re: [PATCH v1 09/45] clk: mediatek: mt2712: Change to use
 module_platform_driver macro
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 5:00 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/02/23 07:33, Chen-Yu Tsai ha scritto:
> > On Mon, Feb 6, 2023 at 11:29 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Now that all of the clocks in clk-mt2712.c are using the common
> >> mtk_clk_simple_{probe,remove}() callbacks we can safely migrate
> >> to module_platform_driver.
> >
> > Instead of splitting the conversion into a module among many patches,
> > I'd do it in one go. With one patch we get a working module instead
> > of a half-baked one half way through the series.
> >
>
> If you really want I can eventually do that in one go - in any case, the
> sense of having this split in multiple commits is:
>   - Bisectability: topckgen/mcucfg migration being faulty would point at
>                    one commit doing just that, making it easier for whoever
>                    is trying to debug that to find what could've gone wrong;

This part I agree with.

>   - Slow changes:  A driver being a platform_driver doesn't mean that it *has*
>                    to be compiled as a module: infact, we can use the .remove()
>                    callback even with built-in drivers (as you can remove one
>                    and re-add it during runtime from sysfs)

I think the part that tripped me up was that in this patch's case it
was already a platform driver, just a builtin one (without the
builtin_platform_driver sugar).

>   - Signaling completion:
>                    Saying "this is complete" in this case is performed in the
>                    last patches of the series, where only the Kconfig is being
>                    changed to allow the module build for (most)all.

I'm concerned about people randomly cherry-picking patches. Unfortunately
not everyone lives on mainline, us included. (I'm sure Android has it
worse.) Many won't see the complete patch series, doubly so if we merge
it in stages. Better we give one complete patch that converts the
boilerplate code from "can't work as module" to "can work as module".
I do agree we should keep all the other cleanups and migration to
simple/pdev_probe separate for bisectability.

> > The subject could say "Convert X driver from builtin to module". And
> > instead of "migrate to module_platform_driver", the body could say
> > "convert to module by switching to module_platform_driver, and adding
> > missing MODULE_* statements". I believe this constitutes one logical
> > change. Maybe the accompanying Kconfig change should be included as
> > well?
> >
>
> But again, I don't have *really strong* opinions on this, if not preferences
> for how I'd like to see the changes getting in: this series brings big changes
> that would be done in many more commits if they were scattered in more series.
> Another point about having this conversion performed in multiple commits is
> showing how it was done and how to replicate it for a different driver...

In the past I've seen some comments from other maintainers about keeping
(module|builtin)_X_driver consistent with its Kconfig entry. That sort of
plays into my argument that this bit should be kept atomic.

There are a couple patches where you convert directly from CLK_OF_DECLARE
to module_platform_driver. We could work those out case by case?

> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >>   drivers/clk/mediatek/clk-mt2712.c | 10 ++--------
> >>   1 file changed, 2 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
> >> index c5fd76d1b9df..65c1cbcbd54e 100644
> >> --- a/drivers/clk/mediatek/clk-mt2712.c
> >> +++ b/drivers/clk/mediatek/clk-mt2712.c
> >> @@ -1028,7 +1028,7 @@ static const struct of_device_id of_match_clk_mt2712_simple[] = {
> >>          { /* sentinel */ }
> >>   };
> >>
> >> -static struct platform_driver clk_mt2712_simple_drv = {
> >> +static struct platform_driver clk_mt2712_drv = {
> >
> > Why the name change? If you do change the name, could you also change
> > the of match table's name as well to be consistent, and also mention
> > the change in the commit log?
>
> It simply looked like being a good idea, as "simple" made sense when we had two
> platform_driver in one file, one using simple_probe, one using a custom probe
> function.
> The latter going away forever means that there's no more distinction to do
> between the two, hence my rename here...
>
> Regarding the of_match_table name change... I'm sorry, I genuinely forgot to
> change it, my intention was infact to actually be consistent... :-)
>
> >
> > I'd just leave it alone though.
>
> I had to explain my reasoning about all of the above, so I'll just wait for
> your opinion again before going for a v2! :-)

Thanks again for working on this.

ChenYu
