Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDC76EC0E6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 17:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDWPuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 11:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjDWPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 11:50:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265971702
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 08:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD90F61232
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 15:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DB4BC4339B;
        Sun, 23 Apr 2023 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682265007;
        bh=8gcxG8cNuInSOjAwh06L+2WeBD3n4AI/2Ng2AXzSvZY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=StW9h/83jVt/dmK1Yak2yRBZGKl8yTscKDXxlYz5jhLUTw2riV60PUCQNIQ6y7fh9
         EYF7vBEGzroptNdqbMgn99d4GkqIPvQTLtAx5WOHO0oXejGdiG21F25Oua6AwT5KF0
         l4E5SKlIKntmaJZ0eS5xPHzzzbk0Qh2jO7mySGCwGnKyJYTxCUrC2TC8mBegBvoTo4
         KojGQMkDkHeVa7jiv3Kj7GiroRoEQ9y8/D6sLakqItxp/HzmT5GLXpsqIB6i9uD7yO
         P9l3VDA2x9EATiuAr/yzCMH96CbUosBg/w5f+qGB4DcLTUf9QXa/0FAJ+X6V85SAaE
         z4A1InJ1bAu5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01BD4E4D000;
        Sun, 23 Apr 2023 15:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230423100113.GAZEUB6UvR5TjCMkfz@fat_crate.local>
References: <20230423100113.GAZEUB6UvR5TjCMkfz@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230423100113.GAZEUB6UvR5TjCMkfz@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3
X-PR-Tracked-Commit-Id: c22ef5684b64a3a1ac08db06a6f327f2695fd377
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97249f05b27385b7f870d8e2e6062e26e5f132e8
Message-Id: <168226500700.30883.5181370695889387073.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Apr 2023 15:50:07 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Apr 2023 12:01:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97249f05b27385b7f870d8e2e6062e26e5f132e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
