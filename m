Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE79D639D00
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiK0UuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiK0Ut5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:49:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF08DEEF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:49:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81AD5B80B64
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 20:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 320ECC433D6;
        Sun, 27 Nov 2022 20:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669582194;
        bh=49uYma9fDfrlO6dWLsCQKIVfIsh+gZWL2YpYQqlhTU4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a6WUXTdkSmndlzJsWgG0hpAGrC17i/lbibhWKvCSoerVtLglHMV+WM9jYrNdKtlK6
         c2/QwA9nJlPcGbY+0DbRkZKdJLkqfuI0CQhA05BYP1RjoCQK97nrm3pajF0pBt0uDz
         q85w/73ZY4FqJVRM2K6c0SFRAofEW0seFBrHnTYnDbiUhgpdcZqrn03ggLiS1zM0SO
         BEJRM7K6df/SNY9r/M2X2ZxV3mxvv6g6feq2IrgHquqr26iKruVV8hzSnBAqczfacz
         9rH05yfCyt10UdqG4x1XK40B2+eSUgPKapeunBRsITsQB2GzKs7TNeMP4BAiXrhwzX
         j6nPNEVWVdBjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09E94E29F3D;
        Sun, 27 Nov 2022 20:49:54 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4NGdmo0OcxvZ5H+@zn.tnic>
References: <Y4NGdmo0OcxvZ5H+@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4NGdmo0OcxvZ5H+@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.1_rc7
X-PR-Tracked-Commit-Id: 4dbd6a3e90e03130973688fd79e19425f720d999
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 08b06441267984d2e42cefc1dfb587e2d2d8512d
Message-Id: <166958219403.7005.629190945650738131.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sun, 27 Nov 2022 12:13:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.1_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/08b06441267984d2e42cefc1dfb587e2d2d8512d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
