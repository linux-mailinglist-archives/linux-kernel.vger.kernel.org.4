Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A386687B2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbjALXBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbjALXBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:01:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B41645D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:01:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A04D9B82037
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48288C433F1;
        Thu, 12 Jan 2023 23:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673564470;
        bh=IdLV+j4UbZSMGxr9j/M32RMhQzrjHWUk8hR4vYulgZU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jlz2zfa7vnRHvO0paRBDsY1fykwq/ERf3keGc7rYvc/Bq53eGDfmL7s0lj33noBAp
         dDOivDP81MQxcN+IRmU/635UwgLv1l0hrmk6KsLWNoG5EGjF7eJbgrCLXmHKAC7DI/
         BMYRaObqi9Y3W7ysB9Hcpv92xg7X/1jwr5NocsDAjNHauT4kRyVfbsj9jg1CPWvLwy
         fL0pPR2FjFqa1qt1Gtc22OAnZ2gS3kQBQkn9mgC41HIRi88goNHBZnsI81E1VFA2bj
         dDAbX3oZFmx7qa8pl89EiuEYq5A7ScJh7vSsxDJil3zBoQCYuiHT5qD2/bnrPehkvQ
         ZdMcg5ced+kWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C4A7C395D4;
        Thu, 12 Jan 2023 23:01:10 +0000 (UTC)
Subject: Re: [GIT PULL] objtool fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8ARvWVv5gXT88Ee@gmail.com>
References: <Y8ARvWVv5gXT88Ee@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8ARvWVv5gXT88Ee@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2023-01-12
X-PR-Tracked-Commit-Id: cad90e5381d840cf2296aaac9b3eff71a30b7c5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf4d5be89c0ad339108e672a2f973bf276bd5d2c
Message-Id: <167356447017.16103.1709251541365035481.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Jan 2023 23:01:10 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

The pull request you sent on Thu, 12 Jan 2023 14:57:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2023-01-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf4d5be89c0ad339108e672a2f973bf276bd5d2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
