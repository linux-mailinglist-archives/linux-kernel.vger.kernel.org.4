Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC9B65541C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 21:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiLWUIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 15:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiLWUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 15:08:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B8B13F21
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 12:08:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B686FB80A26
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 20:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65691C433D2;
        Fri, 23 Dec 2022 20:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671826113;
        bh=5rCuwx60PAGyYzejORrmURo2MBtSfJ6GDgThJgNrgqo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZSDo25rdCkc4ftQt9yOLnq/XPYGVsPZRbEDmuWKMwoGiGhPAg4qbai1d6nL/Cz1UQ
         0xgbHaJf9FEPWO90nmC74J9nGQxf/jqVQC55lJQA9PDIJVv9WW6EohTSnigNMnlN4w
         mXCFnES///jihlXWcMWYQXE4l/rg09VbJxSGH0XoTU4YFz6uuPz7B/VVua3E7yhO3t
         KFJBqe6s3LI/z7TnyyLkTnc1jh4U9DDB6VQYIwumWG2MyLCCvIxb0mFdGABKC0SYYl
         CJGDgfDx/rdJmggYuAKxbj3yYwpR6hdwuPurNBOi0n7mSLOF5Zuuc717BgOenkfkxO
         /BGxqI9rAIJJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50885C395DF;
        Fri, 23 Dec 2022 20:08:33 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping fixes for Linux 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y6W+k0hUkeRaXCTO@infradead.org>
References: <Y6W+k0hUkeRaXCTO@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y6W+k0hUkeRaXCTO@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-2022-12-23
X-PR-Tracked-Commit-Id: 3622b86f49f84e52fb41fee9eb55f9290613dfc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59d2c635f6cfb0a8c7e5acb06b10c4e587fbfd1a
Message-Id: <167182611332.4135.10054718204972322093.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Dec 2022 20:08:33 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Dec 2022 15:43:31 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-2022-12-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59d2c635f6cfb0a8c7e5acb06b10c4e587fbfd1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
