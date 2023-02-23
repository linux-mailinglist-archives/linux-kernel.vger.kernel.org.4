Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672036A0FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjBWSrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjBWSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:47:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC14D158A6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:47:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 801FEB81ACA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BCB6C433D2;
        Thu, 23 Feb 2023 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677178031;
        bh=6FnaLnMcCtJxtgSnhC/NmlUREbuMVrat4VRur9r5yy0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Nde1NXGYnyAui3A5nvd6wq3O/FWODHltkp/soy/uMizyQi+91fHJ8dx5bk6vaFiNv
         pmlJI8/bmnd+A4wCe4wj7Rl+p7t8esgnQXO7ATNPhxvhjM04BnBw/vMcIumzmBxd4a
         c6uPfTQN9z6FWfgMf2OZeSkMHX7jvFLMbZzrZ5sgG+uvEj8ntDhFrUt4kkn/9iunik
         JP2N0pdOEubiRKklAOYTtY0g8OfQtGM+O+TMFCzv6wD8UN6N+BA7QmEZor9veiGxf1
         XO2gSTwCp/TXMfATrSRDETm0wVcwGl8v5Pe74IRLFzWKb5AfhC8PUtCbFWVCtWdEk1
         6Y79fa6xuUG6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1ABBCC43157;
        Thu, 23 Feb 2023 18:47:11 +0000 (UTC)
Subject: Re: [GIT PULL] ktest.pl: Updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230220120138.2ae03ccd@rorschach.local.home>
References: <20230220120138.2ae03ccd@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230220120138.2ae03ccd@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v6.3
X-PR-Tracked-Commit-Id: 7dc8e24f0e09834341f84d37433840b353d64bc8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2562af68f0550317fbd3d5f520069c69d0cf5115
Message-Id: <167717803110.14005.3224698687021768772.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 18:47:11 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 12:01:38 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2562af68f0550317fbd3d5f520069c69d0cf5115

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
