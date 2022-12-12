Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DE164A956
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiLLVNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiLLVMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:12:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE6E1A21C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:11:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98B896123E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 21:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 063A2C433D2;
        Mon, 12 Dec 2022 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670879510;
        bh=5CGSJflTEnNcAFugBp6QH1MyL6huZmbB8LBiclZetKo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WzSHbc9tk7PNcFUC/DTV/a+tBfjdfqcT6OLiy+8UlmAXOdmm83VeiK3lTeQfx8OUX
         oMpGxi6uaD2cDTvSbu/4cle3CSGQ0nAb9AfcBcrNk1I/SnqlLcjeuWkdvyqQHoem7J
         gIvuIDT8u4K9RMaid3YhrWjXL4YNe99hJ296aYvYHSDspBwcd9szGll64UW1KHzZIq
         JZOWpIHTmgHvqFlgb+QsGQ2hpo6KBaRqj8sCOdOaqaHWGty9zfIebRxHqTi5obYK0H
         2LFkLwFupbyIajPckBI6JndF+zdfZTSG0yEBVczsbZ2KvBpQ3JIgr+2YQW4rYNiotu
         5di2VkNuYmckA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7F46C00445;
        Mon, 12 Dec 2022 21:11:49 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <167083908288.564878.16194193666147663160.tglx@xen13.tec.linutronix.de>
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de> <167083908288.564878.16194193666147663160.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <167083908288.564878.16194193666147663160.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-12-10
X-PR-Tracked-Commit-Id: 18a207849218d8c15072f449e6d0b901262290c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a1d4434db5f86c50018fe0aab299ac97dc15b76
Message-Id: <167087950994.1809.2571252256764986716.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 21:11:49 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 11:09:04 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-12-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a1d4434db5f86c50018fe0aab299ac97dc15b76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
