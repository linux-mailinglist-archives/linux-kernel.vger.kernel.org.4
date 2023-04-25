Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9846EE8E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjDYULL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbjDYULI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:11:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4999317DD3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:10:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 175ED63172
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A2B4C433D2;
        Tue, 25 Apr 2023 20:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682453443;
        bh=i6UCmxYkIknxW5wgY4pV7loQJINwLExVTJZsL1l0TKM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vGQriHDJEHAxvjc0Z6Shq9lWOYm16amZ7/wzg/0ac28fd1AxPWRlqbNfvZ7zLu1vE
         qKH6tsnywCz1UunLq2Nd18Q2FO8ri5aTW7azVWm4TRh61ouuVrmM810gBIZNaTlMy8
         k6zCUjg4i3AyOVqy6hEgsAoMhGNzJ2Q27LhGfSOJkvVC6S81K4RIv2coNiXlDj0yLk
         rl+LxRSq0yVPPTvbXbv8LFkQ5jB+8MkYKOKCMMvgchuoWeubYou3lAntFX0GKIQ4ib
         HgqFUAFA9AklBfxp8XZfIVxcibtEMXYvCkCuiBWYqUjA/5mcYGKyNB4R9iLLjSq8ce
         7R8v3Xrkg9iiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 578C9E5FFC5;
        Tue, 25 Apr 2023 20:10:43 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a27e87a0-04f3-2f8e-2494-3036ed7dabc9@suse.cz>
References: <a27e87a0-04f3-2f8e-2494-3036ed7dabc9@suse.cz>
X-PR-Tracked-List-Id: <patches.lists.linux.dev>
X-PR-Tracked-Message-Id: <a27e87a0-04f3-2f8e-2494-3036ed7dabc9@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.4
X-PR-Tracked-Commit-Id: ed4cdfbeb8735c36a2e31009866dfc2dfa26db3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 736b378b29d89c8c3567fa4b2e948be5568aebb8
Message-Id: <168245344334.30863.11721145856076107611.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 20:10:43 +0000
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
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 10:39:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/736b378b29d89c8c3567fa4b2e948be5568aebb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
