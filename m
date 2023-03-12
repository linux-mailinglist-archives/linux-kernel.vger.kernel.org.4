Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757E86B6836
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjCLQYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjCLQXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:23:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BBE1C7CC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 088C3B80D18
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 993FAC433EF;
        Sun, 12 Mar 2023 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678638056;
        bh=ly5v95DrHgVXvigKRijO+MFiLUtRh64uwKPJzhYtHAU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F+1uj3REIw1YX4VXi8+z5jLqzcAzc0aspkFlq2QQePHYEAZVcp/K20kLw54fkiuFu
         /x64NWUjwMdqaDqkQlNdoXhJ8EtbrxjbdJ9qx1ZwSHamAmuLS8QlKVlkNlclTSzuT5
         LL14tu5C1CUVp18JIyK+y5rtwyec4atHSPny01ye4oH01VFM9YQ6pHiWWaCBuIcJNB
         1+tssqrFvMnVSTgKttQVP4bh3sacHXBiPFEziCG63VQMTEEGH76a6j6XxU8V4ct3HX
         eU9IKdfmTvaONy2A31tvu16GeUSngmMUT7qCVML+5LNnI0BvsGJAeFE0oVl06So1KQ
         xgmyZTZQKx9ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88297C59A4C;
        Sun, 12 Mar 2023 16:20:56 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes and removal for 6.3-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZA3mcVDC3sMrgTxE@kroah.com>
References: <ZA3mcVDC3sMrgTxE@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZA3mcVDC3sMrgTxE@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.3-rc2
X-PR-Tracked-Commit-Id: fdf6c2309f425509cddd002f278c650ad0b7e34b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 134231664868e163580cfe79e8c923560d7de302
Message-Id: <167863805655.16000.4918935907573538730.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Mar 2023 16:20:56 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Mar 2023 15:49:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/134231664868e163580cfe79e8c923560d7de302

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
