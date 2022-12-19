Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E5E650D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiLSOac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiLSOaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:30:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A52FDCB
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 06:30:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B4DD60FC3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD027C433D2;
        Mon, 19 Dec 2022 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671460208;
        bh=bfyNt+dh7ngTRKQNMDUnTiLheqC2395LK8hn44iqrG4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hGrTx/Pcd1vyp04waksAOjQYIVnbs/f1Aem8Xk6VmTvj7rS2fJdEjGLfSveEbs1b8
         18WaqA+YHFj2y4sCLIDIQXdq0C6G3f4u77mxBldr1w724002GYKvaTN6zHGNTdlGhj
         fix5ozE0zcSj+BPt8CgnbUJRQjYq9CX7qM7kBdb1wgQBYtE1U9CEtCNow0TpOTB6tK
         u6znouLNDAayosarxDtafV/4K9mIj+ZEzoaB3hbzafdyPOQhO1wL72DQPZD1+WeAuf
         f7ue0dWBS6/KoPWGK3Y/96/WDdWTD5CXZPFN7WHRFfragP0p/fAj+v9x0OVj4Z/FL5
         YF6y30nedTwSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C80EDE21EEE;
        Mon, 19 Dec 2022 14:30:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm for 6.2 (try #2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221216232108.1325224-1-dave.hansen@linux.intel.com>
References: <20221216232108.1325224-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221216232108.1325224-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.2_v2
X-PR-Tracked-Commit-Id: 3e844d842d49cdbe61a4b338bdd512654179488a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f292c4de4f6fb83776c0ff22674121eb6ddfa2f
Message-Id: <167146020881.28969.3432824067708157523.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 14:30:08 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kirill.shutemov@linux.intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 15:21:08 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.2_v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f292c4de4f6fb83776c0ff22674121eb6ddfa2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
