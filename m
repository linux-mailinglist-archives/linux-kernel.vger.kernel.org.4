Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800F05F0747
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiI3JM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiI3JM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:12:27 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A563D14AD50;
        Fri, 30 Sep 2022 02:12:24 -0700 (PDT)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 28U9C57w032344;
        Fri, 30 Sep 2022 18:12:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 28U9C57w032344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664529126;
        bh=HA2of/puN6xRLdK9PexIdFYmyloxm9i54QDhPTAM0Uo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GNukAmlmCpqR93YDlJq6hpb/LTJq9jZKlbJxYDtGCUNKmKXH2JQYAmsXgB6pF+8aB
         GywO0ANdXFQBVudMuuDKP0CTtpK/glYVCX1yKZrp7LSi+CfGPGF+ybQGBmjkxGr1I3
         Gcbzbytu0uuG3XohtI+cdy52hTAV9UMHj1QHonkTYz9NAoSpHGEwgtmkR0+QTJu24B
         ClySX4yQ3MvTfSef74HWLnW+Ew5NF/Q5eDUSIpKJ6GIjWMZwxCmYfyGJn459FBRolI
         gD53DN4qQauRcpJ1AlEQPcTc0mZeHkpHbSGK3JQMGl2nY3sUSwpwbuhlySCzMdnW7H
         7O6YT7hVk0qNQ==
X-Nifty-SrcIP: [209.85.161.54]
Received: by mail-oo1-f54.google.com with SMTP id k10-20020a4ad10a000000b004756ab911f8so1824143oor.2;
        Fri, 30 Sep 2022 02:12:06 -0700 (PDT)
X-Gm-Message-State: ACrzQf0JfSZyGIbSmmAsnM0/TPixzKyfJ4RfDWk5K92CW/gn4V4182IW
        ICuRtss1NGKuN8eJKBc5nA7EIPNqJhXgQjq3TnY=
X-Google-Smtp-Source: AMsMyM7P2o/PpH4uAWWWa8HvGCeVVx36H+mnwjxjpLX3pX8Pthy0bgqohZUCu+KDoYAB97WUfM2VpRVLtdoczYTwjyY=
X-Received: by 2002:a05:6830:658b:b0:63b:3501:7167 with SMTP id
 cn11-20020a056830658b00b0063b35017167mr3118609otb.343.1664529124867; Fri, 30
 Sep 2022 02:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
 <20220815013317.26121-1-dmitrii.bundin.a@gmail.com> <CAKwvOdnnSAozX8bQ9HeSw12BV9OjpzyDmXk_BGczjVVQNN+7tQ@mail.gmail.com>
 <CANXV_Xw2wzwDdJkyV1nHPQm2JTt48SLrNc7YwrfcxOwuFA-z3w@mail.gmail.com>
 <CAKwvOdkiq_byi1QeCvSGb2fd+0AJ1k9WNnsHJMeaaQcPRy1Wxg@mail.gmail.com>
 <CAKwvOdkPwbD-c0V-up2Ufzb-Uh7LLyD12X0FKeBa=hn+cSPA9Q@mail.gmail.com>
 <CANXV_XzdTTYc2w7Ur8zY=ijOofg91yfF7RLhedbVH0rmi3c2yA@mail.gmail.com> <CAK7LNATeW+c5+Kxnj9M4N+yNSv+7ot7bLTHzO3Z0Xb_XEW_6Nw@mail.gmail.com>
In-Reply-To: <CAK7LNATeW+c5+Kxnj9M4N+yNSv+7ot7bLTHzO3Z0Xb_XEW_6Nw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 30 Sep 2022 18:11:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNATqfCxwvYMUtoQZkoTk5yqZ_q+HJgcf934ib3NEG91oiw@mail.gmail.com>
Message-ID: <CAK7LNATqfCxwvYMUtoQZkoTk5yqZ_q+HJgcf934ib3NEG91oiw@mail.gmail.com>
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

On Fri, Sep 30, 2022 at 6:06 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Aug 23, 2022 at 7:42 AM Dmitrii Bundin
> <dmitrii.bundin.a@gmail.com> wrote:
> >
> > On Tue, Aug 23, 2022 at 12:36 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > or perhaps that simply needs to be `-g -gsplit-dwarf`?  In which case,
> > > that if/else could just be re-arranged.
> >
> > How about simply assigning DEBUG_CFLAGS   := -g at the very beginning
> > without any conditions? This would provide the default with the
> > possibility of overriding later and -gsplit-dwarf does not necessarily
> > come with -g implicitly.
>
> This was fixed by commit 32ef9e5054ec0321b9336058c58ec749e9c6b0fe,
> which is now in the mainline.
>
>
>
>
> > > Honestly, I really don't think we need to be wrapping every compiler
> > > command line flag under the sun in a kconfig option.
> >
> > This indeed sounds reasonable to me. So the key point here is to not
> > bloat the kconfig with options related to every compiler flag. But I
> > think it still might be useful to provide some option that would
> > include sort of full debug information compilers may produce. With
> > this approach there would be, in fact 3 different levels of debug
> > information supported by Kconfig: reduced, default and full. The full
> > level would increase everything like -g3, and -fdebug-macro for Clang,
> > and probably others.
>
>
> I think that would be much saner than this patch.
>
>
>
> CONFIG_DEBUG_INFO_LEVEL is a direct way to specify the debug level.
>
> CONFIG_DEBUG_MACRO_DEFINITIONS is feature-driven.
>
> Do not mix two different ways.
>
>
>
>
>
>
> CONFIG_DEBUG_INFO_LEVEL is here just because Andrew Morton suggested that.
>
>
> The debug level is compiler-specific. There is no guarantee
> that there is a common range.
>
>
> The debug level range of GCC is 0-3.
> Clang accepts 3, but -g3 has no effect.
> The debug level range of Rustc is 0-2.
>
> See how badly scripts/Makefile.debug looks in linux-next.
>
>
>
>
>
> How should Rustc behave for CONFIG_DEBUG_INFO_LEVEL=3 ?
>
> -Cdebuginfo=3 is a compile error.
>
>   RUSTC L rust/core.o
> error: debug info level needs to be between 0-2 (instead was `3`)
>
>
>
> You cannot directly specify the debug level number given that
> we support multiple compilers with different policy for
> debug level options.
>
>
>
>
>
>
> > > Or add -g1 to CONFIG_DEBUG_INFO_REDUCED.
> >
> > I ran some tests and there was indeed some decrease in size. That
> > combination probably might be useful.
> >
> > Any thoughts?
> >
> > Regards
> > Dmitrii
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada






I proposed to do a ground-work like the following first.
https://patchwork.kernel.org/project/linux-kbuild/patch/20220930085351.2648034-1-masahiroy@kernel.org/



On top of that, it is easier to add CONFIG_DEBUG_INFO_FULL or whatever.


And, -g1 for CONFIG_DEBUG_INFO_REDUCED if you think it is worthwhile.



-- 
Best Regards
Masahiro Yamada
