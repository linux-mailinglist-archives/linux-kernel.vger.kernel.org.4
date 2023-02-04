Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D568AC91
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 22:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjBDVWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 16:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBDVWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 16:22:06 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E40523651
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 13:22:05 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id ba1so3317843wrb.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 13:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HZ1lZAl4qLcb5xp1Yt6FT/tNVNDJTFKeCgoWYkODGB4=;
        b=f7xwzCC01RxW7hoNdcvo/YvGVMhYaGHnT5BBv/d+9sODBFwBtDv8jWumdD3z+p0NI3
         u61C0xQ/HMbT/xCyEcXqNzIS02ZfG/I7SnyeneJz648wa9JA0Q8u4A+mJbzp+KXwFVfL
         4TfpNQzRfT6mkuhKIiX+scnQNS2tIR0/wx4z4AewRTxJTyKDa4uL//ddkT//kP9h3Fic
         qh0eKtzNp7RudLR2HJdmitiG4Aqj9OaD5HhaMzGtRlh3zAxm22pHUPCxvuKvKOxoGvRS
         k+GRe5UTtP8lsP9An9AJxZOZ+0ngkqwZDOM3QlHmZQeKgMcitGWnqaSMVd1WmoQ2Xt78
         q9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZ1lZAl4qLcb5xp1Yt6FT/tNVNDJTFKeCgoWYkODGB4=;
        b=KY451EV4+DFLI2pb5VjepeR6QXfOWeWSj+m5boV6HEd4ao4jeFGk90ydkuIzoFk+S9
         zcA157kjYpoFZkLWD9MwNIPT9x4Z30CHeOYBeLR8GOHNOEIRGbJFVP4zZYEsBTG7T5Cb
         UBvlIfk+vwyGkxaSt5pzZWdB7dacTBv4NxPzK2motIgCiAHTmO1sSWyQGDSbCoBa8Mks
         Irto2312aTOutXx24hG5zGKOQSzCcdHvCiEWx2AEaV3Vw3V7FtGeGp5/4xyFEcJxMUkw
         vOpoGXWIZ6z4cawjOfV4xDajvAMH/5wPNcDu5PxZYMFKI+9x0pB/YiemLGFNPaGlGgLb
         RF4Q==
X-Gm-Message-State: AO0yUKWFysq1arJrZd5TZsJDf1qUs7IUIHsyLknqN3ygqzW/GJtCJYI0
        f0YjfUnqBf76cYMGNlkcZckVuVqWLaT6/jsnDG8Ivg==
X-Google-Smtp-Source: AK7set93qsPYgehuRreGpbLXPBdG4QFg4jLXmrUW4H8EAbTwGhjrvdrnTTs4XtUATKQIekE1f3pu+7umRXCfwqSRhvk=
X-Received: by 2002:adf:ea01:0:b0:2c3:db66:5cc4 with SMTP id
 q1-20020adfea01000000b002c3db665cc4mr71594wrm.608.1675545723524; Sat, 04 Feb
 2023 13:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20230126190606.40739-4-irogers@google.com> <167526879495.4906.2898311831401901292.tip-bot2@tip-bot2>
 <Y9qbGHDBFtGoqnKK@FVFF77S0Q05N> <20230201173637.cyu6yzudwsuzl2vj@treble>
 <20230203182540.7linqqtr3tlrbfe7@skbuf> <20230204170502.qjc3dpmf2owa3w7v@treble>
In-Reply-To: <20230204170502.qjc3dpmf2owa3w7v@treble>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 4 Feb 2023 13:21:49 -0800
Message-ID: <CAP-5=fXmwOb5ae-tejhhhsC8FF+ajivVjBhEjSyFb0z=uWPwow@mail.gmail.com>
Subject: Re: [tip: objtool/core] objtool: Fix HOSTCC flag usage
To:     Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86@kernel.org, netdev@vger.kernel.org
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

On Sat, Feb 4, 2023 at 9:05 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Fri, Feb 03, 2023 at 08:25:40PM +0200, Vladimir Oltean wrote:
> > On Wed, Feb 01, 2023 at 09:36:37AM -0800, Josh Poimboeuf wrote:
> > > On Wed, Feb 01, 2023 at 05:02:16PM +0000, Mark Rutland wrote:
> > > > Hi,
> > > >
> > > > I just spotted this breaks cross-compiling; details below.
> > >
> > > Thanks, we'll fix it up with
> > >
> > > diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> > > index 29a8cd7449bf..83b100c1e7f6 100644
> > > --- a/tools/objtool/Makefile
> > > +++ b/tools/objtool/Makefile
> > > @@ -36,7 +36,7 @@ OBJTOOL_CFLAGS := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBE
> > >  OBJTOOL_LDFLAGS := $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
> > >
> > >  # Allow old libelf to be used:
> > > -elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
> > > +elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(HOSTCC) $(OBJTOOL_CFLAGS) -x c -E - | grep elf_getshdr)
> > >  OBJTOOL_CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
> > >
> > >  # Always want host compilation.
> >
> > Profiting off of the occasion to point out that cross-compiling with
> > CONFIG_DEBUG_INFO_BTF=y is also broken (it builds the resolve_btfids
> > tool):
>
> The above patch was for objtool, though I'm guessing you were bitten by
> a similar patch for bpf:
>
>   13e07691a16f ("tools/resolve_btfids: Alter how HOSTCC is forced")
>
> It looks like it might have a similar problem we had for objtool.  Does
> this fix it?

Jiri Olsa has been exploring switching to using hostprogs (we need a
hostlibs notion), his patch is:
https://lore.kernel.org/bpf/20230202112839.1131892-1-jolsa@kernel.org/
With this thread giving context:
https://lore.kernel.org/lkml/20230201015015.359535-1-irogers@google.com/
If we have hostprogs and hostlibs then objtool should move to this
approach as changing CC leads to broken CFLAGS and the like.

Thanks,
Ian

> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> index daed388aa5d7..fff84cd914cd 100644
> --- a/tools/bpf/resolve_btfids/Makefile
> +++ b/tools/bpf/resolve_btfids/Makefile
> @@ -18,8 +18,8 @@ else
>  endif
>
>  # always use the host compiler
> -HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
> -                 EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
> +HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)"
> +BTF_CFLAGS     := $(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)
>
>  RM      ?= rm
>  CROSS_COMPILE =
> @@ -53,23 +53,25 @@ $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
>
>  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
>         $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
> -                   DESTDIR=$(SUBCMD_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
> +                   $(HOST_OVERRIDES) EXTRA_CFLAGS="$(BTF_CFLAGS)" \
> +                   DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
>                     $(abspath $@) install_headers
>
>  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
>         $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
> -                   DESTDIR=$(LIBBPF_DESTDIR) $(HOST_OVERRIDES) prefix= subdir= \
> +                   $(HOST_OVERRIDES) EXTRA_CFLAGS="$(BTF_CFLAGS)" \
> +                   DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
>                     $(abspath $@) install_headers
>
>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>
> -CFLAGS += -g \
> -          -I$(srctree)/tools/include \
> -          -I$(srctree)/tools/include/uapi \
> -          -I$(LIBBPF_INCLUDE) \
> -          -I$(SUBCMD_INCLUDE) \
> -          $(LIBELF_FLAGS)
> +BTF_CFLAGS += -g \
> +              -I$(srctree)/tools/include \
> +              -I$(srctree)/tools/include/uapi \
> +              -I$(LIBBPF_INCLUDE) \
> +              -I$(SUBCMD_INCLUDE) \
> +              $(LIBELF_FLAGS)
>
>  LIBS = $(LIBELF_LIBS) -lz
>
> @@ -77,7 +79,7 @@ export srctree OUTPUT CFLAGS Q
>  include $(srctree)/tools/build/Makefile.include
>
>  $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
> -       $(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES)
> +       $(Q)$(MAKE) $(build)=resolve_btfids $(HOST_OVERRIDES) CFLAGS="$(BTF_CFLAGS)"
>
>  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
>         $(call msg,LINK,$@)
