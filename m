Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3B64D34D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLNXYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiLNXXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:23:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92925A1AF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:22:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73566B818DC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 395FBC433D2;
        Wed, 14 Dec 2022 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671060132;
        bh=S6Gmnkg1Rrwp2u66OqR9yvbAG1h4CwYj2TCOa6Z4Mmo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rRSIa0tbZccukHicYWIO35cZc0chfVX1H4rFTCjVgLuZhkYwzepgpZ5SMlZz627BJ
         DB4xPAeHMcRVQIpCL1FCw4NR9SPYwtULpBfrrVNVkpO0oEcoAfACvefJnt/88c9Wfz
         EdWHT5LVLcn6QVvtuluWfDquxQKJwrXLe6iDWiKsmGaL2rTiqbUGbDEXxXLeMJ+FyC
         aSNiDicj2GRc87nFBA2/KVhZtTUyZmoTYUkPBaNwjvPKz1irI1CSNQWZHA4LQfPQ5t
         fRnLIssEp6h7eURRuR9OD4MGQJMetcoH7NUy7SoItLKVbQ2Wpbrx8WW06jHcOC+4OI
         e939h2fzkxmcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2888AC395EA;
        Wed, 14 Dec 2022 23:22:12 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5mplIDz1VX7DMhG@zn.tnic>
References: <Y5mplIDz1VX7DMhG@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5mplIDz1VX7DMhG@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v6.2
X-PR-Tracked-Commit-Id: f1a033cc6b9eb6d80322008422df3c87aa5d47a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 94a855111ed9106971ca2617c5d075269e6aefde
Message-Id: <167106013215.20441.7552372751414437204.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 23:22:12 +0000
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

The pull request you sent on Wed, 14 Dec 2022 11:46:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/94a855111ed9106971ca2617c5d075269e6aefde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
