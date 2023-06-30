Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA097431EB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjF3As1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjF3AsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E6B2112
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FA8861689
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 00:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1CEAC433C8;
        Fri, 30 Jun 2023 00:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688086099;
        bh=BEC55u6VSipA9XBhjEHNmo/pJemnkPgskb4Kl6rVsVs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F6V/yFS246RKCZl7e7nt3XE7ejqJFJz1EsZIH0V/NKsjx0/s7CLWObuPRTm4ysxYj
         Nub0NeKB2sF8et0hoJZmVE8prdIxxq7+TbgaAwLrqajfGkyohs68bostBkLQ/bh47z
         WI+r4h8Lv2gqeQKnxd51I/ikoSU1xJG9aXmAMMBhLDu4vUd/KtgsJY+l95+2f7XGdP
         NE9Ic8rle4erfCJxd+6ePsFAly9lCnQsZBiwxEZku2yWboqWivPLMJJMx3IvnGOis4
         czJtcZ8/23jHT4z8W28qLKWYfDzNl0eLTzIELxvrj0J0mEd+UmQajT+S3pr2tXZM68
         MwbFPrdAGJZFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCE00E5381B;
        Fri, 30 Jun 2023 00:48:18 +0000 (UTC)
Subject: Re: [GIT PULL v3] tracing: tracing: user_event fix for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230628110604.5cf29440@rorschach.local.home>
References: <20230628110604.5cf29440@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230628110604.5cf29440@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.4-rc7-v3
X-PR-Tracked-Commit-Id: d34a271accf8fad00e05aad2cecb9fb53a840a94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ad7b12c72ae6ba34d452e88a60c37c9fb368fbb
Message-Id: <168808609889.32109.10667111477839618517.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 00:48:18 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        sunliming <sunliming@kylinos.cn>,
        Beau Belgrave <beaub@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Jun 2023 11:06:04 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.4-rc7-v3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ad7b12c72ae6ba34d452e88a60c37c9fb368fbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
