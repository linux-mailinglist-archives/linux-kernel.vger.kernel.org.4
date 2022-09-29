Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1C75EFF03
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiI2VHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiI2VHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:07:48 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A7D1B8C82;
        Thu, 29 Sep 2022 14:07:46 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28TL7NGT003772;
        Fri, 30 Sep 2022 06:07:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28TL7NGT003772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664485644;
        bh=iLVh07jKsWnF/nynGPwOpn80jqLcwNey7UtDaG17CHs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=izohTiN6tnHamGY3bka2pIwi9VZh9wJsLgD342C98radP3sA9XzYQmfWRxfAWjQ0K
         KuHSa3XqK/awQQkGl11tuR0JsU9V/iiWiL401B1U5tlWPrElfwWJNWm1ju9alYO7kT
         MChlb7gX5k0RkLkA8RLbVT1kUiZtllwetNvSY5YG5UTRcpHPPol5Z3boTf015kn8aO
         dWHx+c+c4hmRT1NFO/B+8+cg1ntK5eUFgLiK2zJnmaGEcXmupYpaEEru3S/Mu5El64
         zgW+NAujF+BBkEsTdFx2PEmgJxQGHB+4f8ZACdIeth4nSrziUZ56bSBuLYOf9SsH7A
         REzIXfM9jmgbQ==
X-Nifty-SrcIP: [209.85.160.45]
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-131b7bb5077so3303675fac.2;
        Thu, 29 Sep 2022 14:07:24 -0700 (PDT)
X-Gm-Message-State: ACrzQf2CXNFBkb/83Xo5lqNatOaLRDBsa3c/KrHQVUbS5x0NSAo1Qotk
        54cw7husbNTqgeCsisyEVIpm+/qJZbz44ew2Rrg=
X-Google-Smtp-Source: AMsMyM4fem0edsXmUM889roku0P2y8yY3ZF1UrAPxL8lHPaqJ5cdkmOCnxKrnr52z6c1NhIQmiLfFBiTFbVcCQStdvg=
X-Received: by 2002:a05:6870:6326:b0:131:9200:c99d with SMTP id
 s38-20020a056870632600b001319200c99dmr8103058oao.194.1664485643280; Thu, 29
 Sep 2022 14:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
 <20220815013317.26121-1-dmitrii.bundin.a@gmail.com> <CAKwvOdnnSAozX8bQ9HeSw12BV9OjpzyDmXk_BGczjVVQNN+7tQ@mail.gmail.com>
 <CANXV_Xw2wzwDdJkyV1nHPQm2JTt48SLrNc7YwrfcxOwuFA-z3w@mail.gmail.com>
 <CAKwvOdkiq_byi1QeCvSGb2fd+0AJ1k9WNnsHJMeaaQcPRy1Wxg@mail.gmail.com>
 <CAKwvOdkPwbD-c0V-up2Ufzb-Uh7LLyD12X0FKeBa=hn+cSPA9Q@mail.gmail.com> <CANXV_XzdTTYc2w7Ur8zY=ijOofg91yfF7RLhedbVH0rmi3c2yA@mail.gmail.com>
In-Reply-To: <CANXV_XzdTTYc2w7Ur8zY=ijOofg91yfF7RLhedbVH0rmi3c2yA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 30 Sep 2022 06:06:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNATeW+c5+Kxnj9M4N+yNSv+7ot7bLTHzO3Z0Xb_XEW_6Nw@mail.gmail.com>
Message-ID: <CAK7LNATeW+c5+Kxnj9M4N+yNSv+7ot7bLTHzO3Z0Xb_XEW_6Nw@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: add debug level and macro defs options
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 7:42 AM Dmitrii Bundin
<dmitrii.bundin.a@gmail.com> wrote:
>
> On Tue, Aug 23, 2022 at 12:36 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > or perhaps that simply needs to be `-g -gsplit-dwarf`?  In which case,
> > that if/else could just be re-arranged.
>
> How about simply assigning DEBUG_CFLAGS   := -g at the very beginning
> without any conditions? This would provide the default with the
> possibility of overriding later and -gsplit-dwarf does not necessarily
> come with -g implicitly.

This was fixed by commit 32ef9e5054ec0321b9336058c58ec749e9c6b0fe,
which is now in the mainline.




> > Honestly, I really don't think we need to be wrapping every compiler
> > command line flag under the sun in a kconfig option.
>
> This indeed sounds reasonable to me. So the key point here is to not
> bloat the kconfig with options related to every compiler flag. But I
> think it still might be useful to provide some option that would
> include sort of full debug information compilers may produce. With
> this approach there would be, in fact 3 different levels of debug
> information supported by Kconfig: reduced, default and full. The full
> level would increase everything like -g3, and -fdebug-macro for Clang,
> and probably others.


I think that would be much saner than this patch.



CONFIG_DEBUG_INFO_LEVEL is a direct way to specify the debug level.

CONFIG_DEBUG_MACRO_DEFINITIONS is feature-driven.

Do not mix two different ways.






CONFIG_DEBUG_INFO_LEVEL is here just because Andrew Morton suggested that.


The debug level is compiler-specific. There is no guarantee
that there is a common range.


The debug level range of GCC is 0-3.
Clang accepts 3, but -g3 has no effect.
The debug level range of Rustc is 0-2.

See how badly scripts/Makefile.debug looks in linux-next.





How should Rustc behave for CONFIG_DEBUG_INFO_LEVEL=3 ?

-Cdebuginfo=3 is a compile error.

  RUSTC L rust/core.o
error: debug info level needs to be between 0-2 (instead was `3`)



You cannot directly specify the debug level number given that
we support multiple compilers with different policy for
debug level options.






> > Or add -g1 to CONFIG_DEBUG_INFO_REDUCED.
>
> I ran some tests and there was indeed some decrease in size. That
> combination probably might be useful.
>
> Any thoughts?
>
> Regards
> Dmitrii





-- 
Best Regards
Masahiro Yamada
