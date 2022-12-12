Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A40364A4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiLLQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiLLQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:31:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57502FADB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:31:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A763B80DB1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADD37C433D2;
        Mon, 12 Dec 2022 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670862668;
        bh=tt7wUGZuXOoHiSN7xjSkR84MA5CfWqKqfiqTie3+UaA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Cjb0LXE7MzwE16TEaew6Mp7PFo3z7BDuI/RjApGPHUGjXKvDOYTEGh09XKL4NNu4H
         FpPmrLAPiZ+N2g6nNBToRntjGPPqar8SdVeIuGlDsiV7X+I8ujMTUyNspfhTeH57Pp
         E4/zlLHgb7VD+1C5v1Q2lNBiML9yv16IQt2jeMUupBE08U8ftFSGglziCUHqdr3Z+r
         oimU8r2Onb5Wly7G5D1e7Nkxufb/xQaf4uCSfSUYRstfoMMZIrUBVuMQa1o8JDlyxX
         hVWhOblZNTGh01uGDoTPeQtweP8bG0rq1/cQdiDODKXHQ0X53T4HI0/kx9tRuxTDga
         ujMc+Q2pihM9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9BD7EC00445;
        Mon, 12 Dec 2022 16:31:08 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221203012624.GA1817011@paulmck-ThinkPad-P17-Gen-1>
References: <20221203012624.GA1817011@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221203012624.GA1817011@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2022.12.02a
X-PR-Tracked-Commit-Id: 4a95be7ed7669311350d041ca6cd37bf96f92d8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 74dc488b2a1bee840f3cf29a4262e0b1184a4f5d
Message-Id: <167086266863.18680.13682609572302378678.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 16:31:08 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, w@1wt.eu
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Dec 2022 17:26:24 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2022.12.02a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/74dc488b2a1bee840f3cf29a4262e0b1184a4f5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
