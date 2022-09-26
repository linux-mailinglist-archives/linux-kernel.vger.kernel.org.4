Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C2E5EB349
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiIZVkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiIZVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:39:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B429591
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:39:51 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so630341pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gL53yh9xTnldmrpVyGa4fesIlro972GlT8XNds1ol0Y=;
        b=CeR5zgSbXVtQn8jsDnr6VMB4nzxf+Ku2tOSCnxUEkdrkdouu+aoAU6yU2dypC3dSFs
         PNN70bjEMpDeqL5zzvMNjBsd351cKPP90FLr3CLNMEQ9xX5Qw05OVJYX+dKriBH+gtMw
         kzluFoX7IQUOnjGMVkvipy+4kSvtMQj1BL3YtjTrslHI8JreFNMoDCV3+cXDVpJGoThB
         3JTVGhteg3cDx6I3BEj6Uqa9ZkLnZvNIYhbnhZ1tma0jIK4fPJYgYlqkWzNvXmAYplXJ
         0UamSBc5zKdvWua0DMIuDI7L/Kn1JoYqIjGxp9ZPknebfp6KvZ6qHUtpyl3E1flR1gqX
         +OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gL53yh9xTnldmrpVyGa4fesIlro972GlT8XNds1ol0Y=;
        b=jzUzN4PZto/Gemsa0UDtnGr+90k+yljOY3N9RwO0mjjjfFQSYPkog0vfIlikgMjRgc
         dttzQFQlG/aQWzMZFn6z3AA+e8gc8XZjKVjGKFnF2hA5acfl3tu2vD3O6Bb9fpO6vX4m
         kJUPuPgJoJ5M1m5dPWdeLqGfCOvF/YhX1XaHCj/XFvoeqPDSHNSH1j9HMhGw4e0+o/23
         GATR9MVTDbDp7zAH+o0JkuKxNUYT0Yn9JslGQCcWNEdv110gutYLqXmkS8C6Njxu6r8S
         9UiSMPpGj3XeAcktdg3Wc1l4f1lwX+qUJ4vAofzpDpCjorpa8XDjxJ162AwOqpUMdx+O
         6+Jw==
X-Gm-Message-State: ACrzQf3y6fl2zVQpnth2429RshIn49GgE7RFDzBtmuvBypnNJ9UlRfd/
        uBvE68UpB2PcrHx6Q/EL2QxKNboR3z2WIru+pxqdgg==
X-Google-Smtp-Source: AMsMyM4Lt6VVS4q9zkk3zydquKXsh+ROmYxskJzYYqasvFoX5PDWrs3pH0XnLI3msIZOv6Z6nkmCjyuccxb25Z7GQQQ=
X-Received: by 2002:a17:90a:74c4:b0:203:336d:dd36 with SMTP id
 p4-20020a17090a74c400b00203336ddd36mr803819pjl.107.1664228391196; Mon, 26 Sep
 2022 14:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220924181915.3251186-1-masahiroy@kernel.org>
In-Reply-To: <20220924181915.3251186-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Sep 2022 14:39:39 -0700
Message-ID: <CAKwvOdkREP8kFuE2UqMV4a+CRykKMO44X-12N6zcQoBbRYdJ4g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] kbuild: various cleanups
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
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

On Sat, Sep 24, 2022 at 11:20 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>  - Link vmlinux and modules in parallel

I was curious if this resulted in an observable improvement. N=1

Mainline:
$ /usr/bin/time -v make ARCH=arm64 LLVM=1 -j128 -s
Elapsed (wall clock) time (h:mm:ss or m:ss): 2:15.68


With this series:
$ /usr/bin/time -v make ARCH=arm64 LLVM=1 -j128 -s
Elapsed (wall clock) time (h:mm:ss or m:ss): 2:12.22

I'll take it!
Tested-by: Nick Desaulniers <ndesaulniers@google.com>


>  - Remove head-y syntax
>
>
> Masahiro Yamada (7):
>   kbuild: hard-code KBUILD_ALLDIRS in scripts/Makefile.package
>   kbuild: list sub-directories in ./Kbuild
>   kbuild: move .vmlinux.objs rule to Makefile.modpost
>   kbuild: move vmlinux.o rule to the top Makefile
>   kbuild: unify two modpost invocations
>   kbuild: use obj-y instead extra-y for objects placed at the head
>   kbuild: remove head-y syntax
>
>  Documentation/kbuild/makefiles.rst          |  27 +----
>  Kbuild                                      |  24 ++++
>  Makefile                                    | 119 +++++++++++---------
>  arch/alpha/Makefile                         |   2 -
>  arch/alpha/kernel/Makefile                  |   4 +-
>  arch/arc/Makefile                           |   2 -
>  arch/arc/kernel/Makefile                    |   4 +-
>  arch/arm/Makefile                           |   3 -
>  arch/arm/kernel/Makefile                    |   4 +-
>  arch/arm64/Makefile                         |   3 -
>  arch/arm64/kernel/Makefile                  |   4 +-
>  arch/csky/Makefile                          |   2 -
>  arch/csky/kernel/Makefile                   |   4 +-
>  arch/hexagon/Makefile                       |   2 -
>  arch/hexagon/kernel/Makefile                |   3 +-
>  arch/ia64/Makefile                          |   1 -
>  arch/ia64/kernel/Makefile                   |   4 +-
>  arch/loongarch/Makefile                     |   2 -
>  arch/loongarch/kernel/Makefile              |   4 +-
>  arch/m68k/68000/Makefile                    |   2 +-
>  arch/m68k/Makefile                          |   9 --
>  arch/m68k/coldfire/Makefile                 |   2 +-
>  arch/m68k/kernel/Makefile                   |  23 ++--
>  arch/microblaze/Makefile                    |   1 -
>  arch/microblaze/kernel/Makefile             |   4 +-
>  arch/mips/Makefile                          |   2 -
>  arch/mips/kernel/Makefile                   |   4 +-
>  arch/nios2/Makefile                         |   1 -
>  arch/nios2/kernel/Makefile                  |   2 +-
>  arch/openrisc/Makefile                      |   2 -
>  arch/openrisc/kernel/Makefile               |   4 +-
>  arch/parisc/Makefile                        |   2 -
>  arch/parisc/kernel/Makefile                 |   4 +-
>  arch/powerpc/Makefile                       |  12 --
>  arch/powerpc/kernel/Makefile                |  20 ++--
>  arch/riscv/Makefile                         |   2 -
>  arch/riscv/kernel/Makefile                  |   2 +-
>  arch/s390/Makefile                          |   2 -
>  arch/s390/kernel/Makefile                   |   4 +-
>  arch/sh/Makefile                            |   2 -
>  arch/sh/kernel/Makefile                     |   4 +-
>  arch/sparc/Makefile                         |   2 -
>  arch/sparc/kernel/Makefile                  |   3 +-
>  arch/x86/Makefile                           |   5 -
>  arch/x86/kernel/Makefile                    |  10 +-
>  arch/xtensa/Makefile                        |   2 -
>  arch/xtensa/kernel/Makefile                 |   4 +-
>  scripts/Makefile.lib                        |   2 +
>  scripts/Makefile.modfinal                   |   2 +-
>  scripts/Makefile.modpost                    | 112 ++++++++----------
>  scripts/Makefile.package                    |   5 +-
>  scripts/Makefile.vmlinux_o                  |   6 +-
>  scripts/clang-tools/gen_compile_commands.py |  19 +---
>  scripts/head-object-list.txt                |  53 +++++++++
>  scripts/link-vmlinux.sh                     |  34 +-----
>  55 files changed, 273 insertions(+), 314 deletions(-)
>  create mode 100644 scripts/head-object-list.txt
>
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
