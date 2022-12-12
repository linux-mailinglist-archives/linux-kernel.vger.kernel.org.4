Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4064A602
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiLLRei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiLLRdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:33:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9569FE4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:33:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3A34B80DCE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 17:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E851C433EF;
        Mon, 12 Dec 2022 17:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670866402;
        bh=yHcgLC4QPsJFSfAdF6CXycVAthoLn4n9Q5ZxEt5O6Ek=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=szLr+4bjvm597SUt/eRsgdXfIEZT/ixrq3kKrOolhi952uh6+duniSHLM1tVmlIU2
         VS75qlk/cyiC0VmSD8Tv0FMxiqLZ6WHUIfLnLc3+97Q26y10TnaeSDxveT/O1BkFVu
         YUxOfMlglN177qnIcm1bNzQm0C3Ty6zzASB/s3rIPWrs1YzhPVRrHDobn8lkigC+ee
         A8zvJg0UtcoozbkWbf5SU7UfIHZ3lNNKXRVG4zk/erOceSqNQPKhgIA6qn8X6v7jL/
         S000W0Apvw+bdIA30O37Aszip7B6QtKHCF+2bn4cNGwRX9pOTSNndCqRgXgB4pT5I5
         34/BG/QdCP+Kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C618C00448;
        Mon, 12 Dec 2022 17:33:22 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp updates for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202212051629.61BD1239E@keescook>
References: <202212051629.61BD1239E@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202212051629.61BD1239E@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.2-rc1
X-PR-Tracked-Commit-Id: b9069728a70c23dad00684eb994a3f5295f127cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 667161ba0a1c5badc5c40fc45cf62a6d62883710
Message-Id: <167086640250.22610.15341389928212466596.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 17:33:22 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ayushman Dutta <ayudutta@amazon.com>,
        Christian Brauner <brauner@kernel.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Dec 2022 16:30:24 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/667161ba0a1c5badc5c40fc45cf62a6d62883710

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
