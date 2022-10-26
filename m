Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E360DA28
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiJZEF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiJZEFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0C63DBCA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 21:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A7A61CD8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B453C433D7;
        Wed, 26 Oct 2022 04:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666757119;
        bh=11nFNElIFGRiw9yFBvy6kGo6koioymhUxNfO9aouqbo=;
        h=Date:To:Cc:From:Subject:From;
        b=qLTteNtj7JQSchC8DRns7OZwARkqJDqp95CecqoliFNuYeo9iOe5Sv/o3JLADHdTf
         u99a+E2mGyqkTp7zrQzpcL/jZydYJoEo5QHo0cG3RIGK+6w6JLNkwHDkj9qFz3uUDq
         g5OZeKk7Ohxx7pQwzJvX+OgL5kV9zr1Xt7UMvFAbzmTIORXncJJ9tTeigI2ckuf+LJ
         UFlSEe4JJZt811gAAYv1EIdt+mUlzX0DQSESSeRQUfE5OTH3ezssvi6ezYS1X8hvS6
         JHHKr77QAekU1KWOh765wuf9+xw/golijyBtG3O/LyUjtStAtX1snkjjaPpDa6o7VW
         y51qVOl6wzPXQ==
Message-ID: <9ad919b3-b450-8e22-c422-371957c41391@kernel.org>
Date:   Tue, 25 Oct 2022 21:05:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>, Pavel.Kozlov@synopsys.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Zhang Jiaming <jiaming@nfschina.com>
From:   Vineet Gupta <vgupta@kernel.org>
Subject: [GIT PULL] ARC updates for 6.1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some fixes for ARC.

Thx,
-Vineet
----------------->
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

   Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ 
tags/arc-6.1-fixes

for you to fetch changes up to 4fd9df10cb7a9289fbd22d669f9f98164d95a1ce:

   ARC: mm: fix leakage of memory allocated for PTE (2022-10-17 16:32:12 
-0700)

----------------------------------------------------------------
ARC updates for 6.1

  - Fix for Page Table mem leak

  - defconfig updates

  - Miscll other updates

----------------------------------------------------------------
Amadeusz Sławiński (1):
       ARC: bitops: Change __fls to return unsigned long

Jilin Yuan (1):
       ARC: Fix comment typo

Lukas Bulwahn (1):
       arc: update config files

Pavel Kozlov (1):
       ARC: mm: fix leakage of memory allocated for PTE

Randy Dunlap (1):
       arc: iounmap() arg is volatile

Serge Semin (1):
       arc: dts: Harmonize EHCI/OHCI DT nodes name

Zhang Jiaming (1):
       ARC: Fix comment typo

  arch/arc/boot/dts/axc003.dtsi              | 4 ++--
  arch/arc/boot/dts/axc003_idu.dtsi          | 4 ++--
  arch/arc/boot/dts/axs10x_mb.dtsi           | 4 ++--
  arch/arc/boot/dts/hsdk.dts                 | 4 ++--
  arch/arc/boot/dts/vdk_axs10x_mb.dtsi       | 2 +-
  arch/arc/configs/axs101_defconfig          | 4 ----
  arch/arc/configs/axs103_defconfig          | 4 ----
  arch/arc/configs/axs103_smp_defconfig      | 4 ----
  arch/arc/configs/haps_hs_defconfig         | 1 -
  arch/arc/configs/haps_hs_smp_defconfig     | 1 -
  arch/arc/configs/hsdk_defconfig            | 1 -
  arch/arc/configs/nsim_700_defconfig        | 1 -
  arch/arc/configs/nsimosci_defconfig        | 1 -
  arch/arc/configs/nsimosci_hs_defconfig     | 1 -
  arch/arc/configs/nsimosci_hs_smp_defconfig | 6 +-----
  arch/arc/configs/tb10x_defconfig           | 7 +------
  arch/arc/configs/vdk_hs38_defconfig        | 3 ---
  arch/arc/configs/vdk_hs38_smp_defconfig    | 1 -
  arch/arc/include/asm/bitops.h              | 4 ++--
  arch/arc/include/asm/entry-compact.h       | 2 +-
  arch/arc/include/asm/io.h                  | 2 +-
  arch/arc/include/asm/pgtable-levels.h      | 2 +-
  arch/arc/kernel/smp.c                      | 2 +-
  arch/arc/mm/cache.c                        | 4 ++--
  arch/arc/mm/ioremap.c                      | 2 +-
  25 files changed, 20 insertions(+), 51 deletions(-)
