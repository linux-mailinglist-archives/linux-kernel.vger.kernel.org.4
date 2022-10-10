Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38885FA45A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJJTx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiJJTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:53:23 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E11A74CD8;
        Mon, 10 Oct 2022 12:53:21 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 29AJr46V013266;
        Tue, 11 Oct 2022 04:53:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 29AJr46V013266
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665431585;
        bh=fppzhxLc/ULRVnpFhY7WPIq2pRIDpPCXCTtNmRPKCDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OcddSkFV+bx6993DgzdmE4fqmK3YYbJLT4kBMleVXDHxIstri6gKmlYIyirQsY6Pz
         q2RPZTDutqYraqnLGrCgrqNxgtxcHeIhm3vr3iYl5PvWZ65b20iY/9XFhMvDKZWitL
         CIUdbVd8kom4X7rvE3QgPB3B6hkCJ9P4tMeRWLpud2CQ/cZvHzuD9e962wAEDSwtfS
         abdnA2QWb4sdgKDVU16moeTzGopqkKxSjuI9yo23L5KzJMNizedqUbuae2zR5qkpLh
         +e2479X+Q+W3uG/0BrlcpSyrRfhv42kOwXZHAcsC0hEp2VOCSUd6E7iDQK0fMMC/KH
         StMX39LnYaIcA==
X-Nifty-SrcIP: [209.85.167.174]
Received: by mail-oi1-f174.google.com with SMTP id m81so13787688oia.1;
        Mon, 10 Oct 2022 12:53:04 -0700 (PDT)
X-Gm-Message-State: ACrzQf3hK8jDTzrU9arudcEookz/T9dkL1vPgOZmfrDKsjib4CSbSLhA
        67Obxo2fi9KFniaJ/WzDumged73zcNedaf4bPus=
X-Google-Smtp-Source: AMsMyM7kvQuqhaiDL+wDwB0roJTld2uMFANJ19iN5thw6i9kdQLcajUmYBUCqfy2LvbfuxVNM7S8hzxWvOBGXkDN8cc=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr15133580oib.194.1665431583795; Mon, 10
 Oct 2022 12:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASzGEiQfPTaLmhG4k7VAwB5yznd-VqWdJHEF2YjgSQTcA@mail.gmail.com>
In-Reply-To: <CAK7LNASzGEiQfPTaLmhG4k7VAwB5yznd-VqWdJHEF2YjgSQTcA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 11 Oct 2022 04:52:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfd1mbL8bE14NfRCmVU+wRZjxCuBVTBNQ-negr5nms4w@mail.gmail.com>
Message-ID: <CAK7LNARfd1mbL8bE14NfRCmVU+wRZjxCuBVTBNQ-negr5nms4w@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I have not got any feedback on this pull request.
I started to be worried because we are in the 2nd week of MW.

Also, the powerpc pull request overtook this, so
you need this one too.
https://lore.kernel.org/all/20221004091606.71418ddc@canb.auug.org.au/

Best Regards
Masahiro Yamada





On Thu, Oct 6, 2022 at 11:29 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hello Linus,
>
> Please pull Kbuild updates for v6.1-rc1.
>
>
> I attached my resolutions of the merge conflicts.
> (attachment: merge-resolution.diff)
>
> You can find a similar resolution in next-20221005.
>
> A slight difference is that, I inserted
>
>   obj-$(CONFIG_RUST)      += rust/
>
> right after
>
>   obj-$(CONFIG_IO_URING)  += io_uring/
>
> This is the right order to keep the current link order.
>
>
> Thank you.
>
>
>
>
> The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:
>
>   Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
> tags/kbuild-v6.1
>
> for you to fetch changes up to 0715fdb03e2c4f5748d245a231e422602ed29f33:
>
>   docs: bump minimal GNU Make version to 3.82 (2022-10-06 09:16:21 +0900)
>
> ----------------------------------------------------------------
> Kbuild updates for v6.1
>
>  - Remove potentially incomplete targets when Kbuid is interrupted by
>    SIGINT etc. in case GNU Make may miss to do that when stderr is piped
>    to another program.
>
>  - Rewrite the single target build so it works more correctly.
>
>  - Fix rpm-pkg builds with V=1.
>
>  - List top-level subdirectories in ./Kbuild.
>
>  - Ignore auto-generated __kstrtab_* and __kstrtabns_* symbols in kallsyms.
>
>  - Avoid two different modules in lib/zstd/ having shared code, which
>    potentially causes building the common code as build-in and modular
>    back-and-forth.
>
>  - Unify two modpost invocations to optimize the build process.
>
>  - Remove head-y syntax in favor of linker scripts for placing particular
>    sections in the head of vmlinux.
>
>  - Bump the minimal GNU Make version to 3.82.
>
>  - Clean up misc Makefiles and scripts.
>
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       zstd: Fixing mixed module-builtin objects
>
> Janis Schoetterl-Glausch (1):
>       kbuild: rpm-pkg: fix breakage when V=1 is used
>
> Masahiro Yamada (35):
>       kbuild: remove the target in signal traps when interrupted
>       kbuild: add phony targets to ./Kbuild
>       kbuild: hard-code KBUILD_ALLDIRS in scripts/Makefile.package
>       kbuild: check sha1sum just once for each atomic header
>       kbuild: do not deduplicate modules.order
>       nios2: move core-y in arch/nios2/Makefile to arch/nios2/Kbuild
>       kbuild: remove duplicated dependency between modules and modules_check
>       kbuild: refactor single builds of *.ko
>       kbuild: move 'PHONY += modules_prepare' to the common part
>       init/version.c: remove #include <linux/version.h>
>       kbuild: build init/built-in.a just once
>       kbuild: generate include/generated/compile.h in top Makefile
>       scripts/mkcompile_h: move LC_ALL=C to '$LD -v'
>       Revert "kbuild: Make scripts/compile.h when sh != bash"
>       kbuild: fix and refactor single target build
>       kbuild: use objtool-args-y to clean up objtool arguments
>       linux/export: use inline assembler to populate symbol CRCs
>       kbuild: list sub-directories in ./Kbuild
>       kbuild: move .vmlinux.objs rule to Makefile.modpost
>       kbuild: move vmlinux.o rule to the top Makefile
>       kbuild: unify two modpost invocations
>       kbuild: re-run modpost when it is updated
>       kbuild: hide error checker logs for V=1 builds
>       kbuild: use obj-y instead extra-y for objects placed at the head
>       kbuild: remove head-y syntax
>       mksysmap: update comment about __crc_*
>       kbuild: reuse mksysmap output for kallsyms
>       kallsyms: drop duplicated ignore patterns from kallsyms.c
>       kallsyms: take the input file instead of reading stdin
>       kallsyms: ignore __kstrtab_* and __kstrtabns_* symbols
>       kbuild: move modules.builtin(.modinfo) rules to Makefile.vmlinux_o
>       kbuild: rebuild .vmlinux.export.o when its prerequisite is updated
>       Revert "kbuild: Check if linker supports the -X option"
>       ia64: simplify esi object addition in Makefile
>       docs: bump minimal GNU Make version to 3.82
>
> Nick Desaulniers (1):
>       Makefile.compiler: replace cc-ifversion with compiler-specific macros
>
> Owen Rafferty (1):
>       kbuild: rewrite check-local-export in sh/awk
>
> Zeng Heng (2):
>       Kconfig: remove sym_set_choice_value
>       scripts: remove unused argument 'type'
>
>  Documentation/kbuild/makefiles.rst          |  56 ++++++++++++-----------------
>  Documentation/process/changes.rst           |   4 +--
>  Kbuild                                      |  77
> ++++++++++++++++++++++++++++++----------
>  Makefile                                    | 182
> ++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------
>  arch/alpha/Makefile                         |   2 --
>  arch/alpha/kernel/Makefile                  |   4 +--
>  arch/arc/Makefile                           |   2 --
>  arch/arc/kernel/Makefile                    |   4 +--
>  arch/arm/Makefile                           |   3 --
>  arch/arm/kernel/Makefile                    |   4 +--
>  arch/arm64/Makefile                         |   3 --
>  arch/arm64/kernel/Makefile                  |   4 +--
>  arch/csky/Makefile                          |   2 --
>  arch/csky/kernel/Makefile                   |   4 +--
>  arch/hexagon/Makefile                       |   2 --
>  arch/hexagon/kernel/Makefile                |   3 +-
>  arch/ia64/Makefile                          |   1 -
>  arch/ia64/kernel/Makefile                   |   9 ++---
>  arch/loongarch/Makefile                     |   2 --
>  arch/loongarch/kernel/Makefile              |   4 +--
>  arch/m68k/68000/Makefile                    |   2 +-
>  arch/m68k/Makefile                          |   9 -----
>  arch/m68k/coldfire/Makefile                 |   2 +-
>  arch/m68k/kernel/Makefile                   |  23 ++++++------
>  arch/microblaze/Makefile                    |   1 -
>  arch/microblaze/kernel/Makefile             |   4 +--
>  arch/mips/Makefile                          |   2 --
>  arch/mips/kernel/Makefile                   |   4 +--
>  arch/nios2/Kbuild                           |   2 ++
>  arch/nios2/Makefile                         |   5 ---
>  arch/nios2/kernel/Makefile                  |   2 +-
>  arch/openrisc/Makefile                      |   2 --
>  arch/openrisc/kernel/Makefile               |   4 +--
>  arch/parisc/Makefile                        |   2 --
>  arch/parisc/kernel/Makefile                 |   4 +--
>  arch/powerpc/Makefile                       |  12 -------
>  arch/powerpc/boot/wrapper                   |   2 +-
>  arch/powerpc/kernel/Makefile                |  20 +++++------
>  arch/riscv/Makefile                         |   2 --
>  arch/riscv/kernel/Makefile                  |   2 +-
>  arch/s390/Makefile                          |   2 --
>  arch/s390/boot/version.c                    |   1 +
>  arch/s390/kernel/Makefile                   |   4 +--
>  arch/sh/Makefile                            |   2 --
>  arch/sh/kernel/Makefile                     |   4 +--
>  arch/sparc/Makefile                         |   2 --
>  arch/sparc/kernel/Makefile                  |   3 +-
>  arch/x86/Makefile                           |   5 ---
>  arch/x86/boot/compressed/kaslr.c            |   1 +
>  arch/x86/boot/version.c                     |   1 +
>  arch/x86/kernel/Makefile                    |  10 +++---
>  arch/xtensa/Makefile                        |   2 --
>  arch/xtensa/kernel/Makefile                 |   4 +--
>  drivers/gpu/drm/amd/display/dc/dml/Makefile |   2 +-
>  include/linux/export-internal.h             |   6 ++--
>  init/.gitignore                             |   2 ++
>  init/Makefile                               |  57
> +++++++++++++++++++++---------
>  init/build-version                          |  10 ++++++
>  init/version-timestamp.c                    |  31 ++++++++++++++++
>  init/version.c                              |  37 +++++++------------
>  kernel/gen_kheaders.sh                      |   6 ++--
>  lib/Kconfig                                 |   8 +++--
>  lib/zstd/Makefile                           |  16 ++++-----
>  lib/zstd/common/entropy_common.c            |   5 ++-
>  lib/zstd/common/zstd_common.c               |  10 ++++++
>  scripts/Kbuild.include                      |  23 +++++++++++-
>  scripts/Makefile.build                      |  56 +++++++++--------------------
>  scripts/Makefile.compiler                   |  10 ++++--
>  scripts/Makefile.extrawarn                  |   4 +--
>  scripts/Makefile.lib                        |  33 +++++++++--------
>  scripts/Makefile.modfinal                   |   2 +-
>  scripts/Makefile.modpost                    | 114
> +++++++++++++++++++++++++++--------------------------------
>  scripts/Makefile.package                    |   5 ++-
>  scripts/Makefile.vmlinux                    |  21 ++++++++++-
>  scripts/Makefile.vmlinux_o                  |  47 +++++++++++++++++--------
>  scripts/asn1_compiler.c                     |   6 ++--
>  scripts/atomic/check-atomics.sh             |  33 -----------------
>  scripts/check-local-export                  |  97
> +++++++++++++++++++++++++-------------------------
>  scripts/clang-tools/gen_compile_commands.py |  19 +---------
>  scripts/head-object-list.txt                |  53 ++++++++++++++++++++++++++++
>  scripts/kallsyms.c                          |  54 +++++++++++++++++-----------
>  scripts/kconfig/conf.c                      |   2 +-
>  scripts/kconfig/lkc.h                       |   5 ---
>  scripts/link-vmlinux.sh                     |  72
> +++++++------------------------------
>  scripts/mkcompile_h                         |  96
> ++++++--------------------------------------------
>  scripts/mksysmap                            |  24 ++++++++++---
>  scripts/package/mkspec                      |   4 +--
>  87 files changed, 727 insertions(+), 762 deletions(-)
>  create mode 100644 init/.gitignore
>  create mode 100755 init/build-version
>  create mode 100644 init/version-timestamp.c
>  delete mode 100755 scripts/atomic/check-atomics.sh
>  create mode 100644 scripts/head-object-list.txt



--
Best Regards
Masahiro Yamada
