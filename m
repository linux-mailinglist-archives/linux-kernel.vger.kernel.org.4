Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404527085AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 18:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjERQLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 12:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjERQKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 12:10:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706DFE5A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 09:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE57B6509D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 462C5C433EF;
        Thu, 18 May 2023 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684426253;
        bh=ZB+fJJbDgEfwMCmFt9WA78XUm6Chfsioo5isNIsFe8Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TzG2d4K000i+uFEjULKk0JUTzgF6fxLVPDIx0raGNiIwDM0/NGKH6SiH3f1q1b9ff
         9uzMv6UTNq4E1aDlF73Z7CqoGu9Ay2j+zl0yd5xCQ5Hb0nvLV1B37Wgbs6hXuKf96z
         yDqQKbeHUiRHsBNZAkMXMYXPngwgujR6j+2pTc0rcFB1960vqXiyVR2SUbjm0RX3Pm
         r2Dbsx9fpqc5OSCnWaBfGdfkb3Te0vdeaZYdwe648gQZjeglsQy884OPaT+E+xMTZ8
         EppbqC/fix/VVFT2SGDElLHOk4FzFcjpQsKovQrncFO4MauJqmUNIKftda97oZqXgP
         1Z9rv3XJQFksA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32AFAC73FE2;
        Thu, 18 May 2023 16:10:53 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230518224409.62cf8ccef515cbccf07f0e13@kernel.org>
References: <20230518224409.62cf8ccef515cbccf07f0e13@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230518224409.62cf8ccef515cbccf07f0e13@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.4-rc1
X-PR-Tracked-Commit-Id: 571a2a50a8fc546145ffd3bf673547e9fe128ed2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d1bcbc6cd703e64caf8df314e3669b4786e008a
Message-Id: <168442625319.10219.861022467648959439.pr-tracker-bot@kernel.org>
Date:   Thu, 18 May 2023 16:10:53 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Ze Gao <zegao2021@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 May 2023 22:44:09 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d1bcbc6cd703e64caf8df314e3669b4786e008a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
