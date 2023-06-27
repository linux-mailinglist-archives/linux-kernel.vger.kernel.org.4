Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E2E740671
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjF0W1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjF0W04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4C92D5E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 889D061244
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 22:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2D0CC433C8;
        Tue, 27 Jun 2023 22:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687904804;
        bh=/bQ2WS54R8kjjki777jLglAlsKOxtBp3CVlyxovdmgk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YorM+vZQvnGpj0/fIvKKDDuv6Kpa4U0KbqEm1DDlbH6Nl7wubyNC1ZIJaXe0yaPcx
         eyc6M/8xlGkKJ0YtIJqKe+4bqFQeSklcVl3imimKYxZuzR0sgYbI1G2MxQgHMRK4NC
         7HwiKEzcZc05lp01h46CtvVgpTbmfXJxUHozHnwf5ThXWEaaUSlatXmSQxBkBol+aM
         WJC+Q1tK7Xw2VmC9ZiWnhv/+2RcgiTw8NHXSUgMckYND/S4DZXgKA0fX98Yq0Dk7tX
         QJbeFvE12Yc6WAdwoVNo1CEbrxafsa84mmIikNkwvdwRQPRqd2DCTTJJLsNfueIUOt
         sK7W+kEof0I+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF809E5380A;
        Tue, 27 Jun 2023 22:26:43 +0000 (UTC)
Subject: Re: [GIT PULL] Scheduler changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJq3HtUKZp2uMWLu@gmail.com>
References: <ZJq3HtUKZp2uMWLu@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJq3HtUKZp2uMWLu@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-06-27
X-PR-Tracked-Commit-Id: ebb83d84e49b54369b0db67136a5fe1087124dcc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed3b7923a816ded62dccef377c9ee346c7d3b1b4
Message-Id: <168790480384.30460.11125687327188884484.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 22:26:43 +0000
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 12:17:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-06-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed3b7923a816ded62dccef377c9ee346c7d3b1b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
