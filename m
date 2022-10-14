Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58155FF483
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiJNUYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiJNUYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BA02678
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E610B61C2C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 20:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5707DC43470;
        Fri, 14 Oct 2022 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665779076;
        bh=Q9NLUY2WqRdOSFda+5a2QWMxud4tF206DCOEAPIfPGU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AGpkdo3G0O0/9biQkRXfnPeRGmtHD3cZblslxaU4GHW6v9unGUwI2YPn/Irb//tCm
         jPXe5DV0FsXOEihuXTyjpQFNAXksMJpjFCMJQ9cC0Dn6pQM02IWKnMwym5TR0ZYytz
         XzNIvplirNyCzTfoDwtySPXq+pY8GXQemUToUR83EGZPCiD8Ok8HxDl5Qjjplrtrvd
         BEEGNtqtXnLPI626zHAQTYc4VvvQ6fPkoiU3BukOCwj79kwP4amsGsvFmS0TSYQyJK
         ECxhD4b0j2jnHZH776ilca9lVfn3TTL9ckdurkb07RphB9R91O+uVFFGx7xQQBXJPq
         L+Gr/kgtfS1Bg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43F91E4D00A;
        Fri, 14 Oct 2022 20:24:36 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o7ue2z3x.wl-tiwai@suse.de>
References: <87o7ue2z3x.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o7ue2z3x.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.1-rc1
X-PR-Tracked-Commit-Id: 88672826e2a465d2f4c0a50fb5ced2956f4ffcbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dca45efbe3c870a4ad2107fe625109b3765c0fea
Message-Id: <166577907627.10237.14015413539749779551.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Oct 2022 20:24:36 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Oct 2022 17:39:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dca45efbe3c870a4ad2107fe625109b3765c0fea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
