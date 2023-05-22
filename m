Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A0270B9CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjEVKSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjEVKSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:18:45 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC315DB;
        Mon, 22 May 2023 03:18:44 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-75b0df7b225so39524885a.1;
        Mon, 22 May 2023 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684750724; x=1687342724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVzxx737oy6u2gxeyxGx37w11GpVOi1qAeLzN9i/+hI=;
        b=m/nB7XH7qiO2u9HN6szLdHxp/U70Q0TJwDRaVMZwRzkAHAgNbY0KhigzZeTAGfB/jq
         LPkC82qMne//O39/cz7kgin4oFL9ECLBDg9WVfORI1V1kaRLJXPUt92vmPaf9Tqfd+T+
         EL3YAHlIV5Sc+ZsEtoBenTqnwayI6qZhatmFOaUTBGg9fT7XLskj4LqQSXQ9/jBpG6NF
         7EtKkQe/XI4MEMBGGO+ssgGRRRUvrf7tt8RMee6xiLAZ8SFc/FT0KUrIsyuTnXF4Bfk0
         Qw3vIcWwCR0xhgl/XFRGcNCpcMCiZaRUStGSahpK72w1sGdMUMyWfNDjvkl9bIJ8WnuR
         iyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684750724; x=1687342724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVzxx737oy6u2gxeyxGx37w11GpVOi1qAeLzN9i/+hI=;
        b=MuioZzAyGfRyB/Ri7wFLcJFwZrM+b1heIXyN4XAeENt0zty9fWl1U+LWdHiU4y4i6i
         JV+jYhXXoTUC+1SGxJAnNdZ5Ird8WeDbnYzE7eekpUeioVjZp/MqPvMwUUf0emokkLcO
         NbqDJasN4EAAgxB5Nr9LbNbRvuzMAg2yQmOvQ3x1wV8P6mMXdiBF/3P7VP8o/IOX+1MW
         XenY6a447oxcOxN+us+H0vWgvYBDrr3CXFmp9Op8gJuLBdpbeTrEtLW8WgnZ16JXlvKQ
         Q96tVQGpxjd/l8dfM+UuWh+5fOXarkhvr50ynJZr2YW8l6eBoRQxTWv6GD8PKriv9u2l
         wQ0w==
X-Gm-Message-State: AC+VfDzmilRGkRNJ4wwmlFPPXtMMenGDdq1eeEhmEQsNKSzbaUMF4ohu
        evazfaol5jS65LiNzhyGZ8jJzKIch4t9EbbWuLg=
X-Google-Smtp-Source: ACHHUZ5C1OV8N6MBrZF/tIHjUqfOM6LJsG7t4vXZcmQSmDxxwyua7j/BEHzkQdRf3R9ePtPplb9sg6VwQKj4SKW2Pwg=
X-Received: by 2002:a05:620a:47b8:b0:75b:23a0:d9ec with SMTP id
 dt56-20020a05620a47b800b0075b23a0d9ecmr34216qkb.66.1684750723930; Mon, 22 May
 2023 03:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230521225901.388455-1-contact@artur-rojek.eu>
 <20230521225901.388455-2-contact@artur-rojek.eu> <CAHp75VeLRHwcKQALwnBb-gqVeyxxH=_F40TserRXqo_kbaZzoQ@mail.gmail.com>
In-Reply-To: <CAHp75VeLRHwcKQALwnBb-gqVeyxxH=_F40TserRXqo_kbaZzoQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 May 2023 13:18:08 +0300
Message-ID: <CAHp75VedgVOA4qTJFeVuabKXBaB=y4Ss0fLu7a7J9GGgWFPqQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio/adc: ingenic: Fix channel offsets in buffer
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>,
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

On Mon, May 22, 2023 at 1:15=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, May 22, 2023 at 1:59=E2=80=AFAM Artur Rojek <contact@artur-rojek.=
eu> wrote:

...

> > +       u16 tdat[6];
> > +       u32 val;
> > +
> > +       memset(tdat, 0, ARRAY_SIZE(tdat));
>
> Yeah, as LKP tells us this should be sizeof() instead of ARRAY_SIZE().
>
> > +       for (i =3D 0; mask && i < ARRAY_SIZE(tdat); mask >>=3D 2) {
> > +               if (mask & 0x3) {
>
> (for the consistency it has to be GENMASK(), but see below)
>
> First of all, strictly speaking we should use the full mask without
> limiting it to the 0 element in the array (I'm talking about
> active_scan_mask).
>
> That said, we may actually use bit operations here in a better way, i.e.
>
>   unsigned long mask =3D active_scan_mask[0] & (active_scan_mask[0] - 1);
>
>   j =3D 0;
>   for_each_set_bit(i, active_scan_mask, ...) {
>     val =3D readl(...);
>     /* Two channels per sample. Demux active. */
>     tdat[j++] =3D val >> (16 * (i % 2));

Alternatively

     /* Two channels per sample. Demux active. */
     if (i % 2)
       tdat[j++] =3D upper_16_bits(val);
     else
       tdat[j++] =3D lower_16_bits(val);

which may be better to read.

>   }
>
> > +                       val =3D readl(adc->base + JZ_ADC_REG_ADTCH);
> > +                       /* Two channels per sample. Demux active. */
> > +                       if (mask & BIT(0))
> > +                               tdat[i++] =3D val & 0xffff;
> > +                       if (mask & BIT(1))
> > +                               tdat[i++] =3D val >> 16;
> > +               }
> >         }


--=20
With Best Regards,
Andy Shevchenko
