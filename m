Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF45F699A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJFOaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJFOam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:30:42 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4257B5A80C;
        Thu,  6 Oct 2022 07:30:40 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 296EUPkr008936;
        Thu, 6 Oct 2022 23:30:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 296EUPkr008936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665066626;
        bh=TK+umV2EaNY4IsnZrjREEh7rfcv1+HLHaKTsQSOX7J4=;
        h=From:Date:Subject:To:Cc:From;
        b=Ay2AXeX+3ZFo3599NVSK+5uf+wMPADKa2LGHi2PYF+GOOzmBULd9XgKZMOC9P96Fc
         0y2aZglYyPPtu4bpRjuV1JnPDQXHYvR3W37dCAMQC7nybMNVrjOMimGU6u2aXCBGor
         s94MEFDBTw2IksNmoawDbzR/pR8BPJlV+KImAFmkAn+dGtAqRJtHCp1V+pe7sTd0G8
         eyih6JUVLktMBuN4PoLd09Yp5+PDOyE4DtA7+FO77ME1FSQDMebc7m0yk7XyvIfl/1
         nsaCRzEJy5vPv8E4WnAhTzA7jMzWZQ7dS2oJn33AucF6hviS17e/G6Dh/Etu8eZBNB
         TohZAvDmbMRXg==
X-Nifty-SrcIP: [209.85.208.171]
Received: by mail-lj1-f171.google.com with SMTP id a12so2436608ljr.7;
        Thu, 06 Oct 2022 07:30:25 -0700 (PDT)
X-Gm-Message-State: ACrzQf1+0dB/bOkG7ecPHFtj6jDXpEMrTprHmuPpVQPBgzGA0WMskz+X
        8JP12gwQUtdHsQlXPa1sQTlueZulUvwXplf5oqg=
X-Google-Smtp-Source: AMsMyM7LfKUqxGCKvCosFzR98my2GjPf41o0awZNfdFTlrURAAkigziuF6wPYqviR0i73dz1wnLPBR07nq0PNH71OLk=
X-Received: by 2002:a05:651c:242:b0:26d:fb4b:9c8 with SMTP id
 x2-20020a05651c024200b0026dfb4b09c8mr1878616ljn.353.1665066624215; Thu, 06
 Oct 2022 07:30:24 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 6 Oct 2022 23:29:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzGEiQfPTaLmhG4k7VAwB5yznd-VqWdJHEF2YjgSQTcA@mail.gmail.com>
Message-ID: <CAK7LNASzGEiQfPTaLmhG4k7VAwB5yznd-VqWdJHEF2YjgSQTcA@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000aa059305ea5e88d6"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000aa059305ea5e88d6
Content-Type: text/plain; charset="UTF-8"

Hello Linus,

Please pull Kbuild updates for v6.1-rc1.


I attached my resolutions of the merge conflicts.
(attachment: merge-resolution.diff)

You can find a similar resolution in next-20221005.

A slight difference is that, I inserted

  obj-$(CONFIG_RUST)      += rust/

right after

  obj-$(CONFIG_IO_URING)  += io_uring/

This is the right order to keep the current link order.


Thank you.




The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v6.1

for you to fetch changes up to 0715fdb03e2c4f5748d245a231e422602ed29f33:

  docs: bump minimal GNU Make version to 3.82 (2022-10-06 09:16:21 +0900)

----------------------------------------------------------------
Kbuild updates for v6.1

 - Remove potentially incomplete targets when Kbuid is interrupted by
   SIGINT etc. in case GNU Make may miss to do that when stderr is piped
   to another program.

 - Rewrite the single target build so it works more correctly.

 - Fix rpm-pkg builds with V=1.

 - List top-level subdirectories in ./Kbuild.

 - Ignore auto-generated __kstrtab_* and __kstrtabns_* symbols in kallsyms.

 - Avoid two different modules in lib/zstd/ having shared code, which
   potentially causes building the common code as build-in and modular
   back-and-forth.

 - Unify two modpost invocations to optimize the build process.

 - Remove head-y syntax in favor of linker scripts for placing particular
   sections in the head of vmlinux.

 - Bump the minimal GNU Make version to 3.82.

 - Clean up misc Makefiles and scripts.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      zstd: Fixing mixed module-builtin objects

Janis Schoetterl-Glausch (1):
      kbuild: rpm-pkg: fix breakage when V=1 is used

Masahiro Yamada (35):
      kbuild: remove the target in signal traps when interrupted
      kbuild: add phony targets to ./Kbuild
      kbuild: hard-code KBUILD_ALLDIRS in scripts/Makefile.package
      kbuild: check sha1sum just once for each atomic header
      kbuild: do not deduplicate modules.order
      nios2: move core-y in arch/nios2/Makefile to arch/nios2/Kbuild
      kbuild: remove duplicated dependency between modules and modules_check
      kbuild: refactor single builds of *.ko
      kbuild: move 'PHONY += modules_prepare' to the common part
      init/version.c: remove #include <linux/version.h>
      kbuild: build init/built-in.a just once
      kbuild: generate include/generated/compile.h in top Makefile
      scripts/mkcompile_h: move LC_ALL=C to '$LD -v'
      Revert "kbuild: Make scripts/compile.h when sh != bash"
      kbuild: fix and refactor single target build
      kbuild: use objtool-args-y to clean up objtool arguments
      linux/export: use inline assembler to populate symbol CRCs
      kbuild: list sub-directories in ./Kbuild
      kbuild: move .vmlinux.objs rule to Makefile.modpost
      kbuild: move vmlinux.o rule to the top Makefile
      kbuild: unify two modpost invocations
      kbuild: re-run modpost when it is updated
      kbuild: hide error checker logs for V=1 builds
      kbuild: use obj-y instead extra-y for objects placed at the head
      kbuild: remove head-y syntax
      mksysmap: update comment about __crc_*
      kbuild: reuse mksysmap output for kallsyms
      kallsyms: drop duplicated ignore patterns from kallsyms.c
      kallsyms: take the input file instead of reading stdin
      kallsyms: ignore __kstrtab_* and __kstrtabns_* symbols
      kbuild: move modules.builtin(.modinfo) rules to Makefile.vmlinux_o
      kbuild: rebuild .vmlinux.export.o when its prerequisite is updated
      Revert "kbuild: Check if linker supports the -X option"
      ia64: simplify esi object addition in Makefile
      docs: bump minimal GNU Make version to 3.82

Nick Desaulniers (1):
      Makefile.compiler: replace cc-ifversion with compiler-specific macros

Owen Rafferty (1):
      kbuild: rewrite check-local-export in sh/awk

Zeng Heng (2):
      Kconfig: remove sym_set_choice_value
      scripts: remove unused argument 'type'

 Documentation/kbuild/makefiles.rst          |  56 ++++++++++++-----------------
 Documentation/process/changes.rst           |   4 +--
 Kbuild                                      |  77
++++++++++++++++++++++++++++++----------
 Makefile                                    | 182
++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------
 arch/alpha/Makefile                         |   2 --
 arch/alpha/kernel/Makefile                  |   4 +--
 arch/arc/Makefile                           |   2 --
 arch/arc/kernel/Makefile                    |   4 +--
 arch/arm/Makefile                           |   3 --
 arch/arm/kernel/Makefile                    |   4 +--
 arch/arm64/Makefile                         |   3 --
 arch/arm64/kernel/Makefile                  |   4 +--
 arch/csky/Makefile                          |   2 --
 arch/csky/kernel/Makefile                   |   4 +--
 arch/hexagon/Makefile                       |   2 --
 arch/hexagon/kernel/Makefile                |   3 +-
 arch/ia64/Makefile                          |   1 -
 arch/ia64/kernel/Makefile                   |   9 ++---
 arch/loongarch/Makefile                     |   2 --
 arch/loongarch/kernel/Makefile              |   4 +--
 arch/m68k/68000/Makefile                    |   2 +-
 arch/m68k/Makefile                          |   9 -----
 arch/m68k/coldfire/Makefile                 |   2 +-
 arch/m68k/kernel/Makefile                   |  23 ++++++------
 arch/microblaze/Makefile                    |   1 -
 arch/microblaze/kernel/Makefile             |   4 +--
 arch/mips/Makefile                          |   2 --
 arch/mips/kernel/Makefile                   |   4 +--
 arch/nios2/Kbuild                           |   2 ++
 arch/nios2/Makefile                         |   5 ---
 arch/nios2/kernel/Makefile                  |   2 +-
 arch/openrisc/Makefile                      |   2 --
 arch/openrisc/kernel/Makefile               |   4 +--
 arch/parisc/Makefile                        |   2 --
 arch/parisc/kernel/Makefile                 |   4 +--
 arch/powerpc/Makefile                       |  12 -------
 arch/powerpc/boot/wrapper                   |   2 +-
 arch/powerpc/kernel/Makefile                |  20 +++++------
 arch/riscv/Makefile                         |   2 --
 arch/riscv/kernel/Makefile                  |   2 +-
 arch/s390/Makefile                          |   2 --
 arch/s390/boot/version.c                    |   1 +
 arch/s390/kernel/Makefile                   |   4 +--
 arch/sh/Makefile                            |   2 --
 arch/sh/kernel/Makefile                     |   4 +--
 arch/sparc/Makefile                         |   2 --
 arch/sparc/kernel/Makefile                  |   3 +-
 arch/x86/Makefile                           |   5 ---
 arch/x86/boot/compressed/kaslr.c            |   1 +
 arch/x86/boot/version.c                     |   1 +
 arch/x86/kernel/Makefile                    |  10 +++---
 arch/xtensa/Makefile                        |   2 --
 arch/xtensa/kernel/Makefile                 |   4 +--
 drivers/gpu/drm/amd/display/dc/dml/Makefile |   2 +-
 include/linux/export-internal.h             |   6 ++--
 init/.gitignore                             |   2 ++
 init/Makefile                               |  57
+++++++++++++++++++++---------
 init/build-version                          |  10 ++++++
 init/version-timestamp.c                    |  31 ++++++++++++++++
 init/version.c                              |  37 +++++++------------
 kernel/gen_kheaders.sh                      |   6 ++--
 lib/Kconfig                                 |   8 +++--
 lib/zstd/Makefile                           |  16 ++++-----
 lib/zstd/common/entropy_common.c            |   5 ++-
 lib/zstd/common/zstd_common.c               |  10 ++++++
 scripts/Kbuild.include                      |  23 +++++++++++-
 scripts/Makefile.build                      |  56 +++++++++--------------------
 scripts/Makefile.compiler                   |  10 ++++--
 scripts/Makefile.extrawarn                  |   4 +--
 scripts/Makefile.lib                        |  33 +++++++++--------
 scripts/Makefile.modfinal                   |   2 +-
 scripts/Makefile.modpost                    | 114
+++++++++++++++++++++++++++--------------------------------
 scripts/Makefile.package                    |   5 ++-
 scripts/Makefile.vmlinux                    |  21 ++++++++++-
 scripts/Makefile.vmlinux_o                  |  47 +++++++++++++++++--------
 scripts/asn1_compiler.c                     |   6 ++--
 scripts/atomic/check-atomics.sh             |  33 -----------------
 scripts/check-local-export                  |  97
+++++++++++++++++++++++++-------------------------
 scripts/clang-tools/gen_compile_commands.py |  19 +---------
 scripts/head-object-list.txt                |  53 ++++++++++++++++++++++++++++
 scripts/kallsyms.c                          |  54 +++++++++++++++++-----------
 scripts/kconfig/conf.c                      |   2 +-
 scripts/kconfig/lkc.h                       |   5 ---
 scripts/link-vmlinux.sh                     |  72
+++++++------------------------------
 scripts/mkcompile_h                         |  96
++++++--------------------------------------------
 scripts/mksysmap                            |  24 ++++++++++---
 scripts/package/mkspec                      |   4 +--
 87 files changed, 727 insertions(+), 762 deletions(-)
 create mode 100644 init/.gitignore
 create mode 100755 init/build-version
 create mode 100644 init/version-timestamp.c
 delete mode 100755 scripts/atomic/check-atomics.sh
 create mode 100644 scripts/head-object-list.txt

--000000000000aa059305ea5e88d6
Content-Type: text/x-patch; charset="US-ASCII"; name="merge-resolution.diff"
Content-Disposition: attachment; filename="merge-resolution.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l8x5frar0>
X-Attachment-Id: f_l8x5frar0

Y29tbWl0IGUzZTQyYzk2ZmExZThmNTA0YWI0OTlmY2RjOGU0MTA4NzhiOTgzYjYKTWVyZ2U6IDgz
MzQ3N2ZjZTdhMSAwNzE1ZmRiMDNlMmMKQXV0aG9yOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJv
eUBrZXJuZWwub3JnPgpEYXRlOiAgIFRodSBPY3QgNiAxMTowMzo1NiAyMDIyICswOTAwCgogICAg
TWVyZ2UgYnJhbmNoICdrYnVpbGQnIG9mIC4uLy4uL3dvcmtzcGFjZS9saW51eC1rYnVpbGQgaW50
byBtZXJnZS10ZXN0CgpkaWZmIC0tY2MgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NoYW5nZXMucnN0
CmluZGV4IDlhOTAxOTc5ODlkZCwyNmE3ZmQ4NzVjZmEuLjk4NDRjYTNhNzFhNgotLS0gYS9Eb2N1
bWVudGF0aW9uL3Byb2Nlc3MvY2hhbmdlcy5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi9wcm9jZXNz
L2NoYW5nZXMucnN0CkBAQCAtMzEsOSAtMzEsNyArMzEsOSBAQEAgeW91IHByb2JhYmx5IG5lZWRu
J3QgY29uY2VybiB5b3Vyc2VsZiB3CiAgPT09PT09PT09PT09PT09PT09PT09PSA9PT09PT09PT09
PT09PT0gID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICBHTlUgQyAg
ICAgICAgICAgICAgICAgIDUuMSAgICAgICAgICAgICAgZ2NjIC0tdmVyc2lvbgogIENsYW5nL0xM
Vk0gKG9wdGlvbmFsKSAgMTEuMC4wICAgICAgICAgICBjbGFuZyAtLXZlcnNpb24KICtSdXN0IChv
cHRpb25hbCkgICAgICAgIDEuNjIuMCAgICAgICAgICAgcnVzdGMgLS12ZXJzaW9uCiArYmluZGdl
biAob3B0aW9uYWwpICAgICAwLjU2LjAgICAgICAgICAgIGJpbmRnZW4gLS12ZXJzaW9uCi0gR05V
IG1ha2UgICAgICAgICAgICAgICAzLjgxICAgICAgICAgICAgIG1ha2UgLS12ZXJzaW9uCisgR05V
IG1ha2UgICAgICAgICAgICAgICAzLjgyICAgICAgICAgICAgIG1ha2UgLS12ZXJzaW9uCiAgYmFz
aCAgICAgICAgICAgICAgICAgICA0LjIgICAgICAgICAgICAgIGJhc2ggLS12ZXJzaW9uCiAgYmlu
dXRpbHMgICAgICAgICAgICAgICAyLjIzICAgICAgICAgICAgIGxkIC12CiAgZmxleCAgICAgICAg
ICAgICAgICAgICAyLjUuMzUgICAgICAgICAgIGZsZXggLS12ZXJzaW9uCmRpZmYgLS1jYyBLYnVp
bGQKaW5kZXggZmE0NDFiOThjOWY2LDhhMzc1ODRkMWZkNi4uNDY0YjM0YTA4ZjUxCi0tLSBhL0ti
dWlsZAorKysgYi9LYnVpbGQKQEBAIC00MiwxOCAtMzksNjAgKzM5LDYxIEBAQCAkKG9mZnNldHMt
ZmlsZSk6IGFyY2gvJChTUkNBUkNIKS9rZXJuZWwKICBxdWlldF9jbWRfc3lzY2FsbHMgPSBDQUxM
ICAgICQ8CiAgICAgICAgY21kX3N5c2NhbGxzID0gJChDT05GSUdfU0hFTEwpICQ8ICQoQ0MpICQo
Y19mbGFncykgJChtaXNzaW5nX3N5c2NhbGxzX2ZsYWdzKQogIAotIG1pc3Npbmctc3lzY2FsbHM6
IHNjcmlwdHMvY2hlY2tzeXNjYWxscy5zaCAkKG9mZnNldHMtZmlsZSkgRk9SQ0UKKyBQSE9OWSAr
PSBtaXNzaW5nLXN5c2NhbGxzCisgbWlzc2luZy1zeXNjYWxsczogc2NyaXB0cy9jaGVja3N5c2Nh
bGxzLnNoICQob2Zmc2V0cy1maWxlKQogIAkkKGNhbGwgY21kLHN5c2NhbGxzKQogIAotICMjIyMj
Ci0gIyBDaGVjayBhdG9taWMgaGVhZGVycyBhcmUgdXAtdG8tZGF0ZQotIAotIGFsd2F5cy15ICs9
IG9sZC1hdG9taWNzCi0gCi0gcXVpZXRfY21kX2F0b21pY3MgPSBDQUxMICAgICQ8Ci0gICAgICAg
Y21kX2F0b21pY3MgPSAkKENPTkZJR19TSEVMTCkgJDwKLSAKLSBvbGQtYXRvbWljczogc2NyaXB0
cy9hdG9taWMvY2hlY2stYXRvbWljcy5zaCBGT1JDRQotIAkkKGNhbGwgY21kLGF0b21pY3MpCisg
IyBDaGVjayB0aGUgbWFudWFsIG1vZGlmaWNhdGlvbiBvZiBhdG9taWMgaGVhZGVycworIAorIHF1
aWV0X2NtZF9jaGVja19zaGExID0gQ0hLU0hBMSAkPAorICAgICAgIGNtZF9jaGVja19zaGExID0g
XAorIAlpZiAhIGNvbW1hbmQgLXYgc2hhMXN1bSA+L2Rldi9udWxsOyB0aGVuIFwKKyAJCWVjaG8g
Indhcm5pbmc6IGNhbm5vdCBjaGVjayB0aGUgaGVhZGVyIGR1ZSB0byBzaGExc3VtIG1pc3Npbmci
OyBcCisgCQlleGl0IDA7IFwKKyAJZmk7IFwKKyAJaWYgWyAiJCQoc2VkIC1uICckJHM6Ly8gOjpw
JyAkPCkiICE9IFwKKyAJICAgICAiJCQoc2VkICckJGQnICQ8IHwgc2hhMXN1bSB8IHNlZCAncy8g
LiovLycpIiBdOyB0aGVuIFwKKyAJCWVjaG8gImVycm9yOiAkPCBoYXMgYmVlbiBtb2RpZmllZC4i
ID4mMjsgXAorIAkJZXhpdCAxOyBcCisgCWZpOyBcCisgCXRvdWNoICRACisgCisgYXRvbWljLWNo
ZWNrcyArPSAkKGFkZHByZWZpeCAkKG9iaikvLmNoZWNrZWQtLCBcCisgCSAgYXRvbWljLWFyY2gt
ZmFsbGJhY2suaCBcCisgCSAgYXRvbWljLWluc3RydW1lbnRlZC5oIFwKKyAJICBhdG9taWMtbG9u
Zy5oKQorIAorIHRhcmdldHMgKz0gJChhdG9taWMtY2hlY2tzKQorICQoYXRvbWljLWNoZWNrcyk6
ICQob2JqKS8uY2hlY2tlZC0lOiBpbmNsdWRlL2xpbnV4L2F0b21pYy8lICBGT1JDRQorIAkkKGNh
bGwgaWZfY2hhbmdlZCxjaGVja19zaGExKQorIAorICMgQSBwaG9ueSB0YXJnZXQgdGhhdCBkZXBl
bmRzIG9uIGFsbCB0aGUgcHJlcGFyYXRpb24gdGFyZ2V0cworIAorIFBIT05ZICs9IHByZXBhcmUK
KyBwcmVwYXJlOiAkKG9mZnNldHMtZmlsZSkgbWlzc2luZy1zeXNjYWxscyAkKGF0b21pYy1jaGVj
a3MpCisgCUA6CisgCisgIyBPcmRpbmFyeSBkaXJlY3RvcnkgZGVzY2VuZGluZworICMgLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCisgCisgb2JqLXkJCQkrPSBpbml0LworIG9iai15CQkJKz0gdXNyLworIG9i
ai15CQkJKz0gYXJjaC8kKFNSQ0FSQ0gpLworIG9iai15CQkJKz0gJChBUkNIX0NPUkUpCisgb2Jq
LXkJCQkrPSBrZXJuZWwvCisgb2JqLXkJCQkrPSBjZXJ0cy8KKyBvYmoteQkJCSs9IG1tLworIG9i
ai15CQkJKz0gZnMvCisgb2JqLXkJCQkrPSBpcGMvCisgb2JqLXkJCQkrPSBzZWN1cml0eS8KKyBv
YmoteQkJCSs9IGNyeXB0by8KKyBvYmotJChDT05GSUdfQkxPQ0spCSs9IGJsb2NrLworIG9iai0k
KENPTkZJR19JT19VUklORykJKz0gaW9fdXJpbmcvCisrb2JqLSQoQ09ORklHX1JVU1QpCSs9IHJ1
c3QvCisgb2JqLXkJCQkrPSAkKEFSQ0hfTElCKQorIG9iai15CQkJKz0gZHJpdmVycy8KKyBvYmot
eQkJCSs9IHNvdW5kLworIG9iai0kKENPTkZJR19TQU1QTEVTKQkrPSBzYW1wbGVzLworIG9iai0k
KENPTkZJR19ORVQpCSs9IG5ldC8KKyBvYmoteQkJCSs9IHZpcnQvCisgb2JqLXkJCQkrPSAkKEFS
Q0hfRFJJVkVSUykKZGlmZiAtLWNjIE1ha2VmaWxlCmluZGV4IGY2NTlkMzA4NTEyMSxkN2JhMDUx
OTE0NzAuLmQ2NjE4N2Q1M2I1ZgotLS0gYS9NYWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQEAgLTUz
Niw5IC01MDEsOCArNTM2LDkgQEBAIFJVU1RGTEFHU19NT0RVTEUgCiAgQUZMQUdTX01PRFVMRSAg
ID0KICBMREZMQUdTX01PRFVMRSAgPQogIENGTEFHU19LRVJORUwJPQogK1JVU1RGTEFHU19LRVJO
RUwgPQogIEFGTEFHU19LRVJORUwJPQotIExERkxBR1Nfdm1saW51eCA9CisgZXhwb3J0IExERkxB
R1Nfdm1saW51eCA9CiAgCiAgIyBVc2UgVVNFUklOQ0xVREUgd2hlbiB5b3UgbXVzdCByZWZlcmVu
Y2UgdGhlIFVBUEkgZGlyZWN0b3JpZXMgb25seS4KICBVU0VSSU5DTFVERSAgICA6PSBcCkBAQCAt
ODYyLDExIC03ODksNyArODYxLDEwIEBAQCBLQlVJTERfQ0ZMQUdTICs9ICQoc3RhY2twLWZsYWdz
LXkKICAKICBLQlVJTERfQ0ZMQUdTLSQoQ09ORklHX1dFUlJPUikgKz0gLVdlcnJvcgogIEtCVUlM
RF9DRkxBR1MtJChDT05GSUdfQ0NfTk9fQVJSQVlfQk9VTkRTKSArPSAtV25vLWFycmF5LWJvdW5k
cwotIEtCVUlMRF9DRkxBR1MgKz0gJChLQlVJTERfQ0ZMQUdTLXkpICQoQ09ORklHX0NDX0lNUExJ
Q0lUX0ZBTExUSFJPVUdIKQogIAogK0tCVUlMRF9SVVNURkxBR1MtJChDT05GSUdfV0VSUk9SKSAr
PSAtRHdhcm5pbmdzCiArS0JVSUxEX1JVU1RGTEFHUyArPSAkKEtCVUlMRF9SVVNURkxBR1MteSkK
ICsKICBpZmRlZiBDT05GSUdfQ0NfSVNfQ0xBTkcKICBLQlVJTERfQ1BQRkxBR1MgKz0gLVF1bnVz
ZWQtYXJndW1lbnRzCiAgIyBUaGUga2VybmVsIGJ1aWxkcyB3aXRoICctc3RkPWdudTExJyBzbyB1
c2Ugb2YgR05VIGV4dGVuc2lvbnMgaXMgYWNjZXB0YWJsZS4KQEBAIC0xNTc0LDcgLTE0OTMsNyAr
MTU2Nyw4IEBAQCBlbmRpZiAjIENPTkZJR19NT0RVTEUKICAjIERpcmVjdG9yaWVzICYgZmlsZXMg
cmVtb3ZlZCB3aXRoICdtYWtlIGNsZWFuJwogIENMRUFOX0ZJTEVTICs9IGluY2x1ZGUva3N5bSB2
bWxpbnV4LnN5bXZlcnMgbW9kdWxlcy1vbmx5LnN5bXZlcnMgXAogIAkgICAgICAgbW9kdWxlcy5i
dWlsdGluIG1vZHVsZXMuYnVpbHRpbi5tb2RpbmZvIG1vZHVsZXMubnNkZXBzIFwKLSAJICAgICAg
IGNvbXBpbGVfY29tbWFuZHMuanNvbiAudGhpbmx0by1jYWNoZSBydXN0L3Rlc3QgcnVzdC9kb2MK
IC0JICAgICAgIGNvbXBpbGVfY29tbWFuZHMuanNvbiAudGhpbmx0by1jYWNoZSAudm1saW51eC5v
YmpzIC52bWxpbnV4LmV4cG9ydC5jCisrCSAgICAgICBjb21waWxlX2NvbW1hbmRzLmpzb24gLnRo
aW5sdG8tY2FjaGUgcnVzdC90ZXN0IHJ1c3QvZG9jIFwKKysJICAgICAgIC52bWxpbnV4Lm9ianMg
LnZtbGludXguZXhwb3J0LmMKICAKICAjIERpcmVjdG9yaWVzICYgZmlsZXMgcmVtb3ZlZCB3aXRo
ICdtYWtlIG1ycHJvcGVyJwogIE1SUFJPUEVSX0ZJTEVTICs9IGluY2x1ZGUvY29uZmlnIGluY2x1
ZGUvZ2VuZXJhdGVkICAgICAgICAgIFwK
--000000000000aa059305ea5e88d6--
