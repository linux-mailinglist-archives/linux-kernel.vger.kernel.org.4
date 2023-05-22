Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1452D70BB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjEVLLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjEVLKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:10:33 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F1F2D71;
        Mon, 22 May 2023 04:05:43 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6239ab2b8e0so33822166d6.0;
        Mon, 22 May 2023 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753541; x=1687345541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jF2mM5Pjq08Kjskd7AiSB2LqCAcdNBrNhg6QE9S2wI=;
        b=GW1XPgdgxSTkPK+AhEvJQuaekNtQ+vA4S3OPmaaYP5XAxrlQklgyRupmabedm8vrzf
         qPH2cNYuS26TPsENCE+AS5zssxYPTdEx719cn2UsID2dXYi6OhNr19iARY9XMX7nCPYi
         D8blUvVp2dBJRVu4aAsJoqkn1s823UYYm7Alm0pv5TXdPiE5wyeclqTn0iHKsBfzzwAL
         M+vXauka8F1VqUbybQrE70GsDR//p9mVlOW4A1WjSqb7W+ZcjeI8UMGhsO3bfa7twIsa
         6AgN78l1VSfst58zqTZrN/ZE+EUHC27RNdmwvshookTVA9kAyv79Nrd3037+gpp4xDHF
         68/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753541; x=1687345541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jF2mM5Pjq08Kjskd7AiSB2LqCAcdNBrNhg6QE9S2wI=;
        b=ULGEkhBiTGEZUk4rIfSbjlNumCQUcd1Jnt9ENpfEPDsQT44QPQnLvD7TmxTiv89bPr
         2S5IINOhnzr6rO+jSIj2oFrkCyEQiKkfAzjs5uEikoCM+ChwNbPcyIVU6kSRzbSiyaEG
         WtvXfjqCr1inAk2fJBKEKi1nsMqbmwoFjkZuwrdWI2txqE1TkU3X8HR+HvpnXc20aLEY
         N6163Bbt6wM07SRu+m0+TjR0nDdStT7+3oWF6SRr94W8ZhEtmg1qUQvpUsw9xgfIT8ui
         P1wUJB1/jqqtKs5q8WMiP1VqSONFWv7+bp+6NYI576P0oLs0Cf3u26CIjPq67wIeCbGL
         kp/w==
X-Gm-Message-State: AC+VfDz0BgT8AjC4qf8P4vrEfO7yLi1TlpoHSMklu1h7ZUb3iqTWzzJg
        euVKHmkvrmGQsWMDB3LmaVbjNGNURzYx+w31bV8=
X-Google-Smtp-Source: ACHHUZ7lcmbqe5eSIFzYjgCkogXL3YdKidRnHdMM5oHqoRnMoHSxeGH3LcjQppoHfmMrwNw6ojsOFILaNQwQK0EaoCM=
X-Received: by 2002:a05:6214:62d:b0:621:3b88:7af2 with SMTP id
 a13-20020a056214062d00b006213b887af2mr14852116qvx.52.1684753541472; Mon, 22
 May 2023 04:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230521225901.388455-1-contact@artur-rojek.eu>
 <20230521225901.388455-2-contact@artur-rojek.eu> <CAHp75VeLRHwcKQALwnBb-gqVeyxxH=_F40TserRXqo_kbaZzoQ@mail.gmail.com>
 <CAHp75VedgVOA4qTJFeVuabKXBaB=y4Ss0fLu7a7J9GGgWFPqQg@mail.gmail.com> <2fc0874ce8a802aeb98e553b15e27fb4d4b75a1c.camel@crapouillou.net>
In-Reply-To: <2fc0874ce8a802aeb98e553b15e27fb4d4b75a1c.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 May 2023 14:05:05 +0300
Message-ID: <CAHp75VdjAxAvmYVW4qgV2i91L31=Ctx4nx_eAe9+pqPFEArD3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio/adc: ingenic: Fix channel offsets in buffer
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
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

On Mon, May 22, 2023 at 1:23=E2=80=AFPM Paul Cercueil <paul@crapouillou.net=
> wrote:
> Le lundi 22 mai 2023 =C3=A0 13:18 +0300, Andy Shevchenko a =C3=A9crit :
> > On Mon, May 22, 2023 at 1:15=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, May 22, 2023 at 1:59=E2=80=AFAM Artur Rojek
> > > <contact@artur-rojek.eu> wrote:

...

> > > > +       u16 tdat[6];
> > > > +       u32 val;
> > > > +
> > > > +       memset(tdat, 0, ARRAY_SIZE(tdat));
> > >
> > > Yeah, as LKP tells us this should be sizeof() instead of
> > > ARRAY_SIZE().
> > >
> > > > +       for (i =3D 0; mask && i < ARRAY_SIZE(tdat); mask >>=3D 2) {
> > > > +               if (mask & 0x3) {
> > >
> > > (for the consistency it has to be GENMASK(), but see below)
> > >
> > > First of all, strictly speaking we should use the full mask without
> > > limiting it to the 0 element in the array (I'm talking about
> > > active_scan_mask).
> > >
> > > That said, we may actually use bit operations here in a better way,
> > > i.e.
> > >
> > >   unsigned long mask =3D active_scan_mask[0] & (active_scan_mask[0] -
> > > 1);
> > >
> > >   j =3D 0;
> > >   for_each_set_bit(i, active_scan_mask, ...) {
> > >     val =3D readl(...);
> > >     /* Two channels per sample. Demux active. */
> > >     tdat[j++] =3D val >> (16 * (i % 2));
> >
> > Alternatively
> >
> >      /* Two channels per sample. Demux active. */
> >      if (i % 2)
> >        tdat[j++] =3D upper_16_bits(val);
> >      else
> >        tdat[j++] =3D lower_16_bits(val);
> >
> > which may be better to read.
>
> It's not if/else though. You would check (i % 2) for the upper 16 bits,
> and (i % 1) for the lower 16 bits. Both can be valid at the same time.

Are you sure? Have you looked into the proposed code carefully?

What probably can be done differently is the read part, that can be
called once. But looking at it I'm not sure how it's supposed to work
at all, since the address is always the same. How does the code and
hardware are in sync with the channels?

> > >   }
> > >
> > > > +                       val =3D readl(adc->base +
> > > > JZ_ADC_REG_ADTCH);
> > > > +                       /* Two channels per sample. Demux active.
> > > > */
> > > > +                       if (mask & BIT(0))
> > > > +                               tdat[i++] =3D val & 0xffff;
> > > > +                       if (mask & BIT(1))
> > > > +                               tdat[i++] =3D val >> 16;
> > > > +               }
> > > >         }

--=20
With Best Regards,
Andy Shevchenko
