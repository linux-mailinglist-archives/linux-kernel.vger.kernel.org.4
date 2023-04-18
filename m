Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40736E607F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjDRL5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDRLzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:55:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F3A1BB;
        Tue, 18 Apr 2023 04:54:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5465fc13so1463438b3a.3;
        Tue, 18 Apr 2023 04:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681818843; x=1684410843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ybM2LueDVR0cBkIIQ1FL39u+s5FbROx8QFlROWcH4g=;
        b=V/euTDcOCNRcR8gEUbPoOAY3S22aC8zXFOH46BClwrZw26PXR+8P8uoM6J/+h9C6Mj
         i41QNHvn7lCT9kv/+ujFRq2ozOLoRYGljfQUCOgSapKHW3weumUM70IU9eAJ8oS7Yh/o
         iwWkb9SxlVm39XoFhN7DAxLSJPlVd2tdt6PqjeNwoliw5s9MJKcaO9F/GzSOGZs3zRLh
         ncP7xyDA5DfFu2uTMR0VX609KIr3TS1I+cAevO1nmtMvI+xAbBbT1LxqHwX/qJ9HfQhs
         M8VKw5rxokVPICTf0s3skrfQF6FtP/sxsQSIIYLSa5WXahWOWjVqw+FRTVtfrx39Xjvc
         xzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681818843; x=1684410843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ybM2LueDVR0cBkIIQ1FL39u+s5FbROx8QFlROWcH4g=;
        b=O5T9QYarbqSAiEPfzRDJuXfTj7kLN85p3aEfhRV6DuRPjoK99iX5v7OecrTZpHokdJ
         zO6GEaJaoPUY4bUw73UEubHIIZ4ggQFWtxnFX9MYFII1txYLDXQr9aCbH5VxwQ1VNw7H
         nlBo0yWJDaUxNtN8fXYgvzX7xJH2pJMBY+2hPtgMSlH3n4Zf+an4zb4FAenYk+/wXJd1
         B+RGMRkJ43PxDpnBZ7VDUDuXtD9fyTAKSX8jp/BPjMsRxyXtZ88FdzjeEJ8J35L8ep8r
         A6VacD1PM3QxBmmN7Kqsy8pKWOZxRKyfG5849zG5OxHjU+YDYPrtmabNpxM/U2gR+GfV
         Q7pQ==
X-Gm-Message-State: AAQBX9cqVAvTgY8Q7ZGTAeSr41uDGFowoQk/7kUtW+fV/vBropAoSpTa
        acGaBKw2QTwzWLw5p8UnUGfvE+eyQ9G4HSlOUII=
X-Google-Smtp-Source: AKy350bF5ygQ2Drr2fXy89upLPlo2PHAWydehkh62freMFI+uRkOUg8otiAAZp8fkiyX8dnIL8QSyvNnGyroSpIGJ3M=
X-Received: by 2002:a05:6a00:2d17:b0:63b:7af9:72b8 with SMTP id
 fa23-20020a056a002d1700b0063b7af972b8mr5429939pfb.2.1681818842806; Tue, 18
 Apr 2023 04:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230415104104.5537-1-aford173@gmail.com> <414febc4-aab1-95ec-ac2e-e82a3f881d01@denx.de>
 <CAHCN7xKsvT-TL4xdP=CKDzTJoFq1PGqmFmTohdRF9JaWaxWemw@mail.gmail.com> <5667233.DvuYhMxLoT@steina-w>
In-Reply-To: <5667233.DvuYhMxLoT@steina-w>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 18 Apr 2023 06:53:51 -0500
Message-ID: <CAHCN7xK0Dban7ueB_ASrTOjqWK0++ujOoQ_RZpz=FR2Fktzy0g@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 2:00=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi,
>
> Am Montag, 17. April 2023, 00:31:24 CEST schrieb Adam Ford:
> > On Sun, Apr 16, 2023 at 5:07=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> > > On 4/15/23 12:40, Adam Ford wrote:
> > > > According to Table 13-45 of the i.MX8M Mini Reference Manual, the m=
in
> > > > and max values for M and  the frequency range for the VCO_out
> > > > calculator were incorrect.  This also appears to be the case for th=
e
> > > > imx8mn and imx8mp.
> > > >
> > > > To fix this, make new variables to hold the min and max values of m
> > > > and the minimum value of VCO_out, and update the PMS calculator to
> > > > use these new variables instead of using hard-coded values to keep
> > > > the backwards compatibility with other parts using this driver.
> > >
> > > [...]
> > >
> > > >   static const struct samsung_dsim_driver_data imx8mm_dsi_driver_da=
ta =3D
> > > >   {
> > > >
> > > > @@ -470,6 +485,9 @@ static const struct samsung_dsim_driver_data
> > > > imx8mm_dsi_driver_data =3D {> >
> > > >        */
> > > >
> > > >       .pll_p_offset =3D 14,
> > > >       .reg_values =3D imx8mm_dsim_reg_values,
> > > >
> > > > +     .m_min =3D 64,
> > > > +     .m_max =3D 1023,
> > > > +     .vco_min =3D 1050,
> > >
> > > You might want to call this 'min_freq' since there is a 'max_freq' wh=
ich
> > > seems to indicate what VCO max frequency is.
> > >
> > > Note that the same datasheet contains the following information:
> > > "
> > > MIPI_DPHY_M_PLLPMS field descriptions
> > >
> > > 12=E2=80=934 PMS_M
> > > Specifies the PLL PMS value for the M divider
> > > NOTE: The programmable divider range should be within 25 to 125 to
> > > ensure PLL stability.
> >
> > I was confused by this because this statement is not consistent with
> > the link they reference jumps me to the table where it reads M is
> > between 64 and 1023.
> >
> > > NOTE: The M and P divider values should be considered together to ens=
ure
> > > VCO ouput frequency
> > > (VCO_out) range is between 350 MHz to 750 MHz.
> > > Please refer to the topic DPHY PLL for more information.
> >
> > I was confused by this too, because the NXP documentation reads the
> > 350 - 750MHz that you state, but  "Table 13-45: DPHY PLL Parameters"
> > which immediately follows that sentence  on page 4158 shows VCO_out is
> > between 1050-2100 MHz.
> >
> > I compared the PMS values for a variety of frequencies to those that
> > were set in the downstream NXP code, and the PMS values matched.
> > Maybe someone from NXP can explain the discrepancy.
>
> Also note that, according to Table 13-28 in RM (Rev 2 07/2022) for i.MX8M
> Nano, VCO_out and Fout has a maximum of 1500MHz only. Although the note a=
bove
> mentions a range  of 1050-2100MHz...

I looked up the limits in NXP's downstream kernel [1] , and I believe
these values match the table in the reference manual instead of the
conflicting sentence.  I am guessing this is why the PMS values I get
match those of the NXP downstream kernel.

adam

[1] - https://github.com/nxp-imx/linux-imx/blob/lf-6.1.y/drivers/gpu/drm/im=
x/sec_mipi_pll_1432x.h#L38

>
> Best regards,
> Alexander
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>
