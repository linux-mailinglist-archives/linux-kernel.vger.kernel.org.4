Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC46F4BAC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjEBUzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEBUzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:55:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CAB19BE;
        Tue,  2 May 2023 13:55:16 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-24e25e2808fso1409766a91.0;
        Tue, 02 May 2023 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683060916; x=1685652916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EulDzMDk8Bos4imflbNXSXVh2i4HOXSRX7mnAd5bAro=;
        b=g1NYoOOP0BeOhdhVAoHAezLyb8yJGayWqHnJFmM6LeU1abyVyXdM160JdvPLHTGIe+
         fta5SXUVatmuBgISfR/nj+B5UQIZiXaSQofbYFHQrnpMTGV0pwcZSauu+DqgiVpY/7CG
         4K9hPQcrw6FUc7dVCYdz5nPKU7etbqbBLyWtpRuSkKNaEzPq4Ba2FMSDsRaEPotEPBFS
         1qiJVRZW4Q/uflRfMjpBMYZs5mk9ZdyQDtmCzudPEeSt4+NjeehHwq4cX2uf0GLQFZMN
         GxH13a2TjjKvJoygfNtRTocGZw0eMsSAqKwcGhkXZ5sqiLr7DM2IcVhjJfwUmNwzx+SE
         EnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683060916; x=1685652916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EulDzMDk8Bos4imflbNXSXVh2i4HOXSRX7mnAd5bAro=;
        b=E2TFbpHyqwcEtKqS8cuSwYjUcmJ+wBnkb5j+i5UTd+zL8712tKHgllpMIKUIdrdDhp
         u1o2vEJWJOgJxH4AiVBKuW6w2Nhyyknf09bkFtq7Dw7sQqfBEWRwRgkJox+EZWzWxGht
         rChpP7u/xTuhj5yB9b5wKNocIrMAh6lSO/sMRag+IXB71gNgwSiZcoykYxNRIT7qzVDQ
         VMDswqZrth7HMNBg+aml/MdXglZjCvB0S4yJb+Mj6oTik6ZoLR3RO2gijzTg5zYs2rMM
         L5R2DQmg2VYQR/FJ3xJb0yp3G74WXmJZdvLxklA0KLLzFse8WkHZC8gVk8Cmb6I6HljC
         7EDw==
X-Gm-Message-State: AC+VfDz1qw26xS3GCTV6HR8N/TTqJdrr4/pzpGcv6D4O3l6/CIQAy/Pm
        6fJBZZ95xgb1yOzgScTQVGI95oHFw2d3EPqiKtc=
X-Google-Smtp-Source: ACHHUZ4/Ds+5LODFKN0JoCmSbZ301yhWKZdtGeLwomqpBWIAwXbYzuX3X40hi+MtqA6iEUVbkf3JW2LaaeEwh/7iO1c=
X-Received: by 2002:a17:90a:8004:b0:24e:edd:4d63 with SMTP id
 b4-20020a17090a800400b0024e0edd4d63mr6375061pjn.5.1683060916016; Tue, 02 May
 2023 13:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230416191051.106513-1-aford173@gmail.com> <DU0PR04MB9417F545EDAF40730E1C872D889C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417F545EDAF40730E1C872D889C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 2 May 2023 15:55:04 -0500
Message-ID: <CAHCN7xKcbr4yVLpzberGTwJrkGp_y2d9UaPx5Eyq_nveMeQCjg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: composite-8m: Fix clock divisions greater than 8
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "aford@beaconembedded.com" <aford@beaconembedded.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 7:55=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH] clk: imx: composite-8m: Fix clock divisions greater th=
an 8
> >
> > When adding imx8m_clk_divider_determine_rate to let the imx8mm and
> > imx8mn get finer granulatiry of video clocks, it accidentally broke the
> > imx8mp ability to divide clocks by more than 8 on clocks when the
> > CLK_SET_RATE_PARENT flag is not set.
> >
> > On the imx8mp, the CLK_SET_RATE_PARENT flag cannot be set on either
> > media_disp1_pix or media_disp2_pix, because they both share the
> > video_pll as a common clock, and if two displays are used, the parent c=
lock
> > needs to be something that both child clocks can divide.
> >
> > imx8m_clk_divider_determine_rate ends up calling clk_divider_bestdiv
> > which uses the value of 'width' to setup the maximum divisor.  The clk-
> > composite-8m driver sets the with to 3 which means the maximum divisor =
is
> > 8, but these clocks can divide by up to 64.
> >
> > Currently, if the video_pll is set to 1039500000, the slowest clock rat=
e
> > achievable is 129937500 which breaks a whole bunch of lower resolution
> > and refresh options for both media_disp1_pix and media_disp2_pix.
> >
> > By changing the 'width' variable to PCG_DIV_WIDTH, the maximum divisor
> > becomes 64 which allows the clocks to divide down more, so the lower
> > resolutions and refresh rates are achievable again.
> >
> > Fixes: 156e96ff2172 ("clk: imx: composite-8m: Add support to
> > determine_rate")
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-
> > composite-8m.c
> > index 6883a8199b6c..805e6aada83d 100644
> > --- a/drivers/clk/imx/clk-composite-8m.c
> > +++ b/drivers/clk/imx/clk-composite-8m.c
> > @@ -47,6 +47,7 @@ static unsigned long
> > imx8m_clk_composite_divider_recalc_rate(struct clk_hw *hw,
> >                                  divider->flags, PCG_DIV_WIDTH);
> >  }
> >
> > +
> >  static int imx8m_clk_composite_compute_dividers(unsigned long rate,
> >                                               unsigned long parent_rate=
,
> >                                               int *prediv, int *postdiv=
)
> > @@ -215,12 +216,12 @@ struct clk_hw *__imx8m_clk_hw_composite(const
> > char *name,
> >               mux_ops =3D &imx8m_clk_composite_mux_ops;
> >       } else if (composite_flags & IMX_COMPOSITE_BUS) {
> >               div->shift =3D PCG_PREDIV_SHIFT;
> > -             div->width =3D PCG_PREDIV_WIDTH;
> > +             div->width =3D PCG_DIV_WIDTH;
> This is wrong. Pre divider width is 3, not 6.
>
> >               divider_ops =3D &imx8m_clk_composite_divider_ops;
> >               mux_ops =3D &imx8m_clk_composite_mux_ops;
> >       } else {
> >               div->shift =3D PCG_PREDIV_SHIFT;
> > -             div->width =3D PCG_PREDIV_WIDTH;
> > +             div->width =3D PCG_DIV_WIDTH;
> Ditto.
>
> You need find the other way to resolve the regression.

Peng,

Thank you for the review!  It took me a bit to better understand the
clock driver, but I think I found a solution that seems to work
without breaking 8mp. I did a clock dump on the 8mp, and I found no
differences in the clock rates generated before and after my patch.  I
will re-test the solution on the Mini and Nano.  If all goes well, I
will post a V2 patch which both does a revert and posts the fix.
Instead of using a common function to determine_rate, I wrote one
specific for the composite-8m which uses max values from both the
pre-div and post-div to determine the possible clock rates.  If the
read-only flag is set, it reads the existing values of the pre and
post dividers to determine whatever the divider is. It doesn't touch
any pre-existing composite-8m functions.

adam

>
> Regards,
> Peng.
>
> >               divider_ops =3D &imx8m_clk_composite_divider_ops;
> >               mux_ops =3D &clk_mux_ops;
> >               if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
> > --
> > 2.39.2
>
