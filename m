Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3194E64A950
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiLLVMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiLLVMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:12:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4441A064;
        Mon, 12 Dec 2022 13:11:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36B4961232;
        Mon, 12 Dec 2022 21:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9908AC433F1;
        Mon, 12 Dec 2022 21:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670879504;
        bh=pOqijv/HFXVIuo6uHx2j2DKvG63KHFqZXBc0EJC3XDw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OS1Tmv87Myj4bpBvRsfjwEe7SoCQQfISG9EuCsinpCTOTqbMmbuWkvLR7XyAKrGyy
         IiRxjTwfTpf7nA8Gswq4Mt808JTv10C4f8UvfUrS4y1U5O2/8DDc223S7lVErhztri
         TgWtNvS2cgmXFg5FObf5aQmFBIx5H74dn9XXPwYZUGQ8xznY0Bv7rN9wGf8xZQwGVt
         gP6WP/PSPcCUxLCPFF4fdftht6hksKiYyNe1EAFxxudyHbwwvrbZllVy9XCwlxuPeH
         0mOX3FFCWsRunPLk1W/CDG8XVi9X9jm3mJo/knnq91IHcX+tZjajhDmnzGAiKukqSj
         SYZntx8rzzzEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 886B4C00445;
        Mon, 12 Dec 2022 21:11:44 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.2 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5dZr4AVA7CzzHLy@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <Y5dZr4AVA7CzzHLy@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5dZr4AVA7CzzHLy@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.2-1
X-PR-Tracked-Commit-Id: bb3860cc02c660b409a1e02521b84b1d7d4e84cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47477c84b8914525b427bccbdcded0cf0086f2a1
Message-Id: <167087950455.1809.18373590716631543991.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 21:11:44 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 17:41:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47477c84b8914525b427bccbdcded0cf0086f2a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
