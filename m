Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEBA70C5B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjEVTFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjEVTFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:05:45 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3B8FE;
        Mon, 22 May 2023 12:05:43 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-75b14216386so69986885a.0;
        Mon, 22 May 2023 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684782342; x=1687374342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POTBWZOQZAjcWtBfJZ4ftbwcZk2UXapAiYcmlMadLrY=;
        b=gS92fGEP+w1mqEn+7HL/jVqprvgpKOR76fH0C/Ipqm/j3oP02DXZLc1x8dKv1CxovF
         McJnFc8OOv4waOmyBZYks/yPSCWYXn868bzuFnpUV/ZQDLxJCmtKR7DBvgmMt6M1GrFy
         2zIOT6XoiLozZfk81tAOE7eSYb0BOb6HBnjkjHFj0yFgQX0ZZSCJmuf+4LLCXG22cS0I
         pxmX/ZhY1jXEGrZVu926u7G2vAgkhXCEAVc9iWEK8W+6aRYL6IiqMDp9PDkW6hNJU2qK
         fEDFiF47P6j/3kc3SbrUozao2CJ5d6Wx2y2LryIYj/BI4yGTLEkd//QYcQibnEKbBAwT
         U4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684782342; x=1687374342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POTBWZOQZAjcWtBfJZ4ftbwcZk2UXapAiYcmlMadLrY=;
        b=KSgY/DnxyOzx8vx4/SiGYSNOrt6FY8H9ryNFBXS9uRLCmTWX9FtnFjsI9gk0Bhikb6
         AczAdyLZmGWPeL5OwjriPjAz/TpqL8ZWcdHGjhUCxktKrOSxxzk1M5SRarM8MjeYqYiQ
         8nZNQyfQH6At7Nd7ZN39zO5wtGHfr09+yPHd67BVE+D9IErMF30KPD3d+jGDKN/1EnPK
         K6qMckYhGs/ylvJFwxAXb4+XbJLVfKjxPZX5F3PesZZypVrD9XgXe2ug8CL/1N/FElpA
         kyz3a3qb5VbMBaky/N9iYdyPn2KGF4OxdPC6mosMXRGPIrwXWtc9a0NVfxeNLDluvIp1
         jGPw==
X-Gm-Message-State: AC+VfDzjhI/b7js25/96ZQ/zppxzpSyeEl1XWkK/eTrBUUeZeYQDPA06
        itMdYHPheRwIoIJ3Uaeku88GGbzts0ohoI/ciMo=
X-Google-Smtp-Source: ACHHUZ5F+N1CSSPVROq5jIjLbu+QGRgvBwFlr0qw96ZPGBELOlkhk3bFYg1MKqBFj60LOGusopN6rLkNhkp9TTTuRhI=
X-Received: by 2002:a05:6214:20a9:b0:5f7:8b31:4522 with SMTP id
 9-20020a05621420a900b005f78b314522mr22788491qvd.5.1684782342108; Mon, 22 May
 2023 12:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230521225901.388455-1-contact@artur-rojek.eu>
 <20230521225901.388455-2-contact@artur-rojek.eu> <CAHp75VeLRHwcKQALwnBb-gqVeyxxH=_F40TserRXqo_kbaZzoQ@mail.gmail.com>
 <CAHp75VedgVOA4qTJFeVuabKXBaB=y4Ss0fLu7a7J9GGgWFPqQg@mail.gmail.com>
 <2fc0874ce8a802aeb98e553b15e27fb4d4b75a1c.camel@crapouillou.net>
 <CAHp75VdjAxAvmYVW4qgV2i91L31=Ctx4nx_eAe9+pqPFEArD3w@mail.gmail.com> <6b88623e44b2a98a2e5d8d6d2453f92eb1b673ae.camel@crapouillou.net>
In-Reply-To: <6b88623e44b2a98a2e5d8d6d2453f92eb1b673ae.camel@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 May 2023 22:05:06 +0300
Message-ID: <CAHp75Vfbqk73K1qnTBHGKOJ6jBkk1vQb_vgesJzNgZKiV+1fMw@mail.gmail.com>
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

On Mon, May 22, 2023 at 2:35=E2=80=AFPM Paul Cercueil <paul@crapouillou.net=
> wrote:
> Le lundi 22 mai 2023 =C3=A0 14:05 +0300, Andy Shevchenko a =C3=A9crit :
> > On Mon, May 22, 2023 at 1:23=E2=80=AFPM Paul Cercueil <paul@crapouillou=
.net>
> > wrote:
> > > Le lundi 22 mai 2023 =C3=A0 13:18 +0300, Andy Shevchenko a =C3=A9crit=
 :
> > > > On Mon, May 22, 2023 at 1:15=E2=80=AFPM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Mon, May 22, 2023 at 1:59=E2=80=AFAM Artur Rojek
> > > > > <contact@artur-rojek.eu> wrote:

...

> > > > > > +       u16 tdat[6];
> > > > > > +       u32 val;
> > > > > > +
> > > > > > +       memset(tdat, 0, ARRAY_SIZE(tdat));
> > > > >
> > > > > Yeah, as LKP tells us this should be sizeof() instead of
> > > > > ARRAY_SIZE().
> > > > >
> > > > > > +       for (i =3D 0; mask && i < ARRAY_SIZE(tdat); mask >>=3D =
2)
> > > > > > {
> > > > > > +               if (mask & 0x3) {
> > > > >
> > > > > (for the consistency it has to be GENMASK(), but see below)
> > > > >
> > > > > First of all, strictly speaking we should use the full mask
> > > > > without
> > > > > limiting it to the 0 element in the array (I'm talking about
> > > > > active_scan_mask).
> > > > >
> > > > > That said, we may actually use bit operations here in a better
> > > > > way,
> > > > > i.e.
> > > > >
> > > > >   unsigned long mask =3D active_scan_mask[0] &
> > > > > (active_scan_mask[0] -
> > > > > 1);
> > > > >
> > > > >   j =3D 0;
> > > > >   for_each_set_bit(i, active_scan_mask, ...) {
> > > > >     val =3D readl(...);
> > > > >     /* Two channels per sample. Demux active. */
> > > > >     tdat[j++] =3D val >> (16 * (i % 2));
> > > >
> > > > Alternatively
> > > >
> > > >      /* Two channels per sample. Demux active. */
> > > >      if (i % 2)
> > > >        tdat[j++] =3D upper_16_bits(val);
> > > >      else
> > > >        tdat[j++] =3D lower_16_bits(val);
> > > >
> > > > which may be better to read.
> > >
> > > It's not if/else though. You would check (i % 2) for the upper 16
> > > bits,
> > > and (i % 1) for the lower 16 bits. Both can be valid at the same
> > > time.

(i can't be two bits at the same time in my proposal)

> > Are you sure? Have you looked into the proposed code carefully?
>
> Yes. I co-wrote the original code, I know what it's supposed to do.

Yes, but I'm talking about my version to which you commented and I
think it is the correct approach with 'else'. The problematic part in
my proposal is FIFO reading.
So, I have tried to come up with the working solution, but it seems
it's too premature optimization here that's not needed and code,
taking into account readability, will become a bit longer.

That said, let's go with your version for now (implying the GENMASK()
and upper/lower_16_bits() macros in use).

> > What probably can be done differently is the read part, that can be
> > called once. But looking at it I'm not sure how it's supposed to work
> > at all, since the address is always the same. How does the code and
> > hardware are in sync with the channels?
>
> It's a FIFO.

A-ha.

> > > > >   }
> > > > >
> > > > > > +                       val =3D readl(adc->base +
> > > > > > JZ_ADC_REG_ADTCH);
> > > > > > +                       /* Two channels per sample. Demux
> > > > > > active.
> > > > > > */
> > > > > > +                       if (mask & BIT(0))
> > > > > > +                               tdat[i++] =3D val & 0xffff;
> > > > > > +                       if (mask & BIT(1))
> > > > > > +                               tdat[i++] =3D val >> 16;
> > > > > > +               }
> > > > > >         }

--
With Best Regards,
Andy Shevchenko
