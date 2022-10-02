Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311835F243C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJBRUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 13:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJBRU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 13:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95382220D5
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 10:20:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B8E160EFD
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 17:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BCE4C433D6;
        Sun,  2 Oct 2022 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664731227;
        bh=t6ITKPjTGhJe9zfGIsMJiO1s8sogpJtFVuDQaANc3bo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IwoGDq7tbuyvnp2vw6xGU+3dwUpCeIShGUhVvK3XGc5ufHgIPKlo8G2AiPVXufeB6
         ILOMBiql5WXMt/kbRkMqBZbJKBL93APGyp4bXhEaJ7NjZv31nejBwAnpoDXeNLUmig
         DcBBSCd9e4nMP2mAoBOlqdCDFtxj4+5jytULkSxzXs0tUjtjhFgnxvqvE0bPATnHW3
         6LZTQa9NJmfybWCeHVoQCWPxyzhMrDeYrWTV66eM6HHc+o2Wwwn55IKLh2otbKKHAt
         0sGIvLp3iCwM/cQwDQm3W0uZxfwPF/QzD0g+fzLDk06mLRcF2kSfc83Z673cu6+8ey
         N/yZBGJmHdAzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50564E21EC6;
        Sun,  2 Oct 2022 17:20:27 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzllraQ0SCkNe8v1@zn.tnic>
References: <YzllraQ0SCkNe8v1@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzllraQ0SCkNe8v1@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.0
X-PR-Tracked-Commit-Id: df5b035b5683d6a25f077af889fb88e09827f8bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 534b0abc627a4034ecaf177e780b1680e61b37f4
Message-Id: <166473122732.23668.12025359307421796924.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Oct 2022 17:20:27 +0000
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

The pull request you sent on Sun, 2 Oct 2022 12:19:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/534b0abc627a4034ecaf177e780b1680e61b37f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
