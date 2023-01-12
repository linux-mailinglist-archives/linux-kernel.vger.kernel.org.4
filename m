Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C7F6687B4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbjALXBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240666AbjALXBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:01:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749CB5FA0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:01:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10602621DA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6853BC433F0;
        Thu, 12 Jan 2023 23:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673564470;
        bh=jD0B44I2KUAnyKrqxKAoOgZmutvD8Bacz6eZXVXyPxE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=adYAp+zn/qP3XA13pLcRxKwTo8vVHU4y17mdxt4+ZYh0eY5IlFxrF3xs6p13/sWtG
         Im+Yw67gmQXi95Q0Vqn6c5/x8LHr8Na3kJzBOxLW4F0IrihbyG+BgzZSaTXSe4YEYz
         D99YZTd6mPZy4cpq+9HmE+JsMkBlODXjFbN8VxAmM1OR9g+5trS8qqnqWmJjIKcdJE
         DT1Bx41XcdYVp8Gb8NRCe45R+GRrxIdCMCf8sJ3tiLQTLgR4C66wjBYwQLa1O2VCWH
         mQFOvMDvaieEHDa93kdD7AGCmf5CuTz8Rcs3pG+FzEuCYQkNvdv/Nc1PXWVUh++oAn
         azEvi/vn/n7RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CD25C395DC;
        Thu, 12 Jan 2023 23:01:10 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8AYWxzqkoKQfgV9@gmail.com>
References: <Y8AYWxzqkoKQfgV9@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8AYWxzqkoKQfgV9@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-01-12
X-PR-Tracked-Commit-Id: 9a5418bc48babb313d2a62df29ebe21ce8c06c59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea66bf86536d4d98932843896e9d940110a06701
Message-Id: <167356447030.16103.11845332350726197405.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Jan 2023 23:01:10 +0000
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

The pull request you sent on Thu, 12 Jan 2023 15:25:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-01-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea66bf86536d4d98932843896e9d940110a06701

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
