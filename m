Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6DD6A0FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjBWSrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjBWSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:47:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13715158A9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:47:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8E02B81ACC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F204C4339E;
        Thu, 23 Feb 2023 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677178031;
        bh=1g+pnw/o7u/tsM/BP37iaF/afo5gNCAX6OravnjTd8g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ncr/AwzMkAB50WMaAvThB4SjjfVj2VVC9Rmyh6/sBnWvuywta9baDjstEPhfitikc
         UX/NHo+FtdYER54aLOwg/xn9bgyBPiBRtmrfYZXsUB1S9MSlDPSHDrGqt6O+6ETPpE
         MeHwuN5votl08QDoVOuG2gNPWg9wCZqVmQkwIRD5E8ikIML773yE+6wk3seya2Kuav
         wY03GRX6epLxqLBtktgg5p58k7hl0639nF+TfUYTl9Gb3+V8qLuWQld+d5fxdJjtds
         kdfqBTVLxmcjFkfo52KjNmvK2rIHMhAAvcfODX7TXeX2a5E260m2DIiOOJKe+Gm1ig
         HCIv+qNv66v/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E76AC43157;
        Thu, 23 Feb 2023 18:47:11 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/tools: Updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230220135755.0fff5d29@gandalf.local.home>
References: <20230220135755.0fff5d29@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230220135755.0fff5d29@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.3
X-PR-Tracked-Commit-Id: 5dc3750e747f93f9bb7987da3d47a8ab4a5a181e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d392e49ad89059624a2b24daea3c64d0e0fb4124
Message-Id: <167717803138.14005.14867354048008407938.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 18:47:11 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andreas Ziegler <br015@umbiko.net>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        zhang songyi <zhang.songyi@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 13:57:55 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d392e49ad89059624a2b24daea3c64d0e0fb4124

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
