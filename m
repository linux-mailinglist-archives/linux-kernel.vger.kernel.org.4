Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1383621D28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiKHToH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKHToD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:44:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417521112;
        Tue,  8 Nov 2022 11:44:01 -0800 (PST)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 78F166602901;
        Tue,  8 Nov 2022 19:43:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667936640;
        bh=6IPOHqPNCs5nNHtjv5U5pfU8G/tXeRydSVK9DQqoUkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nPXE7p8WqjCGRkfHD/65NWImZPY/i2vIC/StyEb0unYuDap47EAXgfs0u0q+jgkms
         szfJr9WEm99QqrmKzOpP89A42+huD66hckwCuLM0R3+N+IFoV39yh7a+QpsW8gw7DX
         2zPICGRqXjO+jW8lAQdr2juuUiF1kdUR4c05x3VegIw5U11c6+vFBrvPUKGQoBVC9i
         Zeigx9Buktk7dcxN7rQc3OYffrGPxgm3zyM4aMiPot03Z3MUIQTApS554yekyKx5nx
         eIMg/kLlDa5nirPo0oE6en73dqAHwlCV0ZIgG7l6OXr19HoFkUPC0tpLZcKj+zsOZV
         wjbU2tKpgfHZw==
Date:   Tue, 8 Nov 2022 14:43:51 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux@roeck-us.net,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v28 05/11] soc: mediatek: refine code to use
 mtk_mmsys_update_bits API
Message-ID: <20221108194351.u63k4mqzq3bkhpl7@notapiano>
References: <20221107072243.15748-1-nancy.lin@mediatek.com>
 <20221107072243.15748-6-nancy.lin@mediatek.com>
 <58d55016-afc7-e560-32cf-8228794b5752@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58d55016-afc7-e560-32cf-8228794b5752@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 06:37:19PM +0100, Matthias Brugger wrote:
> 
> 
> On 07/11/2022 08:22, Nancy.Lin wrote:
> > Simplify code for update  mmsys reg.
> > 
> > Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Tested-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >   drivers/soc/mediatek/mtk-mmsys.c | 45 ++++++++++++--------------------
> >   1 file changed, 16 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> > index 9a327eb5d9d7..73c8bd27e6ae 100644
> > --- a/drivers/soc/mediatek/mtk-mmsys.c
> > +++ b/drivers/soc/mediatek/mtk-mmsys.c
> > @@ -99,22 +99,27 @@ struct mtk_mmsys {
> >   	struct reset_controller_dev rcdev;
> >   };
> > +static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, u32 mask, u32 val)
> > +{
> > +	u32 tmp;
> > +
> > +	tmp = readl_relaxed(mmsys->regs + offset);
> > +	tmp = (tmp & ~mask) | (val & mask);
> 
> I'm not sure about the change in the implementation of
> mtk_mmsys_update_bits(). Nicolas tried to explain it to me on IRC but I
> wasn't totally convincing. As we have to go for at least another round of
> this patches, I'd like to get a clear understanding while it is needed that
> val bits are set to 1 in the mask.

The point here was to make sure that mtk_mmsys_update_bits() didn't allow
setting bits outside of the mask, since that's never what you want: the entire
point of having a mask is to specify the bits that should be updated (and the
ones that should be kept unchanged). So for example if you had

mask = 0x0ff0
val  = 0x00ff

the previous implementation would happily overwrite the 4 least significant bits
on the destination register, despite them not being present in the mask, which
is wrong.

This wrong behavior could easily lead to hard to trace bugs as soon as a badly
formatted/wrong val is passed and an unrelated bit updated due to the mask being
ignored.

For reference, _regmap_update_bits() does the same masking of the value [1].

That said, given that this function already existed and was just being moved,
it would've been cleaner to make this change in a separate commit.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regmap.c#L3122

Thanks,
Nícolas

> 
> Regards,
> Matthias
> 
> > +	writel_relaxed(tmp, mmsys->regs + offset);
> > +}
[..]
> > -static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, u32 mask, u32 val)
> > -{
> > -	u32 tmp;
> > -
> > -	tmp = readl_relaxed(mmsys->regs + offset);
> > -	tmp = (tmp & ~mask) | val;
> > -	writel_relaxed(tmp, mmsys->regs + offset);
> > -}
> > -
[..]
