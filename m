Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB0261E5FE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 21:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiKFUsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 15:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKFUsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 15:48:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A020DFA3
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 12:48:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09023B80D22
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 20:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEBDFC433D6;
        Sun,  6 Nov 2022 20:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667767718;
        bh=UUzRhsbd3PEcuzz0EMUgTu0ByUWNbzijvGIYMf6Azik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sZlWN3dfAGCbgg0d5ip+f2x/FB8iPIvH/uVjQx5Row972AnWemZfYWIj+wW1P/Kn1
         5ZC/8fx5XOlx80N2GmGVl8MWj0qD5oiUyRQu7FodQsp96yD9j969GL5f51D/kf9+K5
         e8gn3iEACSlwgRiygUmwio7IEUOW0pvJz2ac0Vb+GqGi6sU9oiZp80RK6BDNXgD47z
         NoNlsnpiGo4eObAK+T662Xzrt2F7ZscGakZ/ssSrkuv8p20XU3Mu7cEGhOc9nu7j1o
         xYF2OAfNrIFB3TD2WufalbgGThC69FnUbfzjwLZdCgx4PfQFgjqYWb0KsxizdN9z1W
         YQkoGS7rGx40Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B044E29F4C;
        Sun,  6 Nov 2022 20:48:38 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y2et7Ajw3XimvNVk@zn.tnic>
References: <Y2et7Ajw3XimvNVk@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y2et7Ajw3XimvNVk@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.1_rc4
X-PR-Tracked-Commit-Id: 7beade0dd41d42d797ccb7791b134a77fcebf35b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6f5204727b9b1f3c6e9c90b5b09f40c6e0102f5
Message-Id: <166776771856.27719.568259118474701548.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Nov 2022 20:48:38 +0000
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

The pull request you sent on Sun, 6 Nov 2022 13:51:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.1_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6f5204727b9b1f3c6e9c90b5b09f40c6e0102f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
