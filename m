Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43106A2698
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 02:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBYBiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 20:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBYBh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:37:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1EFEC6B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 17:37:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58A62B81D7A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 01:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08ABBC4339E;
        Sat, 25 Feb 2023 01:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677289075;
        bh=4jayJUebCMjDp6THBy6SHTCNXR/U37FXifVzlOzX59o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kza/Gb+S5DAvIOeDXA/1HkT2va5gEDikSsUQcD49+rbpxmsd7b+4wqbUMHHrkwFBq
         Pck96k175zntty7y1dqSZpM2CsPb5DzI53l031Zd5bvfxvWXoSV4IS7tz6YWRZWTS2
         2hL2HDcjj+JD6yTd/bHY3w4+tS1wZvwPrOL4zJ7oTrX/mkemk7zDUzbPayMKXtWReq
         7cD3F/Yly+G/DcMs54f8NntNKx7WNPrrE/EdKdMl7YH9H1Q+523yKQ5ayLNTeaUtKt
         vgpH17WnswnKC/puo++O2zpzXQrq6gHV5RFUNcYi+y98ChPYUrtWMTFXJ6IFpgX2rH
         5f/Ge3J8/xWTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC5EEC43151;
        Sat, 25 Feb 2023 01:37:54 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/i/dVFrB855ADjV@matsya>
References: <Y/i/dVFrB855ADjV@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/i/dVFrB855ADjV@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.3
X-PR-Tracked-Commit-Id: 3584f6392f09440769246d4936e1fcbff76ac3bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ff99ad04c2ebacb272ff9e4f6155c35be136b3d
Message-Id: <167728907496.28954.935929983155164636.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 01:37:54 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 19:15:25 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ff99ad04c2ebacb272ff9e4f6155c35be136b3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
