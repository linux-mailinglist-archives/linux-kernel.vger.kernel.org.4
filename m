Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0955BFF02
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiIUNgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIUNgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:36:04 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCA0671BF2;
        Wed, 21 Sep 2022 06:36:01 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oaztP-00077s-00; Wed, 21 Sep 2022 15:35:59 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 939D8C0203; Wed, 21 Sep 2022 15:35:53 +0200 (CEST)
Date:   Wed, 21 Sep 2022 15:35:53 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v6.0
Message-ID: <20220921133553.GA13191@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4cf:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.0_2

for you to fetch changes up to e9f3f8f488005f6da3cfb66070706770ecaef747:

  MIPS: Loongson32: Fix PHY-mode being left unspecified (2022-09-19 16:31:32 +0200)

----------------------------------------------------------------
- fix missing export for Lantiq watchdog driver
- fix ethernet phy interface setup for Loongson32

----------------------------------------------------------------
Randy Dunlap (1):
      MIPS: lantiq: export clk_get_io() for lantiq_wdt.ko

Serge Semin (1):
      MIPS: Loongson32: Fix PHY-mode being left unspecified

 arch/mips/lantiq/clk.c                 |  1 +
 arch/mips/loongson32/common/platform.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
