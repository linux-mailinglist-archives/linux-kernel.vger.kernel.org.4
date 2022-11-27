Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B8639CFC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiK0UuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiK0Utz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:49:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACE0DEFC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:49:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D507F60ECC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 20:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42BB9C43146;
        Sun, 27 Nov 2022 20:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669582194;
        bh=BqTvh34p93F2PuH453lA0BEP/1LBRs9IzT4gwIyJy5o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ix7PF5UKXCg+HaQDlIeo7Jo5M1YZYvNxQY1eCxhGYjWlCNQ5lissOGXZkLTzFnuij
         ae3lZnupdhpUk2BjCVQ9/c05x2yshuQyY3Jcy7JR+iUiGp+77hOqwqxTga4PNl3/hm
         VevFXPfHM3tJgKSxwqdj4jQk9P+4l4sypFwWf/oXVN/BdYAmRfHdbJ4FAzNW3CUzVa
         p/U2SYqyQDSRBFfn8//8h+/YBD1oZfjmFaTGlXxAEAWvEhXakt5sFMxvEeT0wjyziz
         DHkS8F/gfkq2Zi9Qz7306XrkDv3dpIsFxr1uvz0Tn0ZJsxcXSt0MXS0mLtN5XeTNJs
         8BjhRI4xvsLow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27444E50D6A;
        Sun, 27 Nov 2022 20:49:54 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for 6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4NJqBtjsoZJtIsm@zn.tnic>
References: <Y4NJqBtjsoZJtIsm@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4NJqBtjsoZJtIsm@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.1_rc7
X-PR-Tracked-Commit-Id: 839a973988a94c15002cbd81536e4af6ced2bd30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 715d2d960871c238e5860d121ba9735e7f6a7ff1
Message-Id: <166958219415.7005.14993010606952135553.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Nov 2022 20:49:54 +0000
To:     Borislav Petkov <bp@suse.de>
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

The pull request you sent on Sun, 27 Nov 2022 12:27:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.1_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/715d2d960871c238e5860d121ba9735e7f6a7ff1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
