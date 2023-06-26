Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AF773EEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFZWy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjFZWyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D514810CB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B80460FBD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A7D5C433D9;
        Mon, 26 Jun 2023 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687820050;
        bh=g+wuL49Y6c9Lwf3oq1dy87NMmuwvJCO94DLvj3HAU9E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e9UvpsbCPl8O13h+wgo7rLXOQOH31MBpIU8LxhE6F1TaEXRoPFKPtgO9r4a9VaUB6
         3ttIOaKfAe52DC0EA+gOF9S0fHjn597nfcl6MHNAuYuhFP6kqe/vp/qflSDjC+PZcU
         k8fhQLipVOEDWNml4nLQbuXtb8t2b2hHvr4CPVJrvUmZZaHRsCUxbBgB1bRhT6X3VP
         yi5s8Crol6MYLQLPS11poXLfb+DffONggh9U15M8Oh/ugjfIF+wjSPLjAGKm/ABVAr
         IaU5uatzyhOmbt8MeEmoIkmgZe4b2a6SU6Ir4KXbI9SnCbBx6f6nF25XRRISjtca7z
         1mTweb8qZ/OXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58C94E5380A;
        Mon, 26 Jun 2023 22:54:10 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626182434.GKZJnX4kAKZ+ea+hOE@fat_crate.local>
References: <20230626182434.GKZJnX4kAKZ+ea+hOE@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626182434.GKZJnX4kAKZ+ea+hOE@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.5
X-PR-Tracked-Commit-Id: f220125b999b2c9694149c6bda2798d8096f47ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 941d77c77339d2dd1cda8911da63da3c67e90860
Message-Id: <168782005035.10634.12040096948631235705.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 22:54:10 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 20:24:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/941d77c77339d2dd1cda8911da63da3c67e90860

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
