Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FC16C96C3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjCZQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjCZQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ECC1BF9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:21:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A71B60EFE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 052AEC4339B;
        Sun, 26 Mar 2023 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679847667;
        bh=mxKLUh/KwDp7F5nJw1mKuhS8jhojqHHyfW7hXv0QBts=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oDjabcdcpGWgoT6zgEHyoQhat+f3yUj9VZ08081jHhsSfoxvDWge2QiJVnv0FMbH9
         8UuvTVs+MbiXEpYji7gIwChfFSz6q1gTGiyQS8DYxRsg6FgbnRiSZmcP8AQfNLeppG
         +0cQEu5QSjtGvo8TYjQPhQAzUEU2zTAjLgH7zApd/kLYskrgR4K7o3fMeVgPtdEU+f
         xjhsXqqNrDZO8+n/mFpEKhUb8LeQQuoSzHSnswLKnb3yfDgIRx1LhPTHqqY9Ld6Jdo
         2wIT+nNdNsUlFIZEfPPLQsS105Vikorf5mboZo08ZhIEPJIQUhjsxrWEzYGMJyeL4r
         RL0RYVX/iSB1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1B23E4D021;
        Sun, 26 Mar 2023 16:21:06 +0000 (UTC)
Subject: Re: [GIT PULL] core/urgent for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230326124735.GBZCA+58Z/H1QD3b7W@fat_crate.local>
References: <20230326124735.GBZCA+58Z/H1QD3b7W@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230326124735.GBZCA+58Z/H1QD3b7W@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v6.3_rc4
X-PR-Tracked-Commit-Id: b416514054810cf2d2cc348ae477cea619b64da7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6cdaeb08b66db0d06b1b70c0801a00b6f30571c
Message-Id: <167984766692.13454.12345599624840078361.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Mar 2023 16:21:06 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Mar 2023 14:47:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v6.3_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6cdaeb08b66db0d06b1b70c0801a00b6f30571c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
