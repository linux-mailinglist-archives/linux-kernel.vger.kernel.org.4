Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893AF63B81E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbiK2CpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiK2Co7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:44:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDFC47312
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:44:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CA7561529
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB9F0C433D6;
        Tue, 29 Nov 2022 02:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669689896;
        bh=EfMP6nipdDT1NUSSMTX/uBFztei0V4LUsDKGJohM/d4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZfaO5ZuCqays/grRrQOeIHqIPXvYphvNpueBFQ32IX1QgiJG20tKwda+IK791AR+t
         w1GrpfgWXDcb3kXPprzm7L8/zgeNc+1gL8+P8KMIGahfKQskl0loq2HPV5PHx152oK
         j87OUSSUW5hadcRPAdbhC8bgp3fOUdVNZNtIKhJMK5Luyg3kPQ9d8jenZIYCqTaEV5
         Lziajpgwe+hjGv6nFy/VuBHfFN71+XVpsd2hwHV80+RogoiNM47zXyBfeTWSWssQzL
         4pEtBnOP+uxnVp/STtzIfuPjD9oSb7LSbXI/kPKa5rG1Z9HUysDR8hXjzp1LbZoru0
         fVBOFIk6gOERw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D72A8E21EF7;
        Tue, 29 Nov 2022 02:44:55 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221128145150.02fd60e2@gandalf.local.home>
References: <20221128145150.02fd60e2@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221128145150.02fd60e2@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.1-rc6
X-PR-Tracked-Commit-Id: 4313e5a613049dfc1819a6dfb5f94cf2caff9452
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb525a6513fad6e28f063f56db0a17e264bc8811
Message-Id: <166968989587.2175.1168069549439080312.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Nov 2022 02:44:55 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Nov 2022 14:51:50 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb525a6513fad6e28f063f56db0a17e264bc8811

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
