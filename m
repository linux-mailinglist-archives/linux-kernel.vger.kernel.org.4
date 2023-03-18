Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AF96BFB52
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCRPqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCRPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295B11C7FD;
        Sat, 18 Mar 2023 08:46:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B093460B07;
        Sat, 18 Mar 2023 15:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1707EC433D2;
        Sat, 18 Mar 2023 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679154396;
        bh=N868iv6xISOzuxsbItW3+We8eXCDviOi3KqIKAOmz9Q=;
        h=From:Date:Subject:To:Cc:From;
        b=t9Pmpkhe8uJaWxeYWlGhb/DWim2OZINnxljX4qNf8/j0B366nUda0PLMrh/I/prRy
         R0bX7ObAIqgt41iNpg0H6NjcdlSaNnVD0msS0xzloR8ut+Qzs+4nTvlxKQRzz/Poip
         Ru3zlvbjz/M2oxX4s7K/lBDdFBh8UFVDX9IgMpKnFIofOuNZZtRmGVpuSsJZVPHlRh
         IcoRlxhtUhKCreqzUnBaJgOBfCMK3wzpedjoJ0hzMnTawzW12kJKRFoTIs949UmWtk
         o3015eyQHBMo7aNo4cn11FSCZSfIFDj/Muh/Bgh7/pIGu8pu33brhLrr1B+MBc9S7/
         s2LuHPcT4QxaA==
Received: by mail-oi1-f175.google.com with SMTP id s41so5917111oiw.13;
        Sat, 18 Mar 2023 08:46:36 -0700 (PDT)
X-Gm-Message-State: AO0yUKW3mXki2B3wQGTef/pQJJF2bV5qN8MqYyfJLksvgcLud6cqwi4H
        92C80nBQFYQHYa289Ap2JMw/VDSLbV/J+0SBvOM=
X-Google-Smtp-Source: AK7set+NPliHrE5UPYBefQhTtmKgaSjoo8SJYT5GTDue0EBCl5T+VoJ0khVP/Sau7V5Qvmrz+KphZ745w7Jwn4Ids4A=
X-Received: by 2002:aca:2309:0:b0:383:c3d5:6c9f with SMTP id
 e9-20020aca2309000000b00383c3d56c9fmr4411812oie.11.1679154395363; Sat, 18 Mar
 2023 08:46:35 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Mar 2023 00:45:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNARH1PPARMD31mECPFs86j8o1MSDTrwahdavDm-C3Dg_sA@mail.gmail.com>
Message-ID: <CAK7LNARH1PPARMD31mECPFs86j8o1MSDTrwahdavDm-C3Dg_sA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.3-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull Kbuild fixes.
This removes scripts/list-gitignored.
I hope you will be happy with it.

Thank you.




The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.3

for you to fetch changes up to 05e96e96a315fa49faca4da2aedd1761a218b616:

  kbuild: use git-archive for source package creation (2023-03-16
22:46:12 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.3

 - Exclude kallsyms_seqs_of_names from kallsyms to fix build error

 - Fix 'make kernelrelease' for external module builds

 - Get the Debian source package compilable again

 - Fix the wrong uname when Debian packages are built with the
   KDEB_PKGVERSION option

 - Fix superfluous CROSS_COMPILE when building Debian packages

 - Fix RPM package build error when KCONFIG_CONFIG is set

 - Use 'git archive' for creating source tarballs

 - Remove the scripts/list-gitignored tool

----------------------------------------------------------------
Arnd Bergmann (1):
      kallsyms: add kallsyms_seqs_of_names to list of special symbols

Jurica Vukadin (1):
      kconfig: Update config changed flag before calling callback

Masahiro Yamada (7):
      kbuild: deb-pkg: make debian source package working again
      kbuild: deb-pkg: do not take KERNELRELEASE from the source version
      kbuild: deb-pkg: set CROSS_COMPILE only when undefined
      kbuild: deb-pkg: split image and debug objects staging out into functions
      kbuild: deb-pkg: use dh_listpackages to know enabled packages
      kbuild: rpm-pkg: move source components to rpmbuild/SOURCES
      kbuild: use git-archive for source package creation

Tzafrir Cohen (1):
      Makefile: Make kernelrelease target work with M=

 .gitignore                       |    1 +
 Makefile                         |   11 +-
 scripts/.gitignore               |    1 -
 scripts/Makefile                 |    2 +-
 scripts/Makefile.package         |  148 ++++++-----
 scripts/check-git                |   14 ++
 scripts/kallsyms.c               |    1 +
 scripts/kconfig/confdata.c       |    6 +-
 scripts/list-gitignored.c        | 1057
------------------------------------------------------------------------------
 scripts/package/builddeb         |  269 ++++++++++----------
 scripts/package/deb-build-option |   14 +-
 scripts/package/gen-diff-patch   |   44 ++++
 scripts/package/mkdebian         |   23 +-
 scripts/package/mkspec           |   22 +-
 scripts/setlocalversion          |   45 +++-
 15 files changed, 358 insertions(+), 1300 deletions(-)
 create mode 100755 scripts/check-git
 delete mode 100644 scripts/list-gitignored.c
 create mode 100755 scripts/package/gen-diff-patch


-- 
Best Regards
Masahiro Yamada
