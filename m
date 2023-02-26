Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583776A32DA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBZQeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZQeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:34:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D221498E;
        Sun, 26 Feb 2023 08:34:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD35A60C39;
        Sun, 26 Feb 2023 16:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAFAC433EF;
        Sun, 26 Feb 2023 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677429242;
        bh=zgTiddkrkneIzXKuZDLDGwLq0Lyt5mykvfyzI40QIjE=;
        h=From:Date:Subject:To:Cc:From;
        b=hxu/WY6JpXELDx29xZ7Dr9FUPaJFToT4jQGsbE57/MAVpA5jWey+JE8f9qXuSN6JP
         YqIMoZta6RdpINmfHe8sW/yYKuKd1TGeQbsagmevYTDYDUpctMXvI6+OevDUbi103U
         j/9Umuh0O3Oplf4iVeMQ3pj4IERjTR3QMh55HiWMo0uFkn9PI34gEPP8LXGW9546qx
         Cu08eGkKmils04Ca0aOd3e62HizUQpuAAz3vxX9Mb86FDc2p9XKIf4jor5J9oQi/o9
         MKfwjq9bhbRY5MMGuO5lQYrgBSBZyJm6q0Z74svkvjnV+z/Ql6209gWInacHh0d62z
         t47Wx1667Y13g==
Received: by mail-oi1-f182.google.com with SMTP id s41so2694450oiw.13;
        Sun, 26 Feb 2023 08:34:02 -0800 (PST)
X-Gm-Message-State: AO0yUKU+XTYPi4tjzhjBbpe9ztAH++HOee/3xirdxXadhdauQIx9SvOE
        4osBuSv+K97o9/bnjAnOLl3TF/vNGwJMD1iqNSY=
X-Google-Smtp-Source: AK7set8UD9qs7iEywzHAMl1N5fCEDRgRB4DQkJwJ/fhakO1uB4qvxIrbWE8MNYW39Qle8jn+FVfDWyElhGpPumBirmU=
X-Received: by 2002:a05:6808:90c:b0:384:2018:571c with SMTP id
 w12-20020a056808090c00b003842018571cmr968633oih.8.1677429241269; Sun, 26 Feb
 2023 08:34:01 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 27 Feb 2023 01:33:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNATJ-3JQ0QQGQ5R+R8aBJEq-tmBL8iBZrbM_4t0zeoYTaw@mail.gmail.com>
Message-ID: <CAK7LNATJ-3JQ0QQGQ5R+R8aBJEq-tmBL8iBZrbM_4t0zeoYTaw@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull Kbuild updates for v6.3-rc1.

Thank you






The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65=
:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v6.3

for you to fetch changes up to 7adf14d8aca1ea53bf9ccf8463809c82adb8c23a:

  kbuild: rpm-pkg: remove unneeded KERNELRELEASE from
modules/headers_install (2023-02-26 16:54:12 +0900)

----------------------------------------------------------------
Kbuild updates for v6.3

 - Change V=3D1 option to print both short log and full command log.

 - Allow V=3D1 and V=3D2 to be combined as V=3D12.

 - Make W=3D1 detect wrong .gitignore files.

 - Tree-wide cleanups for unused command line arguments passed to Clang.

 - Stop using -Qunused-arguments with Clang.

 - Make scripts/setlocalversion handle only correct release tags instead
   of any arbitrary annotated tag.

 - Create Debian and RPM source packages without cleaning the source tree.

 - Various cleanups for packaging.

----------------------------------------------------------------
Bastian Germann (1):
      builddeb: clean generated package content

Carlos Llamas (1):
      kbuild: fix trivial typo in comment

Jani Nikula (6):
      MAINTAINERS: fix kbuild repo branch
      docs/kbuild/makefiles: fix header underline
      docs/kbuild/makefiles: throw out the local table of contents
      docs/kbuild/makefiles: drop section numbering, use references
      docs/kbuild/makefiles: clean up indentation and whitespace
      docs/kbuild/makefiles: unify quoting

Masahiro Yamada (46):
      kbuild: refactor silent mode detection
      kbuild: print short log in addition to the whole command with V=3D1
      kbuild: do not print extra logs for V=3D2
      kbuild: allow to combine multiple V=3D levels
      kbuild: drop V=3D0 support
      kbuild: clean up stale file removal
      .gitignore: update the command to check tracked files being ignored
      kbuild: make W=3D1 warn files that are tracked but ignored by git
      kbuild: rename cmd_$@ to savedcmd_$@ in *.cmd files
      kbuild: add more comments for KBUILD_NOCMDDEP=3D1
      kbuild: unify cmd_dt_S_dtb and cmd_dt_S_dtbo
      kbuild: refactor host*_flags
      kbuild: specify output names separately for each emission type from r=
ustc
      fixdep: parse Makefile more correctly to handle comments etc.
      kbuild: remove sed commands after rustc rules
      fixdep: refactor hash table lookup
      fixdep: avoid parsing the same file over again
      fixdep: do not parse *.rlib, *.rmeta, *.so
      kbuild: rust: move rust/target.json to scripts/
      kbuild: replace $(dot-target).tmp in filechk with $(tmp-target)
      scripts: handle BrokenPipeError for python scripts
      scripts: remove bin2c
      kbuild: do not put .scmversion into the source tarball
      setlocalversion: simplify the construction of the short version
      setlocalversion: make indentation shallower
      setlocalversion: absorb $(KERNELVERSION)
      kbuild: save overridden KERNELRELEASE in include/config/kernel.releas=
e
      kbuild: deb-pkg: add --source-option=3D-sP
      kbuild: do not automatically add -w option to modpost
      kbuild: remove --include-dir MAKEFLAG from top Makefile
      .gitignore: ignore *.cover and *.mbx
      setlocalversion: clean up the construction of version output
      setlocalversion: use only the correct release tag for git-describe
      kbuild: add a tool to list files ignored by git
      kbuild: deb-pkg: create source package without cleaning
      kbuild: rpm-pkg: build binary packages from source rpm
      kbuild: srcrpm-pkg: create source package without cleaning
      kbuild: deb-pkg: hide KDEB_SOURCENAME from Makefile
      kbuild: deb-pkg: make .orig tarball a hard link if possible
      kbuild: deb-pkg: switch over to source format 3.0 (quilt)
      kbuild: make perf-tar*-src-pkg work without relying on git
      kbuild: tar-pkg: use tar rules in scripts/Makefile.package
      kbuild: deb-pkg: fix binary-arch and clean in debian/rules
      kbuild: deb-pkg: improve the usability of source package
      .gitattributes: use 'dts' diff driver for *.dtso files
      kbuild: rpm-pkg: remove unneeded KERNELRELEASE from
modules/headers_install

Nathan Chancellor (13):
      MIPS: Always use -Wa,-msoft-float and eliminate GAS_HAS_SET_HARDFLOAT
      MIPS: Prefer cc-option for additions to cflags
      powerpc: Remove linker flag from KBUILD_AFLAGS
      powerpc/vdso: Remove unused '-s' flag from ASFLAGS
      powerpc/vdso: Improve linker flags
      powerpc/vdso: Remove an unsupported flag from vgettimeofday-32.o
with clang
      s390/vdso: Drop unused '-s' flag from KBUILD_AFLAGS_64
      s390/vdso: Drop '-shared' from KBUILD_CFLAGS_64
      s390/purgatory: Remove unused '-MD' and unnecessary '-c' flags
      drm/amd/display: Do not add '-mhard-float' to dml_ccflags for clang
      kbuild: Turn a couple more of clang's unused option warnings into err=
ors
      kbuild: Stop using '-Qunused-arguments' with clang
      powerpc/vdso: Filter clang's auto var init zero enabler when linking

Nick Desaulniers (3):
      x86/boot/compressed: prefer cc-option for CFLAGS additions
      kbuild: Update assembler calls to use proper flags and language targe=
t
      Documentation/llvm: add Chimera Linux, Google and Meta datacenters

Sangmoon Kim (1):
      docs: kbuild: remove description of KBUILD_LDS_MODULE

Sven Joachim (1):
      builddeb: Consolidate consecutive chmod calls into one

Thomas Wei=C3=9Fschuh (2):
      kbuild: also delete temporary directories
      kheaders: use standard naming for the temporary directory

 .gitattributes                              |    8 +-
 .gitignore                                  |    4 +-
 Documentation/Makefile                      |    2 +-
 Documentation/dontdiff                      |    1 -
 Documentation/kbuild/llvm.rst               |   15 +-
 Documentation/kbuild/makefiles.rst          | 2144
+++++++++++++++++------------------
 MAINTAINERS                                 |    2 +-
 Makefile                                    |   93 +-
 arch/arm/mach-s3c/Makefile                  |    4 +-
 arch/ia64/kernel/Makefile                   |    2 +-
 arch/mips/Kbuild                            |    2 +-
 arch/mips/Makefile                          |   13 +-
 arch/mips/Makefile.postlink                 |    2 +-
 arch/mips/include/asm/asmmacro-32.h         |    4 +-
 arch/mips/include/asm/asmmacro.h            |   42 +-
 arch/mips/include/asm/fpregdef.h            |   14 -
 arch/mips/include/asm/mipsregs.h            |   20 +-
 arch/mips/kernel/genex.S                    |    2 +-
 arch/mips/kernel/r2300_fpu.S                |    4 +-
 arch/mips/kernel/r4k_fpu.S                  |   12 +-
 arch/mips/kvm/fpu.S                         |    6 +-
 arch/mips/loongson2ef/Platform              |    2 +-
 arch/powerpc/Makefile                       |    2 +-
 arch/powerpc/Makefile.postlink              |    2 +-
 arch/powerpc/kernel/prom_init_check.sh      |    9 +-
 arch/powerpc/kernel/vdso/Makefile           |   27 +-
 arch/s390/kernel/vdso64/Makefile            |    4 +-
 arch/s390/purgatory/Makefile                |    2 +-
 arch/sh/boot/compressed/Makefile            |    7 -
 arch/um/drivers/Makefile                    |    2 +-
 arch/um/kernel/Makefile                     |    2 +-
 arch/um/kernel/skas/Makefile                |    2 +-
 arch/um/os-Linux/Makefile                   |    2 +-
 arch/um/os-Linux/drivers/Makefile           |    2 +-
 arch/um/os-Linux/skas/Makefile              |    2 +-
 arch/x86/Makefile.um                        |    2 +-
 arch/x86/boot/compressed/Makefile           |    2 +-
 arch/x86/tools/Makefile                     |    2 +-
 arch/x86/um/Makefile                        |    2 +-
 arch/x86/um/os-Linux/Makefile               |    2 +-
 certs/extract-cert.c                        |    9 +-
 drivers/Makefile                            |    5 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile |    3 +-
 fs/hostfs/Makefile                          |    2 +-
 init/Kconfig                                |    4 -
 kernel/gen_kheaders.sh                      |    2 +-
 rust/.gitignore                             |    1 -
 rust/Makefile                               |   27 +-
 scripts/.gitignore                          |    3 +-
 scripts/Kbuild.include                      |   50 +-
 scripts/Kconfig.include                     |    2 +-
 scripts/Makefile                            |   11 +-
 scripts/Makefile.build                      |   26 +-
 scripts/Makefile.clang                      |    2 +
 scripts/Makefile.compiler                   |    8 +-
 scripts/Makefile.host                       |   24 +-
 scripts/Makefile.lib                        |   45 +-
 scripts/Makefile.modfinal                   |    2 +-
 scripts/Makefile.modpost                    |    8 +-
 scripts/Makefile.package                    |  241 ++--
 scripts/as-version.sh                       |    2 +-
 scripts/asn1_compiler.c                     |    4 +-
 scripts/basic/fixdep.c                      |  238 ++--
 scripts/bin2c.c                             |   36 -
 scripts/checkkconfigsymbols.py              |   13 +-
 scripts/clang-tools/gen_compile_commands.py |    2 +-
 scripts/clang-tools/run-clang-tools.py      |   21 +-
 scripts/diffconfig                          |   16 +-
 scripts/kernel-doc                          |    4 +-
 scripts/list-gitignored.c                   | 1057 +++++++++++++++++
 scripts/misc-check                          |   19 +
 scripts/package/builddeb                    |    8 +-
 scripts/package/buildtar                    |   52 +-
 scripts/package/deb-build-option            |   16 +
 scripts/package/mkdebian                    |   40 +-
 scripts/package/mkspec                      |   12 +-
 scripts/remove-stale-files                  |   30 +-
 scripts/setlocalversion                     |  132 +--
 scripts/tags.sh                             |    2 +-
 79 files changed, 2874 insertions(+), 1778 deletions(-)
 delete mode 100644 scripts/bin2c.c
 create mode 100644 scripts/list-gitignored.c
 create mode 100755 scripts/misc-check
 create mode 100755 scripts/package/deb-build-option
