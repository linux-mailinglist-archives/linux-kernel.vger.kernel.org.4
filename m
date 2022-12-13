Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7258B64C0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiLMXcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbiLMXb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:31:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348C91009
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:31:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2127B81606
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CAEFC433F0;
        Tue, 13 Dec 2022 23:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670974314;
        bh=EbpGkqfXSaUDlLEuGEr9I+nSq2gytYzMVlJpKsPk4P8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hq4hagbFGhet9OUYNU1j8Jl2131mPDj65l5qEoowX7LBLc3VaQ84w10T2B6mGzJgj
         W2zKG5kcWXo8QWcqLGyg6MPbndbGQmyjFOzmU36MvpPVdQV0I59jiLYMi/zEi0Mghk
         Qi+420pB3a2o1Igyuw+TwatJXnEZtNH4mBFYW+3JtnjDkkiRiW+iAgjnHgB12n3MAR
         +Vg0yCEwk75+s9VsUaOGkUT7jGtWB5p4HzpgY62/Xey9mjeYs/UChjzUtMyjrfDyjp
         iiZ5RS69UN+V6E6F2AZnzba9bkhWjsOWKbqbiXAhtr4QmC4okz5KyKSCk91rJMqh2D
         TsBWcgF4B5qoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B035C41612;
        Tue, 13 Dec 2022 23:31:54 +0000 (UTC)
Subject: Re: [GIT PULL] x86/boot for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5hqkAfK7okjRh6n@zn.tnic>
References: <Y5hqkAfK7okjRh6n@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5hqkAfK7okjRh6n@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_boot_for_v6.2
X-PR-Tracked-Commit-Id: 60253f100c5846029f1370e51be6ebaeb160dcec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4eb77fa102ebc2a48d61941fd0293b0aeed00fee
Message-Id: <167097431456.3216.7438846638678062119.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 23:31:54 +0000
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

The pull request you sent on Tue, 13 Dec 2022 13:11:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_boot_for_v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4eb77fa102ebc2a48d61941fd0293b0aeed00fee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
