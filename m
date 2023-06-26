Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6274C73DC18
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjFZKQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFZKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:16:56 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5B819F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:16:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e662:523d:cfc0:1ef2])
        by albert.telenet-ops.be with bizsmtp
        id DmGs2A00D0kkhwT06mGsyv; Mon, 26 Jun 2023 12:16:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qDjH6-000Qfb-JB;
        Mon, 26 Jun 2023 12:16:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qDjHA-00CnyG-BQ;
        Mon, 26 Jun 2023 12:16:52 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.5
Date:   Mon, 26 Jun 2023 12:16:48 +0200
Message-Id: <20230626101648.3052015-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

The following changes since commit b845b574f86dcb6a70dfa698aa87a237b0878d2a:

  m68k: Move signal frame following exception on 68020/030 (2023-05-22 13:51:20 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.5-tag1

for you to fetch changes up to 4055eabe04a26f5d113b5a02588b20b5e166a753:

  m68k: defconfig: Update defconfigs for v6.4-rc1 (2023-06-12 11:20:44 +0200)

----------------------------------------------------------------
m68k updates for v6.5

  - Miscellaneous NuBus fixes and improvements,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Finn Thain (3):
      nubus: Partially revert proc_create_single_data() conversion
      nubus: Remove proc entries before adding them
      nubus: Don't list slot resources by default

Geert Uytterhoeven (1):
      m68k: defconfig: Update defconfigs for v6.4-rc1

 arch/m68k/configs/amiga_defconfig    |  2 +-
 arch/m68k/configs/apollo_defconfig   |  2 +-
 arch/m68k/configs/atari_defconfig    |  2 +-
 arch/m68k/configs/bvme6000_defconfig |  2 +-
 arch/m68k/configs/hp300_defconfig    |  2 +-
 arch/m68k/configs/mac_defconfig      |  2 +-
 arch/m68k/configs/multi_defconfig    |  2 +-
 arch/m68k/configs/mvme147_defconfig  |  2 +-
 arch/m68k/configs/mvme16x_defconfig  |  2 +-
 arch/m68k/configs/q40_defconfig      |  2 +-
 arch/m68k/configs/sun3_defconfig     |  1 -
 arch/m68k/configs/sun3x_defconfig    |  2 +-
 arch/m68k/configs/virt_defconfig     |  2 --
 drivers/nubus/nubus.c                | 13 ++++++++++---
 drivers/nubus/proc.c                 | 33 ++++++++++++++++++++++++---------
 include/linux/nubus.h                |  1 +
 16 files changed, 46 insertions(+), 26 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
