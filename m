Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FBA6F24A2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 14:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjD2MW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 08:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjD2MWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 08:22:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A141999;
        Sat, 29 Apr 2023 05:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BE8860B2F;
        Sat, 29 Apr 2023 12:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B03C4339B;
        Sat, 29 Apr 2023 12:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682770941;
        bh=W9MphV06cv153a0MFT+SS0DHww6j6lDa1wWHga3YdPs=;
        h=From:Date:Subject:To:Cc:From;
        b=njAQnjgglAcvLTg4U87q+tWf+vJKENvm3V0itRaeRclXX46CZKhB+JdDKZkbb9M4h
         +ZgXy3FsA5PMVSKREaraBopBrWAQYHk5x6Yo7hgPWuT1AKb9kc/b27COt9l6JIqUvX
         LTo50mSWN504XngDx+AdSKUsUaOj8qhhg1keT0IpWEcPqZzlok4OCe3wZC33HBPBrc
         dlLK5jqLBLJHcZF5LIuZpeP9iX6VIX3/d4Tna6HEHeLhG9IJmyyu03Nl1aB+jparaW
         6Au1+cQ43LD6ZAnEGVl9iTD2CsrK/xYNNxxl4NKEmJMt953eqWLAdpsqr1wCEcXOT5
         dBwVL6N2ebepg==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-38e9dfa543bso364271b6e.2;
        Sat, 29 Apr 2023 05:22:21 -0700 (PDT)
X-Gm-Message-State: AC+VfDxK9/Qowu+Udfg3OLZtK0IH1tkdwCpM/aDh6+bGALniNtbSJ9Gj
        gIjZAGyz2TogeNBo/iO2owy5Jz9f6NpS4oldtDA=
X-Google-Smtp-Source: ACHHUZ6cA41wYHVJ7L2Vf4u1CRVNe6QuRvx0aIyleYCvNVelfVwvwMUJaDQSMuGaWb+OleSuHTYT2IOEvswF+u0z5Jc=
X-Received: by 2002:a05:6808:4288:b0:387:2e2e:7b2 with SMTP id
 dq8-20020a056808428800b003872e2e07b2mr4002503oib.26.1682770940726; Sat, 29
 Apr 2023 05:22:20 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 29 Apr 2023 21:21:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-8VRCeFx64KvC7VTA8rm4ryK_PjQi=Cs+wvrer+q6QA@mail.gmail.com>
Message-ID: <CAK7LNAQ-8VRCeFx64KvC7VTA8rm4ryK_PjQi=Cs+wvrer+q6QA@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull Kbuild updates for v6.4-rc1.
Thank you.



The following changes since commit 6a8f57ae2eb07ab39a6f0ccad60c760743051026:

  Linux 6.3-rc7 (2023-04-16 15:23:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v6.4

for you to fetch changes up to 9892bd72efdc9daa7c07ca9f427ac7e5928c7704:

  kbuild: deb-pkg: specify targets in debian/rules as .PHONY
(2023-04-26 21:10:51 +0900)

----------------------------------------------------------------
Kbuild updates for v6.4

 - Refactor scripts/kallsyms to make it faster and easier to maintain

 - Clean up menuconfig

 - Provide Clang with hard-coded target triple instead of CROSS_COMPILE

 - Use -z pack-relative-relocs flags instead of --use-android-relr-tags
   for arm64 CONFIG_RELR

 - Add srcdeb-pkg target to build only a Debian source package

 - Add KDEB_SOURCE_COMPRESS option to specify the compression for a
   Debian source package

 - Misc cleanups and fixes

----------------------------------------------------------------
Arnd Bergmann (1):
      kallsyms: expand symbol name into comment for debugging

Bastian Germann (1):
      kbuild: builddeb: Eliminate debian/arch use

Fangrui Song (1):
      Makefile: use -z pack-relative-relocs

Masahiro Yamada (16):
      scripts/kallsyms: remove redundant code for omitting U and N
      scripts/mksysmap: remove comments described in nm(1)
      scripts/mksysmap: use sed with in-line comments
      scripts/kallsyms: exclude symbols generated by itself dynamically
      scripts/kallsyms: move compiler-generated symbol patterns to mksysmap
      scripts/kallsyms: change the output order
      scripts/kallsyms: decrease expand_symbol() / cleanup_symbol_name() calls
      scripts/kallsyms: update the usage in the comment block
      kconfig: menuconfig: remove OLD_NCURSES macro
      kconfig: menuconfig: remove unused M_EVENT macro
      kconfig: menuconfig: reorder functions to remove forward declarations
      kbuild: clang: do not use CROSS_COMPILE for target triple
      kbuild: add srcdeb-pkg target
      kbuild: deb-pkg: add KDEB_SOURCE_COMPRESS to specify source compression
      kbuild: rpm-pkg: remove kernel-drm PROVIDES
      kbuild: deb-pkg: specify targets in debian/rules as .PHONY

Randy Dunlap (1):
      sparc: unify sparc32/sparc64 archhelp

 Makefile                           |   3 +-
 arch/sparc/Makefile                |  15 +-
 scripts/Makefile.clang             |   8 +-
 scripts/Makefile.package           |  61 +++++--
 scripts/kallsyms.c                 | 229 ++++++++----------------
 scripts/kconfig/lxdialog/dialog.h  |  27 ---
 scripts/kconfig/lxdialog/menubox.c |   8 -
 scripts/kconfig/lxdialog/textbox.c | 267 +++++++++++++---------------
 scripts/kconfig/mconf.c            | 314 ++++++++++++++++-----------------
 scripts/link-vmlinux.sh            |   6 +-
 scripts/mksysmap                   | 135 +++++++++-----
 scripts/package/builddeb           |   2 +-
 scripts/package/mkdebian           |   2 +
 scripts/package/mkspec             |   7 +-
 scripts/tools-support-relr.sh      |   8 +-
 15 files changed, 510 insertions(+), 582 deletions(-)


--
Best Regards
Masahiro Yamada
