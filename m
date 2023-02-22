Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB74369FC85
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjBVTyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjBVTx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:53:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2437E23DBF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:53:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD3ADB81711
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EE85C4339E;
        Wed, 22 Feb 2023 19:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677095631;
        bh=lwralkY6ZeBhsCj4WeGB/8I/u4Ut7PfVZSJscMOzjZY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IdE0PvBm7wQJX3j0wcEjxmOYs4XjCFHVXC7zgEK5nYGzfiweEvYiP818grh0h9qoh
         icJjDtBsLr559W14Rcu11M5NgDa4HFqHUTKqgrhrBiCMZoDzTDqGzc+1SsVBMNBCCN
         Z5gl7W1M5+rfAMomIPWgm16aXHVASu1S2RmM2bu8HI+LnXdw6c8T6djmqs/J6KNM4R
         2r3f87E2ibsflbmaFt0Q+UP4j1V9uvErbAJq/J0+KmWwK9wfHhvfHdNP7GXT0a9Yen
         PJ1/3dUI0LHtL4oQr9mP3WasEfgxQpalUuXaK2ytjVT4qRvyuqDylLuDeBsfG3HSer
         Acz2q97U+NzDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C0BAC43157;
        Wed, 22 Feb 2023 19:53:51 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230220143357.C38C0C433EF@smtp.kernel.org>
References: <20230220143357.C38C0C433EF@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230220143357.C38C0C433EF@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.3
X-PR-Tracked-Commit-Id: 7f62cb8861190e7cc1018ff37597fc49b2eaafa8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0175ec3a28c695562a08fdccf73f2ec5ed744e2f
Message-Id: <167709563137.30115.2368534355457923052.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 19:53:51 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 14:33:49 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0175ec3a28c695562a08fdccf73f2ec5ed744e2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
