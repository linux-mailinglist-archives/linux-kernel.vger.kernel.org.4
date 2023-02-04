Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1968ABC5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 18:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjBDRzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 12:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjBDRzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 12:55:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3298620D39;
        Sat,  4 Feb 2023 09:55:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE1A560010;
        Sat,  4 Feb 2023 17:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E0CC433EF;
        Sat,  4 Feb 2023 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675533346;
        bh=DvnyUFTfuLYFClio4Yz27xdgvScxNsoLoiw/RTpcbck=;
        h=From:Date:Subject:To:Cc:From;
        b=neF4OnettAXoktdO9nyyPWMQM/zaGW+4ia7hYR1bPaiCn+qgOPxqMYufNzw7Q24oq
         lAADL/tvbqAONqvHFOimqF7liXgHvxD9JKtaQS5aM8L6Au5O1QG8Fg/K0/+3+a7fEZ
         XHt2lUdJyFVtvu60YAASkKgaKgunVdpMiRlj8EPYR359DyYLtmch2B37XhIuGiFC9L
         14+c9GjvckTmI2v3+cTAfH+QMOjmq9u4acjPCQqFAOCtT/BlcbeFyeLvtwOerpJx0N
         GpDVMmA9vj09ELfw+1diZN7ezzE4+nRwcJJR8/7jv1k/XZ0fhexvOmSXCQip3YHKpf
         CBO4djoZ1DQuw==
Received: by mail-oi1-f182.google.com with SMTP id bx13so6723677oib.13;
        Sat, 04 Feb 2023 09:55:46 -0800 (PST)
X-Gm-Message-State: AO0yUKXcAS24qRIVwA0k+og1vLy2URcyxOGvYGSHJLNhTs/2QHkiR9SS
        ee27qbxHl07vKQvMlstb24mzEcJhQxmWy0euQPU=
X-Google-Smtp-Source: AK7set8A380NaprCfWQjGbR9j8EjoFu0XoP8sGD5Yiar4utMyVgVOJxLCuFsgx1wTgEN03bjvs2HR7RyMEAsDwvkGTs=
X-Received: by 2002:a05:6808:16a3:b0:377:f944:a8b7 with SMTP id
 bb35-20020a05680816a300b00377f944a8b7mr481383oib.194.1675533345328; Sat, 04
 Feb 2023 09:55:45 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 5 Feb 2023 02:55:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNwyei5pGmwR+iSLH733jAsaHet9h1dfWHF2x+Uhb=ag@mail.gmail.com>
Message-ID: <CAK7LNARNwyei5pGmwR+iSLH733jAsaHet9h1dfWHF2x+Uhb=ag@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.2-rc7
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

Please pull some Kbuild fixes.

Thank you.





The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.2-4

for you to fetch changes up to 22e46f6480e83bcf49b6d5e6b66c81872c97a902:

  kbuild: modinst: Fix build error when CONFIG_MODULE_SIG_KEY is a
PKCS#11 URI (2023-01-31 17:53:01 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.2 (4th)

 - Fix two bugs (for building and for signing) when CONFIG_MODULE_SIG_KEY
   contains PKCS#11 URI.

----------------------------------------------------------------
Jan Luebbe (2):
      certs: Fix build error when PKCS#11 URI contains semicolon
      kbuild: modinst: Fix build error when CONFIG_MODULE_SIG_KEY is a
PKCS#11 URI

 certs/Makefile           | 4 ++--
 scripts/Makefile.modinst | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)



-- 
Best Regards
Masahiro Yamada
