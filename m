Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7DC5E8F62
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiIXSfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 14:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiIXSfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 14:35:39 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B51140E22;
        Sat, 24 Sep 2022 11:35:36 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 28OIZLc9005082;
        Sun, 25 Sep 2022 03:35:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 28OIZLc9005082
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664044521;
        bh=RbqoFf+NUPS3ZIfi5M0nVs/cSJ76u5DRwLEJ1NMMjb8=;
        h=From:Date:Subject:To:Cc:From;
        b=KPiIAqprkcpsg10dTimf7qprbxFVoPDTf4FYP7WZf9Vlj/8N459PGF/QlBcsNsDnG
         9v8oK7VRXcELwmHdKA1YZKKkEO2pBONiFqHbqaMqf0uQqsLJlknATS3mEewzmtaPYd
         bxfJQ+rn46JqDtLCzbxBcgtXRQzMkOGgIn364LQntw5OLbk7J2bmZsRYfcNPKFqXGk
         AD0Ggnok3SdgjgO9AvVt1OTKK06C2bxkAps4zu3+Ushs79+H2ox14g23dsN6YSvcj/
         bXuJxpq1bYHAu8yWiEeyM6LjWPOPkjVsLr27Eg1H9yifFBZ/WAdlWGoq8btPVCQCOa
         S5iR2fKgpgz6Q==
X-Nifty-SrcIP: [209.85.167.175]
Received: by mail-oi1-f175.google.com with SMTP id t62so3631468oie.10;
        Sat, 24 Sep 2022 11:35:21 -0700 (PDT)
X-Gm-Message-State: ACrzQf10b+185D1577VpXKTmPan/z/Fx93saQGTVtTitLBwCGjBx/x4t
        zaIVAayw5hgATDvOae1Wi/5dHnE3CgKImO2ADzo=
X-Google-Smtp-Source: AMsMyM7rQ9j5IF9emwrULzHOpQ66ut5L1dC7h0xgpYEFiOUwjUr+ir8cpdIIc7CijiTFyyUKWXaz2T/aOap5jgvhX+A=
X-Received: by 2002:a54:400c:0:b0:34f:9913:262 with SMTP id
 x12-20020a54400c000000b0034f99130262mr6691143oie.287.1664044520383; Sat, 24
 Sep 2022 11:35:20 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 25 Sep 2022 03:34:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATDVBT1NKZtUkjk3GpqxEtOc8JLjY3XMjREHrp94t13-w@mail.gmail.com>
Message-ID: <CAK7LNATDVBT1NKZtUkjk3GpqxEtOc8JLjY3XMjREHrp94t13-w@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.0-rc7
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
Thanks.



The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4cf:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.0-3

for you to fetch changes up to 32ef9e5054ec0321b9336058c58ec749e9c6b0fe:

  Makefile.debug: re-enable debug info for .S files (2022-09-24 11:19:19 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.0 (3rd)

 - Fix build error for the combination of CONFIG_SYSTEM_TRUSTED_KEYRING=y
   and CONFIG_X509_CERTIFICATE_PARSER=m

 - Fix CONFIG_DEBUG_INFO_SPLIT to generate debug info for GCC 11+ and Clang 12+

 - Revive debug info for assembly files

 - Remove unused code

----------------------------------------------------------------
Masahiro Yamada (1):
      certs: make system keyring depend on built-in x509 parser

Nick Desaulniers (2):
      Makefile.debug: set -g unconditional on CONFIG_DEBUG_INFO_SPLIT
      Makefile.debug: re-enable debug info for .S files

Zeng Heng (1):
      Kconfig: remove unused function 'menu_get_root_menu'

yangxingwu (1):
      scripts/clang-tools: remove unused module

 certs/Kconfig                          |  2 +-
 lib/Kconfig.debug                      |  4 +++-
 scripts/Makefile.debug                 | 21 ++++++++++-----------
 scripts/clang-tools/run-clang-tools.py |  1 -
 scripts/kconfig/lkc.h                  |  1 -
 scripts/kconfig/menu.c                 |  5 -----
 6 files changed, 14 insertions(+), 20 deletions(-)


-- 
Best Regards
Masahiro Yamada
