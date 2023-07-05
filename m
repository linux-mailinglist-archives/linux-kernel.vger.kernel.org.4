Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44FC748BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjGES0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjGES0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:26:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E895170B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 11:25:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E39D9618E2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 18:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43F3FC433C8;
        Wed,  5 Jul 2023 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688581142;
        bh=Te+PutRm0To2FwQ47c9iKU2cg6erEC7lDJm/dyPtBQU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WQhHy/0KpaDqsIYUKD1EMA6Y2uPSyeMif3nOxjWHWh49xjSEJCgtUFzU23kqK6ZQ/
         MyOxNISlRGQWi2oeDS9d0Xf6vtZH93LQGcCbA4Sdo6ulVuLQjEKBe+v0Nd/Z9vQpJy
         nlVFoo3jsAWmFvDVrGFOTq0QAspZ68bwVyMct6ns9yavSNAPqVhQbq1+GZSSrwZz0x
         N4vkG3jk2HqGFzIM1gTKipajxh+8cBNeGewEscIcVf2p8z32uLFTubsEc5WfHvuM5J
         1Z3+JhHwxxDrlVOgzGQzxPOjJ+uVVHI6ca+aNJ1iaJphvfpVc63hZ4DG5PM7w0YJQz
         k4mfI/nqYd2WA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31669C0C40E;
        Wed,  5 Jul 2023 18:19:02 +0000 (UTC)
Subject: Re: [GIT PULL] tracing tooling: Updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230704092942.6d140594@rorschach.local.home>
References: <20230704092942.6d140594@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230704092942.6d140594@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.5
X-PR-Tracked-Commit-Id: 6127383217741615f3450b684ecbee1ff570ee98
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2784d74bcc811e9d743398da38552e6f9c73e96b
Message-Id: <168858114218.22216.1385963506532149530.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jul 2023 18:19:02 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 4 Jul 2023 09:29:42 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2784d74bcc811e9d743398da38552e6f9c73e96b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
