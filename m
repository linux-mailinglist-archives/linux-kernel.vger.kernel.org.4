Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05D6DCCBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjDJVVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDJVVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A1B1BFB;
        Mon, 10 Apr 2023 14:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 308D861F70;
        Mon, 10 Apr 2023 21:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B136C433A0;
        Mon, 10 Apr 2023 21:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681161675;
        bh=8k4fQsPLGEfrKVnW8yX0hDrkmwCL37BwrGNFQWMfzmc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wd3iGulpCJnA4OJCXNFg8jD6hdeaXJJACBsFdSn6ppBk2jZxCsOK5zDCgKQBNrtI8
         7r3MjUdufBh3FD7oB3UIgiPOIAsyP4SA1Rn/fczLJS++ItZNdsL8unNE+kcpvs6l97
         bDxX4sw2Fw+hcHeude9VNqmsKsYnlABh8bBSJyhdvS8sEzKosvVwkP94hadIXUcj2M
         4vRuntMle+Un9bCRTCwYzpB3Vy0cb4YmcywbzMLiaWDO6Qd1PvQVFr4ahUSqNUlF3p
         LwplZPeDQk+9VumOvLuAyFLyBKS0uvP4RrdgmzdxLbX+s6DCikqdjsVo4pWNKwHIMA
         PXBgKuyqE41bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78401E21EEE;
        Mon, 10 Apr 2023 21:21:15 +0000 (UTC)
Subject: Re: [GIT PULL] Fix too-short kfree_rcu() grace period for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5c2748db-4811-4d3d-bdd3-0f005ffa275c@paulmck-laptop>
References: <5c2748db-4811-4d3d-bdd3-0f005ffa275c@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5c2748db-4811-4d3d-bdd3-0f005ffa275c@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent-rcu.2023.04.07a
X-PR-Tracked-Commit-Id: 5da7cb193db32da783a3f3e77d8b639989321d48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d3eb744aed40ffce820cded61d7eac515199165
Message-Id: <168116167548.31176.12514039777589092543.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Apr 2023 21:21:15 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com, rostedt@goodmis.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Apr 2023 09:30:33 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/urgent-rcu.2023.04.07a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d3eb744aed40ffce820cded61d7eac515199165

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
