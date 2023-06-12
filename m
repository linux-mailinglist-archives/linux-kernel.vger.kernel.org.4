Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B061672D4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjFLXVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbjFLXVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:21:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E362EBD;
        Mon, 12 Jun 2023 16:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78ED962C1C;
        Mon, 12 Jun 2023 23:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD90BC433EF;
        Mon, 12 Jun 2023 23:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686612102;
        bh=0zwLs2EizeS9sD6llGbHvZa1YRfR1qMXmbvzZNlo+WA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uTn4HVhPBat4dtW8iut63Q9eRYLaIMGv+Hu0c4bDtpjTiRXysUxr5eF5aOaGA4tYr
         1i+s98c3puIGdptb+qOn3+J7r4il+5/RL50HOGtgeysCRZEWV2N50qAqiTc9QVTLX5
         hpnKGc6BNy0q+2D8BP3IDaw7SbvlUvSZYclYcE/bHjDpCq/xnGsLFPdr10PMeK8xNl
         d/CP0M+fS8G3VNztLfyvZEwROqqCNhIrtheGZhbICdY4l2RP0K1vv0pmY1831zt74J
         FJaQHwNYFfIpU1a3xgQLxsryHiQXRdYGjX7FVSqoCHPBWreN1wLJQu5+QJyS5h1YWy
         zJz4QqHcEssEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBB26E1CF31;
        Mon, 12 Jun 2023 23:21:42 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230612122712.f495e24b80f88f58557ea470@linux-foundation.org>
References: <20230612122712.f495e24b80f88f58557ea470@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230612122712.f495e24b80f88f58557ea470@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-06-12-12-22
X-PR-Tracked-Commit-Id: 0bdf0efa180a9cb1361cbded4e2260a49306ac89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb054096aea0576f0c0a61c598e5e9676443ee86
Message-Id: <168661210282.25158.1059860098087339058.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Jun 2023 23:21:42 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Jun 2023 12:27:12 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-06-12-12-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb054096aea0576f0c0a61c598e5e9676443ee86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
