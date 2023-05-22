Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A5270BBAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjEVLYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjEVLXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:23:50 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0783F30DF;
        Mon, 22 May 2023 04:20:18 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-62384e391e3so22973476d6.3;
        Mon, 22 May 2023 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684754367; x=1687346367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i83fQte0kPi44BubtTWNEheRMfnxb2j5LDfuJQhOHp0=;
        b=qFdG49JI+6ZhvL/SM76DpZsKLsV0sl7pKc094y4HAIa5y9qJ8WIgvNjXo0hmYv3rfp
         6Z/VrjHO0f3hoRQgOucTA2PJozbwA822zdQLN0L6IFRwEGiNB3PlzzNnFX0Kub5LuKtp
         GQUCUHHlVeC7SwzZ4c754QxfHPioOq+B4q2l1MK22iNOgQ5994l0NDnG67H9ZLcbKjSr
         zPqCyQh+bbXkL/kpI9s9yGuHt0inSXtgpASxYHSgPlDB3FtRRg3cU0l/gs/yEwK74mvc
         8IQsGLN1mNO/nQs884wWbCKTqmEFx0+1MnDnAQlMVee+NF4/8eShKR3FEtuxUkTGw/l9
         t+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684754367; x=1687346367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i83fQte0kPi44BubtTWNEheRMfnxb2j5LDfuJQhOHp0=;
        b=fXLuFPQI5Q53WITxtl/lxEJBTbdqWdjNn29gat70etwpmm0LNKw3TfpywdfhggMQV3
         aphXfsU/QwguGyXE/jaQ4c2q5Nol4SnsYbnwrGvcdgDBM1iYvxU1WHQmocJhEWv48nev
         Z5JXulussqxe56XDrxNM/bnDNqZZoXoy6MFBCU16EcCbHIqY+pqobu2N3yvGHS8UBqkn
         Hhu7ZzZB9/8jY3YkasKGl9vT4DeOPNMsgMcEmeISIbXQS75Mtodw2CDuGa5oxAgdBjgN
         QcKzCjmmh0v5cv4c+bDNNmVkQb/kCGDHX/jrZ8hTh/p9+5XS8Tua05A026/FmZYD9tZa
         Gf9w==
X-Gm-Message-State: AC+VfDxB1Ls3DwAdo+RTTK1AK9a4EygQhg3ACfAjISpMCmdXZFTgbcwR
        iC+6QFFsouZbkbelDUK1DpShNEtVFlWDMeTVGYI=
X-Google-Smtp-Source: ACHHUZ7At+03MmzdjnVYn32VGSuVFMl+tRrffaBTjQzv7x24hKdLsK3EbrSk4RFF9BVvITYCu4aH1m0Nz1gBBjaudRQ=
X-Received: by 2002:a05:6214:c62:b0:5ef:7e33:c6c9 with SMTP id
 t2-20020a0562140c6200b005ef7e33c6c9mr18954386qvj.38.1684754366919; Mon, 22
 May 2023 04:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230511-tps65219-add-gpio-support-v2-0-60feb64d649a@baylibre.com>
 <20230511-tps65219-add-gpio-support-v2-1-60feb64d649a@baylibre.com>
 <CAMRc=Md-CzrG3QPtnh0OxYaHTAYZ2aUfMKhkAOeRm2Zn30qE0A@mail.gmail.com>
 <ZGiWdQcR6Zq6Aw65@surfacebook> <9fa1a6e8-368a-3e22-aa84-8cad09f72a32@baylibre.com>
In-Reply-To: <9fa1a6e8-368a-3e22-aa84-8cad09f72a32@baylibre.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 May 2023 14:18:50 +0300
Message-ID: <CAHp75Vf0hW6sMXeGSVXRVoW1mxFufWmbJNzt7_10xPj_k5SNkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
To:     jerome Neanne <jneanne@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
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

On Mon, May 22, 2023 at 10:47=E2=80=AFAM jerome Neanne <jneanne@baylibre.co=
m> wrote:
> On 20/05/2023 11:44, andy.shevchenko@gmail.com wrote:
> > Mon, May 15, 2023 at 05:36:46PM +0200, Bartosz Golaszewski kirjoitti:
> >> On Thu, May 11, 2023 at 4:09=E2=80=AFPM Jerome Neanne <jneanne@baylibr=
e.com> wrote:

...

> >>> +       gpio->gpio_chip =3D tps65219_gpio_chip;
> >>
> >> Aren't you getting any warnings here about dropping the 'const' from
> >> the global structure?
> >
> > But this is a copy of the contents and not the simple pointer.

I commented on Bart's question.

> In many other places where this is done, the struct is declared like:
>
> static const struct gpio_chip template_chip =3D {
>
> After internal review, I changed this to:
>
> static const struct gpio_chip tps65219_gpio_chip =3D {
>
> This is because I didn't want to have this "template" that sounds to me
> like "dummy". Maybe I misunderstood and this "template" was used on
> purpose because this const struct is just copied once to initialize
> tps65219_gpio->gpio_chip during probe.
>
> Introducing tps65219_gpio_chip name is maybe confusing with
> tps65219_gpio struct.
>
> I think the const should not be a problem here but the naming I used
> might be misleading. If you have a suggestion of what is a good practice
> to make this piece of code clearer. I'll follow your suggestion (use
> template? more_explicit name like ???).

It's up to Bart.

--=20
With Best Regards,
Andy Shevchenko
