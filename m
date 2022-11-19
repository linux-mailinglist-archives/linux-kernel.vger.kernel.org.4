Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2034630F47
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 16:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiKSP1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 10:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiKSP1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 10:27:33 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0BD82BEA;
        Sat, 19 Nov 2022 07:27:29 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2AJFRG91032593;
        Sun, 20 Nov 2022 00:27:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2AJFRG91032593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668871637;
        bh=+9gghvxDrSZNU0RdOy3O4PxLU5pgUh7eBIfBXs4/VEk=;
        h=From:Date:Subject:To:Cc:From;
        b=KKVcoutomqyXbOLca4DTgtnRW231ee6O2g3yxFp5alweKcKjJYGILVGKsOh9o33iu
         /W3dj1cx3Mo7it4fbqOrML0CQNYhVwsjcCSctyE+F6ceHiBiLPkIZZ3Ajjif5Te8KQ
         mbPu4zVkSvC5Tii3UA012yEI9Kj2NXt/3p9NF/hJ3Myg/VL1TnXNjecVb99KBxIi66
         ppvBL1qsB1FDMjVS7xfuP6OM8AfI7Z2Ylz+gMz1OmNxKkWgwnd57BHS1e5WtSwTSZI
         iFtFq/qIn0j6LuPXPo/McwkwdwZxf4jTvqC1t4i7zUkA2JfhBB0QCMlfaI9txdzp61
         GqdrXKGHM0jvg==
X-Nifty-SrcIP: [209.85.167.172]
Received: by mail-oi1-f172.google.com with SMTP id q186so8416913oia.9;
        Sat, 19 Nov 2022 07:27:17 -0800 (PST)
X-Gm-Message-State: ANoB5pnbHKW4STXL6+Z3rKJL3uui++ABSI9vwiv/5PtiBbnh58CmhHRz
        PXWBpDYd3EK2P2vRWAfKnhwbWn+Y10Mpezqv8R0=
X-Google-Smtp-Source: AA0mqf6u346SGBnD3cJq8+ZXsCOSCnBP/y4aMSHbaLHdzoBozW147yKbXc29cmWjrX7n8jf7+kZxFlBEFBwch3nzXAA=
X-Received: by 2002:a05:6808:3009:b0:354:94a6:a721 with SMTP id
 ay9-20020a056808300900b0035494a6a721mr8537084oib.194.1668871636287; Sat, 19
 Nov 2022 07:27:16 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Nov 2022 00:26:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR3ESoUBQ5HM3FCLT2LC8JPWstTO6aypnm09ayCFjknYA@mail.gmail.com>
Message-ID: <CAK7LNAR3ESoUBQ5HM3FCLT2LC8JPWstTO6aypnm09ayCFjknYA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.1-rc6
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


Please pull Kbuild fixes.
Thanks.





The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.1-3

for you to fetch changes up to 5db8face97f81c9342458c052572e19ac6bd8e52:

  kbuild: Restore .version auto-increment behaviour for Debian
packages (2022-11-17 17:51:45 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.1 (3rd)

 - Update MAINTAINERS with Nathan and Nicolas as new Kbuild reviewers.

 - Increment the debian revision for deb-pkg builds

----------------------------------------------------------------
Marc Zyngier (1):
      kbuild: Restore .version auto-increment behaviour for Debian packages

Nicolas Schier (3):
      MAINTAINERS: Add Nathan and Nicolas to Kbuild reviewers
      MAINTAINERS: Remove Michal Marek from Kbuild maintainers
      MAINTAINERS: Add linux-kbuild's patchwork

 CREDITS                  | 4 ++++
 MAINTAINERS              | 5 ++++-
 scripts/package/mkdebian | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)
