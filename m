Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEDB73D5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 03:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjFZB6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 21:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZB6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:58:16 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3327F135;
        Sun, 25 Jun 2023 18:58:15 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-38e04d1b2b4so2099186b6e.3;
        Sun, 25 Jun 2023 18:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687744694; x=1690336694;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIi3FkwCk5HG64ANT+PN0JameuFfw1WbglMg15jyrTQ=;
        b=DGmwX3l/5bkd6oo8XKGuxduVBE1isYcG0BSNBXdo60CHGPwIdJI0SK1bob1tVFBi4Q
         WkkwPiTAUIVN2HKL8p/l5mNkEylwL49oZY0MApytICxYKc33dZzEI3lK7E1zP7Wjg/68
         Bu73LM/XkHzSN8PuNYh3o1p9HCzCVYUbho1gqSyDBsjKnI8gm0vGx/Gx8H2cw1EVBcmP
         Ng3S9CqDov70r4jNpfME0G0BzxPJuwat9i2USToRbYjdMn7T0f3KZ/FYq8A/FB7nCJw2
         loAt4Az2UHBl0E97jwJIsoCGnRLkJoYFDjj8IRVrgKZzDGvGsK/F3kB8XakoW1Hhi99q
         X60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687744694; x=1690336694;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sIi3FkwCk5HG64ANT+PN0JameuFfw1WbglMg15jyrTQ=;
        b=kHJxitwii+cE94QdoiIRVMSy+Ar/LxG0CH/kqZ7B54TeXxT8jtlvcUuWi1lndbkk7s
         Bvmv2ylyII1LxVha42UYceN52EXz78qU+2MPgCmZoU3T2oWG3MLLD+Ws0PmjBm+3nZHV
         Ow9ZJ72LvG40ATh/8Cnbc6LIMYTLomO3Zmi6Cs3WVbnRHK9+bLxxH+m0BIw0dqxJ1BFN
         BEwZjq7WenCPXvHeFSUbNeWrOGihFP+vtf3V3OxD7Rr8zcIP5uhtkE9TzH9SH2l8PNp8
         S8sWURW0TVE5wnQtpS6WGibJe7+lrSZv21sehjb6/iTTy2kQE7UHVROh70/+u6+eYPDd
         NjdA==
X-Gm-Message-State: AC+VfDxHbKcj/ai6IR0efTJMAcCEJ2QqAaEO1X72gqWlJoqMzaw7D9Lm
        Wk25WRNCSBcDB/h9P8afPIk=
X-Google-Smtp-Source: ACHHUZ78En8oF4JQ4eCiuIXy53tCVU5GcaiDLfFNv6yo542ZIo9IsB/sdnjGu01B5GIrNjswpTqH2w==
X-Received: by 2002:a05:6808:1981:b0:3a1:cdba:e4e0 with SMTP id bj1-20020a056808198100b003a1cdbae4e0mr3634854oib.50.1687744694384;
        Sun, 25 Jun 2023 18:58:14 -0700 (PDT)
Received: from localhost (193-116-198-102.tpgi.com.au. [193.116.198.102])
        by smtp.gmail.com with ESMTPSA id az12-20020a170902a58c00b001b0034557afsm2992916plb.15.2023.06.25.18.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 18:58:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 26 Jun 2023 11:58:06 +1000
Message-Id: <CTM7K580U3T2.261RJKV58M653@wheely>
To:     "Masahiro Yamada" <masahiroy@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>
Cc:     <linux-kbuild@vger.kernel.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        <linux-kernel@vger.kernel.org>,
        "Nicolas Schier" <nicolas@fjasle.eu>
Subject: Re: [PATCH] powerpc: remove checks for binutils older than 2.25
From:   "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230119082250.151485-1-masahiroy@kernel.org>
 <CACPK8XeGsWN+2L57=dfQWOTSo8df7_qrxhwvV4Ho0rkhV=0vSw@mail.gmail.com>
 <CAK7LNAQWtDHOs=K+qznt5U1WiDv86tChkj4zOer4wtVRB974OA@mail.gmail.com>
 <CAK7LNAS=UCo_o-B0mgsR+SDb0sYwvQo90uag5sJ1UmB+8NqLjQ@mail.gmail.com>
In-Reply-To: <CAK7LNAS=UCo_o-B0mgsR+SDb0sYwvQo90uag5sJ1UmB+8NqLjQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jun 25, 2023 at 6:02 PM AEST, Masahiro Yamada wrote:
> On Thu, Jan 19, 2023 at 9:37=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Thu, Jan 19, 2023 at 9:12 PM Joel Stanley <joel@jms.id.au> wrote:
> > >
> > > On Thu, 19 Jan 2023 at 08:24, Masahiro Yamada <masahiroy@kernel.org> =
wrote:
> > > >
> > > > Commit e4412739472b ("Documentation: raise minimum supported versio=
n of
> > > > binutils to 2.25") allows us to remove the checks for old binutils.
> > > >
> > > > There is no more user for ld-ifversion. Remove it as well.
> > >
> > > ppc kernels fail to link with 2.27 under some configurations:
> > >
> > >  https://github.com/linuxppc/issues/issues/388
> > >
> > > We may want to use ld-ifversion to exclude that version.
> >
> >
>
>
> Ping?
>
>
>
>
> >
> > For LLD, CONFIG option is directly checked.

Yeah, doesn't seem too difficult to add new linker version tests if needed.

> >
> >
> > masahiro@zoe:~/ref/linux(master)$ git grep  CONFIG_LLD_VERSION
> > Makefile:ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
> > arch/riscv/Makefile:ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 150000=
),y)
> > arch/x86/Makefile:ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),=
y)
> > scripts/Kbuild.include:# Usage: $(call test-lt, $(CONFIG_LLD_VERSION), =
150000)
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > > >
> > > >  arch/powerpc/Makefile     | 22 +---------------------
> > > >  arch/powerpc/lib/Makefile |  2 +-
> > > >  scripts/Makefile.compiler |  4 ----
> > > >  3 files changed, 2 insertions(+), 26 deletions(-)
> > > >
> > > > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > > > index dc4cbf0a5ca9..3d265b16c0ae 100644
> > > > --- a/arch/powerpc/Makefile
> > > > +++ b/arch/powerpc/Makefile
> > > > @@ -42,18 +42,13 @@ machine-$(CONFIG_PPC64) +=3D 64
> > > >  machine-$(CONFIG_CPU_LITTLE_ENDIAN) +=3D le
> > > >  UTS_MACHINE :=3D $(subst $(space),,$(machine-y))
> > > >
> > > > -# XXX This needs to be before we override LD below
> > > > -ifdef CONFIG_PPC32
> > > > -KBUILD_LDFLAGS_MODULE +=3D arch/powerpc/lib/crtsavres.o
> > > > -else
> > > > -ifeq ($(call ld-ifversion, -ge, 22500, y),y)
> > > > +ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
> > > >  # Have the linker provide sfpr if possible.
> > > >  # There is a corresponding test in arch/powerpc/lib/Makefile
> > > >  KBUILD_LDFLAGS_MODULE +=3D --save-restore-funcs
> > > >  else
> > > >  KBUILD_LDFLAGS_MODULE +=3D arch/powerpc/lib/crtsavres.o
> > > >  endif
> > > > -endif
> > > >
> > > >  ifdef CONFIG_CPU_LITTLE_ENDIAN
> > > >  KBUILD_CFLAGS  +=3D -mlittle-endian
> > > > @@ -389,8 +384,6 @@ vdso_prepare: prepare0
> > > >                 $(build)=3Darch/powerpc/kernel/vdso include/generat=
ed/vdso64-offsets.h)
> > > >  endif
> > > >
> > > > -archprepare: checkbin
> > > > -
> > > >  archheaders:
> > > >         $(Q)$(MAKE) $(build)=3Darch/powerpc/kernel/syscalls all
> > > >
> > > > @@ -405,16 +398,3 @@ else
> > > >         $(eval KBUILD_CFLAGS +=3D -mstack-protector-guard-offset=3D=
$(shell awk '{if ($$2 =3D=3D "TASK_CANARY") print $$3;}' include/generated/=
asm-offsets.h))
> > > >  endif
> > > >  endif
> > > > -
> > > > -PHONY +=3D checkbin
> > > > -# Check toolchain versions:
> > > > -# - gcc-4.6 is the minimum kernel-wide version so nothing required=
.
> > > > -checkbin:
> > > > -       @if test "x${CONFIG_LD_IS_LLD}" !=3D "xy" -a \
> > > > -               "x$(call ld-ifversion, -le, 22400, y)" =3D "xy" ; t=
hen \
> > > > -               echo -n '*** binutils 2.24 miscompiles weak symbols=
 ' ; \
> > > > -               echo 'in some circumstances.' ; \
> > > > -               echo    '*** binutils 2.23 do not define the TOC sy=
mbol ' ; \
> > > > -               echo -n '*** Please use a different binutils versio=
n.' ; \
> > > > -               false ; \
> > > > -       fi
> > > > diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> > > > index 4de71cbf6e8e..c53618c34b70 100644
> > > > --- a/arch/powerpc/lib/Makefile
> > > > +++ b/arch/powerpc/lib/Makefile
> > > > @@ -42,7 +42,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION)        +=
=3D error-inject.o
> > > >  # 64-bit linker creates .sfpr on demand for final link (vmlinux),
> > > >  # so it is only needed for modules, and only for older linkers whi=
ch
> > > >  # do not support --save-restore-funcs
> > > > -ifeq ($(call ld-ifversion, -lt, 22500, y),y)
> > > > +ifndef CONFIG_LD_IS_BFD
> > > >  extra-$(CONFIG_PPC64)  +=3D crtsavres.o
> > > >  endif

This test got inverted for LLD now AFAIKS?

Does LLVM support --save-restore-funcs and supply .sfpr already I
wonder? We could remove this stuff entirely.

Thanks,
Nick
