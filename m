Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97046DAA43
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 10:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbjDGIfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 04:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240006AbjDGIfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 04:35:22 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C434AAD34;
        Fri,  7 Apr 2023 01:35:18 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id u4so7329684qkp.11;
        Fri, 07 Apr 2023 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680856518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+2md01EKsHKSciMrf5z7tCNggOZWfH57xjCKSn/olM=;
        b=A1jPBXmrOolJmsmPCx2F3U+yP0Z09Z+HEDlNMG+rNMQUAUMxMp6cB/HEtH0eJmvsQw
         eUDgLOPfEvo1aCk4gGov1Tly0mBUklxpifDc8qyb4FB/ofCAtCwLCktgkfL2/s8S8f0/
         YCgmWjGPWXndTdBKoDbSw4+sg5kcBY2zWdWpJiFqYgRXyD2MbgsJ3ArKaAm1c85j0yO+
         oqLtmywFlyAGgrNWnzKV5uLTJtKf1ECVvVCYiAr+eHV7dio+eBUui24Ql3ZQd0p0fb/h
         M4WseQNA38l3PteAALEd1X9jyw4mspGaLI88F3/kUCg/QgGBYrghRJCDXUT8V0oFXEEM
         Z6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680856518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+2md01EKsHKSciMrf5z7tCNggOZWfH57xjCKSn/olM=;
        b=qXnMGcA5rqvyZsilSw7RFnoOzaJicZAAOf5+NSQz+b8p9PoPiWAPN1+0u0G2qPt7lb
         /5blMoMSeX6m88uRigc1TRqfNcDHQK3ttpG7aqk+t7lPWo+A+ASXv1l4Pa90iLg521e0
         PXMKffysS2NLSIHwkXFYDHdfYu7zLjXybsmkrJXhss3EI6Ncx8S7vVkeQaHcnbkRJaCf
         Gjjr3Sf7XB1POz8O2ZmITiWpXCEL3tDD85aI2BK8NoW4AWOzdRNzGPn3baHknEcmaYKV
         MN9a2SUstdXVzfWn9LlBL9BqkrAqPsOOn2kTSjFPEBwrsA4PJOLOmqyqUvUPofDjyN2J
         ye7A==
X-Gm-Message-State: AAQBX9eQKVKMtScUrps7eAFI3xrxk7OJUZ8qt4b17fD5KGiGc2WMt6u5
        Fr0WpMnbH+EG1oWUqfyXoboV4a+WBkfC7Xp+UI4=
X-Google-Smtp-Source: AKy350aKRJ4eBlldpwIsuSBKd++F36Q3HKkhF8lrzSBPCUrYeEa8xuaVn3IW7i3R4SaVID7E5ynsnbemA3AI2oYGkyQ=
X-Received: by 2002:a05:620a:1994:b0:74a:5668:da9a with SMTP id
 bm20-20020a05620a199400b0074a5668da9amr259539qkb.14.1680856517829; Fri, 07
 Apr 2023 01:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230405235832.never.487-kees@kernel.org> <20230406000212.3442647-6-keescook@chromium.org>
 <CAHp75Vf-nG865UwbVjwFjVTtXA7mAdi4FfKCpTHDx55eFnbvAA@mail.gmail.com> <642f4e62.170a0220.1f11f.36df@mx.google.com>
In-Reply-To: <642f4e62.170a0220.1f11f.36df@mx.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Apr 2023 11:34:41 +0300
Message-ID: <CAHp75VfyT9A0xAYquSS0AeOemLPZSq9+6H2D-PLaGfGoDa3_9w@mail.gmail.com>
Subject: Re: [PATCH 6/9] fortify: Split reporting and avoid passing string pointer
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Potapenko <glider@google.com>,
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 1:57=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
> On Thu, Apr 06, 2023 at 01:20:52PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 6, 2023 at 3:02=E2=80=AFAM Kees Cook <keescook@chromium.org=
> wrote:

...

> > > +       WARN(1, "%s: detected buffer %s overflow\n", name, write ? "w=
rite" : "read");
> >
> > Using str_read_write() ?
> >
> > Dunno if it's already there or needs to be added. I have some patches
> > to move those str_*() to string_choices.h. We can also prepend yours
> > with those.
>
> Oh! Hah. I totally forgot about str_read_write. :) I will use that.

Btw, makes sense to add

  #define str_write_read(v)    str_read_write(!(v))

to the header, so we won't use negation in the parameter for better readabi=
lity.

--=20
With Best Regards,
Andy Shevchenko
