Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CC764ABB6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLLXpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiLLXpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:45:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF7A1C928
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:45:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E93AE612AB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59490C433F0;
        Mon, 12 Dec 2022 23:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670888734;
        bh=m9VakBbG337zy0qxlU4N3laa+d1eMzhV9EzTJXguhpQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FLabNdWGM8pbS315v5RwoTpQ5noyHcUa/zGx9XwFiSUbfbq2/arr90KgxWF2+XDuR
         gJWGc9oC/IfsNywZpgx8dO1gKjWC4g670nDh9y4d2w8yjeQVkMstTbltmkg/TFGtgW
         BR/3EEWJMrxOVl6IdcMDgPasl+NxbW+2RE5mAbg3tVjqFUxHU5kDPiGKVJzNG2fq0/
         KR/JIFKK8dVEZ4bJIbSfnHeiguiOHUOuIH0u6Goc2wcyh3RI0kkw59Q2B2B7nDdJ6Q
         B/Z5+7D7xLnRiQdBcp9UE0MzyTddNVb6TQv/TqRqKT5kWz4sSlnoFg/OUTS7FRlw8e
         VosaKnxnSVuBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4797DC00445;
        Mon, 12 Dec 2022 23:45:34 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5eT13pECzbv96Uu@gmail.com>
References: <Y5eT13pECzbv96Uu@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5eT13pECzbv96Uu@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-12-12
X-PR-Tracked-Commit-Id: d6962c4fe8f96f7d384d6489b6b5ab5bf3e35991
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf57ae2165bad1cb273095a5c09708ab503cd874
Message-Id: <167088873428.9522.4019057876280432374.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 23:45:34 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
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

The pull request you sent on Mon, 12 Dec 2022 21:49:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-12-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf57ae2165bad1cb273095a5c09708ab503cd874

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
