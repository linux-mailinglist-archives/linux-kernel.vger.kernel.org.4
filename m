Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A756A5F4896
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJDRfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiJDReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8807567173
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36383614F5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B1EEC4314D;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904845;
        bh=bnBLNdwHJnhNWrzzsGyhshIcoqji6YLFWryj121V6rM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IOYFCdJq2NBi+rYG4ieMRSNi8kuxmOlOAaQ53iBWn1e62cZvWTMSLnNjxYTPmzmVu
         jHQCqZ91ML1USqf/82npExdGLqchq+TG1TMO9mtba8Dt3xmFCHnUIdulxPC2Wm9qms
         M9oKBf/PtU17crVSbeNaaZ7QDcW76ip6iYYeOMN+KNmdC3xF/N7bbqSviT7ujqLAK9
         DRW0bKOFHkZ+FMWW9TNVjtCcDOZEAbr5nEXxvc/SjtZm5eM4Y7YnBJSWUcpt0M1fGO
         QJlBxarqNR3HrBuZ70aERj78n70kKsmMxkKNy/rETt2FEFlo5bQv7434CC1EFzmbR1
         ctx/ETYipraew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A09BE21ED6;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yzw/DmB1aHPjfN/8@zn.tnic>
References: <Yzw/DmB1aHPjfN/8@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yzw/DmB1aHPjfN/8@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.1_rc1
X-PR-Tracked-Commit-Id: 5258b80e60da6d8908ae2846b234ed8d9d9d4a19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 901735e51e4dea1eee816b0b57d1d6abbd94b3d5
Message-Id: <166490484555.22164.5186487192981593850.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 17:34:05 +0000
To:     Borislav Petkov <bp@suse.de>
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

The pull request you sent on Tue, 4 Oct 2022 16:11:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.1_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/901735e51e4dea1eee816b0b57d1d6abbd94b3d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
