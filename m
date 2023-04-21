Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B994F6EA986
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjDULpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjDULpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:45:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8F5273D;
        Fri, 21 Apr 2023 04:45:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso1783268b3a.2;
        Fri, 21 Apr 2023 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682077507; x=1684669507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqJNVo1ugMPScl25MbOFNWwX6gbBlo39fajL+yXdhtA=;
        b=Ms+U9Jv9OItrSM1BgXXENvFtjqarSrIuubRqZ1mhl6oYvQ3zrYJvb4U93/qV0uIZOI
         4PmshBR2+nlGBYR+YEOJmOfifOH6vzxLxoQuYRuY3xSqtE2lL/N9kV9jAWvXVq1uULE9
         LOhsBJsB6Ln/AF3kUEWa1/ZKtCRguYnK+So9Yq7xYh3iiHueLHy1OoVnay4lHPmM817/
         pR6GCz16n5GwGcN9o82A9DeAQJ+2mtKbCw62Hh7lD53Xf/Sy6ZPy1UrO2z0yDQsMncK0
         zc0yiyH7+thS5pAbF6YgFZvNg7NNi+wFktCIjyYDbP9tONtMUgjrf3+OIPloTBgqZwec
         vMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682077507; x=1684669507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqJNVo1ugMPScl25MbOFNWwX6gbBlo39fajL+yXdhtA=;
        b=Ax3L2nYn1Y3uBnM7SkzPihqaSByyT5O7tscpo/W6L0uZuRGdCUwuGY5h/vkoIpBTEC
         gg8gUJ+zR09FbLN2Yutssk4DcqebX6Zi/DS9X+Tv8anBMQCtq11BPczrxDEmtdchuq18
         cbXsH+Qlkt+EqzeGW98hBwyT//8ZOPTEkATdWvB/Vh+/bPX25IW8+C2Sz0UL8pFBpUDa
         QmZb5FhnSd1GdALwslk5xclZmJH0ixXl/qTQ9KAs9jeGqtisXfp2bxEtse5To79QcIA3
         XGmpdHEOo2jrv6lrBx8A1/H5CptwfuL1Sk+cf6bpBg9ahkpjC5esYiKFwgT+m4SP1+H2
         qjkA==
X-Gm-Message-State: AAQBX9cnLOFp2a+0VSd8IloTr1dxgusoEXl+pR53CnGrLDHu4LJ3AyLN
        cZBu7AnAeY2MOxKe6d9j41R84E4jQvpIDhy3IK0=
X-Google-Smtp-Source: AKy350YpOhenGXBe/s0poJBk6edH+aClaK5RrnBiGJXEZxlCcOkCSie5j9Yrp7SF0bq0/Raa82MiBoALCUKq+c+IHjo=
X-Received: by 2002:a05:6a20:1582:b0:f0:5920:77b1 with SMTP id
 h2-20020a056a20158200b000f0592077b1mr7291900pzj.28.1682077506868; Fri, 21 Apr
 2023 04:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230415104104.5537-1-aford173@gmail.com> <CGME20230415104123eucas1p103250c1748170354509932778b233900@eucas1p1.samsung.com>
 <20230415104104.5537-3-aford173@gmail.com> <28219b3d-e2cc-63b1-555b-c3845300f45a@samsung.com>
In-Reply-To: <28219b3d-e2cc-63b1-555b-c3845300f45a@samsung.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 21 Apr 2023 06:44:55 -0500
Message-ID: <CAHCN7x+EwT44BiBqyOCkt06Z7TFVt-00-S52re2RKsQaLvQuUw@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm: bridge: samsung-dsim: Fetch pll-clock-frequency automatically
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, marex@denx.de,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Apr 21, 2023 at 6:25=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 15.04.2023 12:41, Adam Ford wrote:
> > Fetch the clock rate of "sclk_mipi" (or "pll_clk") instead of
> > having an entry in the device tree for samsung,pll-clock-frequency.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> This one breaks DSI panel operation on my Exynos-based Trats, Trats2 and
> TM2e boards. I've didn't check the details, but probably something is
> missing in the dts to make it working properly. Surprisingly the display
> is still working fine on Arndale board with DSI TC358764 bridge.

Thanks for testing!  I'm going to update this patch in V2 which will
use the device tree settings if they are present.  If they are
missing, they will fetch the clock rate instead of failing.  This way,
it should mitigate breaking your boards, but it will allow the imx8m
mini/nano/plus to eliminate hard-coding some device tree entries since
they can be fetched automatically.

adam
>
> > ---
> >   drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++------
> >   1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/br=
idge/samsung-dsim.c
> > index 9fec32b44e05..73f0c3fbbdf5 100644
> > --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> > +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> > @@ -1744,11 +1744,6 @@ static int samsung_dsim_parse_dt(struct samsung_=
dsim *dsi)
> >       struct device_node *node =3D dev->of_node;
> >       int ret;
> >
> > -     ret =3D samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequen=
cy",
> > -                                    &dsi->pll_clk_rate);
> > -     if (ret < 0)
> > -             return ret;
> > -
> >       ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequ=
ency",
> >                                      &dsi->burst_clk_rate);
> >       if (ret < 0)
> > @@ -1823,13 +1818,18 @@ int samsung_dsim_probe(struct platform_device *=
pdev)
> >               if (IS_ERR(dsi->clks[i])) {
> >                       if (strcmp(clk_names[i], "sclk_mipi") =3D=3D 0) {
> >                               dsi->clks[i] =3D devm_clk_get(dev, OLD_SC=
LK_MIPI_CLK_NAME);
> > -                             if (!IS_ERR(dsi->clks[i]))
> > +                             if (!IS_ERR(dsi->clks[i])) {
> > +                                     dsi->pll_clk_rate =3D clk_get_rat=
e(dsi->clks[i]);
> >                                       continue;
> > +                             }
> >                       }
> >
> >                       dev_info(dev, "failed to get the clock: %s\n", cl=
k_names[i]);
> >                       return PTR_ERR(dsi->clks[i]);
> >               }
> > +
> > +             if (strcmp(clk_names[i], "sclk_mipi") =3D=3D 0)
> > +                     dsi->pll_clk_rate =3D clk_get_rate(dsi->clks[i]);
> >       }
> >
> >       dsi->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
