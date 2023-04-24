Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60746ED58D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 21:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjDXTuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 15:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjDXTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:49:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F96EBA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 12:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80A2B6218C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E515DC433D2;
        Mon, 24 Apr 2023 19:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682365744;
        bh=pHUNDz29GsDwUQNqfvdLJVWrtFeTN48xqcJCBGt7qpI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GBti3cLpAU2fwSXRGOjNNNmku6BpEE2YaD5O3cpS7Tnh23QRrakdtBxkfBcDiOt3r
         wDZyXl90NiTjeFKZ3s8ntwrggrKNht6S9Sl5Hr1JjlnV40Lascy6tHu0dtBbjcbBqi
         OVP7WiSa6jttci12ETlFLuHpQXGLdaW9NjxSLaiCqaPBj4vq8AIaJsPt63XVc2ADlc
         OUH+R6NC4yiMlqatk1kWgUKMp2tBjY50lejNKzWpUEcw9mFvx0czy0yx8vg4O9TEnf
         PsXYrQJv5QYmzVtt0akwZPYxZw3z+xd48byiQJ/w8G3Opd/Imr5/BQ6tmnIxvhnkLB
         M6OiPl53k7nYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D29A0E5FFC7;
        Mon, 24 Apr 2023 19:49:04 +0000 (UTC)
Subject: Re: [GIT PULL] KCSAN changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <147f3556-8e34-4bc3-a6d9-b9528c4eb429@paulmck-laptop>
References: <147f3556-8e34-4bc3-a6d9-b9528c4eb429@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <147f3556-8e34-4bc3-a6d9-b9528c4eb429@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2023.04.04a
X-PR-Tracked-Commit-Id: 8dec88070d964bfeb4198f34cb5956d89dd1f557
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 022e32094ed2a688dcb2721534abd0a291905f29
Message-Id: <168236574485.6990.14702034469945860205.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 19:49:04 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, kasan-dev@googlegroups.com, elver@google.com,
        rdunlap@infradead.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Apr 2023 16:04:15 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2023.04.04a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/022e32094ed2a688dcb2721534abd0a291905f29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
