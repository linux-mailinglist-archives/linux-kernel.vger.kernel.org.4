Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7D6A8515
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCBPVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCBPVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:21:35 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34FFC2D149;
        Thu,  2 Mar 2023 07:21:34 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pXkkN-0006vy-00; Thu, 02 Mar 2023 16:21:31 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B7329C11F4; Thu,  2 Mar 2023 16:21:23 +0100 (CET)
Date:   Thu, 2 Mar 2023 16:21:23 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes part 2 for v6.3
Message-ID: <20230302152123.GA11226@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 91dc288f4edf0d768e46c2c6d33e0ab703403459:

  MIPS: vpe-mt: drop physical_memsize (2023-02-20 15:11:01 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.3_1

for you to fetch changes up to 1a2c73f4834dd79e4f2c590ac75358fb44137650:

  MIPS: Workaround clang inline compat branch issue (2023-02-28 23:09:49 +0100)

----------------------------------------------------------------
a few more cleanups/fixes

----------------------------------------------------------------
Arınç ÜNAL (2):
      mips: remove SYS_HAS_CPU_MIPS32_R1 from RALINK
      mips: ralink: make SOC_MT7621 select PINCTRL

Jiaxun Yang (4):
      MIPS: Remove DMA_PERDEV_COHERENT
      MIPS: smp-cps: Don't rely on CP0_CMGCRBASE
      MIPS: cevt-r4k: Offset the value used to clear compare interrupt
      MIPS: Workaround clang inline compat branch issue

Sergio Paracuellos (2):
      mips: dts: ralink: mt7621: rename watchdog node from 'wdt' into 'watchdog'
      mips: dts: ralink: mt7621: add phandle to system controller node for watchdog

 arch/mips/Kconfig                     | 10 ++++------
 arch/mips/boot/dts/ralink/mt7621.dtsi |  3 ++-
 arch/mips/include/asm/asm.h           |  2 +-
 arch/mips/include/asm/smp-cps.h       |  4 ++++
 arch/mips/kernel/cevt-r4k.c           |  4 ++--
 arch/mips/kernel/cps-vec.S            | 35 +++++++++++++++--------------------
 arch/mips/kernel/smp-cps.c            |  2 ++
 arch/mips/ralink/Kconfig              |  2 +-
 8 files changed, 31 insertions(+), 31 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
