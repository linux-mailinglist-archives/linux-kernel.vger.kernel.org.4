Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC0631760
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 00:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiKTXiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 18:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKTXhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 18:37:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B9315804
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 15:37:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1326260CEF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65602C433C1;
        Sun, 20 Nov 2022 23:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668987473;
        bh=8SlsHszUWJ2DEwD4H0dsFfYa5kdWf7a3ywmxar/8S9A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q8337KwzbTo23I+SOkdIZbpABMxrWMlyVNWoy+iAwNgxzYoTTucrtcPV6ZGFJRJ0l
         n70rpL4wKCReWbrmTzqycrtrPQad8aHgr8DPXmpSYQ/bM2xTCdFOQCZ2Vjnjpn9Ji6
         9aKtwYwX4m3FDyffN/yIzvs//eJmglZMb0+4PRybBJB7bWeHcen0V4ulGwH13yB1J8
         NaTgDnD6JJPJD8FrynBF6pGGxn8SWhq/n7dehuVQj8pcel0HdsPfWzEyI7E95nnfE6
         8Qm45FUytOd7aIdG++r1pzWFT0lpYd+1vxnUC07mr1WFz+hdsOlUTcBn/lfYn4xw4q
         lGFC3HOOXNWvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5248DE21EFF;
        Sun, 20 Nov 2022 23:37:53 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221120152730.4d2a512d@rorschach.local.home>
References: <20221120152730.4d2a512d@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221120152730.4d2a512d@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.1-rc5
X-PR-Tracked-Commit-Id: 94eedf3dded5fb472ce97bfaf3ac1c6c29c35d26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5239ddeb4872390856bb79655dba85350936681e
Message-Id: <166898747332.25585.4187034776068040297.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Nov 2022 23:37:53 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aashish Sharma <shraash@google.com>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Qiujun Huang <hqjagain@gmail.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Wang Wensheng <wangwensheng4@huawei.com>,
        Wang Yufen <wangyufen@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Nov 2022 15:27:30 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5239ddeb4872390856bb79655dba85350936681e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
