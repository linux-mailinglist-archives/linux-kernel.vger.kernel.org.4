Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3E66EE748
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjDYSBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjDYSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9362816188
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6481D63092
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA3CBC433A4;
        Tue, 25 Apr 2023 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682445652;
        bh=ojluKaOWHhBauR6dF5UwGN61X6rYTyQ6L+Rpajhk1v8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MZ0rBFyDNcIZiZ8q+Kd0hx4LHCMT9mySP75sHu34osCCQTHTtR+1pjAhbyRU0czsq
         CoRNs6a2bYEx8uCzAIhjssgJO6ns7flsCv+0R0fKMRdIMxrJFHrclIJMvmL6L3lVHn
         kcanqzmAqGexk+JM/dqgs45nMIuMbj+Gp0dG4lKfQAwdU/f2zXra7xQCV4sy2gLLfY
         pB/YFSrCkkglGCm21eZgvm7UrBDDVBG3zj8BUmpslH0mz5bc+wSszQ5SMnowliTpiV
         oCO+IJ3XZ1ZAdKTqKR34vNV+ISZ9EtCV+Tw6jIGPpp/4+qBzrV0fQZkELTFlMrFHua
         HF93losNpQnAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B83B9E5FFC5;
        Tue, 25 Apr 2023 18:00:52 +0000 (UTC)
Subject: Re: [GIT PULL] x86/misc updates for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424140029.GEZEaLfYPda4W38IHj@fat_crate.local>
References: <20230424140029.GEZEaLfYPda4W38IHj@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424140029.GEZEaLfYPda4W38IHj@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.4_rc1
X-PR-Tracked-Commit-Id: 5910f06503aae3cc4890e562683abc3e38857ff9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a4a28fca6966ff2aee7d8313db6defcc8fcf70b
Message-Id: <168244565275.10431.6421245993721415607.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 18:00:52 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 16:00:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.4_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a4a28fca6966ff2aee7d8313db6defcc8fcf70b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
