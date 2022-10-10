Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACF25FA487
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJJUFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJJUFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:05:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4A21C431
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 13:05:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3BF7B810D2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E97CC433D7;
        Mon, 10 Oct 2022 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665432313;
        bh=hutxwTa0KvbKTJleL3Mzytg2Aq9cFX/6xotl/OOOItY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZWZdwau9OdZWp95qWbXjBPeEb/0PewSCOY1ZY7QUjGPcIPYmEOoJ89fu3lnqqvfUt
         nqV8HZz4WP1e2zgxOv4O3hv2K7I0kkaNAxdi2VbmqBiSatSZdHQsCh71MvHLXLGpLS
         emv0QVcO1XCC0wdbCD3gU5UUPeUbKk5cuT9FHdYsVQL4/lG51u5Ux5u/CAEXgYoI2b
         ZahsYZi9+9dg50mYGQFQ9X6QLUmZRwg79OFexbfcxxS3iQKr4MO/ebAVFSRnmXBMv1
         PHOPWoUXZAQ+LAuiji+CbVpOjbMXoBZLRG5AOlqcbR6RPSgG8V1+9V2mjlHwv+Ob54
         yOqHN/sn5Swaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CD74E43EFE;
        Mon, 10 Oct 2022 20:05:13 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221006114029.310e80a6@gandalf.local.home>
References: <20221006114029.310e80a6@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221006114029.310e80a6@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.1
X-PR-Tracked-Commit-Id: 4f881a696484a7d31a4d1b12547615b1a3ee5771
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdf072acb5baa18e5b05bdf3f13d6481f62396fc
Message-Id: <166543231330.6988.6014599708871491773.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 20:05:13 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Nico Pache <npache@redhat.com>, Song Liu <song@kernel.org>,
        Tao Chen <chentao.kernel@linux.alibaba.com>,
        Waiman Long <longman@redhat.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Zeng Heng <zengheng4@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Oct 2022 11:40:29 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdf072acb5baa18e5b05bdf3f13d6481f62396fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
