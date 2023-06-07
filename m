Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DB972551E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbjFGHLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238810AbjFGHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:11:33 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CBB1BE8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:11:29 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so62615ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686121889; x=1688713889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGUTPYhgHVq7tjYGlPQBicKEoIBr6v5/fU5n0hbGTrI=;
        b=OvXHLUmNzM4BI0TQ7LDb6i5kkuRVUOSUhd4VMwgVF4fy/BUvxgd1CPNFfT8ZIjTl05
         32kZUrjfGpw8qkUWloq5scwiSkvTRE06xJXmlO5d7J5VTzHUXLGgQ192HglJaYLVLPwZ
         6l9y4crsmvcA7tLYoIwwfjeiv7KW5AxNG8MzALmyunp8omXcMly1vinxkuNBiifMhYMK
         ywVHFFuLdPwqSfHCs4PjZUS23EGN5Hd4t1sa1di7snzkarxYZjrSjL3IUAqskAKAwNSX
         yXPMr626M6jSs2PWUfT6ZX+WSPDH7k3Xy4YrA+U0KzeSWW9h7chVOPbCkki3sFSw1Fsn
         46fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686121889; x=1688713889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGUTPYhgHVq7tjYGlPQBicKEoIBr6v5/fU5n0hbGTrI=;
        b=CUmTuUGi56kFBfECvZ5gtjkDhSJ9uunBkfPlKGUu1k/qwzyU0NnRfNnNVPO17FH2xH
         GOVuTD5AeMSIzm5K3go/fgqREyt3tUlqrru1D8xrbAld3v3sjMvx7rOT+VySvZsughIQ
         j9r0wetDeGvgQX2nULC6biicX8bu2jtCp4wqgjVfk34uLGWYc3OW/Xsvk0ELO8cgGIwe
         M6H2YfKqgX/heCjNSMx0VXQAo2UJNu6Bkti8/OhYalV8gCq7krsR8qPk0sqzHDcILJG/
         4se5C/KDZrlPDAA0ORy1U6KUbDSwAJdRANQcg4xENM2hZlg3MSKqk0PUUQ2JKj1oSm7/
         XPDg==
X-Gm-Message-State: AC+VfDzLffqzsaEafPfxA/LeNjJrpXJWNjw+ySD5NqlfvpLzsd72mT5l
        e5gxq/6kVpDKCgrNU64Za8zjuqcXFlUrXki6q0bbKQ==
X-Google-Smtp-Source: ACHHUZ64HmjkncqN/Uw4dzL9OH0TZk2U52RRwNcZMU9Q2Q7FzCVbkh7mqzoadlw+Dm8EwEvusUhfelYS7RxorIT+RJ0=
X-Received: by 2002:a05:6e02:170d:b0:32f:7715:4482 with SMTP id
 u13-20020a056e02170d00b0032f77154482mr188090ill.4.1686121888943; Wed, 07 Jun
 2023 00:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230605202712.1690876-1-irogers@google.com> <20230605202712.1690876-5-irogers@google.com>
 <CAM9d7cj9k_FYxmAymHG5Nn6-dhjPT95wrqbHZ_YZSx=oZX7YXQ@mail.gmail.com>
In-Reply-To: <CAM9d7cj9k_FYxmAymHG5Nn6-dhjPT95wrqbHZ_YZSx=oZX7YXQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 7 Jun 2023 00:11:17 -0700
Message-ID: <CAP-5=fVeehz=qyL-eFgc8aa+Q8inmN_mA7N+sGY0z4Sj6Bd9dQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf build: Filter out BTF sources without a .BTF section
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
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

On Mon, Jun 5, 2023 at 4:35=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Mon, Jun 5, 2023 at 1:28=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > If generating vmlinux.h, make the code to generate it more tolerant by
> > filtering out paths to kernels that lack a .BTF section.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Makefile.perf | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index f1840af195c0..c3bb27a912b0 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -193,6 +193,7 @@ FLEX    ?=3D flex
> >  BISON   ?=3D bison
> >  STRIP   =3D strip
> >  AWK     =3D awk
> > +READELF ?=3D readelf
> >
> >  # include Makefile.config by default and rule out
> >  # non-config cases
> > @@ -1080,12 +1081,28 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
> >         $(Q)CFLAGS=3D $(MAKE) -C ../bpf/bpftool \
> >                 OUTPUT=3D$(SKEL_TMP_OUT)/ bootstrap
> >
> > -VMLINUX_BTF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                        =
   \
> > +# Paths to search for a kernel to generate vmlinux.h from.
> > +VMLINUX_BTF_ELF_PATHS ?=3D $(if $(O),$(O)/vmlinux)                    =
   \
> >                      $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)   =
 \
> >                      ../../vmlinux                                     =
 \
> > -                    /sys/kernel/btf/vmlinux                           =
 \
> >                      /boot/vmlinux-$(shell uname -r)
> > -VMLINUX_BTF ?=3D $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS)=
)))
> > +
> > +# Paths to BTF information.
> > +VMLINUX_BTF_BTF_PATHS ?=3D /sys/kernel/btf/vmlinux
> > +
> > +# Filter out kernels that don't exist or without a BTF section.
> > +VMLINUX_BTF_ELF_ABSPATHS ?=3D $(abspath $(wildcard $(VMLINUX_BTF_ELF_P=
ATHS)))
> > +VMLINUX_BTF_PATHS ?=3D $(shell for file in $(VMLINUX_BTF_ELF_ABSPATHS)=
; \
> > +                       do \
> > +                               if [ -f $$file ] && ($(READELF) -t "$$f=
ile" | grep .BTF); \
>
> Wouldn't it be `readelf -S` instead?  Also I think grep needs -q to
> suppress output.

Makes sense, I can change it in v3.

> > +                               then \
> > +                                       echo "$$file"; \
> > +                               fi; \
> > +                       done) \
> > +                       $(wildcard $(VMLINUX_BTF_BTF_PATHS))
>
> This changes the order of processing the sysfs file.
> But I'm not sure it matters much as both /boot/vmlinux and sysfs
> should refer to the running kernel.

Agreed. readelf fails for /sys/kernel/btf/vmlinux as it isn't an elf
file and I'm not sure it is worth worrying too much about the order
here.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +
> > +# Select the first as the source of vmlinux.h.
> > +VMLINUX_BTF ?=3D $(firstword $(VMLINUX_BTF_PATHS))
> >
> >  $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> >  ifeq ($(VMLINUX_H),)
> > --
> > 2.41.0.rc0.172.g3f132b7071-goog
> >
