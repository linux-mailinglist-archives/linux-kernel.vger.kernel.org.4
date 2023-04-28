Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9606F20AA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346710AbjD1WEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjD1WEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:04:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3865649CB;
        Fri, 28 Apr 2023 15:04:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBD06645AB;
        Fri, 28 Apr 2023 22:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 319EBC4339B;
        Fri, 28 Apr 2023 22:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682719463;
        bh=3HgQoCXiWFIW0BYfkiGeCS1lAz04D6Lzq2oUwo+Vs1A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=feoxrgFlhSuJPE8eCMsBOIyM+Nqx3Mq677/Xg9K+0BoXs4osMeq1gBa+qz5oGozdz
         t5/LGzHYPwMbmqAzCVKGEgMbR6KrkTa2MSb7AnpIY5TqxUrOB5keM0IPlPQAIKWBq/
         dUn/ZE6+F3CfgyYFepjVWnu0OLdTUSOnxtxopIFEredAYIeBnGNHSii62W9JA+9zff
         +HfzN4EjD/88LvCgy9bhPCI9IbXNbxB+TncsadCJLVFDjACKpywFF17IU3Ht/ZCIok
         Nwd9gK8MBn+xL3kDA4lOB1Otcr49bRCr1qwGI+LKJE9VGaSEwt2VjbtQ9MBE2rLV3S
         2+CHHhcwAc8Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E9C6C41677;
        Fri, 28 Apr 2023 22:04:23 +0000 (UTC)
Subject: Re: [GIT PULL] perf event updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZErdLD+FWUjx08ey@gmail.com>
References: <ZErdLD+FWUjx08ey@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZErdLD+FWUjx08ey@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-04-27
X-PR-Tracked-Commit-Id: 743767d6f6b8f28228be181fe369657f7ecd1eb2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c339778f908875772c17f2e04ed731aac772881
Message-Id: <168271946312.9872.6109742728885395439.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 22:04:23 +0000
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
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 22:38:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-04-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c339778f908875772c17f2e04ed731aac772881

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
