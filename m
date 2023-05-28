Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9F07138C2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 10:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjE1Igr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 04:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjE1Igq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 04:36:46 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE77FBE;
        Sun, 28 May 2023 01:36:43 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q3BtI-0004A3-00; Sun, 28 May 2023 10:36:40 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id CE6DEC02E8; Sun, 28 May 2023 10:36:33 +0200 (CEST)
Date:   Sun, 28 May 2023 10:36:33 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v6.4
Message-ID: <20230528083633.GA3069@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.4_1

for you to fetch changes up to 4897a898a216058dec55e5e5902534e6e224fcdf:

  mips: Move initrd_start check after initrd address sanitisation. (2023-05-23 11:01:38 +0200)

----------------------------------------------------------------
- fixes to get alchemy platform back in shape
- fix for initrd detection

----------------------------------------------------------------
Liviu Dudau (1):
      mips: Move initrd_start check after initrd address sanitisation.

Manuel Lauss (3):
      MIPS: unhide PATA_PLATFORM
      MIPS: Restore Au1300 support
      MIPS: Alchemy: fix dbdma2

 arch/mips/Kconfig                |  1 +
 arch/mips/alchemy/common/dbdma.c | 27 +++++++++++++++------------
 arch/mips/kernel/cpu-probe.c     |  5 +++++
 arch/mips/kernel/setup.c         |  9 +++++----
 4 files changed, 26 insertions(+), 16 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
