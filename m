Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F35464CF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbiLNSFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239288AbiLNSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:05:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6519C1E3C3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 207E7B818A6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 18:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3F92C433F0;
        Wed, 14 Dec 2022 18:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671041076;
        bh=Dlun+MRuHE9BKA7bYbc7kq5P/Kzbp1cR+/G+XwunarY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ECFNi2jKLrI8Kx/xD3a82zuEUiHG6gSNrTRLgNKngf9jQlYIsYwZVUXelLCcjMWdG
         aiTlAME23D6m8QZlBZCk/ExP3EH3G1dIEip0/49xyf7Z6wJZOQJ8PayYYA8Pg2X7qv
         l5GO4qlgoV5/x5+Czh3GsWlf3ThckjtjDvxJnij9IcPCYoRQ5D+d2sZOSgvu3eZN3w
         ec+/63OHp2oKLPG20B7zOZf2RyZ6FcKX1a3vwMJ8GU9laNPc3KZEJb3PRfN+lFyRrA
         rX4tU7Nt8fesq3m6vEteZgom9Ek9GG+psL+UOL8wIw6DaCm8Zrd5wfVfE+Ftwl7pii
         6w5fJ18HnJUEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D273AE29F4D;
        Wed, 14 Dec 2022 18:04:36 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5kHHAOgXCz3zQzi@mail.local>
References: <Y5kHHAOgXCz3zQzi@mail.local>
X-PR-Tracked-List-Id: <linux-i3c.lists.infradead.org>
X-PR-Tracked-Message-Id: <Y5kHHAOgXCz3zQzi@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.2
X-PR-Tracked-Commit-Id: 08dcf0732cb4d97b85493d9f60470e48eebf87fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0a6c76cf2a506c061072db6c187f8a641dc85de
Message-Id: <167104107685.17244.18259461213478551552.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 18:04:36 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Dec 2022 00:13:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0a6c76cf2a506c061072db6c187f8a641dc85de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
