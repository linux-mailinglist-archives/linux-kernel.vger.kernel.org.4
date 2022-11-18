Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BA862FEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiKRUV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiKRUVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:21:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA3A4FF88
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:21:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14FF7B822D1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 20:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0407C433B5;
        Fri, 18 Nov 2022 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668802864;
        bh=Q3v3S7UGWgmOhLfDYSDxxWjQBud9sdpVcrBv+5MYH+s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ESFiP7f7o5j6dfdFzktEcTZycm4MWDM6e41k7ZzA7A3GQrhZAltvwMn9lb7Fs5DFp
         iroDfGk4fAOyRhSfTlYN9mrTuq5IMbH+w/dKZxD+d8JTOPqwZSxAN8RMPrpvqjqUrE
         S3YdhKY/OCTz1O1K8z8c/sJdUCpvN6TRIbh3zyfu+rea07toKJK9m0QDADEm1kB7QV
         mwxkSZFfPyIPUuvoG3BCkuUJ15MZUlarI92CgK1wmk33wzo/Fj6J0u5TPqH7WWyE5s
         KMhv3NUDmo6tcg8fwlrlxSPw8Yi3S6kjAvOnvdDbRBoYpAlLLDdxtH2OHthLfB47bY
         br99FNvZ2lCVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE14FC395F3;
        Fri, 18 Nov 2022 20:21:04 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3dQPc4c0pOW6KfG@kroah.com>
References: <Y3dQPc4c0pOW6KfG@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y3dQPc4c0pOW6KfG@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.1-rc6
X-PR-Tracked-Commit-Id: 1edfe4ea16ca2c9e91ec6cecd446b13636724e4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63c8c0d7dcb687c123ec6dc7e958cd54ebf956b6
Message-Id: <166880286470.9331.17304614267335645928.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Nov 2022 20:21:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Nov 2022 10:28:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63c8c0d7dcb687c123ec6dc7e958cd54ebf956b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
