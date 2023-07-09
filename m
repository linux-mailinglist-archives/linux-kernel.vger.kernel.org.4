Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43A674C6D9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjGIRqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGIRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CFC100
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7427360C09
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 17:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEEE5C433CB;
        Sun,  9 Jul 2023 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688924794;
        bh=ibUJLJSeYgnFfCwdOPEgR7cmS0CVA1r3EFbvmpG+F+s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JEycxaXyUq8MgLQCwN58NvqiUZaX6+tpRFCcVnOo9QcH7BitD1PIg+VEga8rACv/r
         /HpCs2LRbviMGzklF/04Pp8RrdiFcudz57fyJtuZ9HfnLdlrCOrLE1rnRWcRPjbh8C
         S9QcJ7jfxzfn1Ct5lcSlPAr4Y2DZ74wtLS+NhfHzv7OQySwyE93UMB/h90V39waNre
         U47UCoicnX5GYF7+t6v42azn7iYfkH9h0dluryhA+ZhrY3kTp5VfoLczX1KtcBgxxy
         JE3Zzc/MSF55CeOKVBAEx0YIKhXNJRthvOzaT1Dx6o8s5lIxIvu3RAUnqNIC53uOzq
         w+OTyBZMlSX7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B67BDC4167B;
        Sun,  9 Jul 2023 17:46:34 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230709081323.GBZKpsIzizRwSBSzT+@fat_crate.local>
References: <20230709081323.GBZKpsIzizRwSBSzT+@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230709081323.GBZKpsIzizRwSBSzT+@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.5_rc1
X-PR-Tracked-Commit-Id: 67a4e1a3bf7c68ed3fbefc4213648165d912cabb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9943ad3dddb04763e73649ade8ed726a17b5ec3
Message-Id: <168892479474.9789.6251448355752328898.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Jul 2023 17:46:34 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Jul 2023 10:13:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.5_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9943ad3dddb04763e73649ade8ed726a17b5ec3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
