Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2073B5F964B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 02:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbiJJAaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 20:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbiJJA3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 20:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5131B136;
        Sun,  9 Oct 2022 17:04:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9DD960C2B;
        Mon, 10 Oct 2022 00:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1AAC433D6;
        Mon, 10 Oct 2022 00:04:14 +0000 (UTC)
Message-ID: <f16e5bde-0560-9306-be82-d5a825485fb1@linux-m68k.org>
Date:   Mon, 10 Oct 2022 10:04:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v6.1
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu changes for v6.1.

Just a couple of changes. Fixes to compilation of the old/legacy Freescale
68328 targets in some kernel configurations, and some default configuration
updates.

Regards
Greg




The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

   Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.1

for you to fetch changes up to 404b7577cee2dc302ae259604b163cabd9bfd4f3:

   m68k: update config files (2022-09-30 10:12:10 +1000)

----------------------------------------------------------------
m68knommu: updates and fixes for v6.1

Fixes include:
. fix build problems for legacy 68328 targets
. clean out configs of removed options

----------------------------------------------------------------
Greg Ungerer (2):
       m68knommu: fix non-specific 68328 choice interrupt build failure
       m68knommu: fix non-mmu classic 68000 legacy timer tick selection

Lukas Bulwahn (1):
       m68k: update config files

  arch/m68k/68000/ints.c               | 6 +++---
  arch/m68k/Kconfig.cpu                | 4 +---
  arch/m68k/configs/amcore_defconfig   | 4 ----
  arch/m68k/configs/m5208evb_defconfig | 3 ---
  arch/m68k/configs/m5249evb_defconfig | 3 ---
  arch/m68k/configs/m5272c3_defconfig  | 3 ---
  arch/m68k/configs/m5275evb_defconfig | 3 ---
  arch/m68k/configs/m5307c3_defconfig  | 3 ---
  arch/m68k/configs/m5407c3_defconfig  | 3 ---
  9 files changed, 4 insertions(+), 28 deletions(-)
