Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A840634380
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiKVSTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiKVSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:19:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D5A663D8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:19:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x5so21918124wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+NeFEY2WVIgcrUr3NoTkWHcfGCIrIwhotT6Jrtod2Y=;
        b=ZK+M8yPUIZ4sIeWiZIA2M5vb5zFOBeL1KYdHkTuWnUgdYtnHcb166sVL3mkLSj9UHm
         yL3957vuJKQWfUDkretgiX5dPzyz/eiAdJKrI7f74tb99mUF/h9cman0/ZRYG5HoVDTn
         4fD1sJa8dyU82rg2eIKsJm6iWbChauBUm5t6zCG9eMjOJNWqBaIwz6eCxvj/3RN1rZ7e
         eiJJSw0GoIj0llVsXvy1hS79OOT/IlAkHSw+TV1OOnWsEuebAlnyr08xaOzjNuffmj9G
         F5Dh3hVtUUiE/CDIM66r0sWHmFDRfEzOLC0BHo1NqF/lFX7bfC+NzVcORYVg4pNlE3M3
         4+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+NeFEY2WVIgcrUr3NoTkWHcfGCIrIwhotT6Jrtod2Y=;
        b=qPNSKc8otZ6cyIsdxWk6T7eph7bSwZcP40QdfxhaCHj4wH25t4lX0HUxtvfxLijvKR
         +YUXUwPpq/RDfZIGlh6tiOb4WSniXglqB+MO3YcZVfpjTKupIZihJTbi28IngGAdRaty
         KtAWJpuoa9+l+Dx1YMglqD8oz85qsLQRcDcQsIiZew7pEkFVhaW1CK/e9ZXBKEHsl7cQ
         K/w+bXcpnitBLP/8aHSxBJtQARxOlZd9ZVgD2LxlmSn61pzBwhAJH/lSGnScWVOWc+xv
         qJUbweAqdmh6Dyb2w43qaOPxNxcuEcJBnJBT5CMA/5+cG/M3fMpjH+zQSXJodvtwAEoJ
         Um7Q==
X-Gm-Message-State: ANoB5pmyGCtCv7MzOOtOzysDN8x0wENcFSUHSOZxNMTTBymgd22hT2vb
        +YiGte+onDxuuFey0hiscduLmS5K0WLAE64ppjljIw==
X-Google-Smtp-Source: AA0mqf5Buf2m1gXIj5mIbebwZYnYcplPQWRX5FCIOG4mckd9Ybq3GvjfFybXcBY5m2KnEN/ft4mHRso6eZGq7/zNO3M=
X-Received: by 2002:a5d:4acd:0:b0:236:d8f8:b87d with SMTP id
 y13-20020a5d4acd000000b00236d8f8b87dmr7748966wrs.343.1669141167930; Tue, 22
 Nov 2022 10:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20221122001125.765003-1-irogers@google.com> <20221122001125.765003-2-irogers@google.com>
 <Y3xwzWWhfEJb7NW4@bergen.fjasle.eu>
In-Reply-To: <Y3xwzWWhfEJb7NW4@bergen.fjasle.eu>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 22 Nov 2022 10:19:15 -0800
Message-ID: <CAP-5=fXfwSMCXcRXDS_m5LVsf9h2wBeK8mMvbovbh5nGmFLr3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] tools lib subcmd: Add install target
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Stephane Eranian <eranian@google.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Nov 21, 2022 at 10:48 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Mon 21 Nov 2022 16:11:22 GMT, Ian Rogers wrote:
> > This allows libsubcmd to be installed as a dependency.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/subcmd/Makefile | 49 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> > index 8f1a09cdfd17..e96566f8991c 100644
> > --- a/tools/lib/subcmd/Makefile
> > +++ b/tools/lib/subcmd/Makefile
> > @@ -17,6 +17,15 @@ RM =3D rm -f
> >
> >  MAKEFLAGS +=3D --no-print-directory
> >
> > +INSTALL =3D install
> > +
> > +# Use DESTDIR for installing into a different root directory.
> > +# This is useful for building a package. The program will be
> > +# installed in this directory as if it was the root directory.
> > +# Then the build tool can move it later.
> > +DESTDIR ?=3D
> > +DESTDIR_SQ =3D '$(subst ','\'',$(DESTDIR))'
> > +
> >  LIBFILE =3D $(OUTPUT)libsubcmd.a
> >
> >  CFLAGS :=3D -ggdb3 -Wall -Wextra -std=3Dgnu99 -fPIC
> > @@ -48,6 +57,18 @@ CFLAGS +=3D $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
> >
> >  SUBCMD_IN :=3D $(OUTPUT)libsubcmd-in.o
> >
> > +ifeq ($(LP64), 1)
> > +  libdir_relative =3D lib64
> > +else
> > +  libdir_relative =3D lib
> > +endif
> > +
> > +prefix ?=3D
> > +libdir =3D $(prefix)/$(libdir_relative)
> > +
> > +# Shell quotes
> > +libdir_SQ =3D $(subst ','\'',$(libdir))
> > +
> >  all:
> >
> >  export srctree OUTPUT CC LD CFLAGS V
> > @@ -61,6 +82,34 @@ $(SUBCMD_IN): FORCE
> >  $(LIBFILE): $(SUBCMD_IN)
> >       $(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(SUBCMD_IN)
> >
> > +define do_install_mkdir
> > +     if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
> > +             $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
> > +     fi
> > +endef
> > +
> > +define do_install
> > +     if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
> > +             $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
> > +     fi;                                             \
> > +     $(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
> > +endef
> > +
> > +install_lib: $(LIBFILE)
> > +     $(call QUIET_INSTALL, $(LIBFILE)) \
> > +             $(call do_install_mkdir,$(libdir_SQ)); \
> > +             cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
> > +
>
> Sorry for being late.
>
> Is there a specific reason why you do not use 'mkdir -p
> $(DESTDIR)/$(2); cp $(1) $(2)' or 'install $(addprefix -m,$(3)) -D $(1)
> $(2)' for the install rules (cp.  scripts/Makefile.{dtb,mod}inst)?
>
> I think you could get rid of mkdir calls and the ..._SQ handling when
> using one of them.

Thanks for the feedback! Perhaps we can merge this as being consistent
with existing approaches:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/lib/perf/Makefile#n185
and then refactor as you say.

> > +install_headers:
> > +     $(call QUIET_INSTALL, headers) \
>
> Unlikely, but if one of the install commands fails, you probably want
> make to exit with an error.  Might you want to add 'set -e; \' here?

Possibly. Again, I think we should aim for consistency and do this as
a follow up.

Thanks,
Ian

> Kind regards,
> Nicolas
>
>
> > +             $(call do_install,exec-cmd.h,$(prefix)/include/subcmd,644=
); \
> > +             $(call do_install,help.h,$(prefix)/include/subcmd,644); \
> > +             $(call do_install,pager.h,$(prefix)/include/subcmd,644); =
\
> > +             $(call do_install,parse-options.h,$(prefix)/include/subcm=
d,644); \
> > +             $(call do_install,run-command.h,$(prefix)/include/subcmd,=
644);
> > +
> > +install: install_lib install_headers
> > +
> >  clean:
> >       $(call QUIET_CLEAN, libsubcmd) $(RM) $(LIBFILE); \
> >       find $(or $(OUTPUT),.) -name \*.o -or -name \*.o.cmd -or -name \*=
.o.d | xargs $(RM)
> > --
> > 2.38.1.584.g0f3c55d4c2-goog
>
> --
> epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
> =E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
>      -- frykten for herren er opphav til kunnskap --
