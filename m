Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1286F20AC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346678AbjD1WEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346718AbjD1WEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686494213
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:04:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F090E6456E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B9DEC433A0;
        Fri, 28 Apr 2023 22:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682719463;
        bh=Dk0QW3SeM2ED+jRetiddrGfTtc85w1+40SE0eNkxLMQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rkpAtDIkJ3ek44EFpIRz/yg+jHVAvYBxBv5zEuLb/gASaPqgQ7f2s07OzCa2orAA9
         ulDJnLmLg/5Z+Qv8soMTn4fRV3BQP6jQbOKJMRlBl00ugktQvrBfOup85DG3Metars
         wv03nsd1cyW6atiG4f0BYbTWjtdlMMSBrdE+mcX/t0KFuYqzBZJUAvcLrSD/pjRgIg
         wVBAHwbT+K9Uo5U7JRfQmrPHGYdfAfKh5avQY8w7/bIlkwMcrzpNpcxEnfYmDuzdsp
         rr0bbN5YX4SyP8P6wyZf9wKAW64OJIMAm/F0l6Mcn4i4+Ixpz+s9kQvrgCg1tfTaa1
         dgfjzkrfkQtgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47C06C43158;
        Fri, 28 Apr 2023 22:04:23 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZErgOfOLrBwluTbd@gmail.com>
References: <ZErgOfOLrBwluTbd@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZErgOfOLrBwluTbd@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-04-27
X-PR-Tracked-Commit-Id: f31dcb152a3d0816e2f1deab4e64572336da197d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 586b222d748e91c619d68e9239654ebc7fed9b0c
Message-Id: <168271946329.9872.13740650936821087687.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 22:04:23 +0000
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
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 22:51:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-04-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/586b222d748e91c619d68e9239654ebc7fed9b0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
