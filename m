Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605566EE8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 22:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbjDYULO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 16:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjDYULK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 16:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45030C160
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2409963153
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 20:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88B39C433D2;
        Tue, 25 Apr 2023 20:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682453451;
        bh=0o8rlCe9divPDy/5sFEAOE0rTuGqWMeNNNttLM8OZ4I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Km2K+NzaqbaOqEag+w0CeE4B4C8KC+GAtmGlXQnzA0/5OL4AaYSp/44SyKJ3p8yUe
         yUPfAt3K387xlGa66uB7RlbJ/N0QkPAHReeokzPrTzPFoud5z98Sg9eSeu9IiQ4LH8
         v7u1wUEa6trQn72/Re+KnemjAGVwNAHQBc79pUgbeqc+HpZX9avTbMkbbLqG4g5Otr
         Ohd/7ykg7tQiBU6FS4LbCQVjlukHDyAwSz/pZZT4v+17/9D8RfxsnKlJNWtKWkWwMx
         6U+g6UAJumgRzypwS18ci95qJ7mU+6x/rv37bU6eBfD//TOEgi16XRDmbG25Pv/cwl
         JSWhI1EOaAb8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71545E5FFC5;
        Tue, 25 Apr 2023 20:10:51 +0000 (UTC)
Subject: Re: Re: [GIT PULL] printk for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZEaojWvka0SeXv3B@alley>
References: <ZEZ15NNm3gAIfML3@alley> <ZEaojWvka0SeXv3B@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZEaojWvka0SeXv3B@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.4
X-PR-Tracked-Commit-Id: bee43904dc774b35bb159693ff3f3ff222590bb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ec85f3e089aa423a69559bf4555b6218b5a2ef7
Message-Id: <168245345145.30863.15522302850311711902.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 20:10:51 +0000
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
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 18:04:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ec85f3e089aa423a69559bf4555b6218b5a2ef7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
