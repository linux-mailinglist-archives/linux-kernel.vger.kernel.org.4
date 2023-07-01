Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8892274481C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 11:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjGAJCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 05:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 05:02:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01730BC;
        Sat,  1 Jul 2023 02:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8131B60ADF;
        Sat,  1 Jul 2023 09:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9E2C433C8;
        Sat,  1 Jul 2023 09:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688202122;
        bh=ENIAoH2n3kNLaBQhcZgtrZRWpyv37Ars5g2xtqOj7KA=;
        h=From:Date:Subject:To:Cc:From;
        b=lBBgNIdeYfUshUKc+VIcMaCn15e0HNIdIEtP+QPjkbZjWMC7lxLx1PZ8Enz+EnSXI
         mjbqDwnPqo+UZLUOFjrjli+//I/xvRh1+5GPVNrV/Ux53SmrOx9t477x/MosCq0Sv5
         MtYM07H4lyR2wL8NKT+HCexMeqAP/WByQvuExdRTOnnOU/AXPo4OpZXQ8w+impgHS/
         5ALuXVLzi3dlDqPZ34kC9COlFs+VDRbYu/zlx/CacItzFJkM0FuAwBGy7Ygz/yxfCi
         jb+zlQia1ayUFXNjWt00juKmn965qP2wtA0Z+yIOD4cVS411aCkWOSHdkP7/XpczgA
         GtFntXcTrnSEw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-565d65adcf2so1305762eaf.3;
        Sat, 01 Jul 2023 02:02:02 -0700 (PDT)
X-Gm-Message-State: AC+VfDx5Tiwz6EkAS0oRMG3ySXYNQaUp+H4oBecjcCx9lg+jKJvIKHaD
        NvFcjBUBTxhp1JiYKSTPZhj4vLxlUBCcvX6cFGs=
X-Google-Smtp-Source: ACHHUZ55vPyfyaypRXktMsegI+RYyaD/WfTD3ETENwTgyt6ZB42Cp2uwWEn/OP8jWwnbiIdDWXClUgChn+6jQ6QLryQ=
X-Received: by 2002:a05:6808:309a:b0:3a1:d629:d1dd with SMTP id
 bl26-20020a056808309a00b003a1d629d1ddmr5487987oib.56.1688202122110; Sat, 01
 Jul 2023 02:02:02 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 1 Jul 2023 18:01:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQEm1K9VLuo7XqxYKnyvqfbyWKLuEVmxfex7emow7idXg@mail.gmail.com>
Message-ID: <CAK7LNAQEm1K9VLuo7XqxYKnyvqfbyWKLuEVmxfex7emow7idXg@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v6.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull Kbuild updates for v6.5-rc1.
Thank you.



The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6=
:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v6.5

for you to fetch changes up to f5983dab0ead92dc2690d147f0604a0badcac6a8:

  modpost: define more R_ARM_* for old distributions (2023-06-29 01:36:41 +=
0900)

----------------------------------------------------------------
Kbuild updates for v6.5

 - Remove the deprecated rule to build *.dtbo from *.dts

 - Refactor section mismatch detection in modpost

 - Fix bogus ARM section mismatch detections

 - Fix error of 'make gtags' with O=3D option

 - Add Clang's target triple to KBUILD_CPPFLAGS to fix a build error with
   the latest LLVM version

 - Rebuild the built-in initrd when KBUILD_BUILD_TIMESTAMP is changed

 - Ignore more compiler-generated symbols for kallsyms

 - Fix 'make local*config' to handle the ${CONFIG_FOO} form in Makefiles

 - Enable more kernel-doc warnings with W=3D2

 - Refactor <linux/export.h> by generating KSYMTAB data by modpost

 - Deprecate <asm/export.h> and <asm-generic/export.h>

 - Remove the EXPORT_DATA_SYMBOL macro

 - Move the check for static EXPORT_SYMBOL back to modpost, which makes
   the build faster

 - Re-implement CONFIG_TRIM_UNUSED_KSYMS with one-pass algorithm

 - Warn missing MODULE_DESCRIPTION when building modules with W=3D1

 - Make 'make clean' robust against too long argument error

 - Exclude more objects from GCOV to fix CFI failures with GCOV

 - Allow 'make modules_install' to install modules.builtin and
   modules.builtin.modinfo even when CONFIG_MODULES is disabled

 - Include modules.builtin and modules.builtin.modinfo in the linux-image
   Debian package even when CONFIG_MODULES is disabled

 - Revive "Entering directory" logging for the latest Make version

----------------------------------------------------------------
Ahmed S. Darwish (2):
      scripts/tags.sh: Resolve gtags empty index generation
      docs: Set minimal gtags / GNU GLOBAL version to 6.6.5

Andrew Davis (1):
      kbuild: Disallow DTB overlays to built from .dts named source files

Benjamin Gray (1):
      initramfs: Encode dependency on KBUILD_BUILD_TIMESTAMP

Dan Carpenter (1):
      modpost: fix off by one in is_executable_section()

Jiri Slaby (1):
      streamline_config.pl: handle also ${CONFIG_FOO}

Johannes Berg (2):
      kernel-doc: don't let V=3D1 change outcome
      kbuild: enable kernel-doc -Wall for W=3D2

Josh Triplett (1):
      kbuild: builddeb: always make modules_install, to install modules.bui=
ltin*

Masahiro Yamada (53):
      modpost: error out if addend_*_rel() is not implemented for REL arch
      modpost: remove broken calculation of exception_table_entry size
      modpost: remove fromsym info in __ex_table section mismatch warning
      modpost: remove get_prettyname()
      modpost: squash report_extable_warnings() into extable_mismatch_handl=
er()
      modpost: squash report_sec_mismatch() into default_mismatch_handler()
      modpost: clean up is_executable_section()
      modpost: squash extable_mismatch_handler() into default_mismatch_hand=
ler()
      modpost: pass 'tosec' down to default_mismatch_handler()
      modpost: pass section index to find_elf_symbol2()
      modpost: rename find_elf_symbol() and find_elf_symbol2()
      Revert "kheaders: substituting --sort in archive creation"
      doc: Add tar requirement to changes.rst
      Revert "modpost: skip ELF local symbols during section mismatch check=
"
      modpost: remove unused argument from secref_whitelist()
      modpost: unify 'sym' and 'to' in default_mismatch_handler()
      modpost: replace r->r_offset, r->r_addend with faddr, taddr
      modpost: remove is_shndx_special() check from section_rel(a)
      modpost: merge fromsec=3DDATA_SECTIONS entries in sectioncheck table
      modpost: merge bad_tosec=3DALL_EXIT_SECTIONS entries in sectioncheck =
table
      modpost: remove *_sections[] arrays
      modpost: fix section mismatch message for R_ARM_ABS32
      modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}
      modpost: detect section mismatch for R_ARM_{MOVW_ABS_NC,MOVT_ABS}
      modpost: refactor find_fromsym() and find_tosym()
      modpost: detect section mismatch for R_ARM_THM_{MOVW_ABS_NC,MOVT_ABS}
      modpost: fix section_mismatch message for R_ARM_THM_{CALL,JUMP24,JUMP=
19}
      modpost: detect section mismatch for R_ARM_REL32
      kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS
      modpost: propagate W=3D1 build option to modpost
      Revert "[PATCH] uml: export symbols added by GCC hardened"
      scripts/kallsyms: constify long_options
      scripts/kallsyms: remove KSYM_NAME_LEN_BUFFER
      ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guar=
d
      modpost: pass struct module pointer to check_section_mismatch()
      kbuild: generate KSYMTAB entries by modpost
      ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
      modpost: check static EXPORT_SYMBOL* by modpost again
      modpost: squash sym_update_namespace() into sym_add_exported()
      modpost: use null string instead of NULL pointer for default namespac=
e
      kbuild: implement CONFIG_TRIM_UNUSED_KSYMS without recursion
      modpost: merge two similar section mismatch warnings
      modpost: show offset from symbol for section mismatch warnings
      linux/export.h: rename 'sec' argument to 'license'
      kbuild: make modules_install copy modules.builtin(.modinfo)
      kbuild: make clean rule robust against too long argument error
      modpost: factor out inst location calculation to section_rel()
      modpost: factor out Elf_Sym pointer calculation to section_rel()
      modpost: continue even with unknown relocation type
      kbuild: deb-pkg: remove the CONFIG_MODULES check in buildeb
      kbuild: set correct abs_srctree and abs_objtree for package builds
      kbuild: revive "Entering directory" for Make >=3D 4.4.1
      modpost: define more R_ARM_* for old distributions

Nathan Chancellor (4):
      mips: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
      powerpc/vdso: Include CLANG_FLAGS explicitly in ldflags-y
      kbuild: Add CLANG_FLAGS to as-instr
      kbuild: Add KBUILD_CPPFLAGS to as-option invocation

Pierre-Cl=C3=A9ment Tosi (3):
      scripts/mksysmap: Fix badly escaped '$'
      scripts/mksysmap: Ignore __pi_ local arm64 symbols
      scripts/mksysmap: Ignore prefixed KCFI symbols

Sami Tolvanen (2):
      kbuild: Fix CFI failures with GCOV
      kbuild: Disable GCOV for *.mod.o

Vincenzo Palazzo (1):
      script: modpost: emit a warning when the description is missing

 .gitignore                           |   2 -
 Documentation/kbuild/kbuild.rst      |   6 +
 Documentation/process/changes.rst    |  14 +
 Makefile                             |  94 +++---
 arch/arc/include/asm/linkage.h       |   8 +-
 arch/ia64/include/asm/Kbuild         |   1 +
 arch/ia64/include/asm/export.h       |   3 -
 arch/ia64/kernel/head.S              |   2 +-
 arch/ia64/kernel/ivt.S               |   2 +-
 arch/mips/Makefile                   |   2 +-
 arch/powerpc/kernel/vdso/Makefile    |   2 +-
 arch/um/os-Linux/user_syms.c         |   7 -
 include/asm-generic/export.h         |  83 +----
 include/asm-generic/vmlinux.lds.h    |   1 +
 include/linux/export-internal.h      |  49 +++
 include/linux/export.h               | 128 ++------
 include/linux/pm.h                   |  10 +-
 init/Makefile                        |   1 +
 kernel/gen_kheaders.sh               |   9 +-
 kernel/module/internal.h             |  12 +
 scripts/Makefile.build               |  31 +-
 scripts/Makefile.clang               |   3 +-
 scripts/Makefile.clean               |   4 +-
 scripts/Makefile.compiler            |   4 +-
 scripts/Makefile.lib                 |   3 -
 scripts/Makefile.modfinal            |   2 +-
 scripts/Makefile.modpost             |   8 +
 scripts/Makefile.vmlinux             |   1 +
 scripts/adjust_autoksyms.sh          |  73 -----
 scripts/basic/fixdep.c               |   3 +-
 scripts/check-local-export           |  70 ----
 scripts/gen_autoksyms.sh             |  62 ----
 scripts/gen_ksymdeps.sh              |  30 --
 scripts/kallsyms.c                   |  63 ++--
 scripts/kconfig/streamline_config.pl |   2 +-
 scripts/kernel-doc                   |  28 +-
 scripts/mksysmap                     |  10 +-
 scripts/mod/modpost.c                | 799
+++++++++++++++++++++------------------------
 scripts/mod/modpost.h                |   6 +-
 scripts/package/builddeb             |  14 +-
 scripts/remove-stale-files           |   4 +
 scripts/tags.sh                      |   9 +-
 usr/Makefile                         |   1 +
 usr/gen_initramfs.sh                 |  16 +-
 44 files changed, 673 insertions(+), 1009 deletions(-)
 delete mode 100644 arch/ia64/include/asm/export.h
 delete mode 100755 scripts/adjust_autoksyms.sh
 delete mode 100755 scripts/check-local-export
 delete mode 100755 scripts/gen_autoksyms.sh
 delete mode 100755 scripts/gen_ksymdeps.sh

--=20
Best Regards
Masahiro Yamada
