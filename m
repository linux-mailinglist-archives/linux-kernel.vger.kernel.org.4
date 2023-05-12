Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C474701213
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 00:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbjELWOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 18:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbjELWOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 18:14:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD3830F0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 15:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2209E63EAF
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 22:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 831D6C4339B;
        Fri, 12 May 2023 22:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683929650;
        bh=sare64ZtXhD2TFTZrjIyRvFo9dVSGVRaUZuwZb2j2Jg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=onfm9Z0hEE83Ls+f0HVEJStx3i8LmiYlfvAajqyqkjbzGsF41SeX0H4I/X33l0GGd
         LgTFyQJpXE6duPAamujmOuQpW5cSxKecRkdsZAIRID8/6k6873jZ1G8IKvUfZMLJyf
         7j8FVmRa+LdnMzMhs3MSgcCJKsFDeQb6jx5YCK+2z/0PHy1jU3ovQwDB93ktP7mQMa
         ireYl5ES8wS7fdfQqcwAxn8cEEwH3V7rHsfeg1Q5LllZ5j99fkSLR3qEk5P+CDt3OS
         VLJSg7aX9gPoMheLAs1hslwepEfUc3xn+c2kSOR5edhq35hQNJRV9BLexSgYJRCXe0
         vh0u4zOAYqk8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7124CE26D2A;
        Fri, 12 May 2023 22:14:10 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fix for 6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-f7f97b7f-e3aa-4fff-abc7-19439d1720fe@palmer-ri-x1c9>
References: <mhng-f7f97b7f-e3aa-4fff-abc7-19439d1720fe@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-f7f97b7f-e3aa-4fff-abc7-19439d1720fe@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-rc2
X-PR-Tracked-Commit-Id: 3b90b09af5be42491a8a74a549318cfa265b3029
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed6a75e3133bca544849b967f7f3233cddb66090
Message-Id: <168392965045.28473.11930499297837206978.pr-tracker-bot@kernel.org>
Date:   Fri, 12 May 2023 22:14:10 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 May 2023 08:05:20 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed6a75e3133bca544849b967f7f3233cddb66090

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
