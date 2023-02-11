Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9869333D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBKTLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBKTLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:11:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF92199E0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 11:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 329F4B80AB2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 19:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4BCDC433D2;
        Sat, 11 Feb 2023 19:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676142695;
        bh=v3tsh6C64WOwa0UqhHvyVcK+iAl84/PNop0BAqWzhyI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UWhrbUc+tazH5wjmbFM5Inavlet58XXp2tx6XpWiFJs5TWKEqHgP/xrnlz1+0sBj2
         V8rSfQStcXYXZ9uu93IstwoIAsw3ajtASYz3eBU++wuBV+/YD1RO5Rm+5tEyQBoKtp
         AMBRJsc5yW8Srso+ig0zlyud7jMLDGdj+lkpu1bmKEJu7KRPiLYVjN16wisw8OLk4Q
         t6xcqPkQkOYR+wnf9MFYXrtzT3dWQ1upx98GKVBNZyWUvwb5PdkqXa+fNO9bPhDgLc
         K5R4/6mqcWIb0CfDb77L8BPsW/8aH+ghPyaJ9ETAS5NFVB/I/thhEZe8UCqd5GrY83
         mZUSpbq6E0R4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0659E55EFD;
        Sat, 11 Feb 2023 19:11:35 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: Revert "mm: Always release pages to the buddy
 allocator in memblock_free_late()."
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y+dqPRXSqoP1x7u5@kernel.org>
References: <Y+dqPRXSqoP1x7u5@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <Y+dqPRXSqoP1x7u5@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2023-02-11
X-PR-Tracked-Commit-Id: 647037adcad00f2bab8828d3d41cd0553d41f3bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 230809c145091e5cfd948bd2db98e67a1a0571de
Message-Id: <167614269571.18613.15214253956689817725.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Feb 2023 19:11:35 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Thompson <dev@aaront.org>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Feb 2023 12:13:17 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2023-02-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/230809c145091e5cfd948bd2db98e67a1a0571de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
