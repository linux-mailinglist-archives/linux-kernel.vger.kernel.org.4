Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7B6E34C6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 05:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjDPDCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 23:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDPDCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 23:02:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9D4269E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 20:02:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6E5261504
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27FD1C433D2;
        Sun, 16 Apr 2023 03:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681614149;
        bh=Q9pF7NBGgp5Q6k/Q2BTtzCR+2NNuZhVAGS+Wjr99bQY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kVkTVVJJ5QUIMxec4T/EorzVklkVhQ7csSoS+db25yNacqhnC4UeHVHfUtduD+NNP
         DsSUXq2Nxc8Bu+3Lj/XCAVCl4CcIWyvPJSoz+ZKeTAqKHqGGXGAh9I9EuXkY32Q81S
         aWNWwQZzqr/rQS6GlsVJW6rGBji0kr92VYdzV4EroSAyU+TnEsHfKRAYjxDq2rb+EV
         ILIrOqo+PCbptsFXO9/kKadovj34fBFv+VNK0PXuVyru1dMSmFyJO5UgjPHmETybwR
         eAyoXBu0ziVunzgd8k5xn8WBBADds0n7ibC4xPYa9DJpIlazThMusSPP5xlKkZBs9l
         I4QBaO3LFZv7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13D47E5244C;
        Sun, 16 Apr 2023 03:02:29 +0000 (UTC)
Subject: Re: [GIT PULL] UBI fixes for 6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1571141363.69401.1681583046301.JavaMail.zimbra@nod.at>
References: <1571141363.69401.1681583046301.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1571141363.69401.1681583046301.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.3-rc7
X-PR-Tracked-Commit-Id: 1e020e1b96afdecd20680b5b5be2a6ffc3d27628
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc88aa51a61819956bb23dc26fa72b5bc9a81af3
Message-Id: <168161414907.1043.18375446280594861946.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Apr 2023 03:02:29 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Apr 2023 20:24:06 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc88aa51a61819956bb23dc26fa72b5bc9a81af3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
