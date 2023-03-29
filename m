Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324116CF143
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjC2Rll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjC2Rlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D4855B1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CDFB61DE2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 17:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B034EC433EF;
        Wed, 29 Mar 2023 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680111694;
        bh=ObuytjLa4eeOivSqVw0xJwNboKHFJrAVMi7DBvLkeaA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z1UBfquvMVr+iBan9HL0t44w0BE0rH6y1o2scmZr0QdCcFABNdlrSPb6288hckwm8
         bxDobx2kWiNjcIJIlWc+HzV9uXuwQTCfWXvBqUzXXocFGy9HcCNy87JRvahu80sFYu
         F4ntOs0iQzxHJJYYRTZ2H7bwqsDOy+1kJOeq7O1rYQalejY+c8n1igw8ZSycTPPE4R
         KUi8Ti/lIAW9KPWjue51Lk6I+oydntU/ju/VU2rlXTI8ryQr8PnhPSWPoi2ONHoeuH
         w8jJHfeY8EvlFxJ3nooywEkHOpOz6b3KrxxFTHkepTb6qL9cnelFPGrnRQ1qD8Rpok
         xdwlo2UO0LvdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9481CC41612;
        Wed, 29 Mar 2023 17:41:34 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs fix for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZCOHd4jYn8zUCEZ0@google.com>
References: <ZCOHd4jYn8zUCEZ0@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <ZCOHd4jYn8zUCEZ0@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-6.3-rc5
X-PR-Tracked-Commit-Id: 0b04d4c0542e8573a837b1d81b94209e48723b25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3577a4d37f9e5caeb817e221482385151795ec6a
Message-Id: <168011169459.2257.13514222310679539779.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Mar 2023 17:41:34 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Mar 2023 17:33:59 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-6.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3577a4d37f9e5caeb817e221482385151795ec6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
