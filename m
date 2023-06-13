Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF5972E908
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbjFMRIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjFMRIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:08:46 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE7D187;
        Tue, 13 Jun 2023 10:08:45 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-62de508705dso9507116d6.1;
        Tue, 13 Jun 2023 10:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686676124; x=1689268124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEOxPjyq7cbAhN04VkJQjCBC+cXkSTNShgxgFc1N+zA=;
        b=A7iJAOhzjDARsMdLXql0k2OXLHNTpaLZtqbaTeS51zwUgfBoKoHEAdgUwftZtXPkrr
         yoch6gF7JjAlWDOjG9dCbPyLz8wl0KVf9c+xRea0NqOAttdciVtvu9j6oDNptpSoLsj9
         Zy2SsuRT8B3s9C49maijvvGSEb+p2wwuiM3MOY4xvubIKWPb7NMQiueXnt/hLkbjK0Qb
         3LtbtFYpKySGZMPmCO9Y9boRNazVRe3Uc/G0fFHOUGSADUajXULr45dvsJlbVNfhFBg9
         p8NL/UmHMg3bEGWslK4cFSxYbVrEFwIk7cpDgWfblmckcgIaWKaQUoTTNxaMLSZLEVhL
         2Abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686676124; x=1689268124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEOxPjyq7cbAhN04VkJQjCBC+cXkSTNShgxgFc1N+zA=;
        b=lyqlni2rvUohdkJB9n4KzzyagmodFprDp1YSRawrsyYfbllXLDfwKpqG6N5itiN0oq
         2B92kMLfzahdIHkygFE5jAjdp/klqOXES00/6sYDHHZ+BSvyPXfWMXcLjvTUZue6ZEOc
         CndOoFdgu02lbd93G75USlPwS665ZNPR8QU8mHN8ZUQ8RTwQHJj0IBSZdGyagkqnmUqr
         y3ZD7EMQm3wPmGJdCQB4RnEhYa0Hcf3rfy1pCY84dC+l9qT9UdSiDYXJMyJRCeUt7DGr
         A8tmCPEr+01vZkc1bjbfN65nzvcLmuDvRWvadhfe3RuNrmZNZnsTwsjfbuuMQTixZ9v5
         f4Hg==
X-Gm-Message-State: AC+VfDy9+CibQtYeLv1QfTKKHe7qiPL20pXyPIeHMLdYQUfX3NDDwVzK
        iOLkGaww3Wd+MpWAfMpvMYARvQeyy1QGV9aCwZA=
X-Google-Smtp-Source: ACHHUZ6IVHYtr6EhQ8zxzJ7cZgPX29yPpTxMs+tJlNote6SRNod+g3s8Q+j1rgTEV1/Gp9V+uz2mkZmDpuA7/u9qgnM=
X-Received: by 2002:a05:6214:2468:b0:626:1e6b:4785 with SMTP id
 im8-20020a056214246800b006261e6b4785mr15074240qvb.6.1686676124471; Tue, 13
 Jun 2023 10:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230612122926.107333-1-herve.codina@bootlin.com>
 <20230612122926.107333-7-herve.codina@bootlin.com> <CAHp75Vf2dmAS9VD-pgyZwVopVCFy8yFjhPWEj8sym=pfE7uxSA@mail.gmail.com>
 <20230613100000.6bd9e690@bootlin.com>
In-Reply-To: <20230613100000.6bd9e690@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Jun 2023 20:08:08 +0300
Message-ID: <CAHp75Vcr5Owjn0HK-+D0mpPJAkAxG7F8bEO=sqvhT8w=_xnF7w@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] minmax: Introduce {min,max}_array()
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

On Tue, Jun 13, 2023 at 11:00=E2=80=AFAM Herve Codina <herve.codina@bootlin=
.com> wrote:
> On Mon, 12 Jun 2023 17:10:40 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jun 12, 2023 at 3:30=E2=80=AFPM Herve Codina <herve.codina@boot=
lin.com> wrote:
> > >
> > > Introduce min_array() (resp max_array()) in order to get the
> > > minimal (resp maximum) of values present in an array.
> >
> > Some comments below, after addressing them,
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

...

> > > +       typeof(array) __array =3D (array);                        \
> >
> > We have __must_be_array()
>
> Using __must_be_array() will lead to some failure.
> Indeed, we can have:
>   --- 8< ---
>   int *buff
>   ...
>   min =3D min_array(buff, nb_item);
>   --- 8< ---
>
> In this case, __must_be_array() will report that buff is not an array.

Oh, I missed that.

> To avoid any confusion, what do you think if I renamed {min,max}_array()
> to {min,max}_buffer() and replace __array by __buff and use *(__buff + xx=
x)
> instead of array[xxx] in the macro.

But functionally it's still against an array.

I would stick with "array" in the name, but add a comment why
__must_be_array() is not used. If we need a stricter variant, we may
add a new wrapper with that check. That said, I think we can use
__array[0] and similar indexed accesses.


--
With Best Regards,
Andy Shevchenko
