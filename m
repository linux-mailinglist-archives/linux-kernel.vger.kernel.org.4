Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C8C6C2B64
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCUHdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCUHdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:33:11 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF7726A9;
        Tue, 21 Mar 2023 00:33:10 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id n2so16913327qtp.0;
        Tue, 21 Mar 2023 00:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679383989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbvwfX4HdFVcFa9ONSDF5jyL9MuoCdO7UcrZvzzJA0s=;
        b=qe5G4aUH9rC1OF6SnnmwoVmoWoruFcMTUFvk0cF5ismoqM5Bspv4C22Aua25ZEkJrj
         /WQRa+QYBdikD/JxuAsDOXMs2IIfmQw+TZXjt8vZRVqr2bP/BWZOMwbiQ5MFtzS6eAuS
         869utLwajNBfvFYC/lx0lsNb8VntgeU7d5KzQ9R/a/0ybJwbssHE6OsycroBXvARWwZY
         YuaXC0oYZqbTKUvf56OCapHxJ2DTr1mVAkghx+RDSKZFCvg4en0JkYkSgF2142pb8Y6h
         EuIfLl4qIFVJxQdu/s4V252Cv2bHbH6G5UHZUpwPnOVappRXupoMEPI/nEtmzOxZdRzj
         ysFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679383989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbvwfX4HdFVcFa9ONSDF5jyL9MuoCdO7UcrZvzzJA0s=;
        b=V0LxrVUhLG9N/Kn3hyTBFezUpyFI32DqFVgNFYUfAX47C24WVXzT7xcm8I5mpcnA2n
         mibte34QOagdT6pb+tL0A9Ycz9yu9IwT2pMdAUG2s+T2pkjboOmBFDlDwZ/9K/MuIcSG
         zP/3xhkPS56FUpGdFg6oUc3yzOLBb/rKY5p+RSYBx5HTwVvph+BQ/ZSonO4aubsewRky
         OWVezlbXfAvZXUW8a8Rky1azqkf7On3q62DR5yzBTm2oWmkrjj65VaZ25g+21+7J+vtt
         7yhz6ytT9ahx94yjEJO+iZOhPvBIXEdtH9UOL/3AlsRxWCLpqdu2Zj+rhK9DiEZSzYLz
         4sCA==
X-Gm-Message-State: AO0yUKX51+YTDWhwBYDYr6NyUyRZmS2L2qP7OP9Y1Vhp3+sAVJhIYHzp
        4cMYZXldqkw8YE2fXrO1TC/AnQOxz36iWVY1t/c=
X-Google-Smtp-Source: AK7set9ynhqpq7o/wR7ADvwgTLq4BtW5iz8QTCgPqR8XntZv7eGLlKQABZEHV8QtvJkztSq6+4QvEccNDw/Y8LtNdng=
X-Received: by 2002:a05:622a:1996:b0:3e2:efb6:9d9e with SMTP id
 u22-20020a05622a199600b003e2efb69d9emr714164qtc.0.1679383989015; Tue, 21 Mar
 2023 00:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230320163823.886-1-clin@suse.com> <20230320163823.886-2-clin@suse.com>
 <CAHp75VeVbV8iC6J63PgnE=i7EajvrDhFnEUcq0H_fRGfMMh+7g@mail.gmail.com> <ZBk2IksVZ7N6wKeP@linux-8mug>
In-Reply-To: <ZBk2IksVZ7N6wKeP@linux-8mug>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Mar 2023 09:32:32 +0200
Message-ID: <CAHp75VcJ08JL_2X8T6OXEhL0cb2iqYhhVr_jQ4N=4NC_tTU_Tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] pinctrl: s32: use of_device_get_match_data() to
 get device data
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
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

On Tue, Mar 21, 2023 at 6:44=E2=80=AFAM Chester Lin <clin@suse.com> wrote:
> On Mon, Mar 20, 2023 at 06:59:41PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 20, 2023 at 6:39=E2=80=AFPM Chester Lin <clin@suse.com> wro=
te:

...

> > > +       soc_info =3D (struct s32_pinctrl_soc_info *)
> > > +                       of_device_get_match_data(&pdev->dev);
> >
> > Drop the ugly casting, it's not needed.
>
> Actually it's used for suppressing the compiler warning since some member=
s in
> this soc_info need to be filled by pinctrl-s32cc.

Yes, that's one way to solve this.

...

> +       info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +       if (!info)
> +               return -ENOMEM;
> +
> +       memcpy(info, soc_data, sizeof(*info));

Right, but use devm_kmemdup() instead.

--=20
With Best Regards,
Andy Shevchenko
