Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41B864BBB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbiLMSN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiLMSNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:13:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECEB17E0E;
        Tue, 13 Dec 2022 10:13:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A59E616C6;
        Tue, 13 Dec 2022 18:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEE55C43398;
        Tue, 13 Dec 2022 18:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670955218;
        bh=lsrFXEn7bXKrZwJUG8jC+qqqWbaK5CHVG73P2o372mY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=omcW56YsvNsSxdDOo1+o4soCF9Rn0cCNlxXGVJ8WRlfWKeryQWQW0C+ns5LtBU4dQ
         mlbA3HSEPS9sA8oeyaC2bWFrn7Jbv3/CW7SEtR+TOCwgzyfQj+8YNh2FpTMjAU7ws5
         RWu+zbwALTZcIgIFjswpBdqvSOKXt+mQNELbwd+r5WAFndNfGdFyV9lx0nEuqG83U2
         f09woYI9HjnJrUg2IZKhfIXhIyoS4fXnHFmidI0ovtik3+dr9c9Pm4j388DyhR8Efm
         V3mt03UWWXCA8CChy6ByIwsGt7mUOkBhFmYcIT5+AzVNnmtRgIQTy82sk6JZ+W171i
         UAfVL2RsXRhag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C511C41612;
        Tue, 13 Dec 2022 18:13:38 +0000 (UTC)
Subject: Re: [GIT PULL] LSM patches for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhS1QSv+bD6d43vbSq+9goViU=miMTuG0r1WdjM_xo99hw@mail.gmail.com>
References: <CAHC9VhS1QSv+bD6d43vbSq+9goViU=miMTuG0r1WdjM_xo99hw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhS1QSv+bD6d43vbSq+9goViU=miMTuG0r1WdjM_xo99hw@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20221212
X-PR-Tracked-Commit-Id: 577cc1434e4cc1342c3df6d6a3c85136ab335c81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c76ff350bd57682ae12bea6383dd8baf4824ac96
Message-Id: <167095521863.23919.8649278418662590892.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 18:13:38 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 22:05:49 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20221212

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c76ff350bd57682ae12bea6383dd8baf4824ac96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
