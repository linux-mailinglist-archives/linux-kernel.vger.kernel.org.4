Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355606398F2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 00:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKZXgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 18:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKZXge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 18:36:34 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BC412AB6;
        Sat, 26 Nov 2022 15:36:33 -0800 (PST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2AQNaLNI009546;
        Sun, 27 Nov 2022 08:36:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2AQNaLNI009546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669505782;
        bh=ZELmUM9o4zJsGvAOfBpKNAR/OlXNqYM+Qs6zi4NAQMg=;
        h=From:Date:Subject:To:Cc:From;
        b=naIWBt/438Ksc/jpNLDzaF+ayPRcmXys/Dq0RfWnmoBZ4Z4T19kWxUnxE7dgoEIHI
         gQhR16Q79uNQN3v+LpHyLWLxw74PTeE7U4v4sCjmPS65N6ThnVx1c48+yYtMQ3HuZn
         WOBDfZR0Zv9U9rj0EfEo5pHyCJkyVeDQQWOMRTsDVQ/TFX8M+sGetWQWxV7kdF16PA
         cBUMbRUixOBBYhGBIUIpWnpuvkexaycjkMJXyoLUjmYdwswk1MuSa5eG7bH1kOKDOF
         L94Br6DGrVRv3ADZT+n/uVc0xfEVXbL4kCVTNFqtfFDSG7gMO7ejgHm9JSira/MmVF
         JVix5wI34NtPw==
X-Nifty-SrcIP: [209.85.167.169]
Received: by mail-oi1-f169.google.com with SMTP id e205so8006086oif.11;
        Sat, 26 Nov 2022 15:36:21 -0800 (PST)
X-Gm-Message-State: ANoB5plNCelIM6u2TIowNVa3cLI9SvNAAjPA9R0ir6nLMa3wm6nvi4Tt
        lSd00DZUfqEXMTSmJ/3IP9yLW9lp8PMDzVJ7zV0=
X-Google-Smtp-Source: AA0mqf776WuaPkXW9fuuUZpxE8QAH83E51KVd9/HW9WjNqKjHFwzUIqDrvQdRyBat4RVg/7CoVhfIMzeRDj0EC9ogz4=
X-Received: by 2002:a05:6808:3009:b0:354:94a6:a721 with SMTP id
 ay9-20020a056808300900b0035494a6a721mr12926855oib.194.1669505780788; Sat, 26
 Nov 2022 15:36:20 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 27 Nov 2022 08:35:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARrgsRx7FqeS4ojaNKr9u4bvOY-j4p7YGLV5i2H4scsig@mail.gmail.com>
Message-ID: <CAK7LNARrgsRx7FqeS4ojaNKr9u4bvOY-j4p7YGLV5i2H4scsig@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.1-rc7
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

Please pull yet more Kbuild fixes.

Thank you.





The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.1-4

for you to fetch changes up to 869e4ae4cd2a23d625aaa14ae62dbebf768cb77d:

  nios2: add FORCE for vmlinuz.gz (2022-11-27 08:28:41 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.1 (4th)

 - Fix CC_HAS_ASM_GOTO_TIED_OUTPUT test in Kconfig

 - Fix noisy "No such file or directory" message when KBUILD_BUILD_VERSION
   is passed

 - Include rust/ in source tarballs

 - Fix missing FORCE for ARCH=nios2 builds

----------------------------------------------------------------
Alexandre Belloni (1):
      init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with dash

Masahiro Yamada (1):
      kbuild: fix "cat: .version: No such file or directory"

Paran Lee (1):
      scripts: add rust in scripts/Makefile.package

Randy Dunlap (1):
      nios2: add FORCE for vmlinuz.gz

 arch/microblaze/Makefile | 4 ++--
 arch/nios2/boot/Makefile | 2 +-
 arch/x86/boot/Makefile   | 2 +-
 init/Kconfig             | 2 +-
 scripts/Makefile.package | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)


-- 
Best Regards
Masahiro Yamada
