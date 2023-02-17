Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE31769A4F7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 06:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBQFBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 00:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQFBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 00:01:19 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD315A3A3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 21:01:18 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id k6so4417780vsk.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 21:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lmq1AX4l7BfT40HlVrRZjM9eenWjOvLvEux3RFmEoWg=;
        b=mzfynhcgrkOoplyuqlL2AI4eBdkAFhrskPqgnwuDnkU6xR9Fyn93xP2Mhe52MNdxeB
         YbOAgDZoZ5AnITUtUgQtg6cilK0KeJfJKi2P/7sN3sJAOfcaPCdJNQdAyJ/eRGWVsFcP
         Zngo++3RtvgTitafOGLblUpXpCW7gPqR4iyCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lmq1AX4l7BfT40HlVrRZjM9eenWjOvLvEux3RFmEoWg=;
        b=bkwxNacoM7PbJpHlq81fYGmRwYckrGrxkeDyOVx24ik/yb5bX7XBkmcHGHWpK7pdQE
         WQBRrcj523UN+TkIm5Ma1mW7upgsAXZAQ5OQ5tEmIHnIQzBzzW+SFTjMzactPveQPfVD
         iANhV6Hpk0E6bcE3K7RcVTgIJM9uX8VqiKBq9zZjxGXmpM97ddw8ag3yH76bxOta1Q5i
         HgFmoJtmN+lbtwiv1UFzTbT7e9MWl2lYpPIp9HJbvG9/oN7blxz3SL//Z8HI+t7UlwhV
         76CEHRVuMEraXDB/AbqRwQf9qAA7SDGsWRt0IS4dymo/45gZHerldwF1VE9kcGEOpnsD
         xT1Q==
X-Gm-Message-State: AO0yUKU+00qDlumnNpxa105NJq3D8iRrXbKwlAZghdWqF4lzd3zVLdz1
        HPLklCuT65KR32QlcSqoy1hrmyLWCVUsDAayvJQYDg==
X-Google-Smtp-Source: AK7set+rIxXTdLszssQwjrPl/zffBSJASXRC2NxpmWZXPFmaNCb2uW0LmSshMzR+1Jfc6cjYctj08T5+Ubbk9qYPm0g=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1542200vso.60.1676610077504; Thu, 16 Feb
 2023 21:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
 <20230214134127.59273-37-angelogioacchino.delregno@collabora.com> <CAGXv+5FxnsJaVw2MzeH+-Z3yEPzPCRtTukp7FDhsBoKHfx=m=g@mail.gmail.com>
In-Reply-To: <CAGXv+5FxnsJaVw2MzeH+-Z3yEPzPCRtTukp7FDhsBoKHfx=m=g@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 13:01:06 +0800
Message-ID: <CAGXv+5E_kwn+9HLt0Y0BOyk-msXiU3W0N5woKenqVzK-GG_yQQ@mail.gmail.com>
Subject: Re: [PATCH v2 36/47] clk: mediatek: mt2712: Change Kconfig options to
 allow module build
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:24 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > All of the mt2712 drivers have been converted to platform drivers!
> > Change the Kconfig options for all MT2712 clocks to tristate to allow
> > building all clock drivers as modules.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/clk/mediatek/Kconfig | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> > index b9c0a9e21cf1..45b7aea7648d 100644
> > --- a/drivers/clk/mediatek/Kconfig
> > +++ b/drivers/clk/mediatek/Kconfig
> > @@ -75,7 +75,7 @@ config COMMON_CLK_MT2701_G3DSYS
> >           This driver supports MediaTek MT2701 g3dsys clocks.
> >
> >  config COMMON_CLK_MT2712
> > -       bool "Clock driver for MediaTek MT2712"
> > +       tristate "Clock driver for MediaTek MT2712"
>
> Hmm... How does that work out if mt2712-apmixedsys is a
> builtin_platform_driver?

Nevermind. I figured it out.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
