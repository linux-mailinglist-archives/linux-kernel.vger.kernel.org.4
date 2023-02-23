Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3C06A139C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBWXQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBWXQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:16:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F0230192
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:16:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0D38617B0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 920E9C433EF;
        Thu, 23 Feb 2023 23:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677194202;
        bh=Z4k8KfvUlJSvl7bF8CTjTt77bY+epu/Lnawa+Fv11aM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=awwfxO2r0z6w/M4go0N9lrUUgDqLsT4spCv4OeD2vj/ki6S/rRrmWqU4F1KJwQc9s
         DLEPuURTe6UfCO+Rw4rRe5sCJAkP+q5wlefTrvdw049AMN6eYnkKSs7X9Yeb2S0fzT
         CKMlS7DBd9kY1UwXXnhmp4rjFn2AwVWLivL51V54f+BhbRMNvEZ6XweXwVlvQUE7ws
         abhjPXi+BelaYmXyWKjPTQwug6lAPuqfjk4Bp9YIQi9vIFh7ql9/dDjUlDxJBrwLO9
         LTCldllnskqulrpnsbQa0QeFyTZ5U0z2FZSJMI4SEmkXorH/7X9AZSIjeEOzX9ih9Z
         nMUCVEK+cEJ6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74CEBC43157;
        Thu, 23 Feb 2023 23:16:42 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/cq/Im+leAX6XRn@google.com>
References: <Y/cq/Im+leAX6XRn@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/cq/Im+leAX6XRn@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.3
X-PR-Tracked-Commit-Id: 59c54c59974649b2e7bc92faae4a21e2b2408db2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2c23dc7d5f866a8bec3db638fae7f63789303ac
Message-Id: <167719420246.30381.10085284873109192078.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 23:16:42 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Feb 2023 08:59:40 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2c23dc7d5f866a8bec3db638fae7f63789303ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
