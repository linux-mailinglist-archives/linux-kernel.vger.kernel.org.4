Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291D370C903
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjEVToL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbjEVToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:44:05 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82729184
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:44:03 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75afeacb5e4so248915985a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684784642; x=1687376642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uf6BP7twGSDBospMz3gLuMbkNpoM+LqAkeRJFnDLhq0=;
        b=gQJUtf2A/Lyy5uzuYYyAlLsDa6/ZLaGjllhjLnGlzVc1QkkFu2bjYdi/WX7fL+SBZC
         SbxEPlkEikvrBwi4oEzm++APe2/OT/uVYlHVqvuPopJ+A6PJLFb3rXxQc3Yxeqr7T2R6
         09Mwfai1py/Rt2lT8FGmGQ9nweN7aWoNPCJ/NX80OpSVwW+SkJ7TQXjfLGn6lsVDh+Li
         Wnnz8hZJGAU91cVXgRtJstc6TTmkq94aSLoWZ0C0+cygNTR+DvsZauaXk5iGlRIeBDyE
         LF7qnwQRHZgXtzUYn8Qt8Um/yTYoj6nKIPyp+lPRATphvp23pZPI3kUNohBi6KKogCdC
         jzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784642; x=1687376642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uf6BP7twGSDBospMz3gLuMbkNpoM+LqAkeRJFnDLhq0=;
        b=lMkIJbnQ+NSdk6+7HijgkD5ga8mzfjam/Q0q6S2hx7e9inoO9dQ44Kp93uWAdQ1YM4
         /WHt0HBfBaqTXKVpmJ3DlLfvOqo8Z+lLDQt+UDDhy1XGdO9fNuv7baLih/vW5ZCskpZ3
         ZP243ak8JY4AVKW5By7cP3zWT9oVv17NScFfJV5d3A+NvjTwKo6x4y7UWDbH3ip8kkqr
         Tj2CyOQsIr5yeXRzmOCOEaBcBj3Z37v7d7vHFMv8HkRdcZb9uoJS/Sgf5tNn7Dmu6oxU
         i3pXQuOQMSdIQ7ypczIS6NuOSDm0s5KHd/8VdxEXUVNbkph7pwdH+/CWN7zQ8Z6KXPgU
         c3hA==
X-Gm-Message-State: AC+VfDz9upbQz+MC7u5ktpizw0oibYUfC3GL7gSc1xUjtGCdm1NByQZp
        ruuhT38A6yaL8Oy0LZ/Ampp/0YPIbaoR0CzMLE6Dkg==
X-Google-Smtp-Source: ACHHUZ6U/PyCxFJ2nf7jWAQFsY72P2kK2tmXLXmy/RS+oTAbPBeALj+1SlbJUhBD48s+dEOfKcxvdMBeHClwU4MeyJw=
X-Received: by 2002:a37:4114:0:b0:75b:23a1:3611 with SMTP id
 o20-20020a374114000000b0075b23a13611mr1926882qka.34.1684784642426; Mon, 22
 May 2023 12:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230407191904.gonna.522-kees@kernel.org> <20230407192717.636137-1-keescook@chromium.org>
 <CAKwvOdk5JjB21FU85Zxubs+LV8bTY-az598V1hvewndAfhohQA@mail.gmail.com>
 <CAKwvOd=yZw_Ju67D52GfUz39MaAFA639hOxR5Jo2dRdp+xciyQ@mail.gmail.com> <202305101223.B940A881@keescook>
In-Reply-To: <202305101223.B940A881@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 May 2023 12:43:51 -0700
Message-ID: <CAKwvOdn9ytF7EVykt3YXk2QzqYjTfWBzwwXm8LpgPpCLkCvH+Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] kunit: tool: Enable CONFIG_FORTIFY_SOURCE under UML
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
        Alexander Lobakin <aleksander.lobakin@intel.com>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 12:24=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Fri, Apr 07, 2023 at 04:42:27PM -0700, Nick Desaulniers wrote:
> > On Fri, Apr 7, 2023 at 4:33=E2=80=AFPM Nick Desaulniers <ndesaulniers@g=
oogle.com> wrote:
> > >
> > > On Fri, Apr 7, 2023 at 12:27=E2=80=AFPM Kees Cook <keescook@chromium.=
org> wrote:
> > > >
> > > > Since commit ba38961a069b ("um: Enable FORTIFY_SOURCE"), it's possi=
ble
> > > > to run the FORTIFY tests under UML. Enable CONFIG_FORTIFY_SOURCE wh=
en
> > > > running with --altests to gain additional coverage, and by default =
under
> > >
> > > two L's in alltest?
> >
> > Also, while testing this series:
> > ```
> > $ LLVM=3D1 ./tools/testing/kunit/kunit.py run
> > ...
> > [16:40:09] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D forti=
fy (24 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [16:40:09] [PASSED] known_sizes_test
> > [16:40:09] [PASSED] control_flow_split_test
> > [16:40:09] [PASSED] alloc_size_kmalloc_const_test
> > [16:40:09]     # alloc_size_kmalloc_dynamic_test: EXPECTATION FAILED
> > at lib/fortify_kunit.c:249
> > [16:40:09]     Expected __builtin_dynamic_object_size(p, 1) =3D=3D expe=
cted, but
> > [16:40:09]         __builtin_dynamic_object_size(p, 1) =3D=3D -1
> > (0xffffffffffffffff)
> > [16:40:09]         expected =3D=3D 11 (0xb)
> > [16:40:09] __alloc_size() not working with __bdos on kmemdup("hello
> > there", len, gfp)
>
> I'm still tracking this down. I'm not sure what's happening here, but it
> seems to be Clang-specific, and due to some interaction with the changes
> I made for Kunit examination. WHY it happens I haven't found yet.

Was this what exposed https://github.com/llvm/llvm-project/issues/62789?

--=20
Thanks,
~Nick Desaulniers
