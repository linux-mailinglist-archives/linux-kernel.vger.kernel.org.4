Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C7264A308
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 15:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiLLOTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 09:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiLLOTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 09:19:08 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12701057F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 06:18:56 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:e0b1:47d7:2716:fd3])
        by albert.telenet-ops.be with bizsmtp
        id vSJt2800f3pMg3v06SJtD3; Mon, 12 Dec 2022 15:18:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1p4jdt-0003Ul-IM; Mon, 12 Dec 2022 15:18:53 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1p4jds-00F79p-Vo; Mon, 12 Dec 2022 15:18:53 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.2
Date:   Mon, 12 Dec 2022 15:18:51 +0100
Message-Id: <20221212141851.3602384-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
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

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.2-tag1

for you to fetch changes up to 553b20b211c4153f8af6096fd52069bbdf955e23:

  m68k: defconfig: Update defconfigs for v6.1-rc1 (2022-11-14 14:56:11 +0100)

----------------------------------------------------------------
m68k updates for v6.2

  - Remove an unused function involving a non-explictly signed char
    type,
  - Reword a (correct) comment to stop the inflood of (incorrect)
    patches trying to fix it,
  - Defconfig updates.

----------------------------------------------------------------
Geert Uytterhoeven (2):
      m68k: mac: Reword comment using double "in"
      m68k: defconfig: Update defconfigs for v6.1-rc1

Jason A. Donenfeld (1):
      m68k: mac: Remove unused rbv_set_video_bpp()

 arch/m68k/configs/amiga_defconfig    | 42 ++++++++++++++++++------------------
 arch/m68k/configs/apollo_defconfig   | 42 ++++++++++++++++++------------------
 arch/m68k/configs/atari_defconfig    | 42 ++++++++++++++++++------------------
 arch/m68k/configs/bvme6000_defconfig | 42 ++++++++++++++++++------------------
 arch/m68k/configs/hp300_defconfig    | 42 ++++++++++++++++++------------------
 arch/m68k/configs/mac_defconfig      | 42 ++++++++++++++++++------------------
 arch/m68k/configs/multi_defconfig    | 42 ++++++++++++++++++------------------
 arch/m68k/configs/mvme147_defconfig  | 42 ++++++++++++++++++------------------
 arch/m68k/configs/mvme16x_defconfig  | 42 ++++++++++++++++++------------------
 arch/m68k/configs/q40_defconfig      | 42 ++++++++++++++++++------------------
 arch/m68k/configs/sun3_defconfig     | 42 ++++++++++++++++++------------------
 arch/m68k/configs/sun3x_defconfig    | 42 ++++++++++++++++++------------------
 arch/m68k/include/asm/mac_via.h      |  8 -------
 arch/m68k/mac/misc.c                 |  2 +-
 14 files changed, 253 insertions(+), 261 deletions(-)

Thanks for pulling!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
