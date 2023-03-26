Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C036C96C7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjCZQVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjCZQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:21:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A7A1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84DA3B80D17
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FBAEC433A4;
        Sun, 26 Mar 2023 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679847667;
        bh=D+ZnQLlQPhHv6+oR3/E+Nm6x3fOjm1Ewnuuhyo20NPQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S1nzKpuYtkGv73ZxqjcaEGskKEg9tHl8REGuAebj4zbpnqMEREtkLSoUXfa0U7kjF
         Ys9NSTJSg31VTTVAg+OsBygGsLnhl7bTwyUTlpRRj2HgqVoHnJyhOiR34P7lYe957B
         IREm9xpZkDrMbOYcVcRbd29fAnwF6v6kKAO1b62m+MUQ2SDVaQwD2HQr+q16BpC/xL
         h7NtQyBkcuwVg7UnrKtld8jaZTnVtoDQdu1y8XxOOM8Oi/asXXvV5/HmEtBv/maJpv
         IQkQ1fcf4YpSS0Y1rozFGpmqutuDPhbsTpte7RopX13V8nJOIbVykE5JDZ3qoqZpPs
         QbZlop64CNNbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15BC9E55B3C;
        Sun, 26 Mar 2023 16:21:07 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230326130354.GDZCBCum4r9MJ8thhi@fat_crate.local>
References: <20230326130354.GDZCBCum4r9MJ8thhi@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230326130354.GDZCBCum4r9MJ8thhi@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.3_rc4
X-PR-Tracked-Commit-Id: a53ce18cacb477dd0513c607f187d16f0fa96f71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18940c888c85fd7527375343bd4fcc94a540c69c
Message-Id: <167984766708.13454.8044404005575607124.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Mar 2023 16:21:07 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Mar 2023 15:03:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.3_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18940c888c85fd7527375343bd4fcc94a540c69c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
