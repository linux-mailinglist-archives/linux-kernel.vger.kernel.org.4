Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3785D65961C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 09:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiL3IKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 03:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiL3IKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 03:10:11 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE194183B9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:10:10 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id m2so20582857vsv.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 00:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6m26YMbks5w9j7aA1kyB8fHaCoQJomo7rPAPrntLOog=;
        b=da0u9H3i2xBt3fWJah+Dv2qxTKOgSPA3AOzUFkMKqyZBIZZP1P0UGdJuaICzOxt4fH
         Mm1wEa0yAJTOmV4DWB4J14oTVDAi63M5Vz3MP/SaMgYICVkVtF/81mtEBJvcpGuYIkY9
         crEd8lqVWmWgaSLClDuFEAsKqpu5aflcbck8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6m26YMbks5w9j7aA1kyB8fHaCoQJomo7rPAPrntLOog=;
        b=2rJnPO0VXWsFwjd+J8JloIw79xHpYn0xeQbiPMf6lQHk7tVX6mKGzIdXJvtf3Pscrm
         7IjKTiaMjWfyvlEBAu0NqaJU1CAZwZiGXdz6hixxhs+zRUdWl+SaD+3TFZOoO+kdowCK
         qb2wv3JrTJv9Q0A/tauD1MLLtaI01G400Mzjopxl1Ce/hlf4o2EEEE9eojJmIDbxDTIM
         TA1hE2KRCUSI+hjr8xv6WOEKBc+7Y60ShvQtKBbZ/ZiJzWtewkDZlJ2j4I66t4TB9gt4
         vsFST7iXq7asvlJR4IMHjt/f67dVTZjaln3jktZEn7xhnGosE9dTLnbTnWwNiIFYYRk2
         CV4w==
X-Gm-Message-State: AFqh2koTy5KZP5bXmxqNU0+C+nM2jod4Y9dVXuUdJmQSB4QmcjJA0zMM
        SCCdbyiESMFrB65/IUl0sSKFLfauU+gJFeGqZDeO2w==
X-Google-Smtp-Source: AMrXdXu42OIXcFU1BSE54ydAcv7zw3Gqh5WM+YiUnvG/dZqYgZpVZP5X5dL1GmIq2Knsf9WEE8McGyC3+t2WX/bbKjs=
X-Received: by 2002:a67:fbc2:0:b0:3cc:fb59:8c71 with SMTP id
 o2-20020a67fbc2000000b003ccfb598c71mr21878vsr.65.1672387810048; Fri, 30 Dec
 2022 00:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20221223094259.87373-16-angelogioacchino.delregno@collabora.com> <20221228083123.15298-1-miles.chen@mediatek.com>
In-Reply-To: <20221228083123.15298-1-miles.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 30 Dec 2022 16:09:59 +0800
Message-ID: <CAGXv+5Hp3MFjLcP5z0t6QnYHN3VvVg_Og_HhvWNxm5o1q20B=g@mail.gmail.com>
Subject: Re: [PATCH v2 15/23] clk: mediatek: mt8192: Join top_adj_divs and top_muxes
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        devicetree@vger.kernel.org, fparent@baylibre.com,
        ikjn@chromium.org, johnson.wang@mediatek.com,
        jose.exposito89@gmail.com, kernel@collabora.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, msp@baylibre.com, mturquette@baylibre.com,
        nfraprado@collabora.com, pablo.sun@mediatek.com,
        rex-bc.chen@mediatek.com, robh+dt@kernel.org, ryder.lee@kernel.org,
        sam.shih@mediatek.com, sboyd@kernel.org, weiyi.lu@mediatek.com,
        y.oudjana@protonmail.com, yangyingliang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 4:31 PM Miles Chen <miles.chen@mediatek.com> wrote:
>
> Hi,
>
> > These two are both mtk_composite arrays, one dependent on another, but
> > that's something that the clock framework is supposed to sort out and
> > anyway registering them separately isn't going to ease the framework's
> > job in checking dependencies.
> >
> > Put the contents of top_adj_divs in top_muxes to join them together
> > and register them in one shot.
> >
>
> In mt8192, we can join top_adj_divs and top_muxes:
>
> mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base, &mt8192_clk_lock,
>                 top_clk_data);
> mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base, &mt8192_clk_lock,
>                 top_clk_data);
>
> However, there are other top_adj_divs[] and top_muxes[] in different types so
> we cannot join them.
>
> For example:
> in drivers/clk/mediatek/clk-mt8167.c:mtk_topckgen_init():
>
> mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
>                 &mt8167_clk_lock, clk_data);
> mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
>                 base, &mt8167_clk_lock, clk_data);
>
> So we can join top_adj_divs and top_muxes in some platforms, but we
> cannot join top_adj_divs and top_muxes in some other platforms.
>
> I'm afraid that this will confuses people.

I think the confusion comes from the macro names. It's not exactly clear that
DIV_GATE is for composite clocks, while DIV_ADJ is for divider clocks.
Doubly so for the mux related types.

Either way, using the wrong macro or the wrong type will cause the compiler
to complain, so I think it's something we can live with. If it's still not
working out, maybe we should rethink the naming.

ChenYu
