Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD161E55E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 19:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKFSts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 13:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiKFStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 13:49:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4F5FCDA;
        Sun,  6 Nov 2022 10:49:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 07D5FCE0E7D;
        Sun,  6 Nov 2022 18:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45115C43470;
        Sun,  6 Nov 2022 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667760581;
        bh=9c3vit/Z8RvKn32+a9psZtn/ky8u5vrUPzJ7vnj6qds=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SpPUdSC4Tti1M96uHQF+9l4YdYIgzRUE5gMiy3lgHZGrBTCTN61EQIpOwk50DLTcy
         AMKN7C4b5sEBd8Ce0mZxIXvT/N3fFUO/LKtaemwGei6sROgmIx5AH4SEpoyghjgFqd
         DiNvogZ0/XV4G2SS2oJmsSC5izbpm8lUcx/DDKpRtofzrTiHnLkkyJM0kBlUKVE8rd
         fUG0ValG8VIXL0rUxToZMfQ7I3FnGmxJZ9jGG841UyaDHbErRcQMTV1yRg8AgzIJFe
         TnJHlFLFx6masa9yd+kUTIW/zm9HFLg64Si/MnSFnIlqfm8PoM99KINx+Wwesnwhcq
         hPjPmgnpCPS9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FD20E270DD;
        Sun,  6 Nov 2022 18:49:41 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221105170512.39ee3ce9@rorschach.local.home>
References: <20221105170512.39ee3ce9@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-trace-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221105170512.39ee3ce9@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.1-rc3
X-PR-Tracked-Commit-Id: 66f0919c953ef7b55e5ab94389a013da2ce80a2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8391aa4b4cf44c2b942f5e38e6fafc9e6aeb1c24
Message-Id: <166776058118.6751.8880256381103554441.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Nov 2022 18:49:41 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Huafei <lihuafei1@huawei.com>, Li Qiang <liq3ea@163.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Rafael Mendonca <rafaelmendsr@gmail.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 5 Nov 2022 17:05:12 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8391aa4b4cf44c2b942f5e38e6fafc9e6aeb1c24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
