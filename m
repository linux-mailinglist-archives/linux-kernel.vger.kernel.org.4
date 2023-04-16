Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1C16E37C4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 13:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDPLex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 07:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDPLeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 07:34:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930172D4D;
        Sun, 16 Apr 2023 04:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E33160B01;
        Sun, 16 Apr 2023 11:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9075BC433EF;
        Sun, 16 Apr 2023 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681644887;
        bh=zbg/JDCxdpl3fJ0egm+4wFFgvJH4g6+BGIBH23/YPPQ=;
        h=From:Date:Subject:To:Cc:From;
        b=c/JuRRfwrMn2xrERo/bdaLLjZNj5cq7onoKSq++O6wVSMGgBZ5TBfaPNTxL+TU/E3
         SnrNNR8zaI4GLmuP5DECumj14cDFKaq2f+3tLkshXPPtbvfV4RjT7m25GyHhAUMcxE
         vBDB8CRPIhqO02AwKRHyLz7l93tcaqWhB8alcVdEOhiNHbicDFZcssMDjvlFjR18fl
         7g2IXaDWOsjv2I1q5m3CsvBkL6sDbDKvTl79h6QzQ7nFSZDefEww66nRJfRD4UQ75x
         tl/3Zdiae0ugCta2Ka+R+U7r+q2HI3PdBIAeuato0LzrVgwzQpEk2MnrIlFtRGiCar
         pZl0wKNe4fj8w==
Received: by mail-ot1-f42.google.com with SMTP id ds7-20020a0568306c0700b006a5cea70c02so1278359otb.8;
        Sun, 16 Apr 2023 04:34:47 -0700 (PDT)
X-Gm-Message-State: AAQBX9eRHiSmgnKLyL09Wlu8nUWOm3STN3A6SUBQwgc129zuUTZSYBNi
        PuYBvh/ksEiWLYobD9VhQiDmucEPmReVcSZIWwg=
X-Google-Smtp-Source: AKy350biSFYUvDJOqvjDyo4OsP0kDhcRRGMGBSPNeufxynPmca/pTKyYmSAEBoJzQfa3MbxalRqRq1pAjIr60o7VgjM=
X-Received: by 2002:a05:6830:310a:b0:6a5:e464:f0b7 with SMTP id
 b10-20020a056830310a00b006a5e464f0b7mr346991ots.3.1681644886854; Sun, 16 Apr
 2023 04:34:46 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 16 Apr 2023 20:34:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNATfEXPreAvHcLdzBrRX8ucYWM7t4_VxSLTLdcxPxVaU-Q@mail.gmail.com>
Message-ID: <CAK7LNATfEXPreAvHcLdzBrRX8ucYWM7t4_VxSLTLdcxPxVaU-Q@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.3-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull some more Kbuild fixes.
Thank you.



The following changes since commit 7e364e56293bb98cae1b55fd835f5991c4e96e7d:

  Linux 6.3-rc5 (2023-04-02 14:29:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.3-3

for you to fetch changes up to 3c65a2704cdd2a0cd0766352e587bae4a6268155:

  kbuild: do not create intermediate *.tar for tar packages
(2023-04-16 17:38:41 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.3 (3rd)

 - Drop debug info from purgatory objects again

 - Document that kernel.org provides prebuilt LLVM toolchains

 - Give up handling untracked files for source package builds

 - Avoid creating corrupted cpio when KBUILD_BUILD_TIMESTAMP is given
   with a pre-epoch data.

 - Change panic_show_mem() to a macro to handle variable-length argument

 - Compress tarballs on-the-fly again

----------------------------------------------------------------
Alyssa Ross (1):
      purgatory: fix disabling debug info

Benjamin Gray (2):
      initramfs: Check negative timestamp to prevent broken cpio archive
      init/initramfs: Fix argument forwarding to panic() in panic_show_mem()

Masahiro Yamada (4):
      kbuild: give up untracked files for source package builds
      kbuild: merge cmd_archive_linux and cmd_archive_perf
      kbuild: do not create intermediate *.tar for source tarballs
      kbuild: do not create intermediate *.tar for tar packages

Nathan Chancellor (1):
      Documentation/llvm: Add a note about prebuilt kernel.org toolchains

 Documentation/kbuild/llvm.rst  |   4 ++
 arch/riscv/purgatory/Makefile  |   7 +--
 arch/x86/purgatory/Makefile    |   3 +-
 init/initramfs.c               |  11 +----
 scripts/Makefile.package       |  64 ++++++++++++-------------
 scripts/package/gen-diff-patch |  62 +++++++++++--------------
 scripts/package/mkdebian       | 103 +++++++++++++++++++++++------------------
 scripts/package/mkspec         |  11 +----
 usr/gen_init_cpio.c            |  12 +++--
 9 files changed, 138 insertions(+), 139 deletions(-)


-- 
Best Regards
Masahiro Yamada
