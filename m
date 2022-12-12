Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBDD64A685
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiLLSIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiLLSIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:08:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F08E140EE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34334611A1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 18:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 907CEC433F0;
        Mon, 12 Dec 2022 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670868449;
        bh=SEFV08FhfjMTL+Ya5XyxgJasD5/KvFkjoUNPjheQcxc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gxqSXMgUWd3u8nX2qcRArPqSSBXGtpwMa5I/epN8WBEAOKuSzPqv/EJDPH/7O9iEG
         2oqJ/h3L1ms8oAR6q38YANyrj16rvfm/horNu3uhpp+0u0RSo4ssByy9M9EcRdZ3MP
         9lCaiiWlxa4LC9pp4sl7jm2Q7OjokZp3DgVE2fbjeR2DtGGZ0QaOuk7WbxOAB4OiC0
         pQgd0odzgzfIQBmh6xQuecBsy3sK8zfMxuASNSxVh5xgrP6nKLWhYCStuAVYZitHaA
         rIapkc0r4Y63m5ii3hdwPmjwYEejnmNEoJ7loVNk1liBYNxYsHTxV83VX9yH2fFALf
         +d2OIXAyMHx+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80714C00445;
        Mon, 12 Dec 2022 18:07:29 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221209112500.GA3116@willie-the-truck>
References: <20221209112500.GA3116@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221209112500.GA3116@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: 5f4c374760b031f06c69c2fdad1b0e981a1ad42f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06cff4a58e7dfa018c5f8a6ebdc3ff12745e0bae
Message-Id: <167086844952.13437.1951864664297156149.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 18:07:29 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, maz@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Dec 2022 11:25:01 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06cff4a58e7dfa018c5f8a6ebdc3ff12745e0bae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
