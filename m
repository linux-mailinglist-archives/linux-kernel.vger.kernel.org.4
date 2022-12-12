Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EAA64A603
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiLLRem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiLLRdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:33:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B35A47B;
        Mon, 12 Dec 2022 09:33:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4B456117C;
        Mon, 12 Dec 2022 17:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24C14C433F1;
        Mon, 12 Dec 2022 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670866403;
        bh=pW1e879R3mDzJwDoC1+H82gUhPtIqlMJxzVxxPKfXKk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R9WLwD5U+mkQfhDUtxYJ7XoL/yIkmn1ht+tYsgYP1jFhfCcYArpY+PTWVHeuNQhbe
         A03Jdow/LSMLxvgKcm9C4SQSAdoIjLDvdzYTjKJip6KYJvlZrwYhNv2SBQ1ES6Aktt
         a9lJdMtTuf4HIMjm89Yvke11k/aAiioagBGO+EdFzVDYIXMSa28MUX/uW4hHT6n1nX
         ++3jkGB823y/gm827EFsKZ7TSefxWvwmX0fMX5Tc+H0hSBRk4FWdr6f5a8oKUiRkhw
         NPTmzhGmtkyUKO/LG11mYWrM4kAc9PjMfSaMtQ2liDjjbfEFnzV68i/jeeptjN3UJ7
         Zw89qBvhFVO6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 137AAC00448;
        Mon, 12 Dec 2022 17:33:23 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5H9k52WWXBmWuwZ@alley>
References: <Y5H9k52WWXBmWuwZ@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5H9k52WWXBmWuwZ@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.2
X-PR-Tracked-Commit-Id: 6b2b0d839acaa84f05a77184370f793752e786e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98d0052d0d9dcd5323833482712b5799ed0bbb0b
Message-Id: <167086640307.22610.14484806645288312687.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 17:33:23 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
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

The pull request you sent on Thu, 8 Dec 2022 16:06:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98d0052d0d9dcd5323833482712b5799ed0bbb0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
