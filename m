Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5488A630915
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 03:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiKSCGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 21:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbiKSCFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 21:05:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D712F;
        Fri, 18 Nov 2022 18:04:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3BC362762;
        Sat, 19 Nov 2022 02:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52E27C433D6;
        Sat, 19 Nov 2022 02:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668823490;
        bh=LOnZjTnTkOE5q87hJ6EM3N5CHtVVoQvcOlcsiZH4VTU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lFwBRVxPE+WtL4ML4BdVeAvoVqt8YtYMGPxuYeUwcB34wRvz5dmodSiGmhK3UbYVY
         k1Zk2J71elLKptddn4HmGVg0kaX+YYhk28dMO8TxgTXUSmLHJoJIwg02N1+dTorehH
         pqsgNLoZQWJXAIz2hIHgJYjunMH9pT3D3FmaigcD1R74uEW+QbJ5BlodWofc9324f4
         oRvQma8SM+yCE3M/GyA7nmVx2r1eEcIE26e6vgcA0gnmbZJC5KYyyw+KJdy3g5htoh
         fwGkzhaKbgsL5XdyEz4pvow4JrWcWMJDEQ3XF+433XemYKvZu2gEM7T4ssp8MrP/pa
         p5ftIEYveTvZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40A19E270F6;
        Sat, 19 Nov 2022 02:04:50 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3gwySzRvhCwdSgW@google.com>
References: <Y3gwySzRvhCwdSgW@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y3gwySzRvhCwdSgW@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.1-rc5
X-PR-Tracked-Commit-Id: 81cd7e8489278d28794e7b272950c3e00c344e44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe24a97cf2543e8832e7a2124802e5c32aac05aa
Message-Id: <166882349025.5277.9788348641672149029.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Nov 2022 02:04:50 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Nov 2022 17:26:33 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe24a97cf2543e8832e7a2124802e5c32aac05aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
