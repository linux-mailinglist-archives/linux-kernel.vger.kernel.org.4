Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD6169EB5C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjBUXmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjBUXmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:42:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C282BEF2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:41:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7EC861232
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41926C433EF;
        Tue, 21 Feb 2023 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677022821;
        bh=2OtDQiZxcF1YCa/ESz5+akJbkS1dDfqmQVBE88DAOns=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qQNGfsPLG6ZGS2TMqidEw//iIYgBJJk7p5DwPEd6+TZNr97wU73gwW48PnZxk3jzi
         JX0ltFS07zfrrLLM/oVc7NgopBLwrvCKT+cNSHW0IYzc0bEKATosPq7NGV7ZCdA1u6
         Nn7lbJ1IL13IcDFc7EHw7OlNex3z0zwjQUizPe7or4LHGvyYStjb1iAHCh4xc3IOfl
         KhDQ1z12VwHlLlPt/bhJSeRIJTB8wAI72D2obXeARh3XmsobdD7P9VJ1PfgtfMYC54
         sCPArW46HmR3agc0dtYwmsv98rqh5BpX2WBA0MeU8RZV55LK88Ubetppfri7i8L2TJ
         Lk+9D+6dMzjCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DD78C43151;
        Tue, 21 Feb 2023 23:40:21 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/VGorWUI7I6AhL7@zn.tnic>
References: <Y/VGorWUI7I6AhL7@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/VGorWUI7I6AhL7@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.3_rc1
X-PR-Tracked-Commit-Id: 7914695743d598b189d549f2f57af24aa5633705
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 877934769e5b91798d304d4641647900ee614ce8
Message-Id: <167702282118.12607.15799097574432974715.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 23:40:21 +0000
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

The pull request you sent on Tue, 21 Feb 2023 23:33:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.3_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/877934769e5b91798d304d4641647900ee614ce8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
