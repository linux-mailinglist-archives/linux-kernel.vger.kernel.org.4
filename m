Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CD26002BA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJPSKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJPSKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:10:34 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21A92FC0F;
        Sun, 16 Oct 2022 11:10:21 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 29GI9iws009462;
        Mon, 17 Oct 2022 03:09:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 29GI9iws009462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665943785;
        bh=7hgllq+u5KafkXbLu/L7mhMYeT8lSvm1lZlkn+irFHM=;
        h=From:Date:Subject:To:Cc:From;
        b=GfAtMjvMR6BaY2pmFWaoFDhWb21k5YbVasS2VCeAP7jMylS9Jp3Q87WrjbT2v3ybE
         aS6C2cR1zK4agSf84r0LX2EJSk8nqdJWpvu0LwGuG0FSa9F0Eu624C7yLgtOKIrNvM
         cVsrSUBVycOrdity39B4LeLYcAYXaSP36QqxfiSdUqx8lOEvMf+nFxSJzwtwUt1c0r
         xWwGuO3h7PvZs7jOx82uA7E/xrzmD7w6y/c3Pb6Fyf+owGDHEZO3m3HsKRHFdgyfpj
         aUvOi/Q2EqB4fum2ZYQ+Ko2MZBy9ShWaGQxOK7kxCd+nmCUqyW6TOyn4U+T+QrCjYc
         kdNyCg8YXF4Cg==
X-Nifty-SrcIP: [209.85.210.49]
Received: by mail-ot1-f49.google.com with SMTP id p24-20020a9d6958000000b00661c528849eso4652079oto.9;
        Sun, 16 Oct 2022 11:09:44 -0700 (PDT)
X-Gm-Message-State: ACrzQf00rkZV54KJWX2ZHVeTEh14COc06oxd5QZIProqKAAWm2/har/s
        7CgcbWn9MEovHZo5Ua5XqrUylzvlO08e6nNLQOc=
X-Google-Smtp-Source: AMsMyM68ZvVereSYU6w/ELszD8gcDD2ov1yZZh+drmvtGRbr1j5eeMbmlvgRP5uaz/Iu3yWGipaYtypHgQ9lGaLRaDQ=
X-Received: by 2002:a05:6830:6384:b0:661:bee5:73ce with SMTP id
 ch4-20020a056830638400b00661bee573cemr3488230otb.343.1665943783691; Sun, 16
 Oct 2022 11:09:43 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 17 Oct 2022 03:09:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQThQhJRDsFrHo=3sYd5MTFq_R_7CNjpoPmsNeO7WWmGA@mail.gmail.com>
Message-ID: <CAK7LNAQThQhJRDsFrHo=3sYd5MTFq_R_7CNjpoPmsNeO7WWmGA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
Thanks.






The following changes since commit e2302539dd4f1c62d96651c07ddb05aa2461d29c:

  Merge tag 'xtensa-20221010' of
https://github.com/jcmvbkbc/linux-xtensa (2022-10-10 14:21:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.1

for you to fetch changes up to 0a6de78cff600cb991f2a1b7ed376935871796a0:

  lib/Kconfig.debug: Add check for non-constant .{s,u}leb128 support
to DWARF5 (2022-10-17 02:06:47 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.1

 - Fix CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y compile error for
   the combination of Clang >= 14 and GAS <= 2.35.

 - Drop vmlinux.bz2 from the rpm package as it just annoyingly increased
   the package size.

 - Fix modpost error under build environments using musl.

 - Make *.ll files keep value names for easier debugging

 - Fix single directory build

 - Prevent RISC-V from selecting the broken DWARF5 support when Clang
   and GAS are used together.

----------------------------------------------------------------
Guru Das Srinagesh (1):
      scripts/clang-tools: Convert clang-tidy args to list

Masahiro Yamada (3):
      Kconfig.debug: simplify the dependency of DEBUG_INFO_DWARF4/5
      Kconfig.debug: add toolchain checks for DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
      kbuild: fix single directory build

Nathan Chancellor (1):
      lib/Kconfig.debug: Add check for non-constant .{s,u}leb128
support to DWARF5

Nick Desaulniers (1):
      kbuild: add -fno-discard-value-names to cmd_cc_ll_c

Richard Acayan (1):
      modpost: put modpost options before argument

Zack Rusin (1):
      kbuild: Stop including vmlinux.bz2 in the rpm's

 Makefile                               |  2 ++
 lib/Kconfig.debug                      | 10 ++++++++--
 scripts/Makefile.build                 |  2 +-
 scripts/Makefile.modpost               |  2 +-
 scripts/clang-tools/run-clang-tools.py | 11 ++++++-----
 scripts/package/mkspec                 |  2 --
 6 files changed, 18 insertions(+), 11 deletions(-)
