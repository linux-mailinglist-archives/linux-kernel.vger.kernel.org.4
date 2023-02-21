Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8479A69D92C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjBUDHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjBUDH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:07:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229EF23DA5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:07:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5549B80E83
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 811F7C433A7;
        Tue, 21 Feb 2023 03:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676948845;
        bh=gscxx3WpM+z/UUcQrKahtdJCfKwM4LdixVnW7cBUFMI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Fa6xurmlQe5ZYfIQ7BpNrWY4qcrATY5EXnPpQLsFRis+9xy8TDAhuTmDn5MHseBEh
         Vxh2o4l+W6SwEttVudeObZtmOExnRGjjJBQbnbMuc/7JFTWGXC5i54T/z9T29LDgSH
         Xcm7Hi/hoIcBDCrsc7Vf6yn4ZGFxg/TfWesVxCVO1XvFh+Xok3dis/Anp2FOZ4NfGL
         vESszYxVV4982pkzrK/jJovq1y2ZuPH+VxvNFlTPMzMnfyut/wTU/s8V5QztB8tg3F
         Jc+9VLD7isZrGpjPG4S/nEopFLMTa6ExV9PZp6A62k2pB0Ygys6rg7rD+nZlBPRtee
         SzymA4QmzlfhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E45CE68D22;
        Tue, 21 Feb 2023 03:07:25 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm change for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/N07fFHFlotQJEg@gmail.com>
References: <Y/N07fFHFlotQJEg@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/N07fFHFlotQJEg@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2023-02-20
X-PR-Tracked-Commit-Id: ebd3ad60a688131de7df1dd05fd2d7c57f542268
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 238b05ec999a036872af52d23007a7fc5a2df74e
Message-Id: <167694884544.12895.2075753893151483294.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 03:07:25 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 14:26:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/238b05ec999a036872af52d23007a7fc5a2df74e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
