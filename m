Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002866EC961
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjDXJtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjDXJtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:49:00 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C533AB8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:48:27 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:fce4:9ab4:47f9:86e9])
        by albert.telenet-ops.be with bizsmtp
        id oZoL2900K2cB8pT06ZoLFf; Mon, 24 Apr 2023 11:48:20 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pqsnz-000LC6-IW;
        Mon, 24 Apr 2023 11:48:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pqso0-008XI4-9L;
        Mon, 24 Apr 2023 11:48:20 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.4
Date:   Mon, 24 Apr 2023 11:48:16 +0200
Message-Id: <20230424094816.2034583-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit e36a82bebbf7da814530d5a179bef9df5934b717:

  m68k: Only force 030 bus error if PC not in exception table (2023-03-06 14:09:42 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git m68k-for-v6.4-tag1

for you to fetch changes up to aaee8c7f2a17d2dd015dc97c113c9ea0cc97272a:

  m68k: kexec: Include <linux/reboot.h> (2023-04-21 09:53:54 +0200)

----------------------------------------------------------------
m68k updates for v6.4

  - Defconfig updates,
  - Miscellaneous fixes and improvements.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v6.3-rc1

Lukas Bulwahn (1):
      m68k: Remove obsolete config NO_KERNEL_MSG

Simon Horman (1):
      m68k: kexec: Include <linux/reboot.h>

Uwe Kleine-König (1):
      nubus: Drop noop match function

 arch/m68k/Kconfig.debug              | 5 -----
 arch/m68k/configs/amiga_defconfig    | 3 ++-
 arch/m68k/configs/apollo_defconfig   | 3 ++-
 arch/m68k/configs/atari_defconfig    | 3 ++-
 arch/m68k/configs/bvme6000_defconfig | 3 ++-
 arch/m68k/configs/hp300_defconfig    | 3 ++-
 arch/m68k/configs/mac_defconfig      | 3 ++-
 arch/m68k/configs/multi_defconfig    | 4 ++--
 arch/m68k/configs/mvme147_defconfig  | 3 ++-
 arch/m68k/configs/mvme16x_defconfig  | 3 ++-
 arch/m68k/configs/q40_defconfig      | 3 ++-
 arch/m68k/configs/sun3_defconfig     | 3 ++-
 arch/m68k/configs/sun3x_defconfig    | 3 ++-
 arch/m68k/kernel/machine_kexec.c     | 1 +
 drivers/nubus/bus.c                  | 6 ------
 15 files changed, 25 insertions(+), 24 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
