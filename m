Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948816E29AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDNRuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjDNRuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26699210C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B708B6496D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 17:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24012C433D2;
        Fri, 14 Apr 2023 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681494613;
        bh=WZRbQRqH4e7yc4/ZQrSWpzr2f88IPovT0DbH8l99Snw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UmcYVTAzw1IhuwnjGb12LSV+QmjMvvp0jAUDg+U3LH1WJr8RLBYE+/DKYjXyjdnHL
         CyKv5J88aGjeOi6CRNYNqCcoE5+DNdPy/jYuLP0i9YzFzIvZl8ie62bm9cklYOeQO/
         otU0xK1+soJXs4J48ShE1VrgE3uHRMRsNoej4YZIBjoebi0YqgCbUhknmX2DhNgC90
         idq0spx2WvVRtoy62B1ZVgo/V3ZhRrNvcNKzf0sbcLfUeDMfosUv+JTFXoG2nuoxvK
         jSUMB14XvPuu7322mB6JCfB77gqcexwRpRn9vRsiRdwHWdB2vb45CL7/oaMfNMKUJg
         oH8f37ejfRtxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0186AE52446;
        Fri, 14 Apr 2023 17:50:12 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-f47ee915-bbee-4c49-92ea-1d598355a0f3@palmer-ri-x1c9>
References: <mhng-f47ee915-bbee-4c49-92ea-1d598355a0f3@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-f47ee915-bbee-4c49-92ea-1d598355a0f3@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc7
X-PR-Tracked-Commit-Id: 1b50f956c8fe9082bdee4a9cfd798149c52f7043
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a934f4bd7d6f9da84c8812da3ba42ee10f5778e
Message-Id: <168149461293.15164.16774872103556012068.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Apr 2023 17:50:12 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Apr 2023 07:47:26 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a934f4bd7d6f9da84c8812da3ba42ee10f5778e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
