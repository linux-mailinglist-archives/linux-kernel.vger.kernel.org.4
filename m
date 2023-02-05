Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1239F68B169
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 20:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBETsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 14:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBETsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 14:48:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F661BADA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 11:48:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F418B60C0A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 19:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 598F3C4339C;
        Sun,  5 Feb 2023 19:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675626492;
        bh=jgByU9uFqiEnel3RJhdYwhkQ0Ais6fsqCiZyOywkiKw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u4XFlrsmi4wVkRiNIbITLblHDJqUobD1U93si8otJ5aCKAIub5l3GubRsHdZfeW/v
         Uh+CsOm+Z+O3cStgY6wiCydlvGP1ES2+VqtcLkWwkZCXCyiaoriXU59LdRRl+loFI0
         sMiVEJbKjdEXhmVTcv5/EWDTkCHUfjUYjPoIkYgprqFSbCRsco8cYDxUP69tYKqAWB
         5Do1Ru19IvKRuBnh7nIMCB/5V084o7An2M1YZs9rOGb990Y1aKkAT3VR620sVdGbpa
         NtWKZgkEGhu7dhR9J4G9mAcJcW0zeXlB0NxqzpXfxWj0rTZfXaCWPJAtrfew+EVjtc
         bk5CxzRDBgdDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FBC0C4314C;
        Sun,  5 Feb 2023 19:48:12 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y9949A/s6DB4oVwF@zn.tnic>
References: <Y9949A/s6DB4oVwF@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y9949A/s6DB4oVwF@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.2_rc7
X-PR-Tracked-Commit-Id: 9d2c7203ffdb846399b82b0660563c89e918c751
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e482602c59457374916d942b4ba6ff602b14fa4
Message-Id: <167562649225.9320.1162584803130741419.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Feb 2023 19:48:12 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Feb 2023 10:37:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.2_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e482602c59457374916d942b4ba6ff602b14fa4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
