Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F3F74F0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjGKNy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjGKNy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:54:28 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06AE10CB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:54:20 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a04e5baffcso4690245b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689083660; x=1691675660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmBs7dMpOgCcY+Y7gepuTjNdLZ2FF6VMfQg4tdkaSMA=;
        b=FqisUMV94Fso4dE0buXGHlgYAuJ9DeHdEUcuu5i0pZMRfT305sv+T4SNsBNcEwi6VU
         IwAxIkGF851YZDZa/HrIEb9BDKqdNt5UnWR/yrNME2SDNwzwh+pKOwFg1OzcYy/oemag
         AOnTnTfJY22HdNi3ucZaXdJUraPkrozrWThyeafiNWHhgVHsSQzOImWxoOaN8OjF0CGL
         YXR/5ypeUDbo+8gq/EqYbbFQWzYH/mLZUaZp/qsqBNTpbvGfnANFx2LHZ09fgIxt2Vhm
         b57pBE/Qt9BNPPAhhmBaLPkUO8z0dHm7/WUs7ZwsbiLITqzQP7rl6zzUgVeO69p1IV76
         A2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083660; x=1691675660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmBs7dMpOgCcY+Y7gepuTjNdLZ2FF6VMfQg4tdkaSMA=;
        b=UOME5TNLvO9Qg4GcoT1/+kSJELPRKuGgNiF3XNzDkewfOiPE36y5YrxhFuTWXG8H0a
         zmc/KxcpJIptBJqZYLbLET9PTVTgkLgMuWNsYj6Q0GVdC8PuALiI2DtjfBEZz7+ChGVJ
         znGOBcgL2nkvKUZu1bziE5VQUhpczLHVZZPYwRPSPyrBuzhYBNN3QmBcic3xY2pUXuzo
         4VbX+KWnUH+m4lJTxYoezKarjH+vxTZtP5H382rRJgna9dVkcbGKLY3ZreMb1LOuU25e
         sAwnB/gdBXLpLofubWv7iXnzMdOiazE4vwiOrQomvTzwmi7T6094V5EecwlQSEWBXjBR
         SfZQ==
X-Gm-Message-State: ABy/qLbyEK+FoSMCcqiYPZRBd+bAtYMX/NXsS1GCBbBM01POYc/2DXdQ
        B7HpIAUAgXe6UAatX/XA/5FZT0pVn6O7/d1N1VfkgQ==
X-Google-Smtp-Source: APBJJlFmi9UYswIWDnLAqXqYfnTilQgR3H211aP23H1X7Ft5c2mXca80qAldI9m/X/q/veQneAtnZVWA/383V1vIrTI=
X-Received: by 2002:a05:6808:1205:b0:3a2:7f5:c4a with SMTP id
 a5-20020a056808120500b003a207f50c4amr19436320oil.25.1689083660137; Tue, 11
 Jul 2023 06:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-10-ulf.hansson@linaro.org> <CAMuHMdUcmbv7vRKJWACN9dobqKeZuLqjpd8sLgt7FeTBi4uKfA@mail.gmail.com>
In-Reply-To: <CAMuHMdUcmbv7vRKJWACN9dobqKeZuLqjpd8sLgt7FeTBi4uKfA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Jul 2023 15:53:44 +0200
Message-ID: <CAPDyKFrsBV=7CDDiZcAJDRiZsze4fcWq5tCR8zYCRyeTUu5hqA@mail.gmail.com>
Subject: Re: [PATCH 09/18] soc: renesas: Move power-domain drivers to the
 genpd dir
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 at 14:53, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Ulf,
>
> On Fri, Jul 7, 2023 at 4:04=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: <linux-renesas-soc@vger.kernel.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thanks for your patch!
>
> > ---
> >  MAINTAINERS                                   |  1 +
> >  drivers/genpd/Makefile                        |  1 +
> >  drivers/genpd/renesas/Makefile                | 30 +++++++++++++++++++
> >  drivers/{soc =3D> genpd}/renesas/r8a7742-sysc.c |  0
> >  drivers/{soc =3D> genpd}/renesas/r8a7743-sysc.c |  0
> >  drivers/{soc =3D> genpd}/renesas/r8a7745-sysc.c |  0
> >  .../{soc =3D> genpd}/renesas/r8a77470-sysc.c    |  0
> >  .../{soc =3D> genpd}/renesas/r8a774a1-sysc.c    |  0
> >  .../{soc =3D> genpd}/renesas/r8a774b1-sysc.c    |  0
> >  .../{soc =3D> genpd}/renesas/r8a774c0-sysc.c    |  0
> >  .../{soc =3D> genpd}/renesas/r8a774e1-sysc.c    |  0
> >  drivers/{soc =3D> genpd}/renesas/r8a7779-sysc.c |  0
> >  drivers/{soc =3D> genpd}/renesas/r8a7790-sysc.c |  0
> >  drivers/{soc =3D> genpd}/renesas/r8a7791-sysc.c |  0
> >  drivers/{soc =3D> genpd}/renesas/r8a7792-sysc.c |  0
> >  drivers/{soc =3D> genpd}/renesas/r8a7794-sysc.c |  0
> >  drivers/{soc =3D> genpd}/renesas/r8a7795-sysc.c |  0
> >  drivers/{soc =3D> genpd}/renesas/r8a7796-sysc.c |  0
> >  .../{soc =3D> genpd}/renesas/r8a77965-sysc.c    |  0
> >  .../{soc =3D> genpd}/renesas/r8a77970-sysc.c    |  0
> >  .../{soc =3D> genpd}/renesas/r8a77980-sysc.c    |  0
> >  .../{soc =3D> genpd}/renesas/r8a77990-sysc.c    |  0
> >  .../{soc =3D> genpd}/renesas/r8a77995-sysc.c    |  0
> >  .../{soc =3D> genpd}/renesas/r8a779a0-sysc.c    |  0
> >  .../{soc =3D> genpd}/renesas/r8a779f0-sysc.c    |  0
> >  .../{soc =3D> genpd}/renesas/r8a779g0-sysc.c    |  0
> >  .../{soc =3D> genpd}/renesas/rcar-gen4-sysc.c   |  0
> >  .../{soc =3D> genpd}/renesas/rcar-gen4-sysc.h   |  0
> >  drivers/{soc =3D> genpd}/renesas/rcar-sysc.c    |  0
> >  drivers/{soc =3D> genpd}/renesas/rcar-sysc.h    |  0
> >  drivers/{soc =3D> genpd}/renesas/rmobile-sysc.c |  0
> >  drivers/soc/renesas/Makefile                  | 27 -----------------
> >  32 files changed, 32 insertions(+), 27 deletions(-)
>
> LGTM.

Thanks! I defer to your formal ack, before adding your tag.

>
> Is there any specific reason why you're not moving the SYSC_* symbols
> from drivers/soc/renesas/Kconfig to drivers/genpd/renesas/Kconfig?

I was looking into moving the corresponding Kconfig options for all
SoCs/platforms, but I found it being a bit controversial at this
point. One could argue that it looks easier to understand the Kconfig
files, by keeping the SoC specific options together as there are
simply always some kind of dependency that needs to be described too.

Moreover, we currently don't have a menu option for the
CONFIG_GENERIC_PM_DOMAINS. I guess that could be discussed too,
especially if we should want to move the Kconfig files to the genpd
directory.

That said, for now, I suggest we keep the Kconfig files in the soc
directory. Or at least address this separately on top of the $subject
series.

Kind regards
Uffe
