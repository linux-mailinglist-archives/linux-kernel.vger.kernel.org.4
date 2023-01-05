Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC2665E1CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbjAEAlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbjAEAio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D07AC5;
        Wed,  4 Jan 2023 16:38:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34409B8167B;
        Thu,  5 Jan 2023 00:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC522C433D2;
        Thu,  5 Jan 2023 00:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879080;
        bh=YzuyfztP3LvU0R5JDum5PIxAVt6t/0MVi/7Xpg7pR8s=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ZKMpWq6qEReudGh4tkDMG84FeVdzhdQI+gyEum4ji61+CiLuepwFcZpAtWPtNsNyc
         suYsuMu2gvRiaeZn3ryAD65eLDxoKCVY0V6w4LiDQDUlmumBRnkBqnmeleJcAdb8+C
         2mybshgd5vEroEwBgaZZrnugGzk9lxC3HOifH+TKNJsb7JDtrkfKJHWuzG8rYTrIw1
         nIxKXgVsYei+WNGQTea9hZjRNCRx8InIGY06NX4t6NXAisF8CZU4h67ugd7kQLp/hh
         8i0kNDS54RUjvK6hd8n1GjRBHLpm6d24k7iG+nnbsj2YEQSM0R2+ghUW4Rtc/Q20bK
         pMS4BzGWSUSEA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 861D45C05CA; Wed,  4 Jan 2023 16:37:59 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:37:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/27] Unconditionally enable SRCU
Message-ID: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series removes Kconfig "select" clauses and #ifdef directives that
are no longer necessary give that SRCU is now unconditionally enabled,
courtesy of new-age printk() requirements.  Finally, the SRCU Kconfig
option is removed entirely.

1.	arch/x86: Remove "select SRCU".

2.	arch/arm64/kvm: Remove "select SRCU".

3.	arch/mips/kvm: Remove "select SRCU".

4.	arch/powerpc/kvm: Remove "select SRCU".

5.	arch/riscv/kvm: Remove "select SRCU".

6.	arch/s390/kvm: Remove "select SRCU".

7.	block: Remove "select SRCU".

8.	drivers/base: Remove CONFIG_SRCU.

9.	drivers/clk: Remove "select SRCU".

10.	drivers/cpufreq: Remove "select SRCU".

11.	drivers/dax: Remove "select SRCU".

12.	drivers/devfreq: Remove "select SRCU".

13.	drivers/hwtracing/stm: Remove "select SRCU".

14.	drivers/md: Remove "select SRCU".

15.	drivers/net: Remove "select SRCU".

16.	drivers/opp: Remove "select SRCU".

17.	drivers/pci/controller: Remove "select SRCU".

18.	fs/btrfs: Remove "select SRCU".

19.	fs/dlm: Remove "select SRCU".

20.	fs/notify: Remove "select SRCU".

21.	fs/quota: Remove "select SRCU".

22.	init: Remove "select SRCU".

23.	kernel/power: Remove "select SRCU".

24.	mm: Remove "select SRCU".

25.	fs: Remove CONFIG_SRCU.

26.	kernel/notifier: Remove CONFIG_SRCU.

27.	rcu: Remove CONFIG_SRCU.

						Thanx, Paul

------------------------------------------------------------------------

 arch/arm64/kvm/Kconfig                                      |    1 
 arch/mips/kvm/Kconfig                                       |    1 
 arch/powerpc/kvm/Kconfig                                    |    1 
 arch/riscv/kvm/Kconfig                                      |    1 
 arch/s390/kvm/Kconfig                                       |    1 
 arch/x86/Kconfig                                            |    2 
 arch/x86/kvm/Kconfig                                        |    1 
 block/Kconfig                                               |    1 
 drivers/base/core.c                                         |   42 ------------
 drivers/clk/Kconfig                                         |    1 
 drivers/cpufreq/Kconfig                                     |    1 
 drivers/dax/Kconfig                                         |    1 
 drivers/devfreq/Kconfig                                     |    1 
 drivers/hwtracing/stm/Kconfig                               |    1 
 drivers/md/Kconfig                                          |    1 
 drivers/net/Kconfig                                         |    1 
 drivers/opp/Kconfig                                         |    1 
 drivers/pci/controller/Kconfig                              |    2 
 fs/btrfs/Kconfig                                            |    1 
 fs/dlm/Kconfig                                              |    1 
 fs/locks.c                                                  |   25 -------
 fs/notify/Kconfig                                           |    1 
 fs/quota/Kconfig                                            |    1 
 init/Kconfig                                                |    1 
 kernel/notifier.c                                           |    3 
 kernel/power/Kconfig                                        |    1 
 kernel/rcu/Kconfig                                          |    3 
 mm/Kconfig                                                  |    1 
 tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt |    4 -
 29 files changed, 1 insertion(+), 102 deletions(-)
