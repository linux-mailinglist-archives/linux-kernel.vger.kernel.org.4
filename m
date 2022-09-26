Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04395EB353
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiIZVlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIZVlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:41:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DA599B60
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:41:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jm5so7392970plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=E7fyttjWXDvI+Nh4igxE5vTXF/dm3A6WscqBjfXxDFc=;
        b=YtQ5GFLymPsHxq9c5yK0qNnU7qPdI2crr9VRqh8rJZggYlU5LusqpdCK4y162UvGGQ
         RsnuHhfmS43W7s9YtaMJDMobXZS4Pr37nZYEUzkQhqbXq6qzZmLkg6YwnusBhvc79Kfw
         x7R4iRAjacE5C+n5PBc976/KStqQnyt8NUWhFvWQPXWR7kyn7duY7phUmNidZDxTolhZ
         1OMj39KucjSsyDfQ931fIDfgtP55Xl4D04OkilCttCQH3/hCblEJQXoAcDBEQnXUFR/K
         2XwS9r+I0pGCQnHHnrDqNiDqOGapgON+L3Js71KnP4NwVYqoLwfEg6zNO1YL0bkTWUDp
         IvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=E7fyttjWXDvI+Nh4igxE5vTXF/dm3A6WscqBjfXxDFc=;
        b=XgV0gzeSiFHYcOGqhLiB32Zj8ijAcgnoSRIDgI7KwSPL31b3wPf3m4c3HT8VZ0tOws
         wB2RTDAfiBYirJKiSnFhhsU1e/Utns0qloqrSYPlAMBIAPNLLOMcLr31HpKs+wlNLBrB
         MXikhZ1SKbttXQc68YocUGnqrFTE7iSofPCu1CXiLLB1YOT0HZozt0XCoTbEsdRmykFu
         HWT9tIPDuSpU+/FSSqHJ0MB/kRZrNy9HCAOgyGzWIMxvyi1bgSNjYdreVvanENFRg8c0
         amS6oSEgM68HIZSJiSlqXretTTd1nLlJYR4YOQFc+t1uiDd6MnTpU5iYCMhaoL8pDvO7
         RnfA==
X-Gm-Message-State: ACrzQf17kpwQPQREsUT0LVQEN6gPCCChoXr3Ht9rAg7e1l9J+NZPPQ9k
        iwlFbOH3ffPhOXXFqezwsLbQhyt320BQwex3KwgFXNL0u/U=
X-Google-Smtp-Source: AMsMyM7ZvXJD30YyLq1Wy98Uom1ldZglXbcguk66Px/nAVmlE+H5+m08kvO0PEoKHhwCz0L90AMue/SgQcoxgSUZJAc=
X-Received: by 2002:a17:90b:33c9:b0:200:a0ca:e6c8 with SMTP id
 lk9-20020a17090b33c900b00200a0cae6c8mr804570pjb.147.1664228471880; Mon, 26
 Sep 2022 14:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919170828.3718437-1-ndesaulniers@google.com> <CAK7LNARk74U8AWzOVHP1pPVy2PNSMsNiyPL8bmFcYs6DkheorA@mail.gmail.com>
 <CAK7LNAQRV_Z+0V9gB0=KWKpQE=sH-Y4QVhgSjxc==412U=_LBw@mail.gmail.com> <CAK7LNATqGJCKRmL=vhH1_Ms--7QYTT8YTFxExejDs0_bQD4Ptg@mail.gmail.com>
In-Reply-To: <CAK7LNATqGJCKRmL=vhH1_Ms--7QYTT8YTFxExejDs0_bQD4Ptg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Sep 2022 14:41:00 -0700
Message-ID: <CAKwvOdmoHCwazcTpF=jDc_ghu09OCSkrSZ-ZP4rHNtO54n-aRw@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>
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

On Sat, Sep 24, 2022 at 6:23 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > I noticed a small flaw now.
> >
> >
> >
> > $ make mrproper; make
> > /bin/sh: 1: [: -ge: unexpected operator
> > ***
> > *** Configuration file ".config" not found!
> > ***
> > *** Please run some configurator (e.g. "make oldconfig" or
> > *** "make menuconfig" or "make xconfig").
> > ***
> > Makefile:711: include/config/auto.conf.cmd: No such file or directory
> > make: *** [Makefile:720: .config] Error 1
> >
> >
> >
> >
> >
> >
> >
> >
> > This fails anyway, but it shows annoying
> >
> >    /bin/sh: 1: [: -ge: unexpected operator
> >
> >
> >
> > It is emit by this line:
> >
> >   KBUILD_CFLAGS-$(call gcc-min-version, 90100) += -Wno-alloc-size-larger-than
> >
> >
> >
> >
> > When $(CONFIG_GCC_VERSION) is empty, it becomes invalid shell code:
> >
> >      [ -ge $(1) ] && echo y
> >
> >
> >
> >
> >
> > Now I just recalled why I wrote the original code like this:
> >
> >
> >   cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ]  ...
> >
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
>
>
>
>
>
>
> I squashed the following code diff.
> Please let me know if there is a problem.

LGTM; thanks (again).

>
>
>
>
>
>
>
>
>
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index 9d18fb91890e..20d353dcabfb 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -63,11 +63,11 @@ cc-disable-warning = $(call try-run,\
>
>  # gcc-min-version
>  # Usage: cflags-$(call gcc-min-version, 70100) += -foo
> -gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION) -ge $(1) ] && echo y)
> +gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION)0 -ge $(1)0 ] && echo y)
>
>  # clang-min-version
>  # Usage: cflags-$(call clang-min-version, 110000) += -foo
> -clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION) -ge $(1) ] && echo y)
> +clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION)0 -ge $(1)0 ] && echo y)
>
>  # ld-option
>  # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
>
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada
>


-- 
Thanks,
~Nick Desaulniers
