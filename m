Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1E6DF55A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjDLMfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDLMet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:34:49 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B716591
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:34:37 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id f188so43285115ybb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681302877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YXoQo6py9BlLlLB4luwS0T52CdFK6DSEsc9nX8DvME=;
        b=m6oOMaq7AIpz/zpcB4O7LFlpyQPl17ZHtvQZoBkc3xWvlBktd8Ba6FJGqvuKUIcy1V
         EyefnbJD4EHx3fWLpEyoXTjXuSTlsQP222pfKSbFQFhkMz/iSOSdw2q7Xx+G+T2Dc3l0
         u9mAgIwLAC18tvLHMZzaXATUQqN60W0jjr0BPxu+CudLclmufl8TelDCAyQnYl5oN13N
         WjuH8lo5pv3ZELSjxR+QJRA0mS7rWfHMLI/9UUimPO4jL+NSUm3gfaQbT6jc+QVivkim
         fXsin3wqOPHiyj3fFNJr6/9dUgfjOVyIUWlwKSKHrJRsAEb/yahYst9Yd+hQsQ4xr8yA
         e/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YXoQo6py9BlLlLB4luwS0T52CdFK6DSEsc9nX8DvME=;
        b=ns+nTKyiIaM9pLPcD9Bm2SDHD4R1yPNuvpjatdvRnWK0F+8IPS+BErJLJmH4l72ph0
         BMrQiehofR/UuR/modg1bWP8GToi5kdofNkI34yxZvsMKMkrxH9cMI/+ggOEJgPHE5nN
         npo74YuO29PfLValrDjjZkEP6cUpGSGUK1f5vJC3iY7NePBOVMxihsi9nR6u8KQlUDze
         vAvwzSDqp91Y08U70YpEnR4kuR5Yg4fuCMFnsKAL3DOORVCpBh+T2B7GMqWM2n6F05Ko
         tXMCLXHWHZ9zE7OvaHnn0/udc/iGNvLTsQJG7koRL/H7dmHVOW/y3jEb/nDn1mMlk9db
         Jbfw==
X-Gm-Message-State: AAQBX9e3WbIjKSkhWoCbRoweC+OkoqiWBR4JpxZOnQGEcmJ/e5QBXeow
        v7jeKaA05qgqjCHjddtigpmAaaI2tq3SHgiij3862Q==
X-Google-Smtp-Source: AKy350bgchv0LG5sx6bzIAWgGjZuU7bgT+7Hyw1P0akFhpQeWT7o7YMnyLaVTmDda+Kf4w5Mx7naI30fiNP/V8qR+eU=
X-Received: by 2002:a05:6902:1206:b0:b8f:34a5:25b0 with SMTP id
 s6-20020a056902120600b00b8f34a525b0mr2481198ybu.27.1681302876634; Wed, 12 Apr
 2023 05:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230405235832.never.487-kees@kernel.org> <20230406000212.3442647-3-keescook@chromium.org>
 <CAG_fn=V-3yxPihQdt+OJuOfF6sBuNvQ2OQfYNZak1xbx6viU2w@mail.gmail.com> <642f50b8.170a0220.95ab9.859f@mx.google.com>
In-Reply-To: <642f50b8.170a0220.95ab9.859f@mx.google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 12 Apr 2023 14:34:00 +0200
Message-ID: <CAG_fn=VfHU7-ixnxXN=34nvnNyvfZ2QVgOVWfvj7AxKZR706bQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] string: Add Kunit tests for strcat() family
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <kees@outflux.net>,
        Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <yury.norov@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Sander Vanheule <sander@svanheule.net>,
        Eric Biggers <ebiggers@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Latypov <dlatypov@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 1:07=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Thu, Apr 06, 2023 at 11:11:09AM +0200, Alexander Potapenko wrote:
> > > +static void strncat_test(struct kunit *test)
> > > +{
> > > +       char dest[8];
> > > +
> > > +       /* Destination is terminated. */
> > > +       memset(dest, 0, sizeof(dest));
> > > +       KUNIT_EXPECT_EQ(test, strlen(dest), 0);
> > > +       /* Empty copy of size 0 does nothing. */
> > > +       KUNIT_EXPECT_TRUE(test, strncat(dest, "", 0) =3D=3D dest);
> > > +       KUNIT_EXPECT_STREQ(test, dest, "");
> > > +       /* Empty copy of size 1 does nothing too. */
> > > +       KUNIT_EXPECT_TRUE(test, strncat(dest, "", 1) =3D=3D dest);
> > > +       KUNIT_EXPECT_STREQ(test, dest, "");
> > > +       /* Copy of max 0 characters should do nothing. */
> > > +       KUNIT_EXPECT_TRUE(test, strncat(dest, "asdf", 0) =3D=3D dest)=
;
> > > +       KUNIT_EXPECT_STREQ(test, dest, "");
> > > +
> > > +       /* 4 characters copied in, even if max is 8. */
> > > +       KUNIT_EXPECT_TRUE(test, strncat(dest, "four\000123", 8) =3D=
=3D dest);
> > > +       KUNIT_EXPECT_STREQ(test, dest, "four");
> > > +       KUNIT_EXPECT_EQ(test, dest[5], '\0');
> >
> > Maybe also add a test case for strncat(dest, "four", 4) that checks
> > that the fourth byte of dest is not 0?
>
> I think I don't understand what state you want to test for? The line
> above (STREQ is checking dest is "four". Maybe I should check for
> dest[6] being 0 as well as dest[5]. But if that's not what you mean, I'm
> not sure. Is it something here:

Sorry, not sure why I wrote "strncat" here, I was thinking about
strncpy, which is handled in a different patch.
Please disregard.

> char dest[16];
> memset(dest, 0, sizeof(dest));
> // dest =3D=3D ""
> strncat(dest, "four", 4);
> // dest =3D=3D "four"
> strncat(dest, "four", 4);
> // dest =3D=3D "fourfour"
>
> strncat's "n" is how much to reach from source -- dest will always be
> terminated.
>
> --
> Kees Cook



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
