Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548095FAB58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJKDno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJKDnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901D7F26F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A87076109A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 03:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19934C433C1;
        Tue, 11 Oct 2022 03:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665459802;
        bh=hWCZ1JuyFZDrZxm9oivtXdfbWaMIXJDFUV7rc6YcZTg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OU4rc3BPC9sDloEcB29Z8yHapH5xULlvaFOJ7sGO461KB+UfyVompNYBFQ03glX5N
         P3bBjcCu9YZh0a7yivLdYNRWUPif5OKlfdBi0He3tLf3gCP4SFp09CaNkd2xxFEWh3
         gA14pUu9kgafxEeoKeQCMhvzDzprF99rshYW4AbCVOykHPFEyH38yPn522Fu8+jAwR
         PrdcV/TvuYYvVSmuTiKuz5X5nUbWC55zS93xzNBrE7detn/wm0DxpTuo2VNa2q2HZz
         7lVcHXfxWvDHYtZpT2HF9nvv23DPsMnf45yMIvWrFaRRVGv2No+bV7KnPs0O0uEeF1
         K5yB7zt03/TyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0953AE29F33;
        Tue, 11 Oct 2022 03:43:22 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221009104539.368110-1-agruenba@redhat.com>
References: <20221009104539.368110-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221009104539.368110-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.0-rc2-fixes
X-PR-Tracked-Commit-Id: 74b1b10e29b1f25e1a081fa82733baea65429d53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7d7d2d345697eb3781198e58a22504feb74af63
Message-Id: <166545980203.4678.2491823509591876881.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 03:43:22 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  9 Oct 2022 12:45:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.0-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7d7d2d345697eb3781198e58a22504feb74af63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
