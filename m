Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB37D5B4AA0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiIJWtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIJWtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:49:09 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 629F34E60F;
        Sat, 10 Sep 2022 15:49:08 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oX9He-0003Ex-00; Sun, 11 Sep 2022 00:49:06 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 11F12C1128; Sun, 11 Sep 2022 00:48:59 +0200 (CEST)
Date:   Sun, 11 Sep 2022 00:48:59 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v6.0
Message-ID: <20220910224858.GA13203@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.0_1

for you to fetch changes up to 727488e305b223ca69205ca5a3b99ace21bbbf5f:

  mips: Select SPARSEMEM_EXTREME (2022-09-09 17:37:27 +0200)

----------------------------------------------------------------
- fix for loongson32 starup hang
- fix for octeon irq setup problem
- fix compiler warning for new CONFIG option
- switch to SPARSEMEM_EXTREME for all platforms selecting SPARSEMEM

----------------------------------------------------------------
Alexander Sverdlin (3):
      MIPS: octeon: Get rid of preprocessor directives around RESERVE32
      MIPS: OCTEON: irq: Fix octeon_irq_force_ciu_mapping()
      mips: Select SPARSEMEM_EXTREME

Yang Ling (1):
      MIPS: loongson32: ls1c: Fix hang during startup

 arch/mips/Kconfig                                  |  1 -
 arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c |  4 ----
 arch/mips/cavium-octeon/octeon-irq.c               | 10 ++++++++
 arch/mips/cavium-octeon/setup.c                    | 27 +++++++++-------------
 arch/mips/loongson32/ls1c/board.c                  |  1 -
 5 files changed, 21 insertions(+), 22 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
