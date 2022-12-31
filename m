Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1165A4A0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiLaNXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiLaNXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:23:35 -0500
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A68B4A3;
        Sat, 31 Dec 2022 05:23:33 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2BVDNC0T024452;
        Sat, 31 Dec 2022 22:23:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2BVDNC0T024452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672492993;
        bh=hA5JdMstmYILZuTW3S9yvFg3QCQeMln5UE4GkP/2L6g=;
        h=From:Date:Subject:To:Cc:From;
        b=sNdPxAJdaC1SeWjuMYNaD1mdVNytr2PsZg2rMt8KUnYJ2WqGIdPnaQszY2a929ZJt
         CfJfT4PDKr4+AWXmtZg4DMcYQqV6rTG5lyL1XPK+mFXF2iXRiSVqPUHqZJBd7dDJn9
         4TdOyosaSuRGZbgm6k7ovmEX9lC+PCshyI09CDYt3x6KuSGvlRt7OWFqHi2/uwXfCs
         QdjKejpURuVF2ZDE7QzRk6loy9fnX51N5s5wg8SuCY5aoGc0MvRXGSwGOZALYohnhq
         ZVwnA0lEELW+4yldIZgK/OUHSygEKAVoYWNzhXji0YrqC3p1ecU2pxuiToH84nHiAd
         d1OOHeQQck2uQ==
X-Nifty-SrcIP: [209.85.208.182]
Received: by mail-lj1-f182.google.com with SMTP id p2so9071213ljn.7;
        Sat, 31 Dec 2022 05:23:13 -0800 (PST)
X-Gm-Message-State: AFqh2kopTYYrvrJkSlWoASS+AcFqRtMbIIfB+V4eF8EeFFkAUAKcauvR
        AaZEV+y7bvUcXt7Jm1eXg+lKL9mp5zNj/220mxM=
X-Google-Smtp-Source: AMrXdXu6q1r471sijjQKqWZ8qj1JQk/QXWP/iOhLV7Epa+V01RHD3VEjqbyWe7/YzLiKYdPhtgebkJUBL/6nLrbGCnM=
X-Received: by 2002:a2e:bf18:0:b0:27f:bcdf:453a with SMTP id
 c24-20020a2ebf18000000b0027fbcdf453amr1682720ljr.116.1672492991686; Sat, 31
 Dec 2022 05:23:11 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 31 Dec 2022 22:22:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ66CwHVH+vvqkaRqEn8M46bOSFhyEAOdQfcKeWLxUTUA@mail.gmail.com>
Message-ID: <CAK7LNAQ66CwHVH+vvqkaRqEn8M46bOSFhyEAOdQfcKeWLxUTUA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.2-rc2
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

Hello Linus,

Please pull some Kbuild fixes.

Thank you.





The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.2

for you to fetch changes up to 6a5e25fc3e0b94301734e8abb1d311a1e02d360d:

  fixdep: remove unneeded <stdarg.h> inclusion (2022-12-30 17:26:19 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.2

 - Fix broken BuildID

 - Add srcrpm-pkg to the help message

 - Fix the option order for modpost built with musl libc

 - Fix the build dependency of rpm-pkg for openSUSE

----------------------------------------------------------------
Bhaskar Chowdhury (1):
      kconfig: Add static text for search information in help menu

Jun ASAKA (1):
      kbuild: add a missing line for help message

Masahiro Yamada (5):
      arch: fix broken BuildID for arm64 and riscv
      .gitignore: ignore *.rpm
      kbuild: rpm-pkg: add libelf-devel as alternative for BuildRequires
      kbuild: sort single-targets alphabetically again
      fixdep: remove unneeded <stdarg.h> inclusion

Samuel Holland (1):
      kbuild: Fix running modpost with musl libc

 .gitignore                        |  1 +
 Makefile                          |  2 +-
 include/asm-generic/vmlinux.lds.h |  5 +++++
 scripts/Makefile.modpost          | 22 +++++++++++-----------
 scripts/Makefile.package          |  1 +
 scripts/basic/fixdep.c            |  1 -
 scripts/kconfig/mconf.c           |  6 ++++++
 scripts/package/mkspec            |  3 ++-
 8 files changed, 27 insertions(+), 14 deletions(-)



Best Regards
Masahiro Yamada
