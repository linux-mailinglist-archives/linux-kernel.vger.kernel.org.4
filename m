Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E729F6E3ACD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDPRno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjDPRnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4FA268F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:43:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEC1360FAD
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 17:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ABACC433A0;
        Sun, 16 Apr 2023 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681667011;
        bh=qBZrla+P/mozW7bNhJMQLCB+FVNMF3K8gPOvYykl4Og=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U5bmN78LvTC0KaV4S0st75fQtzDNQlgymh5DsEr0wY9mN2HhlgXRqnZElnQJc/jpr
         KfiKAmRTJNNsDRGEaV1MrqEhdIl2CO67KRHtKtv7jzWC72kbZHlqOweg9ue6wrN5gJ
         wGKAA9TXzYIcvu7YCSyHefj4N9UNZBPZregy/9TpH1nlkkIfieH9Cu88U3fJbE9hHj
         A5uf4TF4DWC6o9oxD5PQ4FHi+rq0r9auFGwLc89KjqMi2Pgfj0A/dSd2ZE+42q+fGu
         6ITTAV2E6d/g2C+MCxeNaE54pWMOlT13pKrXy+zGRww3YNVBdG1z+DpD3hO5zGm9zK
         D1vWexn2znZ6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 289E1E29F3B;
        Sun, 16 Apr 2023 17:43:31 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.3-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230416122913.GCZDvqGVe9TPa5LPRm@fat_crate.local>
References: <20230416122913.GCZDvqGVe9TPa5LPRm@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230416122913.GCZDvqGVe9TPa5LPRm@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc7
X-PR-Tracked-Commit-Id: 775d3c514c5b2763a50ab7839026d7561795924d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e623175f6418f5873b28ca91a88312843b2e0dab
Message-Id: <168166701116.4218.860733446374764362.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Apr 2023 17:43:31 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Apr 2023 14:29:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e623175f6418f5873b28ca91a88312843b2e0dab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
