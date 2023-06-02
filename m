Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D2072089A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbjFBRvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjFBRvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC30D133
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4486F617EC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 17:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7FF8C433D2;
        Fri,  2 Jun 2023 17:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685728291;
        bh=zj46sBxqQ+tBQGixmp150qgB+9p1dqPoFWwdu9l2b7s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZPg1FaRaWGE7SxfxmsZBtn82mDn+38qFoF88uTeTSecYNGYmstGdenkkfaYvfebEj
         0HtOEpStWTI/rlIc/5I3ShWCzYPnL9pNZNcVIimmn0gR2zwhHbrtaoAbqj2GJ6Ws3V
         G5KCPyDMObUWnjS7DiqQ7Z5fx73aYTCgi8/dMsK+q9ZRdPPdryzx2OayVmslqrbXNb
         YERzxE32CzMcS96mOi2bUUfp9vzmcTvZbIjS5gcyARqvwXD1m98OW83h0dRbeZz7yz
         2y7IaK+lvJCW77aXjvK19g8Oapn7fu76W3DrFKHvkG2yiD6epUvws2jkRyYgHhyr7u
         s/8UdylJPzBmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 948C7C395E5;
        Fri,  2 Jun 2023 17:51:31 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-78f8e789-4700-4d48-b64e-11ed75a3a048@palmer-ri-x1c9>
References: <mhng-78f8e789-4700-4d48-b64e-11ed75a3a048@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-78f8e789-4700-4d48-b64e-11ed75a3a048@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-rc5
X-PR-Tracked-Commit-Id: 6966d7988c4fb6af3e395868e9800c07f9e98a30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5321d1b1afb9a17302c6cec79f0cbf823eb0d3fc
Message-Id: <168572829160.3621.16483655385183630604.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jun 2023 17:51:31 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 02 Jun 2023 08:11:03 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5321d1b1afb9a17302c6cec79f0cbf823eb0d3fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
