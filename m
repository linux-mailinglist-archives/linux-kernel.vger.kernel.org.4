Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C716C0369
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCSRQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCSRPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:15:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02531A483
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5ADAB80B16
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 17:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 938F3C433EF;
        Sun, 19 Mar 2023 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679246146;
        bh=jovxHOQlob/PA5bx2TvucjNPAP9+WD9/7uGTDCLRaCw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TfZhYFKhnYS7GtlRFuZmeDEf5+dhSB5L3i+MQEWruQKCRM/E2CJu/LrlijYO7o8CT
         fWkE8qOreSl1NsLidX7XmiuOORf26eJXtD6bJGkLSvy+vfPq5weXZSu900P9I4mmqx
         6wrYqhs1c/Y9BdxyJyPfds3lamGrMkcm1oQNxtBeJjR++/AuU51mwTad0ABQcz4LYf
         JQF4yu/Y4MLQQq9DLkzKi9zICgcIdDcmjJbxiQnAV223pVweRRBwh+eOMIdL7ppN1S
         5IwD7powJ8Fw2Y7YN+RpicL3m08eqwz0haMrndKPPyVMCdfySH69fzss7LGLyglwNk
         +f2W7DVtNUwcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81753E21EE6;
        Sun, 19 Mar 2023 17:15:46 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230319123528.GAZBcBkJKPZCwVKnBl@fat_crate.local>
References: <20230319123528.GAZBcBkJKPZCwVKnBl@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230319123528.GAZBcBkJKPZCwVKnBl@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc3
X-PR-Tracked-Commit-Id: cbebd68f59f03633469f3ecf9bea99cd6cce3854
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ac39c5910add53e77aad356cc19721206c76ef7
Message-Id: <167924614652.22094.13611308333830550180.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Mar 2023 17:15:46 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Mar 2023 13:35:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ac39c5910add53e77aad356cc19721206c76ef7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
