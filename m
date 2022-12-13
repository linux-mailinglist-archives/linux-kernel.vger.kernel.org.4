Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F62C64C0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbiLMXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbiLMXb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:31:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55871F64
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:31:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 093A2B8124B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C493DC43392;
        Tue, 13 Dec 2022 23:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670974315;
        bh=+CG8Wbo8Uqn5cOu3qHmOPm2LARjfAYeDrsU7I5xYjo8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dw1mNOraUxBf8T4edHxvGV9dzpD3XB9vMBXPnxlmxlaskXLwIufVkUUxX07/5gF4H
         8tKWhUlPBZ01oW2FB4lG21xSOTPOIKTLBEowsC76zfArdILR/VTZiU7cS5BeeEHvnq
         DlXDxuJwf+V2M5vyedI9bVxwgegrqGGVOQLCLPcYwHz+oYlg//ll67IrzVNr/7o+ij
         IKqObMrSvWAOmcip1i8/C6XhNk/yO+Wzax+f2XFu5Bdx8AIPOkXVbUZ06f+UgrHuse
         l1qINpi4G+54rkNhnQE3m9I+T8Uu5uXhKX3gXrTCWtcZOw3juURRdOgzHrWmmKbK46
         7F5kQblWIFZDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4BE8C41612;
        Tue, 13 Dec 2022 23:31:55 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5iR0Jnh/1auvH5e@zn.tnic>
References: <Y5iR0Jnh/1auvH5e@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5iR0Jnh/1auvH5e@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.2
X-PR-Tracked-Commit-Id: 2874529b3513bdc90299c90f40713602da685e35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 740afa4d39414516c36836ad88bed8294c72ba5f
Message-Id: <167097431573.3216.10485368464090701582.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 23:31:55 +0000
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

The pull request you sent on Tue, 13 Dec 2022 15:53:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/740afa4d39414516c36836ad88bed8294c72ba5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
