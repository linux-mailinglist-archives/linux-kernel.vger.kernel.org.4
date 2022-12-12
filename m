Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F8464ABB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiLLXpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiLLXph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:45:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247B71CB09
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:45:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8B78B81018
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A400C433EF;
        Mon, 12 Dec 2022 23:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670888733;
        bh=0Ta4qkZUhTUn49N52wvRKxS2lbZPwhZGgzC+jkLFS9Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tBU+0t4ZkDTofTPNWgc429iVAbebFKc9B04NENrpQriZTDpTy9N/z7NOfuRdu7LA0
         wB3XDMqy3Iw9GG5X2GkTzsY+2GI3Ffg1H0w7ytjCk0wYCqr6d9o3p/nFTHiyiovlLe
         SF4icIa2+1lw1JKKKZ0NjkgA9y2TBvDspaPyjqeKWJ0azDsuAnhxeMLoAqeiTYAhYa
         d/5kBehLlfDFLY4uEM/0zeh65LG6p8Qt977ZgNLCTyoXQ4iVVtmbdLerBujQifRFtW
         44HuDtm2o4Nb88sUH8H7lq1Wy4x+/LK/5LsN5hg9TZIa7qE48xeUyFkp2Y8tv3thuA
         mLaMQ3dVd8mow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67E0CC00445;
        Mon, 12 Dec 2022 23:45:33 +0000 (UTC)
Subject: Re: [GIT PULL] ras/core for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5eJk3Tqh3Ip3oCx@zn.tnic>
References: <Y5eJk3Tqh3Ip3oCx@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5eJk3Tqh3Ip3oCx@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.2
X-PR-Tracked-Commit-Id: 50865c14f34edbd03f8113147fac069b39f4e390
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9196a0ba9f0ebe168c7b186f63cf7cab02e55778
Message-Id: <167088873342.9522.9230757731535958696.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 23:45:33 +0000
To:     Borislav Petkov <bp@alien8.de>
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

The pull request you sent on Mon, 12 Dec 2022 21:05:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9196a0ba9f0ebe168c7b186f63cf7cab02e55778

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
