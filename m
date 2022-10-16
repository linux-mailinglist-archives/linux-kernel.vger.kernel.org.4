Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFFF5FFCAF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 02:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJPAPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 20:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJPAPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 20:15:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE063FD4E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 17:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5164CB80B3A
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 00:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08537C433C1;
        Sun, 16 Oct 2022 00:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665879337;
        bh=Hotm6fY7uxsa20ffEGsks8HQGh8KFOOKC3xOJp0RDUA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ub3zCq4YyqOBXYzZPO1iYYsTQBvYpB1fQiZtnZ/HAmwHYjq06+8FhvFKUnOLrIJ7U
         S6UTOchhwJxXy5tI5TScJt3TowPxX8zKfQZuASuWu1qpEnjAs+Sy+oVU5PaREYDE+S
         THY99YgsgvK+cIKkk8gKMuNKJdDONmTw+rJ4t2Nvqo12Hi/VuZAsot0xj01woRtcqU
         cuBuqVqGUn4eQf1cNyMzFLyoLq3UTr3nodyKtdCilqN/Vd5it3q6G62kO31eQzoWoW
         qaCYz4+nUOYhNFOL61V4TSbIXsHm0vszAEV71Z6cDBJWgHCQzR3sK61hArqI/NIC3e
         tFRpYlobz1l5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7CBAE270EF;
        Sun, 16 Oct 2022 00:15:36 +0000 (UTC)
Subject: Re: [GIT PULL] slab hotfix for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <83deef1e-48ab-6e29-4611-2e7c37d023c8@suse.cz>
References: <83deef1e-48ab-6e29-4611-2e7c37d023c8@suse.cz>
X-PR-Tracked-List-Id: <patches.lists.linux.dev>
X-PR-Tracked-Message-Id: <83deef1e-48ab-6e29-4611-2e7c37d023c8@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.1-rc1-hotfix
X-PR-Tracked-Commit-Id: e36ce448a08d43de69e7449eb225805a7a8addf8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1501278bb7ba0728b869d3399ea94b67853256a2
Message-Id: <166587933693.18523.9655976105117440555.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Oct 2022 00:15:36 +0000
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
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Feng Tang <feng.tang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Oct 2022 22:06:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.1-rc1-hotfix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1501278bb7ba0728b869d3399ea94b67853256a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
