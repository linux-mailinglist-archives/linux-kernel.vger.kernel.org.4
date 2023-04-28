Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A66F2134
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 01:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjD1Xgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 19:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346883AbjD1Xgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12414EEC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 431806389A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 23:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5CEEC433D2;
        Fri, 28 Apr 2023 23:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682725000;
        bh=8+2YyOgaV0jClucbKjqMfJ7PyqY6SyUAGhoGCnEYHWo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jCD5ClIdApYy2s904kVu5EAcxr1MiAnlpTqVyzpl0l52KrZz3aU6PSncQqNThUegn
         CzeqRUg7E3YxVjHtv4auzf+BRBo4FwZ+awNpB4KpQigKkTeswJQMlirtEdQvViqypB
         9P5PHcXRgghnDiv2FXGJ4Zu95MMtMvlWHs2M5eo1+PvTbrmG3rBhF5UOpMZppWfexq
         xNQZ/eZMCJhKu3U12wgNq2Pe5YFil7A/DjXF/0nnehp2xwXNhR70tP1A89x5j9Lmn5
         F6i7OO0HEzbvUBSqB3lPveqqSanmJGB56SLfhZebPxcEGBBBsKUEIKedWKJN7V4bfX
         hbGXGDTcqp0/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93F89C43158;
        Fri, 28 Apr 2023 23:36:40 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230427184500.6d093468@gandalf.local.home>
References: <20230427184500.6d093468@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230427184500.6d093468@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.4
X-PR-Tracked-Commit-Id: 675751bb20634f981498c7d66161584080cc061e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d579c468d7ad6e37f5b4290b0244a9a5a7d3c4bf
Message-Id: <168272500060.24865.11813462642317088000.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 23:36:40 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Florent Revest <revest@chromium.org>,
        Hao Zeng <zenghao@kylinos.cn>,
        Johannes Berg <johannes.berg@intel.com>,
        Ken Lin <lyenting@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Ross Zwisler <zwisler@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 18:45:00 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d579c468d7ad6e37f5b4290b0244a9a5a7d3c4bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
