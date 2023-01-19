Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94D4674384
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjASUbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjASUbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:31:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87A39AAB0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:31:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B0A361D03
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1991C433D2;
        Thu, 19 Jan 2023 20:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674160277;
        bh=IBvh7rkBELH4QU5y3YctQAq24lLOtXW342SF7y7QdQs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wol8mKgbKuEBaU/pompJsJF7YcFcOtKMf/u1owA4mtDC+WRiV+EbYInTpGm8EX/g4
         1Z9o/9OpEXoXmZeuI0Y1YYDhSKyyqkLSIJuCKNAo9CmS1tPQQsOzLKmgyQMU5RyctV
         LlCFz07ADWYxD7Nq7sTdO5vA2N3RsDp64MawkVtsygVlGLJXqxDsXphRJolJojS2dU
         tUWqV4BnL3F0WFZsKgOR0D0elG1AxSd5ZkOWFUVnlWPGoeiZ9lG3zzfbr+UeI1eZAM
         2iRrzGuEHB1RZHRc3hYloxLvgMu85Zy/o0v6mimgA6BrvnBFNMd2BUyrYKAq8XWM2e
         q8AswB2BNRrMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB2DDC39564;
        Thu, 19 Jan 2023 20:31:17 +0000 (UTC)
Subject: Re: [GIT PULL] slab fix for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0d10c2ed-7a1a-e94a-af73-d56b0ba98086@suse.cz>
References: <0d10c2ed-7a1a-e94a-af73-d56b0ba98086@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <0d10c2ed-7a1a-e94a-af73-d56b0ba98086@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.2-rc5
X-PR-Tracked-Commit-Id: cc2e9d2b26c86c1dd8687f6916e5f621bcacd6f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46f0cba31ccc28cfb3e65d0ab49a9a7e58c0ef9f
Message-Id: <167416027775.28102.10541876861258425913.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Jan 2023 20:31:17 +0000
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Jan 2023 10:54:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46f0cba31ccc28cfb3e65d0ab49a9a7e58c0ef9f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
