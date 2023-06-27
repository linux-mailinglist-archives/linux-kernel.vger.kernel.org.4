Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34647740672
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjF0W1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjF0W04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDF62D59;
        Tue, 27 Jun 2023 15:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4F8D611DC;
        Tue, 27 Jun 2023 22:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C39CC433C8;
        Tue, 27 Jun 2023 22:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687904800;
        bh=IyrXEJBaB4u55uz4j5feDlb027nc9kcodk8sWIoLi0w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l74vbXa1xlUq2iG++qCp3MHviJ8are1QBtLMDjMaRvm8dbsoVC2UZAnZA/Jejozzj
         TSvlJPCMKLcAxH7EY24t5tZoO4Q8b4xpxiS/nVNCentBmepXe/QwEYSaFJjp3Nbtw2
         prky7NgnQBO4oZKJsljpxU0GgOoymbtgqOaaS7VHdpuc4J6Nd1oBkOUpvugooK722F
         b8Rmkkb5PoglIS4hC7DpG+TsrI6qej9w01M1Bw/7iluObkQWQMXA3sBJ7jKpx5UEjX
         jQ4E+u3ua59PHB+PhmnyqHhk5YpPDMOcNVc6BYdUVBsMv2aUWjRVX/zkitturK8Sll
         4QdADMISRhZ8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28CA3E5380A;
        Tue, 27 Jun 2023 22:26:40 +0000 (UTC)
Subject: Re: [GIT PULL] perf event updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJrIm3y2n8x3Oyq/@gmail.com>
References: <ZJrIm3y2n8x3Oyq/@gmail.com>
X-PR-Tracked-List-Id: <linux-perf-users.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJrIm3y2n8x3Oyq/@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-06-27
X-PR-Tracked-Commit-Id: 228020b490eda9133c9cb6f59a5ee1278d8c463f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a193cc7506fde23185a7c0d99474a03a8ec5ee4c
Message-Id: <168790480015.30460.16252790000586448263.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 22:26:40 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 13:31:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-06-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a193cc7506fde23185a7c0d99474a03a8ec5ee4c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
