Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D12D69E846
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBUTaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjBUT35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:29:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B31621979
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:29:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 795CB61158
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 19:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1244C433EF;
        Tue, 21 Feb 2023 19:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677007795;
        bh=8NJTMV7T8N1uBwGUttU6roIVBXUAiwgB+yb9SbyPPWc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qw1+8wkjZBc0w2o1s8Khp9w1Ci7qB5DFkSa6augioDy2L4CPQLZoyTNVpkPAwQLhv
         azGhmk5zEi5To1T/a+rLias4vai6Qh5uOzYhgthIJq2vkTDYQeXl+9XEBTlVl9sncZ
         s3COreJ2SLbBRaHjUArmf1RbYtsD2qu/kIv1D+1wit0R/AoDHfefv6t+G5wNDzYGfV
         3qlMejgg/wRSY54VHKfzxBIxm8oOjIhG3s7VljdBP6Iu2fPih7oE8FXCcpaoQNq58x
         0XY/zaAckiTf9wNW7EQwadv4JX88GCueoL3RHhm/BA/F5nPrP1zu0CBTvBxW2EwmHh
         9zRK6S1zwacWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D15D0C43158;
        Tue, 21 Feb 2023 19:29:55 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue changes for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/KuM8ovt66dSAHU@slm.duckdns.org>
References: <Y/KuM8ovt66dSAHU@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/KuM8ovt66dSAHU@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.3
X-PR-Tracked-Commit-Id: c63a2e52d5e08f01140d7b76c08a78e15e801f03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e82b41e1e3cc74108712a66b5be8a7b8be9e8b0
Message-Id: <167700779585.6594.7718170383333908934.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 19:29:55 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Feb 2023 13:18:11 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e82b41e1e3cc74108712a66b5be8a7b8be9e8b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
