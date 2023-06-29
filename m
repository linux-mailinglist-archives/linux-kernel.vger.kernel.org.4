Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D447423F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjF2KZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjF2KZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:25:15 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6310F;
        Thu, 29 Jun 2023 03:25:11 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-791b8525b59so182898241.1;
        Thu, 29 Jun 2023 03:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688034310; x=1690626310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTm2R4f4h1+O6uYNvyiVwVy5iGd6ob1BEHbPRTu4rPo=;
        b=l3g5YpQ0rLrUEY8s0rBG5pT3FfHXqj9VwbA1SdTuIcrg+6GogfpONRcw/Lao3QagZN
         SX7xeY2qvk0LIDrvCqUgD6RUI/MkC5zhze31nT3zOyRZpMeF7nUIlFE5AAp2LvaVdL0w
         b4bbSjrvnQZtfqNDUPqYSc7Ajo8FzehuE9c74ZZ9yXdRc5QOX3N4oE28ygWgPeiLAC6K
         lnuhJUHN+pltMK9bMSSI0O3pBm0id8vvlIv1Dz4cC29x2dFFc45cgdU4Y/4Wovt7bU97
         NZqT5qB+7jGUtJwZ9FIs/im831ZqmsN0LBM65mI1x4H6IXnoDqLZ8AMt0PeDa/3GMgyD
         5fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688034310; x=1690626310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTm2R4f4h1+O6uYNvyiVwVy5iGd6ob1BEHbPRTu4rPo=;
        b=XLSEzSwbE3QSJu7NqIeKKlBJ//S9duEjbo+YCpOAuZA14PKJ/epAd+PSh5+fI20YDw
         B7mA7MILUUFDLskWF64aaR9592z1FMlrHn4sGSZnvO1oelGWuIEzc1WoWrPSQ7Zbsu2L
         yuFA+eXFg2zZilKz1sjfNar/B9t0AVMG/hPE+hSG1XmCBlH98U45na33sHGQn0y04ZtE
         7noc/Pf+uKSb5DJGD/OC1V15ST7yR2k+qHdpna/oug0U0ALTngOpq9zeUn219tvuwcmm
         CSX/VPO7eWRLioqjiktY75EJqwG93mKQDSro08SZ8ZcCUhDoB6cmow/TU5oHtRtbXXmh
         mJPw==
X-Gm-Message-State: AC+VfDzXbfYWck45XJXhuyrpQUVtnLWF/FjHbN8XFzjLXTGe0HPmexAI
        uYxXi+/9K1hx16UIVuaXbbfezFW/ddlvslAkbto=
X-Google-Smtp-Source: ACHHUZ5HXwtUzxCv8pjT4UbZRbgTzNUPzvUalS2nVUrC0UeyvkhAUzFwydIbtNOaHZoxeVoGhaAiWDjJ4EeNCv0Yvgs=
X-Received: by 2002:a67:f906:0:b0:443:5af5:8128 with SMTP id
 t6-20020a67f906000000b004435af58128mr7388178vsq.0.1688034310265; Thu, 29 Jun
 2023 03:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230621100151.6329-1-victorshihgli@gmail.com>
 <20230621100151.6329-2-victorshihgli@gmail.com> <CAPDyKFq5YzwAGGKi_4=MVrQad9kM-i0xoQ5XhijDNuWDPOVFFA@mail.gmail.com>
In-Reply-To: <CAPDyKFq5YzwAGGKi_4=MVrQad9kM-i0xoQ5XhijDNuWDPOVFFA@mail.gmail.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Thu, 29 Jun 2023 18:24:58 +0800
Message-ID: <CAK00qKAVyOxz9nJMphJ+atbgsR7Bd_KG6fe4+zudmsKcTm=YLQ@mail.gmail.com>
Subject: Re: [PATCH V8 01/23] mmc: core: Cleanup printing of speed mode at
 card insertion
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ulf

On Wed, Jun 21, 2023 at 9:44=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 21 Jun 2023 at 12:02, Victor Shih <victorshihgli@gmail.com> wrote=
:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Please do not claim authorship of patches that haven't been authored
> by you. Of course, there is a balance, if you need to make bigger
> modifications, then you deserve to claim the authorship, but that
> isn't the case here I think.
>
> This applies to a couple of more patches in the series, I will not
> comment on them in this regard, but leave that to you to look over at
> the next submission.
>

I have confirmed this issue in several other patches in this series,
and I will fix it in the next version of the patch.

> >
> > The current print of the bus speed mode in mmc_add_card() has grown ove=
r
> > the years and is now difficult to parse. Let's clean up the code and al=
so
> > take the opportunity to properly announce "DDR" for eMMCs as
> > "high speed DDR", which is according to the eMMC spec.
> >
> > Updates in V8:
> >  - Modify commit message.
> >
> > Updates in V7:
> >  - Remove unnecessary parentheses.
> >
> > Updates in V6:
> >  - Adjust the position of matching brackets.
>
> I appreciate the version history per patch. However, this doesn't
> belong in the commit message.
>
> Instead you have to manually edit each formatted patch to add this,
> exactly where see below.
>
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
>
> After this line you can add comments and version history for the
> patch. In this way, it will not be a part of the commit message when
> applying.
>
> Complete the section by adding three new dashes and a newline - this
> keeps the patch format correct.
>
> ---
>

I will implement this in the next version of the patch.

> >  drivers/mmc/core/bus.c | 36 ++++++++++++++++++++----------------
> >  1 file changed, 20 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> > index 2c3074a605fc..cf32cf135781 100644
> > --- a/drivers/mmc/core/bus.c
> > +++ b/drivers/mmc/core/bus.c
> > @@ -299,6 +299,7 @@ int mmc_add_card(struct mmc_card *card)
> >  {
> >         int ret;
> >         const char *type;
> > +       const char *speed_mode =3D "";
> >         const char *uhs_bus_speed_mode =3D "";
> >         static const char *const uhs_speeds[] =3D {
> >                 [UHS_SDR12_BUS_SPEED] =3D "SDR12 ",
> > @@ -337,27 +338,30 @@ int mmc_add_card(struct mmc_card *card)
> >                 break;
> >         }
> >
> > +       if (mmc_card_hs(card))
> > +               speed_mode =3D "high speed ";
> > +       else if (mmc_card_uhs(card))
> > +               speed_mode =3D "ultra high speed ";
> > +       else if (mmc_card_ddr52(card))
> > +               speed_mode =3D "high speed DDR ";
> > +       else if (mmc_card_hs200(card))
> > +               speed_mode =3D "HS200 ";
> > +       else if (mmc_card_hs400es(card))
> > +               speed_mode =3D "HS400 Enhanced strobe ";
> > +       else if (mmc_card_hs400(card))
> > +               speed_mode =3D "HS400 ";
> > +
> >         if (mmc_card_uhs(card) &&
> >                 (card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
> >                 uhs_bus_speed_mode =3D uhs_speeds[card->sd_bus_speed];
> >
> > -       if (mmc_host_is_spi(card->host)) {
> > -               pr_info("%s: new %s%s%s card on SPI\n",
> > -                       mmc_hostname(card->host),
> > -                       mmc_card_hs(card) ? "high speed " : "",
> > -                       mmc_card_ddr52(card) ? "DDR " : "",
> > -                       type);
> > -       } else {
> > -               pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
> > -                       mmc_hostname(card->host),
> > -                       mmc_card_uhs(card) ? "ultra high speed " :
> > -                       (mmc_card_hs(card) ? "high speed " : ""),
> > -                       mmc_card_hs400(card) ? "HS400 " :
> > -                       (mmc_card_hs200(card) ? "HS200 " : ""),
> > -                       mmc_card_hs400es(card) ? "Enhanced strobe " : "=
",
> > -                       mmc_card_ddr52(card) ? "DDR " : "",
> > +       if (mmc_host_is_spi(card->host))
> > +               pr_info("%s: new %s%s card on SPI\n",
> > +                       mmc_hostname(card->host), speed_mode, type);
> > +       else
> > +               pr_info("%s: new %s%s%s card at address %04x\n",
> > +                       mmc_hostname(card->host), speed_mode,
> >                         uhs_bus_speed_mode, type, card->rca);
> > -       }
> >
> >         mmc_add_card_debugfs(card);
> >         card->dev.of_node =3D mmc_of_find_child_device(card->host, 0);
> > --
> > 2.25.1
> >

Thanks, Victor Shih
