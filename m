Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9566267724A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 21:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjAVUUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 15:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjAVUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 15:20:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC0115CA3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 12:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5083B80B69
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 20:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91D74C433EF;
        Sun, 22 Jan 2023 20:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674418838;
        bh=WlXdsC9A0/9p1cxSdpupYhEAqCaazI4vau3qUW+OzJk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=itWgISiaT44m2dtqZrZOxwxXJnVquboWgjuzcvcx/HhQgp3Nm+doPX2O4Yross1ms
         fCA82+8uT9vzMbcVmAe7qGNMR/fHImRe/PnRqAl3Wg9tTIks4XDcJLe9d2MMnnhmYQ
         ka9ywuhCoVthB6au4Dc5X7vcOR3XgMKDNl/0uAX2jbn5Uk14A74+anVJeMWFO1JCKT
         WGkEkONQztTMFGbP9wvQPNSy5/cBgvjQlFTUCJsKaHMDJTg9j7QAmtGkbILNRHS22l
         SUEWdfHdXeSC0LDP9qWdFSqr7whoKXQuxOPdVTyBzYU6yZhNZU6n9lyJnblDh82Y/E
         4LWGSZXh9qqlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B885C73FFF;
        Sun, 22 Jan 2023 20:20:38 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y80lgQ26uCQCdG+b@zn.tnic>
References: <Y80lgQ26uCQCdG+b@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y80lgQ26uCQCdG+b@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.2_rc6
X-PR-Tracked-Commit-Id: 5a8a05f165fb18d37526062419774d9088c2a9b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b299a1cd43271ffb582342a2a3c227aea0f32ac
Message-Id: <167441883850.2461.18284817805016577797.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Jan 2023 20:20:38 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Jan 2023 13:01:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.2_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b299a1cd43271ffb582342a2a3c227aea0f32ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
