Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6055B747972
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 23:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjGDVMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 17:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDVMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 17:12:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C7BE5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 14:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 879AF6138B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 21:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E20C2C433C7;
        Tue,  4 Jul 2023 21:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688505135;
        bh=5QV1piu8KT5vafxiFmpN7bFFflBc5pG3+2HZtP83okQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h0mU4VVhYeKPmxqoyDmdr/qRXQ/a/+/cZ7bVhcq2aZDsNEzJ3lBBZjFHawyobl76m
         VCuwjyaAsaKx1FlFefGAnO2yi0pgtrv3iMXOSYmrS/h1n45WPk5FlgsTc/oddBlkOP
         1EPTfA+hpWmSxG/XoW7Jdy02zktTHUT/eVHmtAxEVQhwRTbIVxDyVsRZtCekTwn0OW
         neX3GPloR34ozXqTCDFKQKxCh4O4gnqiWqD3WTBNTwLV2xbSw3ERMlkcxHbmTQxJ1R
         QdprduzTmswSrqlWBUe31Y1+YL3tBPYWPqdB3oqqEEiEsudRfF3awVsRoIO0ycRYFE
         5WEEMSxXpgXpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0153C395C8;
        Tue,  4 Jul 2023 21:12:15 +0000 (UTC)
Subject: Re: [GIT PULL] Scope-based Resource Management for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626125726.GU4253@hirez.programming.kicks-ass.net>
References: <20230626125726.GU4253@hirez.programming.kicks-ass.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626125726.GU4253@hirez.programming.kicks-ass.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git tags/core_guards_for_6.5_rc1
X-PR-Tracked-Commit-Id: b5ec6fd286dfa466f64cb0e56ed768092d0342ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04f2933d375e3f90d4435b7b518d3065afd1fa25
Message-Id: <168850513584.8524.13859881561991027918.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Jul 2023 21:12:15 +0000
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 14:57:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git tags/core_guards_for_6.5_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04f2933d375e3f90d4435b7b518d3065afd1fa25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
