Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD67A676519
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 09:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjAUIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 03:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUIbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 03:31:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214F440C5;
        Sat, 21 Jan 2023 00:31:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90038B82A5E;
        Sat, 21 Jan 2023 08:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D56C4339B;
        Sat, 21 Jan 2023 08:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674289902;
        bh=zMXndpiTzTL9gGkwjFj/rSsFeYftQOBu81rTPjLBeW0=;
        h=From:Date:Subject:To:Cc:From;
        b=nmDGoK/ewTXHsRIVt6HKTwxDcPEl8trcCDViJQ9kVSPh4rUdehNItEN8tm8E/FeTe
         sCHls5LbusVkwkyHIZp793gvEdBe/uGTdXMn7NG1cFEtHKBVSSW10xCJ2XwFhM0Hh3
         QxrfpbLOygEUt+aVBeyW2o4hAZQGTTydm8/NN5cGDc6lMzURREX8EADTfYMvcB+oyA
         XjsAPkfXGwYmKguGL8VNaY5LvegHzBv6EdjQE1kh4KCdEYKvS3Y0jBPx3xg8YVupy8
         o/h8N1KlJmZ6pcRuXnK+5OMw2caVF2Mw/wMTYOIanicZKJPm5OllkQBoui/5b3SfBH
         fgdTZFxrFv+yQ==
Received: by mail-ot1-f51.google.com with SMTP id k44-20020a9d19af000000b00683e176ab01so4407466otk.13;
        Sat, 21 Jan 2023 00:31:42 -0800 (PST)
X-Gm-Message-State: AFqh2krhdU9+qvMSjv1muIBvM8m/w9GEd+bZT7vxsRh3bgnQD0QqflhM
        eQdbuvKor/LFTsumgqFikYogF7I/2MPCN9LOE6I=
X-Google-Smtp-Source: AMrXdXueurw7RIpF/XIbb0r+h5pl7uOrwDOxsByRWojoNVt8O+KpeMacKLKnKLgIY0ANy5yie5lTjSfzPlynGeRMAJ4=
X-Received: by 2002:a9d:6a4c:0:b0:684:a3ad:87e8 with SMTP id
 h12-20020a9d6a4c000000b00684a3ad87e8mr993547otn.225.1674289901351; Sat, 21
 Jan 2023 00:31:41 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 21 Jan 2023 17:31:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNARFTDWJtxb=1gu6f4_=jRWevb4Hd71ipfpMFpf8GU4SCw@mail.gmail.com>
Message-ID: <CAK7LNARFTDWJtxb=1gu6f4_=jRWevb4Hd71ipfpMFpf8GU4SCw@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.2-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Please pull some Kbuild fixes.

Thank you.




The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262=
:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.2-3

for you to fetch changes up to 13e1df09284da53ae5abdd3364c36caf8f0f8916:

  kheaders: explicitly validate existence of cpio command (2023-01-18
16:34:04 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.2 (3rd)

 - Hide LDFLAGS_vmlinux from decompressor Makefiles to fix error messages
   when GNU Make 4.4 is used.

 - Fix 'make modules' build error when CONFIG_DEBUG_INFO_BTF_MODULES=3Dy.

 - Fix warnings emitted by GNU Make 4.4 in scripts/kconfig/Makefile.

 - Support GNU Make 4.4 for scripts/jobserver-exec.

 - Show clearer error message when kernel/gen_kheaders.sh fails due to
   missing cpio.

----------------------------------------------------------------
Arend van Spriel (1):
      scripts: rpm: make clear that mkspec script contains 4.13 feature

Martin Liska (1):
      scripts: support GNU make 4.4 in jobserver-exec

Masahiro Yamada (3):
      init/version-timestamp.c: remove unneeded #include <linux/version.h>
      kbuild: export top-level LDFLAGS_vmlinux only to scripts/Makefile.vml=
inux
      kbuild: fix 'make modules' error when CONFIG_DEBUG_INFO_BTF_MODULES=
=3Dy

Miguel Ojeda (1):
      docs: kbuild: remove mention to dropped $(objtree) feature

Peter Foley (1):
      kconfig: Update all declared targets

Rasmus Villemoes (1):
      init/Kconfig: fix LOCALVERSION_AUTO help text

Thomas Wei=C3=9Fschuh (1):
      kheaders: explicitly validate existence of cpio command

 Documentation/kbuild/makefiles.rst |  2 +-
 Makefile                           | 15 ++++++++++++++-
 init/Kconfig                       |  2 +-
 init/version-timestamp.c           |  1 -
 kernel/gen_kheaders.sh             |  2 ++
 scripts/jobserver-exec             | 19 ++++++++++++++-----
 scripts/kconfig/.gitignore         |  2 +-
 scripts/kconfig/Makefile           |  2 +-
 scripts/package/mkspec             |  2 +-
 9 files changed, 35 insertions(+), 12 deletions(-)
