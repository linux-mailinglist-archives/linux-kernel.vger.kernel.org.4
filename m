Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCACA66B0F8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 13:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjAOMaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 07:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjAOMaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 07:30:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A9A10AB1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 04:30:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27AB660C8F
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 12:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 757A1C433EF;
        Sun, 15 Jan 2023 12:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673785803;
        bh=7BXp75cC6cfO9m+Rrz6SG9lb+tVKVUe1lg3WFGT/Gmc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IQAGP36ls2EcBGY4a71EW+tG2KQjuGS9bG/Bfo57ojYY3ekHR87rriodJqW3+sMw5
         JdEcujYv2wjjZhBR8208J+fnXmJSCLUqGN8TZLuwuWOj0ONd3DSHmJ506NB0zvguQp
         2SoJ9MbenSiBvDrrXM9R0ZlSxx9KQ6K7Rm/DnthCz9qOwLm/hjavurvV8jO2z+j0tV
         H2+1d9YMgX83KWcDAdBqR2xbIzK1VLGXqLG+npvTspgVEwnIyCN6UxE+dnTLV1GXRt
         KCTy3j/5wZrKT7aFThlhoke8vGSftvfMb6xiJ+ZApLmwKrDZ5Rhr6d6z+4Ku2KxaAs
         CuwHXn7MTb2aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5674EC395C8;
        Sun, 15 Jan 2023 12:30:03 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8PwPKu2/SfWMdn6@zn.tnic>
References: <Y8PwPKu2/SfWMdn6@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8PwPKu2/SfWMdn6@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.2_rc4
X-PR-Tracked-Commit-Id: 5268a2842066c227e6ccd94bac562f1e1000244f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7b19c603e0ca156fb2422017a053d5d48fc769b
Message-Id: <167378580330.697.18114854801322100402.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Jan 2023 12:30:03 +0000
To:     Borislav Petkov <bp@alien8.de>
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

The pull request you sent on Sun, 15 Jan 2023 13:23:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.2_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7b19c603e0ca156fb2422017a053d5d48fc769b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
