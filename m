Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625CA5FE05B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiJMSHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiJMSG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:06:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5314D201BB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46DACB82064
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 081C5C433B5;
        Thu, 13 Oct 2022 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665684022;
        bh=+DpVpPSm9dxw1iEoeQ65gRCW0vbMCdadha+MqdY+w1c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uXAZQGRP/1e+pRszTU+ygB4JXGVYQ515MCWrBlYJrgJOgl6uuuLxZJlNKvm9A1WDD
         rQt8pbE+Lfl6d43TDawaX1n/gJh0UeR45+nQUyH2cbOz4AThARwcKUhoB1gNLnUAhY
         1yYag3DX5xurq8jqApmU4fWTpgrq4IYdOv2CGsibvAjvyuPAqSCamXE7rRWqFyYoZa
         V5qh4bFgU+ujz2nB2HTu7IDXXRWPQF+xf1JUz4H0Jqp9F0lYzEdcryUVjloQokPWwv
         ni2VPXrJZavdvp6/PS90IBHgqmXNmGGrXmVLa6Pt7tTy6WuIkTMsU+YyLZSuZgWdml
         rtDiemqOVcPbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6FF4E29F31;
        Thu, 13 Oct 2022 18:00:21 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221012181123.7a510a66@rorschach.local.home>
References: <20221012181123.7a510a66@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221012181123.7a510a66@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.1-1
X-PR-Tracked-Commit-Id: 0934ae9977c27133449b6dd8c6213970e7eece38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa41478a576238995c8d414ab9e0d35d1200c9fb
Message-Id: <166568402194.7515.4438186867404768294.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Oct 2022 18:00:21 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Tom Zanussi <zanussi@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Oct 2022 18:11:23 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa41478a576238995c8d414ab9e0d35d1200c9fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
