Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872FD6BA550
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCOCl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCOCl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:41:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD234026
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 620FB61AA5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE1BBC4339C;
        Wed, 15 Mar 2023 02:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678848084;
        bh=olup1W4eNNBxUw0Pe1HBv+dF65Vj0ACLHuaXiTBsQ64=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dlz8zSeUV0R9aojM8Jhw92hI3+rJBwofAMaPcn+CVJrLVlkqBcDiugcdUU49Dx0T5
         iUIe7TDY1gEFpdDHGy7XUEIE0Pn2c7+Rlju0teYHSFcIzzvlp3Za5omAFjguTS2/BU
         CEA75/jcYsA9Ld0bHz9tQX1iC30HlKR1BA/3vIxJI88E8d+a6e1w5DBxy0j0RS6kot
         eEg27D0Y18O3VFIoQJBlLK/9nxKsrQ/P6nWuBgueIsObitDJLg/k97xiUCivnwAKK1
         ziE2gJZ95EJeeyTYG9KPTmp5g/ay0y6esOH7y/6sNNvz50wUMirqP5i8v8sAhkpp64
         N6qH179Bslf5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEBDBE4D005;
        Wed, 15 Mar 2023 02:41:24 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230314181012.05baf5c7@gandalf.local.home>
References: <20230314181012.05baf5c7@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230314181012.05baf5c7@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.3-rc1
X-PR-Tracked-Commit-Id: c2679254b9c9980d9045f0f722cf093a2b1f7590
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29db00c252c7d0e015f3b436647b6f87d5854833
Message-Id: <167884808471.332.2905086814917088880.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Mar 2023 02:41:24 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Tom Zanussi <zanussi@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 Mar 2023 18:10:12 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29db00c252c7d0e015f3b436647b6f87d5854833

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
