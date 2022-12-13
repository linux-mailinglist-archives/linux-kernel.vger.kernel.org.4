Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC88464C0AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbiLMXcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237249AbiLMXb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:31:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1816FDD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:31:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E52B61783
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF5E3C433F1;
        Tue, 13 Dec 2022 23:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670974314;
        bh=LGlYMR/KkvsaPLPWux/hkctOCKBL+doHyM/wXRvUmtk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MVzKwszh+bjqZQW4qKZJ4xKsqMRRmTXLuxLUUIKEG+t6P1tHsMzwLIPRvu/UrUHAZ
         QRX25xeH+jwPSSH9oX4NVoTTvm1ND8yNdzIIWakgiTb9oHclZGE9SeJuoBhxxTjs/B
         N4Itikiby/RRUN+T+7lupOWm84qKIoPNMx52w1+zRw9RSKufZzOu/b+sa/HNR0/DX9
         H4xNHfDkHz5dPME2J8CwK7S4LlWN/FrdfZY1NhShP0+4PGGfFeBOe0oZPGZ2um5fOF
         zsaz0aYwKD7bfI0G8V7WDzbIDbIU6jdha1ceyScNnhXrGZ4xOpsQlbE3K2HhUJa8/z
         HFSOhQCDrAsYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFF15C00445;
        Tue, 13 Dec 2022 23:31:54 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5iFrMDV+YOdncjA@zn.tnic>
References: <Y5iFrMDV+YOdncjA@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5iFrMDV+YOdncjA@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.2
X-PR-Tracked-Commit-Id: 7882b69eb6cdf6288a89d831d95c8547400a8b4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ef3ace4e2ecf4aa4c8ddff1d35683671a09b05e
Message-Id: <167097431484.3216.8891751154042629883.pr-tracker-bot@kernel.org>
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

The pull request you sent on Tue, 13 Dec 2022 15:01:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ef3ace4e2ecf4aa4c8ddff1d35683671a09b05e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
