Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA56AFCFE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCHCqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCHCqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:46:38 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65404617C;
        Tue,  7 Mar 2023 18:46:36 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j11so40781504edq.4;
        Tue, 07 Mar 2023 18:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678243595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrKMiwGYeVx1STAfxRYkJBqPZfFoqtzB1W9N4+PknWc=;
        b=NywrVP/0Lx73MjbKGOcCV1MT5EUgqxwK3D+U9hPTdWfVPUmv/DrF39ocdb0BKdYY05
         y+HJuEhSfvLSoPE761mXyXSU9dHpFvVVbMdb6MNnbrxyRdnGKagWTbP6Zvew6CsJZdQU
         AqAQDia5yNhbyvl1rrB62puySOAWBt2oyG4moNlV1jT0S7FAeTMgvQc+wSuJkAItJN2y
         j8MsbA0mT0Epv61gRpuyWIapgj6N+ehBA14lVThzhZf4dHV8w6kEPT5rvCa1Qp/ehl2D
         KptjFgO/CPYf8EUPHYj1hTnKaiYgxvQ+j2I0bZG3JGPpGHuAKJ+UT3L/xhwZEsu8y9nt
         utCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678243595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrKMiwGYeVx1STAfxRYkJBqPZfFoqtzB1W9N4+PknWc=;
        b=Bb22urqu2twdVrqrScXcsjnMm6JRHaeskBapDCjurw5Suzrw+LJIicEXjF83rTSuDc
         E/PZSmgUKra0G89130EmjI4JJfxf7TX2fk3ycSEXQsT5KN56uqxRq7BGTqk989xcSGRo
         bs+5NC8II3V9UbuW/isqJf3V8eUGtHN4YW+Zj4N4aQ//1f/hvgRFHpVmgNXfG1nnRwtH
         f25jbLd/mOZoxp5DH9GCUKUlFZfF/VcLZT0G3BkPVP4g2er7hui8aSI8SEj3YVaUs6sR
         lo07IxvzMjQSlz7l1SN4hQQUGB2378FH3Rdt/mBM49UPUpB3PDGbmhLb3Vjsj5CkJfs9
         FpOA==
X-Gm-Message-State: AO0yUKU3y+oDhGU+f7xa2+npbqaQCrOxR0KLSBkZuylhhFc2SNl2Ch5X
        c6gHfoazW5KAGE7dVzqaJl2sBskjtoA1dpYHi5RhbwYjU4NP+A==
X-Google-Smtp-Source: AK7set9aFJDvx+U0Z7Cj5PrVkC8DU9/0MT+LP7J1ksieiqbJxabr8nWd5xbsIEKQlqhz+YGs0xMRfS6oVwr0nKVoPV8=
X-Received: by 2002:a17:906:498e:b0:901:e556:6e23 with SMTP id
 p14-20020a170906498e00b00901e5566e23mr8310102eju.0.1678243595008; Tue, 07 Mar
 2023 18:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
 <20230302125215.214014-2-keguang.zhang@gmail.com> <CAMRc=Me=Yrr5BuRaMd4r91URzmdYHWUvVGvLL9YFuZPaV0WYFA@mail.gmail.com>
 <CAJhJPsVf8EvFc9N8eMtc8Qu2BhODv7PzZm9C5ePR+GdTFiAY1w@mail.gmail.com> <CACRpkda_y1Hz69XyDjcDPd=gEi_n2PChJOgKsonXcvYyxQzg4w@mail.gmail.com>
In-Reply-To: <CACRpkda_y1Hz69XyDjcDPd=gEi_n2PChJOgKsonXcvYyxQzg4w@mail.gmail.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Wed, 8 Mar 2023 10:46:18 +0800
Message-ID: <CAJhJPsXLs6OqHEUrCwoybDP4MiKE1D050Dj2auZ4fdQ-Rb+BWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: loongson1: Convert to SPDX identifier
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 9:31=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Tue, Mar 7, 2023 at 3:25 AM Keguang Zhang <keguang.zhang@gmail.com> wr=
ote:
> > On Mon, Mar 6, 2023 at 5:29=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > > On Thu, Mar 2, 2023 at 1:52=E2=80=AFPM Keguang Zhang <keguang.zhang@g=
mail.com> wrote:
> > > >
> > > > Use SPDX-License-Identifier instead of the license text and
> > > > update the author information.
> > > >
> > > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
>
> > > Why are you removing credits of the old author?
>
> > Kelvin Cheung and Keguang Zhang are the same person.
> > This change is to keep pace with the related entry of MAINTAINERS.
>
> That's a pretty interesting change!
>
> Is Kelvin Cheung the "westernized" name and Keguang Zhang the
> closer to the real name, such as pinyin form? That would make
> a lot of sense.
>
Exactly.
Kelvin Cheung is easy to pronounce, but has no direct relationship
with my real name.
Keguang Zhang, the Pinyin form of my real name, is the official name.
That is why I'd like to make this change.

> I think some authors even use the native characters these days,
> as git and all tools and terminals should support Unicode now.
> It might make it hard for us to answer mails (not knowing which
> characters to refer to as given name) but I kind of like it when I
> see it.
>
Yes, I did see the names written in native characters.
But it's even harder for western people to identify.
Maybe the real name with native characters + "westernized" name is better.

> Yours,
> Linus Walleij



--=20
Best regards,

Kelvin Cheung
