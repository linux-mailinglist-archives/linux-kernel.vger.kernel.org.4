Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC196E3ACA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjDPRni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDPRnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AE826A8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3FC861C47
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 17:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54AC4C433A7;
        Sun, 16 Apr 2023 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681667011;
        bh=58dKAHYeTlKdvVBSiiCqpMWJNB9sPaDYtkw6+P/4DKM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cIanTh5tZTr1C11EfwzgC6Wc8VHOPDpbFMv5/5sEOpEMx3iIdp4zbTtnX4MSJXMhv
         1smtKAHYNMBElQtbBQZ4wApGoSLWycydPn0qLMayVxrcAHhSBPb/qiqwqnMkEFuE2B
         Pi9n9K1T/7yEYzgYw6qKl3MKdHtPW28WBrar62oilxAfDPz1XT/HZ7RE0krMlFN+34
         wvLo2j6/zVoNfzr2XR9nzY5X5CvNx1c9K/z1+8cUcqto8A3fuCauPH5/PPX0Xyg3U9
         TCw9VpDyI45dnqr7OV9MTcZXV/iD1Bc8cXosAlpg5ai7mS1i3NDjxG0RKnGtzPTgYY
         KUHIJVYjdTGsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 443AFE21EE8;
        Sun, 16 Apr 2023 17:43:31 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230416123412.GDZDvrRCv9VvvmXuPz@fat_crate.local>
References: <20230416123412.GDZDvrRCv9VvvmXuPz@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230416123412.GDZDvrRCv9VvvmXuPz@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.3_rc7
X-PR-Tracked-Commit-Id: 91dcf1e8068e9a8823e419a7a34ff4341275fb70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c538e1adbfc696ac4747fb10d63e704344f763d
Message-Id: <168166701127.4218.1846964940825600375.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Apr 2023 17:43:31 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Apr 2023 14:34:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.3_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c538e1adbfc696ac4747fb10d63e704344f763d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
