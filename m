Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E853B6F2135
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 01:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347049AbjD1Xgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 19:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347036AbjD1Xgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65CD5244
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 16:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71EEB645F3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 23:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D011FC4339C;
        Fri, 28 Apr 2023 23:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682725000;
        bh=WQdsqAYV80U/Lo6DNKXs/BKuY4qjn48183qKktJU9Gc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RprVDaW/djV6H8F92ctAxk+Yr55mMLOmGAOsjrJ81SOTjO7GwTyotf0Panfw3jRkn
         mkP204Nr3KE68AefXI6HpbZ5V4HS3rqYHO82jF0I/mtY/1VjRPAIuAfVnHwkDmve8J
         4OqJ4/891O9JtDAb/6gioSd4N7mKIBefd1mniVWGf4Ep5082UQm3NS3bEbaIrV58uV
         UZky27Uozy4ZfCkVW7Ms1bRLdcesGgTzZ0rwvQSQd0fAjg3XRJ+Rj/oHna4qVdHbGm
         wI6JquOj3soyUvTyZGygtHERyhecRPwpqDY3xCQVdInaCejM8pnDvM9524dP2NJLFU
         R3oj8Yw/vuItA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCE05C3959E;
        Fri, 28 Apr 2023 23:36:40 +0000 (UTC)
Subject: Re: [GIT PULL] tracing/tools: Updates for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230427184718.3af785b5@gandalf.local.home>
References: <20230427184718.3af785b5@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230427184718.3af785b5@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.4
X-PR-Tracked-Commit-Id: 82253a271aae9271fcf0aaa5e0ecc6dd38fb872b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ea8abf589f2974d65460a1ffa0c303763e958da
Message-Id: <168272500076.24865.4628194739658390818.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 23:36:40 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Rong Tao <rongtao@cestc.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 18:47:18 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ea8abf589f2974d65460a1ffa0c303763e958da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
