Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D825C68B16A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 20:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBETsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 14:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBETsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 14:48:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21B81B544
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 11:48:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B3C8B80AB3
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 19:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28A8FC433EF;
        Sun,  5 Feb 2023 19:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675626492;
        bh=Nu3oqhCnRmR4+f/5MWGTIfcaS/MeFIRoJeVRbuGHwY8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RWxUAU3d47PDDP3Pb1i3DOJ1tF789kD7KnHH+PjSC/4C3/GiJcdaLtafxWjUH51+E
         ZHe6xb0Ho+8PrLlTGwXeyxr0q7nRKt69msnxmQxx4wd4eaZoCJzwSTzdiQsO29ozTu
         6bmkdThJ2Kfi4PmCOTeV9wnNxfpq/dmDY60vTYizpnaCD/NzgAESq9jjHXTrOm44ez
         3vldIK0T7FsE85ybaVgGYG7WMhzZCzsU9+wAcby0Du6csky277wIaGiK7DimlNftIG
         OaT4rNI15RZKcdQvT3ewx/KeuWfmQXGdqPdpYYUQ6Bvaf5ZGBzyrDppRdXCbalgjr5
         /TReS0xNfX2xQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 163B7E21ED0;
        Sun,  5 Feb 2023 19:48:12 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y992xcV7/Zg/30va@zn.tnic>
References: <Y992xcV7/Zg/30va@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y992xcV7/Zg/30va@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.2_rc7
X-PR-Tracked-Commit-Id: 4f64a6c9f6f11e8b7314f8e27e2c4568706009e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de506eec89d8456dfe344fac5b72afce0dce07a3
Message-Id: <167562649208.9320.6674189984191992827.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Feb 2023 19:48:12 +0000
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

The pull request you sent on Sun, 5 Feb 2023 10:28:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.2_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de506eec89d8456dfe344fac5b72afce0dce07a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
