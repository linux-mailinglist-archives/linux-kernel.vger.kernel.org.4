Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBC56B2084
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCIJqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjCIJqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:46:04 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D659E4D84
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:45:06 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:3a77:63e:b168:ae06])
        by albert.telenet-ops.be with bizsmtp
        id W9l32900Y54Hw2A069l3gz; Thu, 09 Mar 2023 10:45:04 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1paCp3-00BKDc-0P;
        Thu, 09 Mar 2023 10:45:03 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1paCpb-00G3TG-I0;
        Thu, 09 Mar 2023 10:45:03 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k fixes for v6.3
Date:   Thu,  9 Mar 2023 10:44:55 +0100
Message-Id: <20230309094455.3826581-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.3-tag2

for you to fetch changes up to e36a82bebbf7da814530d5a179bef9df5934b717:

  m68k: Only force 030 bus error if PC not in exception table (2023-03-06 14:09:42 +0100)

----------------------------------------------------------------
m68k fixes for v6.3

  - Fix systems with memory at end of 32-bit address space,
  - Fix initrd on systems where memory does not start at address zero,
  - Fix 68030 handling of bus errors for addresses in exception tables.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (1):
      m68k: mm: Move initrd phys_to_virt handling after paging_init()

Kars de Jong (1):
      m68k: mm: Fix systems with memory at end of 32-bit address space

Michael Schmitz (1):
      m68k: Only force 030 bus error if PC not in exception table

 arch/m68k/kernel/setup_mm.c | 10 +++++-----
 arch/m68k/kernel/traps.c    |  4 +++-
 arch/m68k/mm/motorola.c     | 10 +++++-----
 3 files changed, 13 insertions(+), 11 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
