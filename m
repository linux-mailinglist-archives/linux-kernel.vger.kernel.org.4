Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757CB626FC3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 14:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbiKMNfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 08:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiKMNfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 08:35:37 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 130581055D;
        Sun, 13 Nov 2022 05:35:36 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1ouD94-0003YR-00; Sun, 13 Nov 2022 14:35:34 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 47D4CC11F2; Sun, 13 Nov 2022 14:35:27 +0100 (CET)
Date:   Sun, 13 Nov 2022 14:35:27 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v6.1
Message-ID: <20221113133527.GA3935@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.1_1

for you to fetch changes up to 648060902aa302331b5d6e4f26d8ee0761d239ab:

  MIPS: pic32: treat port as signed integer (2022-11-11 15:53:58 +0100)

----------------------------------------------------------------
- fix jump label branch range check
- check kmalloc failures in Loongson64 kexec
- fix builds with clang-14
- fix char/int handling in pic32

----------------------------------------------------------------
Jason A. Donenfeld (1):
      MIPS: pic32: treat port as signed integer

Jiaxun Yang (1):
      MIPS: jump_label: Fix compat branch range check

John Thomson (1):
      mips: boot/compressed: use __NO_FORTIFY

Liao Chang (1):
      MIPS: Loongson64: Add WARN_ON on kexec related kmalloc failed

Linus Walleij (1):
      mips: alchemy: gpio: Include the right header

Rongwei Zhang (1):
      MIPS: fix duplicate definitions for exported symbols

 arch/mips/alchemy/common/gpiolib.c        |  2 +-
 arch/mips/boot/compressed/decompress.c    |  1 +
 arch/mips/include/asm/fw/fw.h             |  2 +-
 arch/mips/kernel/jump_label.c             |  2 +-
 arch/mips/kernel/relocate_kernel.S        | 15 +++++----------
 arch/mips/loongson64/reset.c              | 10 ++++++++++
 arch/mips/pic32/pic32mzda/early_console.c | 13 ++++++-------
 arch/mips/pic32/pic32mzda/init.c          |  2 +-
 8 files changed, 26 insertions(+), 21 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
