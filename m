Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0775F4890
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJDRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJDReI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871076716B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2851A614F0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC929C43142;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904846;
        bh=jMX833bButgEFV6pFQg9r199E7AX0byxAkcuyNApRRY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lv48uCndmE+WYfpfVmjuyR/BlTes9Ejkhq+V3B9hMMsmbymMS0PNupo1XslFS11rq
         iTK1C4O7Jlyx4s6TUhdG5USTBi4rUbEHOYz/Lp95QxJ/tgNUU6XSoDXjQ1IvF1ptRg
         v2FpTBPjStKOXSv6j1a+rouvgbOsu/2wwc03p5YzGwPpB5GI/O2BT2ZPFoaOI36oXi
         +zPfsoXOBHTyjxkx6YioIt2LzCNkl5Pr98xFXvjUoN+wKO0A0erPHbYXPj7Rdj3rLM
         hEbCgEQ+JyV2VZ0EONQ8E5Rk7wYDTaeAWrbsuBkG/rcnWinuqqueDv/xjRnlikyKCU
         TS9rmbVbRDW3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB3B2E49F62;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzxCfhYNjqfl2DFK@zn.tnic>
References: <YzxCfhYNjqfl2DFK@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzxCfhYNjqfl2DFK@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v6.1_rc1
X-PR-Tracked-Commit-Id: f7b1843eca6fe295ba0c71fc02a3291954078f2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 193e2268a3bb1404b42f8edcc037a3eafd165aa9
Message-Id: <166490484589.22164.3817667725182323166.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 17:34:05 +0000
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

The pull request you sent on Tue, 4 Oct 2022 16:26:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v6.1_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/193e2268a3bb1404b42f8edcc037a3eafd165aa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
