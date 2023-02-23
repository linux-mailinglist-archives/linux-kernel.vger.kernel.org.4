Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23926A12BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjBWWUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBWWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:20:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E135C16C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 14:20:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92036B81B41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 22:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 115CCC4339B;
        Thu, 23 Feb 2023 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677190808;
        bh=V5JtkesD2LsJcWhbBth1bh6y6QjxfI7sCglHfv8pS7g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rg+qHIkCpwN2WgpQ+8FwgsnMZsl4TKJs7dKSKLQybee/dMYg5G2g1whNnm/NEz5E7
         nCJE8//zJErsFqFLsAAlIeNkKGphlzEhNjyvpw9BsqFpyn2hUPvtnpGG/zvIQSXLdQ
         PMF9wvgzWLVlh9QlWQvXXrR3d3Zg7KmCm+aXBrx8YJvginsfOcVUMKvb7eNN/vySvy
         r941ssZYSxntCZgClX9O3kzCQZVzDqtdqtWm8Ehlx5h87QZ+HIkOI/d0+XGxEPbvBl
         sFnvBuyRsvnfl/cbjYUQanqbtGDdJNh4oyKJ9qLuPz85aHdNmoC6SwYq8ysTkppm/Y
         DgyUuT+DcuKkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEC4FC43157;
        Thu, 23 Feb 2023 22:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/TULJCcv0OlhIf1@alley>
References: <Y/TULJCcv0OlhIf1@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/TULJCcv0OlhIf1@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.3
X-PR-Tracked-Commit-Id: 392143c9f2a31a9faaf99a6f8639eae7e71b8e61
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8763154455e92a2ffed256e48fa46bb35ef3bdf
Message-Id: <167719080797.29288.10941406850845850285.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 22:20:07 +0000
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

The pull request you sent on Tue, 21 Feb 2023 15:24:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8763154455e92a2ffed256e48fa46bb35ef3bdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
