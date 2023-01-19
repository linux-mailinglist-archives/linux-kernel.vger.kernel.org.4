Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669E5674C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjATFhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjATFgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061E46A32B;
        Thu, 19 Jan 2023 21:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77084B82069;
        Thu, 19 Jan 2023 12:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244DBC433A1;
        Thu, 19 Jan 2023 12:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674131914;
        bh=VYU+ZLbsscCnRTpOffTpwW7cmorX4mMTsMM0/YbvjHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XGeV7Z8+d1J/lCrCOg19J+OaEL2oTYhuMHwRhkSIAFAY2wFaLeHOweyWh3CRd1MF8
         0dA9VigNRUwx38diYpUNOVSXMS3dSdMMEsvZhZp6v0PjGFlMN7/SOohOKlNJN87IuK
         goOhoZqvavrRFcwjrYk+aDYO90ARjn+kcCGLdfdkKo7GOVM5Nezs7MpsjH705DlTVT
         Qrmsz1Zh81iH6JOuZeRQzheW79AvVHZjx9YAzfqjBeFcqeMYU8PsXuKzA8ZzEYVNDz
         q0kD4cm7JXhcKqifQ1umRtXqyBOsNIGD/hb7JcedLBbSIdlh2qxQY2Vhd1yGgtnstU
         hW2+JMzmax+MQ==
Received: by mail-oi1-f174.google.com with SMTP id s66so1546580oib.7;
        Thu, 19 Jan 2023 04:38:34 -0800 (PST)
X-Gm-Message-State: AFqh2kqXKQe5SMJul83zZ+iXFvM0hqa8h0BC3SLVefVl7wHI1N4fXDrY
        4Jd5JI9DgJnO/2ezIak6ieBt7kclcO4tKvjO2Tg=
X-Google-Smtp-Source: AMrXdXvAkFeKnGe++M9UmwSC8ZBzWfR+eZuxwnJYUTDXA682kW1EYPVmzK8HAnvopQTClHkMMsH97xcN0bqmCNS2irw=
X-Received: by 2002:a05:6808:1786:b0:35e:7c55:b015 with SMTP id
 bg6-20020a056808178600b0035e7c55b015mr662251oib.287.1674131913358; Thu, 19
 Jan 2023 04:38:33 -0800 (PST)
MIME-Version: 1.0
References: <20230119082250.151485-1-masahiroy@kernel.org> <CACPK8XeGsWN+2L57=dfQWOTSo8df7_qrxhwvV4Ho0rkhV=0vSw@mail.gmail.com>
In-Reply-To: <CACPK8XeGsWN+2L57=dfQWOTSo8df7_qrxhwvV4Ho0rkhV=0vSw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 19 Jan 2023 21:37:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWtDHOs=K+qznt5U1WiDv86tChkj4zOer4wtVRB974OA@mail.gmail.com>
Message-ID: <CAK7LNAQWtDHOs=K+qznt5U1WiDv86tChkj4zOer4wtVRB974OA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove checks for binutils older than 2.25
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-kbuild@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 9:12 PM Joel Stanley <joel@jms.id.au> wrote:
>
> On Thu, 19 Jan 2023 at 08:24, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Commit e4412739472b ("Documentation: raise minimum supported version of
> > binutils to 2.25") allows us to remove the checks for old binutils.
> >
> > There is no more user for ld-ifversion. Remove it as well.
>
> ppc kernels fail to link with 2.27 under some configurations:
>
>  https://github.com/linuxppc/issues/issues/388
>
> We may want to use ld-ifversion to exclude that version.




For LLD, CONFIG option is directly checked.


masahiro@zoe:~/ref/linux(master)$ git grep  CONFIG_LLD_VERSION
Makefile:ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
arch/riscv/Makefile:ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 150000),y)
arch/x86/Makefile:ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
scripts/Kbuild.include:# Usage: $(call test-lt, $(CONFIG_LLD_VERSION), 150000)











> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/powerpc/Makefile     | 22 +---------------------
> >  arch/powerpc/lib/Makefile |  2 +-
> >  scripts/Makefile.compiler |  4 ----
> >  3 files changed, 2 insertions(+), 26 deletions(-)
> >
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index dc4cbf0a5ca9..3d265b16c0ae 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -42,18 +42,13 @@ machine-$(CONFIG_PPC64) += 64
> >  machine-$(CONFIG_CPU_LITTLE_ENDIAN) += le
> >  UTS_MACHINE := $(subst $(space),,$(machine-y))
> >
> > -# XXX This needs to be before we override LD below
> > -ifdef CONFIG_PPC32
> > -KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> > -else
> > -ifeq ($(call ld-ifversion, -ge, 22500, y),y)
> > +ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
> >  # Have the linker provide sfpr if possible.
> >  # There is a corresponding test in arch/powerpc/lib/Makefile
> >  KBUILD_LDFLAGS_MODULE += --save-restore-funcs
> >  else
> >  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> >  endif
> > -endif
> >
> >  ifdef CONFIG_CPU_LITTLE_ENDIAN
> >  KBUILD_CFLAGS  += -mlittle-endian
> > @@ -389,8 +384,6 @@ vdso_prepare: prepare0
> >                 $(build)=arch/powerpc/kernel/vdso include/generated/vdso64-offsets.h)
> >  endif
> >
> > -archprepare: checkbin
> > -
> >  archheaders:
> >         $(Q)$(MAKE) $(build)=arch/powerpc/kernel/syscalls all
> >
> > @@ -405,16 +398,3 @@ else
> >         $(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
> >  endif
> >  endif
> > -
> > -PHONY += checkbin
> > -# Check toolchain versions:
> > -# - gcc-4.6 is the minimum kernel-wide version so nothing required.
> > -checkbin:
> > -       @if test "x${CONFIG_LD_IS_LLD}" != "xy" -a \
> > -               "x$(call ld-ifversion, -le, 22400, y)" = "xy" ; then \
> > -               echo -n '*** binutils 2.24 miscompiles weak symbols ' ; \
> > -               echo 'in some circumstances.' ; \
> > -               echo    '*** binutils 2.23 do not define the TOC symbol ' ; \
> > -               echo -n '*** Please use a different binutils version.' ; \
> > -               false ; \
> > -       fi
> > diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> > index 4de71cbf6e8e..c53618c34b70 100644
> > --- a/arch/powerpc/lib/Makefile
> > +++ b/arch/powerpc/lib/Makefile
> > @@ -42,7 +42,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION)        += error-inject.o
> >  # 64-bit linker creates .sfpr on demand for final link (vmlinux),
> >  # so it is only needed for modules, and only for older linkers which
> >  # do not support --save-restore-funcs
> > -ifeq ($(call ld-ifversion, -lt, 22500, y),y)
> > +ifndef CONFIG_LD_IS_BFD
> >  extra-$(CONFIG_PPC64)  += crtsavres.o
> >  endif
> >
> > diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> > index 3d8adfd34af1..ad07a4efc253 100644
> > --- a/scripts/Makefile.compiler
> > +++ b/scripts/Makefile.compiler
> > @@ -72,7 +72,3 @@ clang-min-version = $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
> >  # ld-option
> >  # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
> >  ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
> > -
> > -# ld-ifversion
> > -# Usage:  $(call ld-ifversion, -ge, 22252, y)
> > -ld-ifversion = $(shell [ $(CONFIG_LD_VERSION)0 $(1) $(2)0 ] && echo $(3) || echo $(4))
> > --
> > 2.34.1
> >



-- 
Best Regards
Masahiro Yamada
