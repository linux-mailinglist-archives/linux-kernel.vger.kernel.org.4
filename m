Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D5C641FD5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 22:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiLDVZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 16:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiLDVZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 16:25:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A6C13CCD
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 13:25:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6C0560F0C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 21:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 105B1C433D7;
        Sun,  4 Dec 2022 21:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670189137;
        bh=tsyMRW13S7VrzLk/gTcsE3qNkFJHpS++7TxeZEJwkn0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rZvAeK2aghw1A8Ea7lpvPN0dAmpq/W2NoQ1WaaXziEocOyR1BQ4XU20QL3E0DbxsJ
         A/8N5uaOxO5HnoIZtA0H38YR175mz/3CriGtv40ZOWNq7va1XGj/YfXCQeLweWOl4N
         +mF2Wt1SYqcnCKlu8Tsp83ddS3ir3yBtjeTxSqGBJ6D7iaU5oLR1y6iRMl0SN+/0iB
         ITJH08NCikYjPxoxEfzQZa90tMUxbQCGod4uK+cuJACJW0nTxFOAr0OtEWGma/S1Dt
         /u2VafXwKVHno17GMMQYmLTLsznLKx+N4PnRb/+a2W7e+5hKRGaoWUrHhOnJrnFh3n
         uoVY9RS5/LbTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1CCDC395EE;
        Sun,  4 Dec 2022 21:25:36 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for 6.1-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4ymVQuBVF2RZslZ@zn.tnic>
References: <Y4ymVQuBVF2RZslZ@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4ymVQuBVF2RZslZ@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.1_rc8
X-PR-Tracked-Commit-Id: d9f15a9de44affe733e34f93bc184945ba277e6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eea8bebd51739cc7a3bb501032ee877b4aada553
Message-Id: <167018913698.1549.6525640352426096053.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Dec 2022 21:25:36 +0000
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

The pull request you sent on Sun, 4 Dec 2022 14:53:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.1_rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eea8bebd51739cc7a3bb501032ee877b4aada553

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
