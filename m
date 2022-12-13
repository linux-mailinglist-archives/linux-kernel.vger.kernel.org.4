Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4953D64BF74
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiLMWf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbiLMWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:35:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444D51D0EB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 14:35:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D445A6175C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 22:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39A4DC433F1;
        Tue, 13 Dec 2022 22:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670970946;
        bh=FB2H35HgnK8H8vpwsXc12bIXKPoyOQH+GsH93ruuw4s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Szbko4LU5NatjkfbI5A7pD1wiWagUe2ivOgZWSYr4GEkELqB08xZA3IfX3i1DkKpH
         QyuLfi40edHLkiRXxP69VeFRuOe836HfbBtsGyr7KhfwNb+VMKyL+pEao0IX2LWMaE
         xv6HmnkN/Q8YcZFLt66qTtuNE4LN72Hiacx1LuiaRvOK/dY0jZ63Gow1urI1bfMyoW
         37kXRNzlIoRbBdTO6WrD0oQ9dnJQ2v4MrxsUmNoaOCPC8j0wkhvpGvROUx1CqdlwAQ
         obOBdd17hwKJtIOdMMDFnyA5sRPkefl0rNyWMWReuP2qSDrE/0JJ/zuuGiiVswsqMH
         M+1dwsIzKDUQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27CA0C41612;
        Tue, 13 Dec 2022 22:35:46 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5gMIvLH0KKJgTY0@bombadil.infradead.org>
References: <Y5gMIvLH0KKJgTY0@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5gMIvLH0KKJgTY0@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.2-rc1
X-PR-Tracked-Commit-Id: 0dff89c4488f90c01807d9c12023433703206523
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8fa37a68359d2d5dc16deeb5b09d64c9833c0674
Message-Id: <167097094615.5412.10361624631028312343.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 22:35:46 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        peterz@infradead.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 21:22:42 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8fa37a68359d2d5dc16deeb5b09d64c9833c0674

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
