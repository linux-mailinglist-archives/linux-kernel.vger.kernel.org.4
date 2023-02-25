Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2FC6A2C8F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 00:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjBYXWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 18:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjBYXWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 18:22:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2742614229
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 15:22:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6DBE60B92
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 23:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 280A7C433EF;
        Sat, 25 Feb 2023 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677367332;
        bh=Wx8jW0MqDXMT/MaOcZcCyAOBxdEIx7ZNco1QOfO2FBg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IP8xQKsBU0NHKR7Au3fYJ3oSQAw06moVXBPL/m9cf/AHYuElD3a2uaObo4AOUoNTN
         w6SonyO2dnaj03VaXqk9uwwYswWh7v8GAmPUzPlg3y6O+Quz6OQivs/RoIHWSwm6EG
         5GqAzDogvXhvVyIuJ8yVHxBkolmYz5txZt7nf+bY8O7VkKzlN0rLCZ3/wzYtrP7s+E
         xhdevENaKDa9l4avO/OhQWlhTkoAXmWW4o3zCSdjtvKMNwZCT6uO+PgdMRsFH3+Kvv
         4IFJZ6O7EB0YKgU9bil8e8homd8WN94uSctuR/dIh18uHc/lqp5S87aJ3Xv6UnfXkr
         /gwWKB+3qll6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17FA3E68D34;
        Sat, 25 Feb 2023 23:22:12 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY3u9hBsHEeJXEYcdohhy-nQy8io1ZN1-MhFjvudUBPZ6w@mail.gmail.com>
References: <CABb+yY3u9hBsHEeJXEYcdohhy-nQy8io1ZN1-MhFjvudUBPZ6w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY3u9hBsHEeJXEYcdohhy-nQy8io1ZN1-MhFjvudUBPZ6w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v6.3
X-PR-Tracked-Commit-Id: 6ccbe33a39523f6d62b22c5ee99c6695993c935e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 562ed38ded83a5cd3ecf9a1a875c7ee786c146ae
Message-Id: <167736733209.9412.16710244940013461768.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 23:22:12 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 15:27:48 -0600:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/562ed38ded83a5cd3ecf9a1a875c7ee786c146ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
