Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2F64CF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiLNS0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbiLNSZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:25:49 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01881220EC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:25:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so662843wrh.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xcDDPBR7PVVq1gsDBQPjFYlUePtxzPfWYMI5nAMWQWM=;
        b=UUYrg/4p80IykoqsYXgQCS28VTR2q2S/KADm55UlrER9OdX92XZSA0/+AdHw3CYgzS
         M5pnPX3NTwZrf22T/MVlciVeCES8bLvFbPmoc07GyhcXkXq73kNINU3tUSdJLlfTM1Os
         euy1fjxVGyu04NptaaIHPNHZ7XtgmbgKJa7RRDo6EbGl2PF6FbIfBM3Et2zUbUo6Op4J
         RY6jI1D8pknvKA+ZCXnhRGF0/fI8wsvp0AgruDPKu7ckhhJTNrA6YnAvp13YwhPbJav+
         WkN1oKT/HaKaIVoFYXyU9gMf9j9zr5ntsLewExCqGyZ77DyWm81lmKsYdO6R2Y+0HxSz
         KtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcDDPBR7PVVq1gsDBQPjFYlUePtxzPfWYMI5nAMWQWM=;
        b=EZNbR+wxrYUM4EYQ/uRsy7XJ8inAChv4lIU4rxzxVe8npIrfmXGfKLz/N12s2G2LJC
         jr8afqE6kIPrzk8HoPUjl1pL4rEYc2bVEGDZKTGKCZNR8xuxpq/+qHlDhIl1/rkzQnTN
         MsMtUlnoh3y8la6RhFkwtvRrXmSlyIhpYKP38SHXmSxIXwznJmviChDMMTUz1xJMpI5f
         1FIP7uCoR4RJ2D/3BNBAfgk8J9nxcMNM68wAclDedNfnWcovvMmgVbWWdwPpXfm3nS/s
         23t1svuGB0i5llmYuHVaA4nrSBOmxqcypKAJiXRx0bAu9eME8DC3zyiZfzheFx749kIM
         xTvQ==
X-Gm-Message-State: AFqh2kqaTIRMLI2HEI3QAgJR/X6f/luuJ8UdZT7ixWAg+aDI+vw+eseZ
        ibhgcPyj26G4RBrTYY2DPKzOXX/8poRE+9CtABnCng==
X-Google-Smtp-Source: AMrXdXugna5UNKFzcPG1mNIEq0Mn1lT298lG6VDfsKgax1yR4ktKk239CdGwPW0+UierGbqeDkFR4TrXUKnMx+WjCRI=
X-Received: by 2002:a05:6000:69b:b0:256:c249:b819 with SMTP id
 bo27-20020a056000069b00b00256c249b819mr2890wrb.654.1671042346124; Wed, 14 Dec
 2022 10:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20221122001125.765003-1-irogers@google.com> <20221122001125.765003-5-irogers@google.com>
 <CAKwvOd=kgXmpfbVa1wiEvwL0tX3gu+dDTGi-HEiRXSojwCLRrg@mail.gmail.com>
In-Reply-To: <CAKwvOd=kgXmpfbVa1wiEvwL0tX3gu+dDTGi-HEiRXSojwCLRrg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Dec 2022 10:25:33 -0800
Message-ID: <CAP-5=fUX2jYgKVrnFLH2MjhUXb_Y1KGdoonkeLE7AcB5gdtaVw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] objtool: Alter how HOSTCC is forced
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 10:26 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Nov 21, 2022 at 4:12 PM Ian Rogers <irogers@google.com> wrote:
> >
> > HOSTCC is always wanted when building objtool. Setting CC to HOSTCC
> > happens after tools/scripts/Makefile.include is included, meaning
> > flags are set assuming say CC is gcc, but then it can be later set to
> > HOSTCC which may be clang. tools/scripts/Makefile.include is needed
> > for host set up and common macros in objtool's Makefile. Rather than
> > override CC to HOSTCC, just pass CC as HOSTCC to Makefile.build, the
> > libsubcmd builds and the linkage step. This means the Makefiles don't
> > see things like CC changing and tool flag determination, and similar,
> > work properly. To avoid mixing CFLAGS from different compilers just
> > the objtool CFLAGS are determined. HOSTCFLAGS is added to these so
> > that command line flags can add to the CFLAGS.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/objtool/Makefile | 27 ++++++++++++++++-----------
> >  1 file changed, 16 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> > index 61a00b7acae9..e550a98e2dd9 100644
> > --- a/tools/objtool/Makefile
> > +++ b/tools/objtool/Makefile
> > @@ -2,16 +2,12 @@
> >  include ../scripts/Makefile.include
> >  include ../scripts/Makefile.arch
> >
> > -# always use the host compiler
> > -AR      = $(HOSTAR)
> > -CC      = $(HOSTCC)
> > -LD      = $(HOSTLD)
> > -
> >  ifeq ($(srctree),)
> >  srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> >  srctree := $(patsubst %/,%,$(dir $(srctree)))
> >  endif
> >
> > +MAKE = make -S
> >  LIBSUBCMD_DIR = $(srctree)/tools/lib/subcmd/
> >  ifneq ($(OUTPUT),)
> >    LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
> > @@ -36,13 +32,20 @@ INCLUDES := -I$(srctree)/tools/include \
> >             -I$(srctree)/tools/objtool/include \
> >             -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
> >             -I$(LIBSUBCMD_OUTPUT)/include
> > -WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
>
> Looking closer at the V=1 diff in meld, I think this is dropping
> EXTRA_WARNINGS.  I think you want to add those back to OBJTOOL_CFLAGS.

Thanks Nick! When I try this it causes new build failures.
Specifically EXTRA_WARNINGS includes things like -Wswitch-enum that
trigger:

```
check.c:1312:10: error: 14 enumeration values not explicitly handled
in switch: 'INSN_JUMP_DYNAMIC',
'INSN_JUMP_DYNAMIC_CONDITIONAL', 'INSN_CALL_DYNAMIC'... [-Werror,-Wswitch-enum]
       switch (insn->type) {
               ^~~~~~~~~~
check.c:2620:11: error: enumeration value 'OP_SRC_CONST' not
explicitly handled in switch [-Werror,-
Wswitch-enum]
               switch (op->src.type) {
                       ^~~~~~~~~~~~
check.c:3447:11: error: 5 enumeration values not explicitly handled in
switch: 'INSN_BUG', 'INSN_NOP
', 'INSN_TRAP'... [-Werror,-Wswitch-enum]
               switch (insn->type) {
                       ^~~~~~~~~~
check.c:3647:11: error: 9 enumeration values not explicitly handled in
switch: 'INSN_CONTEXT_SWITCH'
, 'INSN_BUG', 'INSN_STAC'... [-Werror,-Wswitch-enum]
               switch (insn->type) {
                       ^~~~~~~~~~
check.c:4008:10: error: 9 enumeration values not explicitly handled in
switch: 'INSN_CONTEXT_SWITCH'
, 'INSN_BUG', 'INSN_STAC'... [-Werror,-Wswitch-enum]
       switch (insn->type) {
               ^~~~~~~~~~
check.c:4173:11: error: 15 enumeration values not explicitly handled
in switch: 'INSN_JUMP_CONDITION
AL', 'INSN_JUMP_UNCONDITIONAL', 'INSN_JUMP_DYNAMIC_CONDITIONAL'...
[-Werror,-Wswitch-enum]
               switch (insn->type) {
                       ^~~~~~~~~~
6 errors generated.
```

What should the next step be? Land this or add EXTRA_WARNINGS and fix
all the issues?

Thanks,
Ian

> > -CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
> > -LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
> > +WARNINGS := -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
> > +OBJTOOL_CFLAGS := -Werror $(WARNINGS) -g $(INCLUDES) $(LIBELF_FLAGS) $(HOSTCFLAGS)
> > +OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD)
> >
> >  # Allow old libelf to be used:
> >  elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
> > -CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> > +OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> > +
> > +# Always want host compilation.
> > +HOST_OVERRIDES := CC="$(HOSTCC)" EXTRA_CFLAGS="$(OBJTOOL_CFLAGS)" \
> > +                 LD="$(HOSTLD)" AR="$(HOSTAR)"
> > +BUILD_HOST_OVERRIDES := CC="$(HOSTCC)" CFLAGS="$(OBJTOOL_CFLAGS)" \
> > +                       LD="$(HOSTLD)" LDFLAGS="$(OBJTOOL_LDFLAGS)" \
> > +                       AR="$(HOSTAR)"
> >
> >  AWK = awk
> >  MKDIR = mkdir
> > @@ -65,10 +68,11 @@ include $(srctree)/tools/build/Makefile.include
> >
> >  $(OBJTOOL_IN): fixdep FORCE
> >         $(Q)$(CONFIG_SHELL) ./sync-check.sh
> > -       $(Q)$(MAKE) $(build)=objtool
> > +       $(Q)$(MAKE) $(build)=objtool $(BUILD_HOST_OVERRIDES)
> > +
> >
> >  $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
> > -       $(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
> > +       $(QUIET_LINK)$(HOSTCC) $(OBJTOOL_IN) $(KBUILD_HOSTLDFLAGS) $(OBJTOOL_LDFLAGS) -o $@
> >
> >
> >  $(LIBSUBCMD_OUTPUT):
> > @@ -77,6 +81,7 @@ $(LIBSUBCMD_OUTPUT):
> >  $(LIBSUBCMD): fixdep FORCE $(LIBSUBCMD_OUTPUT)
> >         $(Q)$(MAKE) -C $(LIBSUBCMD_DIR) O=$(LIBSUBCMD_OUTPUT) \
> >                 DESTDIR=$(LIBSUBCMD_DESTDIR) prefix= subdir= \
> > +               $(HOST_OVERRIDES) \
> >                 $@ install_headers
> >
> >  $(LIBSUBCMD)-clean:
> > --
> > 2.38.1.584.g0f3c55d4c2-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
