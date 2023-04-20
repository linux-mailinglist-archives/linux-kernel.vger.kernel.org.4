Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F56E9C56
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjDTTPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDTTPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:15:14 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA59C26B2;
        Thu, 20 Apr 2023 12:15:12 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-51b5490c6f0so1261715a12.0;
        Thu, 20 Apr 2023 12:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682018112; x=1684610112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB42OP/0chsseE66LQ/QUwQPHdlFt1RecluHsLuAJY4=;
        b=PkfTz/PmrkjzTlyyAkJGB3k8eVlOC59C1SVPbdq6Edf6RyUTVqNYNlMvpRVkFgFDrv
         kch/3YnkgSp/yFqqSvhjw4/cyHFxsplXn9Ejlp6TV19kGl3/u6+m5181gAh57LAgvPqG
         zPGEtmrM3C0y0S5R2AEC31TfEFnRKGqmoe/zb34OPWQ09nIDUGoCNiNxnDstgDRSAtVl
         vrOmezSnSQV6wZq6Q0MMmoKn8M/a21t6uUaQp4WKMrVohxugniTDoERgncztowWyX0I+
         iDrmLrTd/R2snVC2C+deJLxzSWCLs+TTb/8hwTVdhTd5ZhmmwEODUk1Xzc2jvc/jEvC1
         E/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682018112; x=1684610112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB42OP/0chsseE66LQ/QUwQPHdlFt1RecluHsLuAJY4=;
        b=kS808qgzrIHD8Y/xhcDlzNZWe/9JU7CMXexDNXWIGJIDU+q+TSdXO8R7oFgZ7rtLZF
         MHTfYug430NwJcmhywgOIUUtCZy7EsrJGSDXnIvc/wEBiIGP2s1ttJ9FVfTlMtPbpT2g
         cGGqH2fTk5OKpkOQthzff4/2yn/RiECzHuD6uKKcQfFcKK5itIoax/N+o4LfXLNz11Br
         sEJXsQXbJwkBAkt81hR4v+X9RfjbdBwPnb/7LpZUrfrdSDxopoKWJ7Akq6Nsnwub3lgi
         Pt+qqZcueWgfy5CnU7u8lJu2pZVcpWVlYkgbkjJ0jsbO2uE2+DDhIPDq+WRgoc3ZEgnB
         MHMQ==
X-Gm-Message-State: AAQBX9cV8ATqskpxyorGnNKSGZxQ0/7sEqOdEFNJ9ur80R52VLmMjxoR
        4VR9hKT7dTJ0dVe+kycX+a5BQXG7pHJHa4s2hMQ=
X-Google-Smtp-Source: AKy350YVTmd97fwntq23PuJ/Ty5yPWRWuBjTNLojg7FftZa0smSn5bHtfBllr8HEG9WbWSpf91gSn4y34LDBr9UYvf4=
X-Received: by 2002:a17:90a:4dc5:b0:247:90d8:41fd with SMTP id
 r5-20020a17090a4dc500b0024790d841fdmr2650658pjl.26.1682018111804; Thu, 20 Apr
 2023 12:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230415104104.5537-1-aford173@gmail.com> <414febc4-aab1-95ec-ac2e-e82a3f881d01@denx.de>
 <CAHCN7xKsvT-TL4xdP=CKDzTJoFq1PGqmFmTohdRF9JaWaxWemw@mail.gmail.com>
 <5667233.DvuYhMxLoT@steina-w> <CAHCN7xK0Dban7ueB_ASrTOjqWK0++ujOoQ_RZpz=FR2Fktzy0g@mail.gmail.com>
In-Reply-To: <CAHCN7xK0Dban7ueB_ASrTOjqWK0++ujOoQ_RZpz=FR2Fktzy0g@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 20 Apr 2023 14:15:00 -0500
Message-ID: <CAHCN7xJx46zSOt5KLvJCo3NomFmjEzcirTnB9YdLWdR0aqOWew@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm: bridge: samsung-dsim: Fix PMS Calculator on imx8m[mnp]
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        m.szyprowski@samsung.com, Robert Foss <rfoss@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
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

On Tue, Apr 18, 2023 at 6:53=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Mon, Apr 17, 2023 at 2:00=E2=80=AFAM Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:
> >
> > Hi,
> >
> > Am Montag, 17. April 2023, 00:31:24 CEST schrieb Adam Ford:
> > > On Sun, Apr 16, 2023 at 5:07=E2=80=AFPM Marek Vasut <marex@denx.de> w=
rote:
> > > > On 4/15/23 12:40, Adam Ford wrote:
> > > > > According to Table 13-45 of the i.MX8M Mini Reference Manual, the=
 min
> > > > > and max values for M and  the frequency range for the VCO_out
> > > > > calculator were incorrect.  This also appears to be the case for =
the
> > > > > imx8mn and imx8mp.
> > > > >
> > > > > To fix this, make new variables to hold the min and max values of=
 m
> > > > > and the minimum value of VCO_out, and update the PMS calculator t=
o
> > > > > use these new variables instead of using hard-coded values to kee=
p
> > > > > the backwards compatibility with other parts using this driver.
> > > >
> > > > [...]
> > > >
> > > > >   static const struct samsung_dsim_driver_data imx8mm_dsi_driver_=
data =3D
> > > > >   {
> > > > >
> > > > > @@ -470,6 +485,9 @@ static const struct samsung_dsim_driver_data
> > > > > imx8mm_dsi_driver_data =3D {> >
> > > > >        */
> > > > >
> > > > >       .pll_p_offset =3D 14,
> > > > >       .reg_values =3D imx8mm_dsim_reg_values,
> > > > >
> > > > > +     .m_min =3D 64,
> > > > > +     .m_max =3D 1023,
> > > > > +     .vco_min =3D 1050,
> > > >
> > > > You might want to call this 'min_freq' since there is a 'max_freq' =
which
> > > > seems to indicate what VCO max frequency is.
> > > >
> > > > Note that the same datasheet contains the following information:
> > > > "
> > > > MIPI_DPHY_M_PLLPMS field descriptions
> > > >
> > > > 12=E2=80=934 PMS_M
> > > > Specifies the PLL PMS value for the M divider
> > > > NOTE: The programmable divider range should be within 25 to 125 to
> > > > ensure PLL stability.
> > >
> > > I was confused by this because this statement is not consistent with
> > > the link they reference jumps me to the table where it reads M is
> > > between 64 and 1023.
> > >
> > > > NOTE: The M and P divider values should be considered together to e=
nsure
> > > > VCO ouput frequency
> > > > (VCO_out) range is between 350 MHz to 750 MHz.
> > > > Please refer to the topic DPHY PLL for more information.
> > >
> > > I was confused by this too, because the NXP documentation reads the
> > > 350 - 750MHz that you state, but  "Table 13-45: DPHY PLL Parameters"
> > > which immediately follows that sentence  on page 4158 shows VCO_out i=
s
> > > between 1050-2100 MHz.

I reached out to my NXP rep asking if the VCO_out is 350-750 or if it
should be 1050-2100, and received the following statement:

" Yes it is definitely wrong, the one that is part of the NOTE in
MIPI_DPHY_M_PLLPMS register table against PMS_P, PMS_M and PMS_S is
not correct. I will report this to Doc team, the one customer should
be take into account is the Table 13-40 DPHY PLL Parameters and the
Note above."

Table 13-40 (for the Nano) reads the VCO_out is 1050-2100, despite
other text stating 350-750MHz, so I believe this patch is appropriate.
I'll add the above statement to the commit message as confirmation
when I submit a V2 of this series.

adam
> > >
> > > I compared the PMS values for a variety of frequencies to those that
> > > were set in the downstream NXP code, and the PMS values matched.
> > > Maybe someone from NXP can explain the discrepancy.
> >
> > Also note that, according to Table 13-28 in RM (Rev 2 07/2022) for i.MX=
8M
> > Nano, VCO_out and Fout has a maximum of 1500MHz only. Although the note=
 above
> > mentions a range  of 1050-2100MHz...
>
> I looked up the limits in NXP's downstream kernel [1] , and I believe
> these values match the table in the reference manual instead of the
> conflicting sentence.  I am guessing this is why the PMS values I get
> match those of the NXP downstream kernel.
>
> adam
>
> [1] - https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/drivers/gpu/drm/=
imx/sec_mipi_pll_1432x.h#L38
>
> >
> > Best regards,
> > Alexander
> > --
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > http://www.tq-group.com/
> >
> >
