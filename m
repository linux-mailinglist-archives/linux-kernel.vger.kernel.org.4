Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9436A0FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBWSr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjBWSr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:47:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01495504E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:47:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18B8761728
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CA89C433A4;
        Thu, 23 Feb 2023 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677178032;
        bh=s51h+OxlHX2eSApAfvI7lEucNFkCArZJU6P9f2hk6GI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zh+aKKuN2mArHqUxJUyS7LRTePAaCkSmuljj+pHZDv3uZ4pN8JD9DcRDXZ18ud3rD
         x83pNsqAc2Pg7eoUOd8xYJOzL4Y5tBhtupR+Kg1+Bw4Erx+VP8thPQxyTIHwwPUDcM
         NT7qKWcz2M5IoQ3FeXYQh6mnOlAGZSAZvft3LXqtYDOtP45uK07LZN7oZfd3/MW6Ua
         res/5d+ZoJQqZiFIJif0R/p3WOx5Xq0nIt/I5lechGMHcrNQ3ZN4kx4EaLA7K3qTZH
         wiwDVTk3+WVbvvgwOQnid/ddEfQ44mekkO78TojEmydxQ8UtUFIw9u6121XkK7SAoX
         LGSB56gL2fjrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B0B8C43157;
        Thu, 23 Feb 2023 18:47:12 +0000 (UTC)
Subject: Re: [GIT PULL] x86 NMI diagnostics for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230222020218.GA1345108@paulmck-ThinkPad-P17-Gen-1>
References: <20230222020218.GA1345108@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230222020218.GA1345108@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nmi.2023.02.14a
X-PR-Tracked-Commit-Id: 344da544f177f919cf6919e5abcd388f27aa53db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 525445efacdfeed71329ce8bc5f558859a894b8b
Message-Id: <167717803250.14005.17029470835034385179.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 18:47:12 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 18:02:18 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nmi.2023.02.14a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/525445efacdfeed71329ce8bc5f558859a894b8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
