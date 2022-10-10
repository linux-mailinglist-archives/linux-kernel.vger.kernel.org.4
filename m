Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE305FA2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJJRWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJJRWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:22:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1C44D833
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A972C60FC7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F9EDC43141;
        Mon, 10 Oct 2022 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665422527;
        bh=A524WYfrpoxKCvSwMMAitOqA5Yt/WgPNbGH5m/NQrWE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rODDP/g9BXxywY1kavQZgRDIkbeKRqXod7FpFMLOpt/8RzR55u1izk7OqoaFQM3Pg
         1JDC0Fq08QCpdURs78oFdwECphJI5iifvmlgH9cV3LzqGJmur9P9Efo33uEuysN0FU
         PXOX0XA+IaUuIO+QLnqbaHghxdLjSsBO9oOFLbmIHqrrGmvoj5tDoCxG09+pJDr5ZV
         uTB7JDEqm2zJwiSTWsBOxwtWSiLni5rcfs7o47evEfbf3tfiiSPeKvhRii3+PJyf7G
         YJ2aNydoPm6jXVE7MzQs+lZAY2c9Mrm3wc/FiYD5JQHFEhyvozAjKDI6jL7gmNqs/k
         NwCa79FqgjlKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFF4EE4D00E;
        Mon, 10 Oct 2022 17:22:06 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yz/VEcAmcUP/hLkn@gmail.com>
References: <Yz/VEcAmcUP/hLkn@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yz/VEcAmcUP/hLkn@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-10-07
X-PR-Tracked-Commit-Id: fdf756f7127185eeffe00e918e66dfee797f3625
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30c999937f69abf935b0228b8411713737377d9e
Message-Id: <166542252697.13651.16655126579990157413.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 17:22:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Galbraith <efault@gmx.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Oct 2022 09:28:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-10-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30c999937f69abf935b0228b8411713737377d9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
