Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB907055F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjEPS0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjEPS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:26:50 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159FC26A6;
        Tue, 16 May 2023 11:26:33 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-61a4e03ccbcso131492636d6.2;
        Tue, 16 May 2023 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684261592; x=1686853592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT7bRc6l1S4ETcunRnTQsfP8igcUrEhlREYerWSYnMQ=;
        b=JaJpFjBtqzh7mm5lKcPTRIbCESb4BPIsS/PP57sfGECO2YccYPFO4c5FsndOUvKq4G
         /cSgwd5+2luHlnzMlYn99pG7y0uQ5Wyje8p5QCcB28FDPoT0Rc9r57Rib8PB/85HC7S1
         g9aO8mhkOMa/o9EDqYpypVnew0Ar89Mrj+DiB2Xc++ne+btuUb/42/QRUY8e/BMZjPMH
         ADj4EmF6o4sHNszbwlMV2846tGXYK+BpG0j1ibDsjt87y80V+6R/hRw60Wq0NHcbkTeN
         EHWZS99zms4cy1UOxRVIHM3jKVfotXjvSFbUTGQQtf+EpNHL0DUk2WZww514kBBuxq/d
         lkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684261592; x=1686853592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pT7bRc6l1S4ETcunRnTQsfP8igcUrEhlREYerWSYnMQ=;
        b=RoA8qlSzRW1CBuqakB6cqLOaUhRoqo2XS8vEkuHfs/41vV/TKw6NPlCGl175GFMnID
         Rk0UUyhRe2zx83R0vsDzqFzJfHe018vw+W4VBsIEUY3lOYe/rLN0eLQaHilFUqoZxfrI
         kJ6Epje89XJMAIoEquJGS+5nmKaVL1dxkymoyeoOhLFLqdAZk4NwIht1FtyzZFNUar8u
         HW706CGYvKi8aVnJ4Ymn20BQzFehi+NkZX9A4kbUh4b12oHpYF2Bcpq1DyYYuhHKRgi4
         KSKqyWydFAHeK4jYZmhzkQXOHqL54enw5wfknVmEv5UUWQ0fXeHq1MgpU7dJbIzhuSvP
         2xRQ==
X-Gm-Message-State: AC+VfDyGzZ1/o9AMQxLX3TK3xX6xrhkfNF87RU0QkdcIjD8nribmC7oW
        PG5jygRJln8QvQT8nMK2uLyHwGF60grbXe75QJ691eGOEIU=
X-Google-Smtp-Source: ACHHUZ6jvFtkoCDhLk+JkgjprYlHwRw3+tEt+Qw3GiGZuZ81RvvrH642xUpeaTzofVK4jrZ1bJc8MYqjVEzdnuXkpY8=
X-Received: by 2002:a05:6214:d0a:b0:61b:5afc:d4be with SMTP id
 10-20020a0562140d0a00b0061b5afcd4bemr65647512qvh.7.1684261592057; Tue, 16 May
 2023 11:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230515174321.494714-1-afd@ti.com> <ZGJ7POc8Qm9pE_WZ@surfacebook>
 <44a19ea6-a7e3-51bb-6631-b7514ef88219@ti.com>
In-Reply-To: <44a19ea6-a7e3-51bb-6631-b7514ef88219@ti.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 May 2023 21:25:56 +0300
Message-ID: <CAHp75Vc_GgfxFpxNZVJZSG+2nqyVnNz7vu8UeYabXc0Hjg-4vw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: pisosr: Use devm_gpiochip_add_data() to simplify
 remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, May 16, 2023 at 6:24=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
> On 5/15/23 1:34 PM, andy.shevchenko@gmail.com wrote:

...

> >> +static void pisosr_mutex_destroy(void *data)
> >> +{
> >> +    struct mutex *lock =3D data;
> >> +
> >> +    mutex_destroy(lock);
> >> +}
> >
> > No need to cast void * explicitly.
> >
>
> No need sure, but I really think it looks cleaner to be
> explicit with the types here.

The parameter is void * and since it's a simplest wrapper on another
function there is no value to have a clear type. It brings nothing in
my opinion.

> If you feel strongly I
> can change it though.

I would go with less LoCs.

> > static void pisosr_mutex_destroy(void *lock)
> > {
> >       mutex_destroy(lock);
> > }

--=20
With Best Regards,
Andy Shevchenko
