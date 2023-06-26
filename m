Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F0673EEDA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjFZWya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjFZWyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267F71B0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FCEB60FB7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E1E5C433C8;
        Mon, 26 Jun 2023 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687820050;
        bh=6kWm3YjiXWP3r3a4Usu4N22uqZAlafeb6Vv54hxFxOo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DIABKJHMhjTB+HmAIUYGTPnwxD9Lok8aRe07+owZQ9AU4R6Zp6NwJQgdY6vptXfJf
         dGCILOtcEfmE5dehUVlcGpXWi9N0m4hhb+fs4yzbpn3+8ydaXdHiLerTFmx/SkoBPB
         oZns9M7Mzt0Is5B26KsTBZROaVrYj+7qFRBzrU1wV81WFAKOoP+T6gloXw7Msm3zN1
         TZHHBcnqYE/swj87bOyHEG7BH4F9+v3H0YYzElR/N6qGfFR29sfaqSbcPX9sCUJSOF
         XQsZMGW9Hi7btO9TIHW3EsHdnNkDDqTmeUJsE/TBIyYSIvZjr/jT23BVGEXQPUaWyW
         xfCkAr/9TXNPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED287C43170;
        Mon, 26 Jun 2023 22:54:09 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626164554.GGZJnAwnKoOTCbvKfn@fat_crate.local>
References: <20230626164554.GGZJnAwnKoOTCbvKfn@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626164554.GGZJnAwnKoOTCbvKfn@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v6.5
X-PR-Tracked-Commit-Id: 9d9173e9ceb63660ccad80f41373fd7eb48ff4ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59035135b32280fd394ba5765c6f4de24f48353e
Message-Id: <168782004996.10634.11088056019227759553.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 22:54:09 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 18:45:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59035135b32280fd394ba5765c6f4de24f48353e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
