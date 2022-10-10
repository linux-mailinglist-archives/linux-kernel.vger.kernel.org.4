Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4431C5FA39C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJJSs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJJSsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:48:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237FA753AA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:48:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEFF9B810BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90CB4C433B5;
        Mon, 10 Oct 2022 18:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665427681;
        bh=XPa1IgI/F7x/vnXWLSPuZ8Lz+6AGUPQvbgHc0Qyenzw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XxJs4JYdP0EDb79lWb87WOQQukbigh16tGurZB2sg0+1NIkAzvkE2qnYdu+uyx8wS
         OGREMr79joFvgII1QQKO1+EIH7TYhxIJQXPnC30StDTYzhNIQEtOLFVrnN8GS3uAo1
         kx+0HispwsaXPFsdrARqrWZH2zoC0LoVgaF6GUGHvF/ZPk3uQDt+Z8CmBvUBAtimBb
         A1bsyTesm+30O3NsMhXeONT5vzfjXo2CrCguAq2bEBIKPLyK2xpevQYKOQYHDzeb7G
         FguxSFyLx54RDR/VI29pfs29eCyJfQ12ryzrIX6syiHQ0anipaRXh2kwnlFg5ry+a9
         x/vVenjkVgkLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E961E4D00E;
        Mon, 10 Oct 2022 18:48:01 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yz1VANOUjskMbdxY@alley>
References: <Yz1VANOUjskMbdxY@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yz1VANOUjskMbdxY@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.1
X-PR-Tracked-Commit-Id: c77ae0b86322fe91115d8188cbd3b36ecdb8120e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b520410654103086ccc0d339c0ff645d4c4dd697
Message-Id: <166542768151.29715.15905206673083792795.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 18:48:01 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Oct 2022 11:57:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b520410654103086ccc0d339c0ff645d4c4dd697

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
