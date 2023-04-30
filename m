Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913166F2740
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 02:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjD3Awc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 20:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjD3AwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 20:52:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29512194;
        Sat, 29 Apr 2023 17:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4D3F61261;
        Sun, 30 Apr 2023 00:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A3C3C433EF;
        Sun, 30 Apr 2023 00:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682815943;
        bh=rkvelM1w5rEYXzPvUAQIPM+5ezm5R+M3PCcNjwO5hBA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rz3o5n0FqiS58rQ7A5NJ6+rEYf8FeWdx3mcYOmUKtsBAO+feO0R1jHx6Cl48rBm5C
         Jl14DZd1O2bEwPRzRU5EG03vCu+3GI2rdKAl+aJLj2c3w4DgzmRoK7cEMuD77oDSSr
         NhdXC3VfvTIZFkINnswND2tp8bOdVaPjz6oaM2exv/KAAMtHADnJgpOGZj/ftfHojk
         0/zEl7v+8tUHpIfQK6k1BKU24xeHX5QGRbiSQXqhX2m7kxG3fwC5jpDd5XvkL1rHgx
         t5btJ/gZDrXBBCsDg2me9teDjtnrU0TeCeKmGHrdfpFBcCDOZMAFVWeMfqOnU1bCy6
         4l6Q+8nb5L9XA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C71EC43158;
        Sun, 30 Apr 2023 00:52:23 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230429165843.uobwenl6dy7x3vtr@mercury.elektranox.org>
References: <20230429165843.uobwenl6dy7x3vtr@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230429165843.uobwenl6dy7x3vtr@mercury.elektranox.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.4
X-PR-Tracked-Commit-Id: baba1315a74d12772d4940a05d58dc03e6ec0635
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17d4ded2fc9d4f0b7c3c74ed9f80420c59d36e0b
Message-Id: <168281594304.341.14349219432692177673.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Apr 2023 00:52:23 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Apr 2023 18:58:43 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17d4ded2fc9d4f0b7c3c74ed9f80420c59d36e0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
