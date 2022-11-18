Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6FA62FEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiKRUVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiKRUVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:21:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC164E413
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:21:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 694AF6276D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 20:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF282C433C1;
        Fri, 18 Nov 2022 20:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668802859;
        bh=6iI6TvYDawwQ+2kytuwWuZn2a5xW2H0B1LFfTmKXJ2A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UwGRl7CXPTP0FPvwDnorxjWqLY9+PzwfCikhLflRCOZJnbkts8OcytEUukc6Gp+F5
         S0/gsE0Djbip4swUHerFOK87y7T3U9lJknBUnneJ+dbssss5tm6pTE6Y/ZDNlFisQa
         +XB/bLqRv6RiIhm6Tm3tdDVQl9CWUb2YL6d1BdyHBRu0cK435zwAKFjnZPlDmk6o8V
         tLAxs1Fjr6u7Js16f8M1yPTVttFd+6P5MW7KWtLvATxg4kgpmtG2AGZLH2AM16R/PN
         DTij+el3pN/GirmS2rxpuRpT1CmTzUreQhA/ExiGIlV7WNIdlNBD1vDtTR7ib/uhRP
         5axAPzZxG2UDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE226C395F3;
        Fri, 18 Nov 2022 20:20:59 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fix for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3fJ4o2sEO7Kef0y@kroah.com>
References: <Y3fJ4o2sEO7Kef0y@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <Y3fJ4o2sEO7Kef0y@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.1-rc6
X-PR-Tracked-Commit-Id: 937ec9f7d5f2625d60077bb7824fee35dc447c6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12fe29ee259f9a14fba4c593eff55b851ef264fe
Message-Id: <166880285977.9331.8704744718538007263.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Nov 2022 20:20:59 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Nov 2022 19:07:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12fe29ee259f9a14fba4c593eff55b851ef264fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
