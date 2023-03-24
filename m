Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943DE6C832B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjCXRRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjCXRQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:16:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B42708
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D1CCB825B8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 17:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEC46C4339B;
        Fri, 24 Mar 2023 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679678149;
        bh=3vK7EQHW/mUxIGD0tXcolxrLVKt2Ft5l+RQ3l5IVXBc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KqEWTcGZGFnVHSBzcdzh3sUNr6kTMIJ78JDdZzEvB9GAV4guT4RkSTLALCOJ7eqn9
         hTIpUFF1/HC3r/tJDx7zoYgEinEBOk7P3pwHB6CJxbCwIHG3AV5IrCw46OnCalBE2m
         2pQT9L8FFoTJiN403q2vwNvPJYDTKyRpU8ybGMjo0y3/UnwpuStGiw334SXbS6fzQP
         pBqchLJqG3iwhXNI+xjjv+cBPN/LoJvKLWUUVIWJG8/dNnrHc9Qjq44XBFLH7uV+9X
         4EgGNX6vvf3BLB734Gg1cfFeedLQCi3lS9TPlKJQM+Rul9prh9MSKxv/enGHGohoyU
         TRXbBfnJ3UaNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6049C41612;
        Fri, 24 Mar 2023 17:15:49 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-4d782094-e4c0-4626-a038-78e17e33b19e@palmer-ri-x1c9>
References: <mhng-4d782094-e4c0-4626-a038-78e17e33b19e@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-4d782094-e4c0-4626-a038-78e17e33b19e@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc4
X-PR-Tracked-Commit-Id: e89c2e815e76471cb507bd95728bf26da7976430
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19a6b66ca5244203214726376fda978cda2fc488
Message-Id: <167967814967.905.5197343284289553060.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Mar 2023 17:15:49 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Mar 2023 07:44:56 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19a6b66ca5244203214726376fda978cda2fc488

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
