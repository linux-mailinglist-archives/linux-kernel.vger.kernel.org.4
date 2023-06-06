Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2059E724640
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbjFFOfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbjFFOfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:35:06 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD810DE;
        Tue,  6 Jun 2023 07:34:59 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-62613b2c8b7so64103256d6.1;
        Tue, 06 Jun 2023 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686062099; x=1688654099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubLsalXSoy/Ya10j4ymkpZHgwVV8ccg0Uc0f0PWrIso=;
        b=DQ4FMvX55hxTjxUqA6lurcdL4gQPjBbU5gNhBtcH5A+gC3g2zP3YEBdnzduPLhsQPv
         kfR0j6vjSv/US5i3jQw970qqRxMujQhC12EodC1oeIXAnWZu31OjO4vpwYlzCtXM/xP2
         Rt0QbRah1lQnu952QHwtPkW1Yi/AaSTbTivbKBFsOHDkrnolCLp7ZuBsEfvMtBR/Cug5
         Q9usEQZoV9xz3lYxkBCj4H2RlWHDWSYdtvau0WOyWOo7u938Xtas9t3QuBuyDOOfV10/
         xMLcioR2KTX4CwuFQBQBq/9At8fg36faSZOQ+QgIZjurlLzUAZd6kGNanT63iCGuQYvW
         TyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686062099; x=1688654099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubLsalXSoy/Ya10j4ymkpZHgwVV8ccg0Uc0f0PWrIso=;
        b=Kr3OxqGkugZhmGwooRoLQOznS7/o58rxpApO247H4DBVh9LSUnmbdIo4Ow4EzvtsOD
         R7f+lraaXU6CG1oePf1UfEQqSit3geic/rvPmAutPCTv3BAigS18nI+vYtKjt8JgBp1F
         aQD7nIf3zMXfhDy+oKgud1n81HRnB33RDLnyi1Ti7EDgYtPUz8XbUGAJpE7mTKevBHO5
         QvMEXVim3jMz2wAvUrJN9oXw8wZS1TYZI5Ag576X2FClaO6x/0yMKTKyBJ1+5F5vbsE7
         pPUKJHbue6jZ4pUlFvm+caa1s0OmwSjrWKEiEjrIqK58DJnKaiP49txk4M48CHs6SulJ
         EMZw==
X-Gm-Message-State: AC+VfDxsY8Un8xyYD7bRtl2O2mQ5n492rFxsatHEwau/riK6VaUdWiwD
        6rh52qz2CTdxncWFbM0rqJ0SZbZL6fZI/wszJKI=
X-Google-Smtp-Source: ACHHUZ58EJc1NimrHm9HFKUT0yEW5424HAkwblu4NVsObmM2kI1uHfYW3uevL77UxjMv7aNkCKK/m62X0P8q3i6Lnnk=
X-Received: by 2002:a05:6214:b62:b0:629:78ae:80e3 with SMTP id
 ey2-20020a0562140b6200b0062978ae80e3mr3064231qvb.24.1686062098766; Tue, 06
 Jun 2023 07:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230523151223.109551-1-herve.codina@bootlin.com>
 <20230523151223.109551-8-herve.codina@bootlin.com> <ZHuFywIrTnEFpX6e@surfacebook>
 <20230606155404.28ada064@bootlin.com>
In-Reply-To: <20230606155404.28ada064@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Jun 2023 17:34:22 +0300
Message-ID: <CAHp75Vd00N8z7kgTb=WTZHJW3XhsKbLfhTTKPjnCvKUSfL+xDQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

On Tue, Jun 6, 2023 at 4:54=E2=80=AFPM Herve Codina <herve.codina@bootlin.c=
om> wrote:
> On Sat, 3 Jun 2023 21:26:19 +0300
> andy.shevchenko@gmail.com wrote:
> > Tue, May 23, 2023 at 05:12:21PM +0200, Herve Codina kirjoitti:

...

> > > +   int max;
> > > +   int min;
> >
> > Wondering if there is already a data type for the ranges (like linear_r=
ange.h,
> > but not sure it's applicable here).
>
> Seems not applicable here.
>  - IIO does not use linear_range or something similar. It just uses simpl=
e int.
>  - ASoC does not use linear_range or something similar. It just uses simp=
le long.
>
> So, I keep the simple int min and max.

Sure.

...

> > > +   return 1; /* The value changed */
> >
> > Perhaps this 1 needs a definition?
>
> Yes but to be coherent, in ASoC code, many places need to be changed too
> in order to use the newly defined value.
> I don't think these modifications should be part of this series.

Yes, we are all for consistency.

...

> > > +   for (i =3D 0; i < iio_aux->num_chans; i++) {
> > > +           iio_aux_chan =3D iio_aux->chans + i;
> > > +
> > > +           ret =3D of_property_read_string_index(np, "io-channel-nam=
es", i,
> > > +                                               &iio_aux_chan->name);
> > > +           if (ret < 0) {
> > > +                   dev_err(iio_aux->dev, "%pOF: failed to read io-ch=
annel-names[%d]\n", np, i);
> > > +                   return ret;
> >
> > Ditto.
> Will be changed in next iteration.
> >
> > > +           }
> >
> > > +           tmp =3D 0;
> > > +           of_property_read_u32_index(np, "snd-control-invert-range"=
, i, &tmp);
> >
> > > +           iio_aux_chan->is_invert_range =3D tmp;
> >
> > You can use this variable directly.
>
> Not sure, is_invert_range is a bool and tmp is a u32.

Ah, I see.

> In previous iteration, I wrote
>   iio_aux_chan->is_invert_range =3D !!tmp;
>
> > > +   }
> >
> > Btw, can you avoid using OF APIs? It's better to have device property/f=
wnode
> > API to be used from day 1.
>
> Hum, this comment was raised in the previous iteration
>   https://lore.kernel.org/linux-kernel/20230501162456.3448c494@jic23-huaw=
ei/
>
> I didn't find any equivalent to of_property_read_u32_index() in the
> device_property_read_*() function family.
> I mean I did find anything available to get a value from an array using a=
n index.

This is done by reading the entire array at once and then parsing as
you wish in the code, device_property_read_u32_array() is for that.

> In the previous iteration it was concluded that keeping OF APIs in this s=
eries
> seemed "reasonable".

Maybe, but consider the above.

--
With Best Regards,
Andy Shevchenko
