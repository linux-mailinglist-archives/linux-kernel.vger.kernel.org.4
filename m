Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A95C74C179
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 09:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjGIHkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGIHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 03:40:13 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6414EE46;
        Sun,  9 Jul 2023 00:40:10 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qIP1d-0000bE-00; Sun, 09 Jul 2023 09:40:09 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 49137C01C1; Sun,  9 Jul 2023 09:40:02 +0200 (CEST)
Date:   Sun, 9 Jul 2023 09:40:02 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v6.5
Message-ID: <ZKpkUhSd/GGm37IM@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e47084e116fccaa43644360d7c0b997979abce3e:

  MIPS: Loongson64: DTS: Add RTC support to Loongson-2K1000 (2023-06-26 09:18:43 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.5_1

for you to fetch changes up to 3a6dbb691782e88e07e5c70b327495dbd58a2e7f:

  MIPS: kvm: Fix build error with KVM_MIPS_DEBUG_COP0_COUNTERS enabled (2023-07-07 14:43:01 +0200)

----------------------------------------------------------------
- fixes for KVM
- fix for loongson build and cpu probing
- DT fixes

----------------------------------------------------------------
Huacai Chen (3):
      MIPS: Loongson: Fix cpu_probe_loongson() again
      MIPS: KVM: Fix NULL pointer dereference
      MIPS: Loongson: Fix build error when make modules_install

Krzysztof Kozlowski (1):
      MIPS: dts: add missing space before {

Thomas Bogendoerfer (1):
      MIPS: kvm: Fix build error with KVM_MIPS_DEBUG_COP0_COUNTERS enabled

 arch/mips/Makefile                         | 10 +++-------
 arch/mips/boot/dts/mscc/serval_common.dtsi |  2 +-
 arch/mips/boot/dts/pic32/pic32mzda.dtsi    |  2 +-
 arch/mips/include/asm/kvm_host.h           |  6 +++---
 arch/mips/kernel/cpu-probe.c               |  9 +++------
 arch/mips/kvm/emulate.c                    | 22 +++++++++++-----------
 arch/mips/kvm/mips.c                       | 16 ++++++++--------
 arch/mips/kvm/stats.c                      |  4 ++--
 arch/mips/kvm/trace.h                      |  8 ++++----
 arch/mips/kvm/vz.c                         | 20 ++++++++++----------
 10 files changed, 46 insertions(+), 53 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
