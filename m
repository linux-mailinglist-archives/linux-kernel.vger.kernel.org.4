Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737126315BB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 19:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKTSxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 13:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiKTSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 13:52:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55166183BA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 10:52:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E012960CBB
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 18:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E6EEC433D7;
        Sun, 20 Nov 2022 18:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668970374;
        bh=EOB5zbXQwHg0UWjow15moUeXVHw/6+bWpPa/rMM/Oko=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BHd23Nnv8xcMi2hw2PLsN0TJEOxX9lZ+qDiC+AbjITi6XboOap8+0lW64VsSCvPh1
         ryswVi0oKUnn9mVziocmZcRNGBL+hI8T59NIHP5v06f7inBuve6in1v2Q8ODhj7LZl
         8ZftBzSlSUQWHnc/nG0Ywc41xQtB9NmB9LGLPuv/eOdsYxpdKpc7QX8n/BH70w7G39
         0t6iToRo+GDu4O1Natk0/ZiO20do72syW7r3yEjtcsyDSJscNA0ZwDp+3gi/s7Yi8v
         S2k1z7ZpbxShlb2EsJmc8Iz2v/ZpCoo51bTdeXIEy8NUaJ9ReyJCKaQrX87zWNmly0
         pW3sScEVhlVxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 363D8E270C9;
        Sun, 20 Nov 2022 18:52:54 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3oOcqhGQqpH7xtd@zn.tnic>
References: <Y3oOcqhGQqpH7xtd@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y3oOcqhGQqpH7xtd@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc6
X-PR-Tracked-Commit-Id: ce0d998be9274dd3a3d971cbeaa6fe28fd2c3062
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb0ef8add5a3e98332f803737d18a384da7f9a74
Message-Id: <166897037421.26274.17975733742016559725.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Nov 2022 18:52:54 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Nov 2022 12:24:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb0ef8add5a3e98332f803737d18a384da7f9a74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
