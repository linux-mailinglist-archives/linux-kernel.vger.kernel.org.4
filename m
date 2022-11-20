Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A40631761
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 00:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKTXiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 18:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiKTXh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 18:37:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C21EAF4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 15:37:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB741B80BFE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F6E6C433D7;
        Sun, 20 Nov 2022 23:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668987473;
        bh=k74DB+A/c6keA65rwx9w5GFDT0SH2f36UoEyh90pulc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f0LZAX3sp3H4U+DM6EqQsDilBUGXHc8MhK83c/y3Ec/DypDdkEtg0nBg87RfP4fPi
         XSEMjlI0j6beQ1UU2hUukkRti57ZnlhjetvWbGekP7HWcss73SDS5qVzoz0df+Flda
         8HZIINJi+i8p3ZIXdDYrGrfNSxHzNDy/NxOG4mE3gSJNydl9o38d1YGZTkmEtD+ys0
         2xb35cW6DFilkSVvVECYn5PO8yDTkFD7KcQONiCpTZkah3GipVdAFH/QmGWkxiGFg/
         gLBJuzGSfZhEYgLYIYGIkwpYf2e5MEKKfbeDKnGloYnblxuKZcS8u724gyw/7P9CT+
         mD7vRk9cSy+pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 621F0E270C7;
        Sun, 20 Nov 2022 23:37:53 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/probes: Fixes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221120154645.63d5c899@rorschach.local.home>
References: <20221120154645.63d5c899@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221120154645.63d5c899@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-probes-v6.1
X-PR-Tracked-Commit-Id: 40adaf51cb318131073d1ba8233d473cc105ecbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6c67bf9bc2714d9c2c2e7ecfbf29d912b8c4f17
Message-Id: <166898747339.25585.16030540635168944340.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Nov 2022 23:37:53 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Huafei <lihuafei1@huawei.com>,
        Rafael Mendonca <rafaelmendsr@gmail.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Yi Yang <yiyang13@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Nov 2022 15:46:45 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-probes-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6c67bf9bc2714d9c2c2e7ecfbf29d912b8c4f17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
