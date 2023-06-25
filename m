Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF1873D2AE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 19:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFYRXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 13:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjFYRXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 13:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D0D186
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 10:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 662E860BFA
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 17:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF0BBC433C8;
        Sun, 25 Jun 2023 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687713809;
        bh=cv+snXh07MW8sDKn8T4D5gN/dkRc9bPmyuXmvnLW0TQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iRIhufUpkrZhem7hPAMqgU7IUlWdsfTegAjCXf7X8C7fn55DwvO8SDiBTLBgc/oct
         +kIilFGf+m6xBlFrsiVIclEHd6y2cZlAW2rXkYG3GS2S2rLCTLn+0KUw7KV7AhWrV6
         LdQioRjuK6XXO6X3lz1FvEQb1K5nYi4Wcbi9Ncq5P5SdeyC8XfARr52swb4e2ljrBp
         mnBRpgZSdRNy1n7SujvNI0ImjU5Z2wGu3BZAH7VWBP2xB1QUH/jQUXs5gX/bQGAzGe
         lFqOAjQzn8r41sORc6m/Vv9OG+7BIsByLFZ/+7y2vHR4qJ/X4Dk6V7Ki0WhHYKaunf
         0p67ykgQOfWgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACD36C43143;
        Sun, 25 Jun 2023 17:23:29 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230625091943.GAZJgGr8IH10VrwHU6@fat_crate.local>
References: <20230625091943.GAZJgGr8IH10VrwHU6@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230625091943.GAZJgGr8IH10VrwHU6@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.4
X-PR-Tracked-Commit-Id: 85d38d5810e285d5aec7fb5283107d1da70c12a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 661e723b6fc7247e8aa6704651c49cd25c559f75
Message-Id: <168771380969.13789.1634186177428987378.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Jun 2023 17:23:29 +0000
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

The pull request you sent on Sun, 25 Jun 2023 11:19:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/661e723b6fc7247e8aa6704651c49cd25c559f75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
