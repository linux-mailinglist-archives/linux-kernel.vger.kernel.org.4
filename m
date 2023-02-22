Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ABC69FD44
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjBVU7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjBVU65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:58:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78572A15A;
        Wed, 22 Feb 2023 12:58:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 666966141D;
        Wed, 22 Feb 2023 20:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9DFAC4339B;
        Wed, 22 Feb 2023 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677099535;
        bh=kbTfvn/jvskJiJnNcnDB3OgPn3kAX4sdGWWwnS5+duw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XZIlZViNzItP+2nnjHaGUbbyrR3W8dKViy7Pb/GStAWZkaEVDy3kqOEnwN0fW4YWJ
         yDOjtX/i3yrh6a44aLr+Xp59LMG1wmBV3tYGUZokQeHoZBhe39Z5Gsc4O3Nez9godU
         poSruc4jZ5VY6dfmDoNEESvo7d7oAMH6LXEeIUqK2XgGNtY5vtfLhWhN9Od/znfkEz
         fbht8YEZGns1reAn7LYZBW8BkQziC2+Dlbg2G2UIVJNJM4zUHCyxpJzBjoR1lfzEiZ
         Oow6r1BQIltta11kqdTIrbw5dPVcGbV1u406F38pxRXHVU+w0v6YGYwcW5kKtZhJ8F
         pqEm4Jz1cD2yQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C90F7C43151;
        Wed, 22 Feb 2023 20:58:55 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5c203a3e-3f92-9e23-c2c2-8f82baed3a47@schaufler-ca.com>
References: <5c203a3e-3f92-9e23-c2c2-8f82baed3a47.ref@schaufler-ca.com> <5c203a3e-3f92-9e23-c2c2-8f82baed3a47@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <5c203a3e-3f92-9e23-c2c2-8f82baed3a47@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.3
X-PR-Tracked-Commit-Id: ccfd889acb06eab10b98deb4b5eef0ec74157ea0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77bc1bb18463a7fa3742accaddf31845655edf66
Message-Id: <167709953581.1614.14221079365869739128.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 20:58:55 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        casey@schaufler-ca.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Feb 2023 13:16:08 -0800:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77bc1bb18463a7fa3742accaddf31845655edf66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
