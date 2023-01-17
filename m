Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B5466E531
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjAQRrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjAQRqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:46:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907A858299
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:35:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E136A614FB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CB79C433EF;
        Tue, 17 Jan 2023 17:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673976946;
        bh=9bCF04U/YHKPdtco+358Twcum2xuam0kg8r/RXQa/KM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RVrNDes5px/Oz27b79fyOOeCiJ3o9MhBZVKGxUPD7iQSQN90RRFE9k9xIxpJvzpIm
         ED4WL+gcVz0Nfl3CqqP6Z0CXOihDBI99B8sUChZu2LJKQA5Xq7MxE5SlmZ9sRrheyR
         V/ywqI5u+stHFClV/SZl3lTp8ZVQXKcdr43oJYmc8DK+eqEA/+wL8rqrtUgN4x0wga
         taBCj1LXFFYEc4b/Ay+o5CmSgBvE79xOEPYHqrjmngFJ7kOUFo6Ts2h/I6Ix7d194S
         MDr4QvKHizca/PTSFpug20GlLjK9cf1a+/7lbhN2hiZX6tp8Ox0vpYbVQ6DLGKLFhb
         c2q15Zh8WKfkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3885EC43147;
        Tue, 17 Jan 2023 17:35:46 +0000 (UTC)
Subject: Re: [GIT PULL] tomoyo update for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d101b94f-cbd6-dac0-f5d1-f6cb32585d0c@I-love.SAKURA.ne.jp>
References: <d101b94f-cbd6-dac0-f5d1-f6cb32585d0c@I-love.SAKURA.ne.jp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d101b94f-cbd6-dac0-f5d1-f6cb32585d0c@I-love.SAKURA.ne.jp>
X-PR-Tracked-Remote: git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20230117
X-PR-Tracked-Commit-Id: fa17087e244263627a01d6a9b76b8fdaf410de34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bbb0674c93f9373f12048786b4638b055243112
Message-Id: <167397694622.24435.14481779598286518989.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Jan 2023 17:35:46 +0000
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Jan 2023 19:58:08 +0900:

> git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20230117

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bbb0674c93f9373f12048786b4638b055243112

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
