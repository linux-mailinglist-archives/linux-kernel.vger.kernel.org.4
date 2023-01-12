Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC446687B1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbjALXBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240670AbjALXBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:01:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9327F645D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:01:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29316621DD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 852A6C43392;
        Thu, 12 Jan 2023 23:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673564470;
        bh=ExDADUhGsdKYmyCy/oBTDdN1tPJDfw8WTfxi8JjplrI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q0QR9Q4mnY4PVD+AgJs7myDe8e3go0BPWUsTO/T1TAI6jQhk4W0hfdXPfe98p1iSh
         8Bx+pEGRtn3cxx/5v7GKZy0W/PnfvTzO+XISIVhOtXN/KQiwVyiZ6zd8XJxA6cShGa
         lG4LWqgeZuk6fDvvh9pYXnJ7c8+Xj4wHC4616NRd7Gj4Qfj5YfqTk0BlsGxHdtLvKl
         w1OcDt4V+aL0strpyPijogojtapNNgsWdvnqZ1cmZZJL3Qkr0cDYNKUZn92KnexWpe
         E4mR6Lumtm+4Q+n5erIM5P6SYRVT+OyVTOATIWtCW6iyHAMmwknT964DDzuJBCTpAE
         IJu/3FrgRRRzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7119BC395D4;
        Thu, 12 Jan 2023 23:01:10 +0000 (UTC)
Subject: Re: [GIT PULL] timer fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8AcuX1o8aOSp7oj@gmail.com>
References: <Y8AcuX1o8aOSp7oj@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8AcuX1o8aOSp7oj@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2023-01-12
X-PR-Tracked-Commit-Id: f3cb80804b8295323919e031281768ba3bf5f8da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 772d0e9144df4fdf68b23f2136a512e2e5670e9a
Message-Id: <167356447045.16103.6954634151695869006.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Jan 2023 23:01:10 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Jan 2023 15:44:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2023-01-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/772d0e9144df4fdf68b23f2136a512e2e5670e9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
