Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92ED45B4EC3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 14:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiIKMYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 08:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiIKMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 08:24:51 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD771240AA;
        Sun, 11 Sep 2022 05:24:47 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28BCOZex029075;
        Sun, 11 Sep 2022 21:24:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28BCOZex029075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662899076;
        bh=GQ03xwoGNDq52aqnQEQ/BAf1toU8NsXlr/BYPbrzfFY=;
        h=From:Date:Subject:To:Cc:From;
        b=hi/qylNg/A0WmA+nBMjBb8VyaaxAXKIeTg3FjDABgilLKv3O0Jx+dcTb6Z2F5IwPp
         Uy2+2oIJeacqdsgCoc1krHdRSRvLRhfiKVZwFQ0dUKU3i1D38GcGJNa3jOW/WAgvDl
         JQbuoig/x1W0iQKBhEGEWHuPtt7abNInANuLFH5AsPKFwPfIaZdSWfWgcSDyGr+v4X
         fSJf6MqqgvU3/oaxsnSjGkQptmLPL5y+DL9Qc6v49EycBYHSGHMPeoNwFWV4OmjwQE
         8a+Gpry5644CqJi90L0lk6tOD94sU86z+auAV0MWyWTULcXsYFNHkLMBaxqS/KbUwo
         CTx9hyyjIU1Ow==
X-Nifty-SrcIP: [209.85.160.45]
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-12803ac8113so16423753fac.8;
        Sun, 11 Sep 2022 05:24:35 -0700 (PDT)
X-Gm-Message-State: ACgBeo0FG0K23AEemU0rMa9ffGmdCqD7LYedrfKrFV6CPyl1P9mz1mVv
        MBXQbdIS9bvN5fk95upokAJYlGmC1RktTwVJRQ8=
X-Google-Smtp-Source: AA6agR4IDQlmqXtVVX+3L56RW++8IoCwq2DzqhwdRVX+eUmN5eaJtxslcfFGrrEbsHWPH0K5y5hRR6t/Pg5dOqyWOdY=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr9334676oab.287.1662899074869; Sun, 11
 Sep 2022 05:24:34 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 11 Sep 2022 21:23:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNASxoB67Tdzj78FA9iuRr2WxcH+-knSkziv36TFOW4KhHQ@mail.gmail.com>
Message-ID: <CAK7LNASxoB67Tdzj78FA9iuRr2WxcH+-knSkziv36TFOW4KhHQ@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.0-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,


Please pull some Kbuild fixes.
Thanks.





The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.0-2

for you to fetch changes up to c17a2538704f926ee4d167ba625e09b1040d8439:

  mksysmap: Fix the mismatch of 'L0' symbols in System.map (2022-09-10
05:35:13 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.0 (2nd)

 - Remove unused scripts/gcc-ld script

 - Add zstd support to scripts/extract-ikconfig

 - Check 'make headers' for UML

 - Fix scripts/mksysmap to ignore local symbols

----------------------------------------------------------------
Lukas Bulwahn (1):
      scripts: remove obsolete gcc-ld script

Masahiro Yamada (1):
      kbuild: disable header exports for UML in a straightforward way

Thitat Auareesuksakul (1):
      scripts/extract-ikconfig: add zstd compression support

Youling Tang (1):
      mksysmap: Fix the mismatch of 'L0' symbols in System.map

 Makefile                 |  3 +--
 scripts/extract-ikconfig |  1 +
 scripts/gcc-ld           | 30 ------------------------------
 scripts/mksysmap         |  2 +-
 4 files changed, 3 insertions(+), 33 deletions(-)
 delete mode 100755 scripts/gcc-ld


-- 
Best Regards
Masahiro Yamada
