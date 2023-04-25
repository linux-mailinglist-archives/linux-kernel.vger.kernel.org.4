Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D875A6EE743
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbjDYSBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjDYSA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19162161A6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99F0C6308F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E409C433EF;
        Tue, 25 Apr 2023 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682445653;
        bh=lwRBj+HnRpMPkqw5iiwgH4y+k73hUxi5Sg7cdD1M284=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rsxuw4euanlZ0hRibojmSPBqWFDYfLZ4MQmchsxtJNze9DDI267d6GKZVfxhr8kKU
         pb7EHYELqzAjVtwoxRx65lmcBROuuKom5UTh/6S7759lGBFJYtAka03n4kBZ5nj5Eg
         7eQDO68WLmyiMtcQ/nlrHgurGfxb/lkZGR7mEWUJoTeJR2ScW0ZAZNlgY9ihHQkf3m
         UXfpBJG+F3yDug3LlTIEqE+qklgdM6A7a796G70S06DTqi/6Uqy/FfB5kpEpRh2IH1
         I85urOgy7BaP4dW8sZcq/j3JxpAWpkr22hObWlPrc/gAwc5YNF922jzMRFxQ9lak42
         oYSc4FoWR/aWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF09FE5FFC6;
        Tue, 25 Apr 2023 18:00:52 +0000 (UTC)
Subject: Re: [GIT PULL] x86/paravirt updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424145148.GFZEaXhA07fMrO9ooE@fat_crate.local>
References: <20230424145148.GFZEaXhA07fMrO9ooE@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424145148.GFZEaXhA07fMrO9ooE@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v6.4_rc1
X-PR-Tracked-Commit-Id: 11af36cb898123fd4e0034f1bc6550aedcc87800
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c42b59bfaa0091833b6758be772c54ec7183daa5
Message-Id: <168244565297.10431.15113275103933084505.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 18:00:52 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 16:51:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v6.4_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c42b59bfaa0091833b6758be772c54ec7183daa5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
