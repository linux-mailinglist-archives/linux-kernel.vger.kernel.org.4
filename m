Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF2F72635F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbjFGOxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241194AbjFGOx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:53:27 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF3D1FE2;
        Wed,  7 Jun 2023 07:53:23 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6260b578097so57468066d6.3;
        Wed, 07 Jun 2023 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686149602; x=1688741602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BZ3nTd09gXKywNR/B6BfXsK/SAkvfps+yetF3PKLmE=;
        b=g5Noxau3TS0Qg27aaV/uM0E3U96cuuuxg5aX1n2SRdPGgYPmSNfEhKnM8CPqpbdcnr
         YcjPoGaItYSIyhkDVDe7vqJczQXUxK0Y8sADSJDPEnGAMLlR5TNi9pCfPFhR5+FQ61Mx
         y1HxKZ3JR4mZccNqlUjdZ2VFPTpKETv2q9b5d8t8y8N+dRLVUg7KJLXNkx2XP6JHpb+C
         dYRCP5EpZGwRSLtZgoendcgwwi8RxkHkpYJb7CZrNHDGUb5svgWq9vEDaF2xJRjunxR6
         AalbRhmOkr8B0LnPdcfVlk0GJNCjjlQ9nk2GgMVlK/Xe+z8tu8Guhb3pJ6yz/VleyERL
         ixVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686149602; x=1688741602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BZ3nTd09gXKywNR/B6BfXsK/SAkvfps+yetF3PKLmE=;
        b=Gnvrgf3+zToP9ehpC0winhQgAIDtLxkUBf2tT4+7+kUczqcgcs77RcY/kTFMyOSakp
         mZMdKRKvFFa1b2pskFIWhjCWAEjezlVSSRqOoyfybyJqRi5Mncc4/mUPARAuDUBEsqgX
         7MPRYSdgadjX13KKrIBreIlF0benRvj5ZUxmQqhUYwy+8Xlc1z94S5PHhBvNg8/t8tOp
         JKUyfCY1Q9QTWifYfX7pFZEUMUiHf22EWKy/HLE0R/GBt4QiSvBr8VjqQME86mxCiP/i
         /S2Y5u+F8zxZHP9PPnEmiIjPAtPCxUEwZ2Z4tvMR5cQw/FhH1KmyaeytePCzYcGs0XkS
         93XQ==
X-Gm-Message-State: AC+VfDwjAu/Zbig60laRLYj+qIzYl6nF7ySeQkFL9Zw2T+FMrevyUnGb
        vzw1iiEabO10l9GtACWLJr5c0CjA1W+5JMnilEE=
X-Google-Smtp-Source: ACHHUZ7kfUiJiwb3xiTcDZskY9uOa78FYg/TuXDxXkqzTa/XzDsVaQ+2r8uqafTwTNZKrRUyc8awuYHs7dPVKzmn1Fk=
X-Received: by 2002:a05:6214:2266:b0:625:aa48:e625 with SMTP id
 gs6-20020a056214226600b00625aa48e625mr4610415qvb.53.1686149602171; Wed, 07
 Jun 2023 07:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230522163115.2592883-1-eblanc@baylibre.com> <20230522163115.2592883-4-eblanc@baylibre.com>
 <ZG0VHnEByyMW9i4a@surfacebook> <613601c2-cc98-526b-a9e3-2ad2abc68e1d@baylibre.com>
In-Reply-To: <613601c2-cc98-526b-a9e3-2ad2abc68e1d@baylibre.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Jun 2023 17:52:46 +0300
Message-ID: <CAHp75VdTi4y9=XsjjQOBzUhSYf8jzV7mwguruqMZD0jV7VqZkw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] regulator: tps6594-regulator: Add driver for TI
 TPS6594 regulators
To:     jerome Neanne <jneanne@baylibre.com>
Cc:     Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, aseketeli@baylibre.com, u-kumar1@ti.com
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

On Wed, Jun 7, 2023 at 2:44=E2=80=AFPM jerome Neanne <jneanne@baylibre.com>=
 wrote:

...

> >> +    enum {
> >> +            MULTI_BUCK12,
> >> +            MULTI_BUCK123,
> >> +            MULTI_BUCK1234,
> >> +            MULTI_BUCK12_34,
> >
> >> +            MULTI_FIRST =3D MULTI_BUCK12,
> >> +            MULTI_LAST =3D MULTI_BUCK12_34,
> >> +            MULTI_NUM =3D MULTI_LAST - MULTI_FIRST + 1

> >               MULT_NUM
> >
> > will suffice instead of all this.

(1)

> >> +    };
> >
> > But why enum at all? See below.
> Just for the switch case readability.
> I have to iterate across the multiphases array for look up name into
> device tree and evaluate in that order.
>
> This can be reduced to:
>         enum {
>                 MULTI_BUCK12,
>                 MULTI_BUCK123,
>                 MULTI_BUCK1234,
>                 MULTI_BUCK12_34,

>                 MULTI_NUM =3D MULTI_BUCK12_34 - MULTI_BUCK12 + 1

See (1) above.

>         };

...

> >> +                    continue;
> >> +            delta =3D strcmp(npname, multiphases[multi]);
> >> +            if (!delta) {
> >> +                    switch (multi) {
> >> +                    case MULTI_BUCK12:
> >
> > This all looks like match_string() reinvention.
> I can go with match_string but this is not significantly changing the gam=
e:
>
> index =3D match_string(multiphases, ARRAY_SIZE(multiphases), npname);
> if (index >=3D 0) {
>         switch (index) {
>
> No question on all your other feedback. Just wondering if I missed
> something with match_string use. Looks like a good idea indeed but this
> is not drastically changing the code as you seem to expect... Let me
> know if you think I'm doing it in a wrong way.

I guess the entire big for-loop can be optimized, but I haven't looked
at that. At least match_string() would help understanding what you are
trying to do,

In any case it seems Mark applied your version, so the follow ups can be ma=
de.

--=20
With Best Regards,
Andy Shevchenko
