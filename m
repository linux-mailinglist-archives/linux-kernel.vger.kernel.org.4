Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6E169B5AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBQWrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBQWrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:47:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D508D6665A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:47:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EAE662085
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 22:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E490C433D2;
        Fri, 17 Feb 2023 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676674066;
        bh=luqgV4kScazHV6dhXU3cC4RLXwXa7+Ar02mJRjsgCEA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KE4kLTyWhGufl2CwY89oLtOKfvDA361LUdQ2CCCMlo3qqVVXA0usoW9asmlQm0hAo
         9m0rm0sC1X7ajXYIG6wY65BxgrRMn67iI7lNhsyyAxQSaxdE5tSoklRpXfoQmrZygr
         DFbO7Vz+GA/z5YfDVWkbM35jP0VDr/LsodcqLDfWD+MlfmjX/tiOb8tSliJQjE6B0q
         Crwg6Qxc3oRy0yCroj2C00ebzgG4oCFzCKRfjA6mc9mTzEq87NnQcUiLYUZ0YZ9sAv
         X+5SE/NpxPmwbZXkUd5rEVRAKx22DyAbJtDzu5PZOa9KjorXBAwzUxc6iUwAy+OfMj
         reaCo/Ly6OWNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AC53C1614B;
        Fri, 17 Feb 2023 22:47:46 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y+8v0JG8DvedQISA@gmail.com>
References: <Y+8v0JG8DvedQISA@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y+8v0JG8DvedQISA@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-02-17
X-PR-Tracked-Commit-Id: c2dbe32d5db5c4ead121cf86dabd5ab691fb47fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64e0253df67d5e1557e82b923c78f1bad185eb9a
Message-Id: <167667406649.13496.13984663502605448379.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Feb 2023 22:47:46 +0000
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

The pull request you sent on Fri, 17 Feb 2023 08:42:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2023-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64e0253df67d5e1557e82b923c78f1bad185eb9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
