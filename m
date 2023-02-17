Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8569AF5F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBQPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjBQPTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:19:31 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2D76FF27
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:19:20 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id 79so665878iou.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=28m85WAnnpLbewBzTbhGeA+5WhnAGWrMfNOGOaniYvg=;
        b=iTru555DCJcpPNOjU2/mVZu3LtQWSUYUAdKx5txJDVaFEE+NyIgC/P/XwyueRf+4do
         7Yz+08J0QeVNBWxztiyYiioFfvMUrEuBB4AmC0Z3DpkFXaTd0jRfUUXDfymbuGl4ntV2
         JKwmE3iszmEVGb4VRciHCQmkRcgZoqezEIapM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28m85WAnnpLbewBzTbhGeA+5WhnAGWrMfNOGOaniYvg=;
        b=R1Q5axTvvIN3W67K7dmL57ZnNxUbuofOTNi32ob/le7p+DxWbArjcd0YJq1GDqSZMZ
         Lc9pXDv4Qq9Vs9rhdYFfNdjKQSbeMpTNLhsbpJ2/7Ah5skfvh3H0V9Pq9zmkefgAhu/g
         6pMp33EFIxqolKdi8jqN9lhSCCM6NBH/tAmtEKP3QSoQtkti41ln70UNBetnrEYFf+33
         aqhQzzPIXIk88bHITLRauHgGgT9oB+aP8Vqql6VAXEwJWJuv67bwOIxebxFrv62a6bUj
         b2e8lgg7Jq1oXUTvMtMeBVMQdsjfLzg+rrFCrsfZQ/gq0yVbnEFxAcPtdOLLzDt5bLE1
         ukLA==
X-Gm-Message-State: AO0yUKW9h0fTslDMw9nE7WLHyZVbi1jtbo88MsczQWka9U1FT2QV44lh
        AGnX6AzhwtFaF8zgwbq/YvpiuKD2fnAJgIa4IK8SZQ==
X-Google-Smtp-Source: AK7set8yV0jmr30XFE4rM1GZt6qlKEkgdKldV2tS6LZdcI//mJo2pc20sn2fQPNhGqIKrveAS4/pZnYJaRxzTdtVSm4=
X-Received: by 2002:a6b:e70e:0:b0:740:66b5:12c1 with SMTP id
 b14-20020a6be70e000000b0074066b512c1mr3255468ioh.19.1676647159803; Fri, 17
 Feb 2023 07:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
 <20230214134127.59273-37-angelogioacchino.delregno@collabora.com>
 <CAGXv+5FxnsJaVw2MzeH+-Z3yEPzPCRtTukp7FDhsBoKHfx=m=g@mail.gmail.com> <37690521-4d24-ce55-f81e-30ad931dfe95@collabora.com>
In-Reply-To: <37690521-4d24-ce55-f81e-30ad931dfe95@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 23:19:08 +0800
Message-ID: <CAGXv+5FM_pxu4Ms1mbvpdJLxkOZe2ZXjNoiOCfANpdxLme+_Lg@mail.gmail.com>
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

On Fri, Feb 17, 2023 at 7:25 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 17/02/23 05:24, Chen-Yu Tsai ha scritto:
> > On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> All of the mt2712 drivers have been converted to platform drivers!
> >> Change the Kconfig options for all MT2712 clocks to tristate to allow
> >> building all clock drivers as modules.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> ---
> >>   drivers/clk/mediatek/Kconfig | 16 ++++++++--------
> >>   1 file changed, 8 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> >> index b9c0a9e21cf1..45b7aea7648d 100644
> >> --- a/drivers/clk/mediatek/Kconfig
> >> +++ b/drivers/clk/mediatek/Kconfig
> >> @@ -75,7 +75,7 @@ config COMMON_CLK_MT2701_G3DSYS
> >>            This driver supports MediaTek MT2701 g3dsys clocks.
> >>
> >>   config COMMON_CLK_MT2712
> >> -       bool "Clock driver for MediaTek MT2712"
> >> +       tristate "Clock driver for MediaTek MT2712"
> >
> > Hmm... How does that work out if mt2712-apmixedsys is a
> > builtin_platform_driver?
> >
> > ChenYu
>
> That doesn't. Thanks for catching that, I've added a .remove() callback
> and changed it to module_platform_driver() for v3!

Actually, I thought that if it were built as a module, then the
builtin_platform_driver would then expand to a module_init() without
module_exit(). So it would become a loadable module that cannot be
unloaded.

That was just looking at the header files, so I could be mistaken.

Side note: IIRC a missing .remove() driver callback doesn't actually
block driver removal or unbinding.

ChenYu
