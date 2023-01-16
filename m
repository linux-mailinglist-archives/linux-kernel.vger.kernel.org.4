Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBE766CDD9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbjAPRnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjAPRmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:42:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D33367E9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:20:54 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b7so2157550wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 09:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w7ruzlKMZHkDd9yX5xBt67Kofb46IkEUMimIJ3H0GGg=;
        b=d/POZtNJjfodVLsaLYxeCx4Fzo0tJ4tutCLrn41k1uhe7ISwxtfj4L8XwkK0rNGYKe
         dnby2tAZmgNM2IvnfTCSwJw6p7/4uKX2Szl7+MYg0glhIsYmxeZ9eC9PX9YbbvnIIR51
         OLstI7i2lHyDuDkJjUn+IWLCw6lUAMBMc6EmCeaUkP63WwcWsYUvpwEHdwmjnjYrKLLG
         K87g9QDPewjAlwXU45MxrYIHv7mvOSs206I8UKzA+Tsu+kF+xI2pd+ILl+XN8VnVKXPs
         +jhCLe3Q52RkooioVNVHzvHJpHz8rD+BuhbTMwDU3SQSycQUWMZ7WojsBvSUJSXCM6YT
         oGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7ruzlKMZHkDd9yX5xBt67Kofb46IkEUMimIJ3H0GGg=;
        b=qIoivQDE//XPZr/Lk/m3hnu9cBOLhgN0FbqSNOmSWWL4d4IdwBEzfpekxA/xUnawy5
         jL9XP7SqMjg+WK9FLsgjU0Bz/auXnRdnT0PCouh3o7WmleJCqWDwR7euiVVq4tcx1IYl
         nhTKHsbxe35EIGS46oDdvHct84G8H5ryf6JyxBtrKiD4wiiBDLJ+04uzCXYPuSX6rigf
         sEbqM2GuJYBesVOas3uolQKnvYbjMURFpsMcF3WB+/QqhupsYWKrz94wa/Xd3Fb8PkYy
         RIMyL+/ZQ+SWXkkNQCj5zMIcUCx9/1s+bmaFq+I7tml6QpknZoTPl58+tOCfnKx9tDub
         qqVA==
X-Gm-Message-State: AFqh2kqu3bfsQEZAt1HiYI1K9iOEeAFYjN2W+CiZ1uisY/PHI0TjtB7L
        oMHs3K2bPz1ZjcHCzPRvedBXeeoi+jArrbOAlHkH8Q==
X-Google-Smtp-Source: AMrXdXsbh9TO5h+SzyA6j/U0QsCy5QmQvGXfqM+Kityz8JId7ZCvJfb83z2KehT2z94NashmpYDr7sTYz3qnZ+FYlew=
X-Received: by 2002:adf:e2cd:0:b0:2bd:f8da:9be0 with SMTP id
 d13-20020adfe2cd000000b002bdf8da9be0mr7884wrj.375.1673889652518; Mon, 16 Jan
 2023 09:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20230112004024.1934601-1-irogers@google.com> <Y8Uzet0cNtDo8kHe@krava>
In-Reply-To: <Y8Uzet0cNtDo8kHe@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 16 Jan 2023 09:20:39 -0800
Message-ID: <CAP-5=fXjjnivhuVSRj7yjaea+6E-YfVKP+Tz2BsTNSqUBDvm4g@mail.gmail.com>
Subject: Re: [PATCH v1] tools/resolve_btfids: Install subcmd headers
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 3:22 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Wed, Jan 11, 2023 at 04:40:24PM -0800, Ian Rogers wrote:
> > Previously tools/lib/subcmd was added to the include path, switch to
> > installing the headers and then including from that directory. This
> > avoids dependencies on headers internal to tools/lib/subcmd. Add the
> > missing subcmd directory to the affected #include.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/bpf/resolve_btfids/Makefile | 19 ++++++++++++++-----
> >  tools/bpf/resolve_btfids/main.c   |  2 +-
> >  2 files changed, 15 insertions(+), 6 deletions(-)
>
> this depends on changes that went to Arnaldo's tree right?
> I can't apply this on bpf-next/master

Hmm.. sorry for that. I did the work on the master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

> >
> > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > index 19a3112e271a..de7d29cf43d6 100644
> > --- a/tools/bpf/resolve_btfids/Makefile
> > +++ b/tools/bpf/resolve_btfids/Makefile
> > @@ -35,21 +35,29 @@ SUBCMD_SRC := $(srctree)/tools/lib/subcmd/
> >  BPFOBJ     := $(OUTPUT)/libbpf/libbpf.a
> >  LIBBPF_OUT := $(abspath $(dir $(BPFOBJ)))/
> >  SUBCMDOBJ  := $(OUTPUT)/libsubcmd/libsubcmd.a
> > +SUBCMD_OUT := $(abspath $(dir $(SUBCMDOBJ)))/
> >
> >  LIBBPF_DESTDIR := $(LIBBPF_OUT)
> >  LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
> >
> > +SUBCMD_DESTDIR := $(SUBCMD_OUT)
> > +SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
> > +
> >  BINARY     := $(OUTPUT)/resolve_btfids
> >  BINARY_IN  := $(BINARY)-in.o
> >
> >  all: $(BINARY)
> >
> > +prepare: $(SUBCMDOBJ)
>
> do we need special target for that? we already have BPFOBJ dependency
> placed in the BINARY_IN as prereq

BPFOBJ is $(OUTPUT)/libbpf/libbpf.a which is needed at link time. The
prepare step is one we have elsewhere and it creates things like the
header files necessary to compile the C code, so we need it earlier is
the answer.

> why not place both as BINARY_IN prereq, or is there some other reason
> for new 'prepare' target?

I was trying to follow the convention elsewhere in the tree of having
a prepare target that does things like get the necessary header files
ready. Having prepare is useful because if an additional dependency is
added, then it just needs to be added to prepare. It could be tedious
to list all the dependencies for every C file, although Makefile.build
handles most of that. It isn't clear to me why $(BPFOBJ) is a
dependency of $(BINARY_IN) as it is already a dependency of $(BINARY).

Thanks,
Ian

> jirka
>
> > +
> >  $(OUTPUT) $(OUTPUT)/libsubcmd $(LIBBPF_OUT):
> >       $(call msg,MKDIR,,$@)
> >       $(Q)mkdir -p $(@)
> >
> >  $(SUBCMDOBJ): fixdep FORCE | $(OUTPUT)/libsubcmd
> > -     $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(abspath $(dir $@))/ $(abspath $@)
> > +     $(Q)$(MAKE) -C $(SUBCMD_SRC) OUTPUT=$(SUBCMD_OUT) \
> > +                 DESTDIR=$(SUBCMD_DESTDIR) prefix= \
> > +                 $(abspath $@) install_headers
> >
> >  $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUT)
> >       $(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC) OUTPUT=$(LIBBPF_OUT)    \
> > @@ -60,14 +68,14 @@ CFLAGS += -g \
> >            -I$(srctree)/tools/include \
> >            -I$(srctree)/tools/include/uapi \
> >            -I$(LIBBPF_INCLUDE) \
> > -          -I$(SUBCMD_SRC)
> > +          -I$(SUBCMD_INCLUDE)
> >
> >  LIBS = -lelf -lz
> >
> >  export srctree OUTPUT CFLAGS Q
> >  include $(srctree)/tools/build/Makefile.include
> >
> > -$(BINARY_IN): $(BPFOBJ) fixdep FORCE | $(OUTPUT)
> > +$(BINARY_IN): $(BPFOBJ) fixdep FORCE prepare | $(OUTPUT)
> >       $(Q)$(MAKE) $(build)=resolve_btfids
> >
> >  $(BINARY): $(BPFOBJ) $(SUBCMDOBJ) $(BINARY_IN)
> > @@ -79,7 +87,8 @@ clean_objects := $(wildcard $(OUTPUT)/*.o                \
> >                              $(OUTPUT)/.*.o.d             \
> >                              $(LIBBPF_OUT)                \
> >                              $(LIBBPF_DESTDIR)            \
> > -                            $(OUTPUT)/libsubcmd          \
> > +                            $(SUBCMD_OUT)                \
> > +                            $(SUBCMD_DESTDIR)            \
> >                              $(OUTPUT)/resolve_btfids)
> >
> >  ifneq ($(clean_objects),)
> > @@ -96,4 +105,4 @@ tags:
> >
> >  FORCE:
> >
> > -.PHONY: all FORCE clean tags
> > +.PHONY: all FORCE clean tags prepare
> > diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> > index 80cd7843c677..77058174082d 100644
> > --- a/tools/bpf/resolve_btfids/main.c
> > +++ b/tools/bpf/resolve_btfids/main.c
> > @@ -75,7 +75,7 @@
> >  #include <linux/err.h>
> >  #include <bpf/btf.h>
> >  #include <bpf/libbpf.h>
> > -#include <parse-options.h>
> > +#include <subcmd/parse-options.h>
> >
> >  #define BTF_IDS_SECTION      ".BTF_ids"
> >  #define BTF_ID               "__BTF_ID__"
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
