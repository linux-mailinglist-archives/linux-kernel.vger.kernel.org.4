Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF95F94B4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 02:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJJABO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 20:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiJJAA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 20:00:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021A76C76B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 16:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED1C0B80DE0
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AECE7C433D6;
        Sun,  9 Oct 2022 23:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665358401;
        bh=hsj6AAjkpKQy9Nj8qF7bhJHVTXyjs8ioDiEbKfwQ4g8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lQ13Bm32ahxoOnzOlL4UvAgw3SLHyaYQhQ/dQLatIi5OSA72BKkdAxVllguMnIOtt
         /drkMmn+QtHEhjnt66tKY4MVrlzkmKeuZYagdtQ2bFdNpaNYkaGM8KaH9lPoK6aPWv
         4Fb4HQv79shK1wN20Wn5M9ugebXvOnDVRRJbWV9BnThlZyaaVhv/8UTVM2v5VNrSyw
         niatXqVStY1Zyky+woEkD/gf2rZ1UHs+/kH/RiuMUQ1FvI9md9Al3TnJioOIAn1TEf
         rXs+48BryedI4eR/Cbg8va9RgNfGjX+9IA0YEyppFSsxf5n8HdXEyZNLAJrqB4WYtU
         dG/r4GsgJ8AGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B6A6C73FE7;
        Sun,  9 Oct 2022 23:33:21 +0000 (UTC)
Subject: Re: [GIT PULL] ipc: mqueue: fix possible memory leak in init_mqueue_fs()
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87wn9gwp6n.fsf@email.froward.int.ebiederm.org>
References: <87wn9gwp6n.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87wn9gwp6n.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git refs/tags/retire_mq_sysctls-for-v5.19
X-PR-Tracked-Commit-Id: c579d60f0d0cd87552f64fdebe68b5d941d20309
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86fb9c53d82f1dadf960553a3bd351de6173911f
Message-Id: <166535840163.20820.1013007543288277195.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Oct 2022 23:33:21 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 03 Oct 2022 16:52:00 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git refs/tags/retire_mq_sysctls-for-v5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86fb9c53d82f1dadf960553a3bd351de6173911f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
