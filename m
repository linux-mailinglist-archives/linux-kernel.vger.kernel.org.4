Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110AD64FC3A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 21:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiLQUY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 15:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLQUY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 15:24:56 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257CF11A3B;
        Sat, 17 Dec 2022 12:24:55 -0800 (PST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2BHKOaQd021483;
        Sun, 18 Dec 2022 05:24:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2BHKOaQd021483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1671308677;
        bh=12Z45VhByhhHvXxa3z2C0y4e5fHfFmaFNtxkKKhzxMw=;
        h=From:Date:Subject:To:Cc:From;
        b=VLavnf2F4FZIZ0FfnDbeFKeIn0o2K/Nfw6n/GuUaB13o7VeEeEtYxVykkzBkdzqjz
         kX/5wBmF6jbG3cgdNds59Jyf8BLnPLQYDBWcPmomdFD5ESFNqZQgr12mSl7IAW3q+p
         3LlvTOF1+Sog5ofJvUNNQo7oH8qVUNuDKIwK0P9PL5CwYAK2eQi5t670mIQTiiBnTq
         AtbSMzycN5F06x9bHV1I9adujvabv96l5+c2zQEUOBn2ZeM2csKlWoNL76CcBlUQhj
         L2iJTFxTcnLwHPouJ+DXb2Ptto4qoerr69rn+KSrumlkCpvSf4gqaTX7NG90Bv2LuS
         ztKreKyG2heqg==
X-Nifty-SrcIP: [209.85.210.53]
Received: by mail-ot1-f53.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so3333107otp.9;
        Sat, 17 Dec 2022 12:24:36 -0800 (PST)
X-Gm-Message-State: ANoB5pkT1kXihWiETh9n5xuikEesWN+NuvWpXN1QryxZmpM7XVKUwxXf
        BZP+v6MYFjgudOQoQ+UcfOLrlWhpBG9JYWjxTfU=
X-Google-Smtp-Source: AA0mqf5HlAF82+p3X/JOEHhuKbDPs057KoLCu3aB0jlbDPD+7gWrbjwmLiiwBIh5cMuy5bjYg6/Cctk2Z5h2QCpM20s=
X-Received: by 2002:a9d:282:0:b0:66c:794e:f8c6 with SMTP id
 2-20020a9d0282000000b0066c794ef8c6mr50268414otl.343.1671308675774; Sat, 17
 Dec 2022 12:24:35 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 18 Dec 2022 05:23:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR5JSqfOZ1WCHHPtjAQTOGiwpPEqshCheXrj7WSW1fMxg@mail.gmail.com>
Message-ID: <CAK7LNAR5JSqfOZ1WCHHPtjAQTOGiwpPEqshCheXrj7WSW1fMxg@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v6.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,


Please pull Kbuild updates for v6.2-rc1.
Thank you.







The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8=
:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v6.2

for you to fetch changes up to 731c4eac848ff9dd42776da8ed3407b257e3abf0:

  buildtar: fix tarballs with EFI_ZBOOT enabled (2022-12-17 21:55:04 +0900)

----------------------------------------------------------------
Kbuild updates for v6.2

 - Support zstd-compressed debug info

 - Allow W=3D1 builds to detect objects shared among multiple modules

 - Add srcrpm-pkg target to generate a source RPM package

 - Make the -s option detection work for future GNU Make versions

 - Add -Werror to KBUILD_CPPFLAGS when CONFIG_WERROR=3Dy

 - Allow W=3D1 builds to detect -Wundef warnings in any preprocessed files

 - Raise the minimum supported version of binutils to 2.25

 - Use $(intcmp ...) to compare integers if GNU Make >=3D 4.4 is used

 - Use $(file ...) to read a file if GNU Make >=3D 4.2 is used

 - Print error if GNU Make older than 3.82 is used

 - Allow modpost to detect section mismatches with Clang LTO

 - Include vmlinuz.efi into kernel tarballs for arm64 CONFIG_EFI_ZBOOT=3Dy

----------------------------------------------------------------
Andy Shevchenko (1):
      modpost: Mark uuid_le type to be suitable only for MEI

Dmitry Goncharov (1):
      kbuild: Port silent mode detection to future gnu make.

Geert Uytterhoeven (1):
      modpost: Join broken long printed messages

Ivan Vecera (1):
      kbuild: add ability to make source rpm buildable using koji

KaiLong Wang (1):
      modpost: fix array_size.cocci warning

Masahiro Yamada (18):
      kconfig: remove unneeded variable in get_prompt_str()
      kconfig: remove const qualifier from str_get()
      kconfig: remove redundant (void *) cast in search_conf()
      scripts/jobserver-exec: parse the last --jobserver-auth=3D option
      kbuild: deb-pkg: get rid of |flex:native workaround from Build-Depend=
s
      kbuild: add kbuild-file macro
      kbuild: warn objects shared among multiple modules
      kbuild: move -Werror from KBUILD_CFLAGS to KBUILD_CPPFLAGS
      kbuild: add -Wundef to KBUILD_CPPFLAGS for W=3D1 builds
      Documentation: raise minimum supported version of binutils to 2.25
      kbuild: add test-{ge,gt,le,lt} macros
      kbuild: do not sort after reading modules.order
      kbuild: add read-file macro
      kconfig: refactor Makefile to reduce process forks
      kbuild: use .NOTINTERMEDIATE for future GNU Make versions
      kbuild: change module.order to list *.o instead of *.ko
      kbuild: refactor the prerequisites of the modpost rule
      kbuild: ensure Make >=3D 3.82 is used

Nathan Chancellor (2):
      padata: Mark padata_work_init() as __ref
      modpost: Include '.text.*' in TEXT_SECTIONS

Nick Desaulniers (1):
      Makefile.debug: support for -gz=3Dzstd

Thomas Wei=C3=9Fschuh (2):
      firmware_loader: remove #include <generated/utsrelease.h>
      init/version.c: remove #include <generated/utsrelease.h>

Veronika Kabatova (1):
      buildtar: fix tarballs with EFI_ZBOOT enabled

 Documentation/process/changes.rst           |  4 ++--
 Makefile                                    | 26 +++++++++++++++++------
 arch/riscv/Makefile                         |  2 +-
 arch/x86/Makefile                           |  2 +-
 drivers/base/firmware_loader/firmware.h     |  2 --
 init/version.c                              |  1 -
 kernel/padata.c                             | 12 +++++++++--
 lib/Kconfig.debug                           | 29 +++++++++++++++++++++++--
 scripts/Kbuild.include                      | 48
+++++++++++++++++++++++++++++++++++++++---
 scripts/Makefile.asm-generic                |  6 +++---
 scripts/Makefile.build                      | 14 ++++++------
 scripts/Makefile.clean                      |  5 +----
 scripts/Makefile.compiler                   |  4 ++--
 scripts/Makefile.debug                      |  6 +++++-
 scripts/Makefile.dtbinst                    |  2 +-
 scripts/Makefile.extrawarn                  |  1 +
 scripts/Makefile.modfinal                   |  8 +++----
 scripts/Makefile.modinst                    |  4 ++--
 scripts/Makefile.modpost                    | 41
+++++++++++++++++++++++-------------
 scripts/Makefile.package                    | 10 +++++++++
 scripts/clang-tools/gen_compile_commands.py |  8 +++----
 scripts/gen_autoksyms.sh                    |  2 +-
 scripts/jobserver-exec                      |  4 +++-
 scripts/kconfig/.gitignore                  |  4 +++-
 scripts/kconfig/Makefile                    | 45
+++++++++++++++++++++------------------
 scripts/kconfig/gconf-cfg.sh                |  7 ++++--
 scripts/kconfig/lkc.h                       |  2 +-
 scripts/kconfig/mconf-cfg.sh                | 25 ++++++++++++----------
 scripts/kconfig/mconf.c                     |  5 ++---
 scripts/kconfig/menu.c                      |  4 +---
 scripts/kconfig/nconf-cfg.sh                | 23 +++++++++++---------
 scripts/kconfig/qconf-cfg.sh                | 10 ++++++---
 scripts/kconfig/util.c                      |  2 +-
 scripts/min-tool-version.sh                 |  2 +-
 scripts/mod/file2alias.c                    | 30 +++++++++++++------------=
-
 scripts/mod/modpost.c                       | 23 ++++++++------------
 scripts/mod/sumversion.c                    |  4 ++--
 scripts/modules-check.sh                    |  2 +-
 scripts/package/buildtar                    |  2 +-
 scripts/package/mkdebian                    |  2 +-
 scripts/package/mkspec                      |  7 ++++++
 scripts/remove-stale-files                  |  2 ++
 42 files changed, 286 insertions(+), 156 deletions(-)


--=20
Best Regards
Masahiro Yamada
