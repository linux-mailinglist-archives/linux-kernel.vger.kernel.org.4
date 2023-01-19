Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C87673800
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjASMMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjASMM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:12:28 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD7C474E3;
        Thu, 19 Jan 2023 04:12:27 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id tz11so5252196ejc.0;
        Thu, 19 Jan 2023 04:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qGf+yAWhycXycQ2Yp6dQqCBU9N9hm20/EcONeRGAQM4=;
        b=Qzda+1FKoXwkc+DVexBSLmX3kpJyS4pGgoxta9rF6HUvlniX9CFQ0NujiyQqHenlwD
         VWgQzZ4lKzu7DrGLeRPZouPjFt/LNwc3bjWWVXWOJvbFqCT0R4oIuHGbQoMPt7H/hkpc
         oX88ALAxyi6NQwb9XIy+b195Dkq5Ny4ytnFnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGf+yAWhycXycQ2Yp6dQqCBU9N9hm20/EcONeRGAQM4=;
        b=alQ+5lirwFJjx/0/X6rwn2mGRXBcm4zLj6PB4L7HDVEIQhQ2D3R7M5HLnHu463sr/l
         JsZicLi65XbyvcwEOI3NVVNhvvQP+4MqeNgmABDmVxyeYoN0zgR1m1Jghbo3tGpydRu/
         fajJiY/TepimOwUYyK1BRlcODno9D5uOiRpsAA01K6o/B/ohCNrYoYzx4cvtCPM7DyuM
         Mq2BGQIW/SzKk6KaqKjHePf+1PtfCpJChcyQ70oI0+d5lAR1LbAm/gR/uElJtG8H7tAM
         wehI7l7b0t/ITWsjIoF5DW8tDaUPXoByBIJzCO6hDPgNBJabpGNXfnx0+ghyvzCXq+xv
         m4nw==
X-Gm-Message-State: AFqh2koCjJCfiV215IK8VZCtqiCJnL+zqMdxm65+wZz33FI9/Cygk2Qt
        OhV4beFBk+KtNJoawfQMBqrJyN/V9vu4nrPDeZVCEMZQ7hE=
X-Google-Smtp-Source: AMrXdXuaaRjSRIZeHJmKIB51qInDkVHFrYZOAFXeUDCJnfTGjJl17j/VxbyTUaODPU5dae5QOWV0oF7MXmTGWBK2s6Q=
X-Received: by 2002:a17:906:8e18:b0:877:696c:e42c with SMTP id
 rx24-20020a1709068e1800b00877696ce42cmr249026ejc.651.1674130345698; Thu, 19
 Jan 2023 04:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20230119082250.151485-1-masahiroy@kernel.org>
In-Reply-To: <20230119082250.151485-1-masahiroy@kernel.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 19 Jan 2023 12:12:13 +0000
Message-ID: <CACPK8XeGsWN+2L57=dfQWOTSo8df7_qrxhwvV4Ho0rkhV=0vSw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove checks for binutils older than 2.25
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 at 08:24, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit e4412739472b ("Documentation: raise minimum supported version of
> binutils to 2.25") allows us to remove the checks for old binutils.
>
> There is no more user for ld-ifversion. Remove it as well.

ppc kernels fail to link with 2.27 under some configurations:

 https://github.com/linuxppc/issues/issues/388

We may want to use ld-ifversion to exclude that version.

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/powerpc/Makefile     | 22 +---------------------
>  arch/powerpc/lib/Makefile |  2 +-
>  scripts/Makefile.compiler |  4 ----
>  3 files changed, 2 insertions(+), 26 deletions(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index dc4cbf0a5ca9..3d265b16c0ae 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -42,18 +42,13 @@ machine-$(CONFIG_PPC64) += 64
>  machine-$(CONFIG_CPU_LITTLE_ENDIAN) += le
>  UTS_MACHINE := $(subst $(space),,$(machine-y))
>
> -# XXX This needs to be before we override LD below
> -ifdef CONFIG_PPC32
> -KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> -else
> -ifeq ($(call ld-ifversion, -ge, 22500, y),y)
> +ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
>  # Have the linker provide sfpr if possible.
>  # There is a corresponding test in arch/powerpc/lib/Makefile
>  KBUILD_LDFLAGS_MODULE += --save-restore-funcs
>  else
>  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
>  endif
> -endif
>
>  ifdef CONFIG_CPU_LITTLE_ENDIAN
>  KBUILD_CFLAGS  += -mlittle-endian
> @@ -389,8 +384,6 @@ vdso_prepare: prepare0
>                 $(build)=arch/powerpc/kernel/vdso include/generated/vdso64-offsets.h)
>  endif
>
> -archprepare: checkbin
> -
>  archheaders:
>         $(Q)$(MAKE) $(build)=arch/powerpc/kernel/syscalls all
>
> @@ -405,16 +398,3 @@ else
>         $(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "TASK_CANARY") print $$3;}' include/generated/asm-offsets.h))
>  endif
>  endif
> -
> -PHONY += checkbin
> -# Check toolchain versions:
> -# - gcc-4.6 is the minimum kernel-wide version so nothing required.
> -checkbin:
> -       @if test "x${CONFIG_LD_IS_LLD}" != "xy" -a \
> -               "x$(call ld-ifversion, -le, 22400, y)" = "xy" ; then \
> -               echo -n '*** binutils 2.24 miscompiles weak symbols ' ; \
> -               echo 'in some circumstances.' ; \
> -               echo    '*** binutils 2.23 do not define the TOC symbol ' ; \
> -               echo -n '*** Please use a different binutils version.' ; \
> -               false ; \
> -       fi
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 4de71cbf6e8e..c53618c34b70 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -42,7 +42,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION)        += error-inject.o
>  # 64-bit linker creates .sfpr on demand for final link (vmlinux),
>  # so it is only needed for modules, and only for older linkers which
>  # do not support --save-restore-funcs
> -ifeq ($(call ld-ifversion, -lt, 22500, y),y)
> +ifndef CONFIG_LD_IS_BFD
>  extra-$(CONFIG_PPC64)  += crtsavres.o
>  endif
>
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index 3d8adfd34af1..ad07a4efc253 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -72,7 +72,3 @@ clang-min-version = $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
>  # ld-option
>  # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
>  ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
> -
> -# ld-ifversion
> -# Usage:  $(call ld-ifversion, -ge, 22252, y)
> -ld-ifversion = $(shell [ $(CONFIG_LD_VERSION)0 $(1) $(2)0 ] && echo $(3) || echo $(4))
> --
> 2.34.1
>
