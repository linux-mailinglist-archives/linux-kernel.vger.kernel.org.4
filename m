Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F882701E2F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbjENPze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENPzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:55:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E782699
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 08:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42B1761001
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 15:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A382BC433D2;
        Sun, 14 May 2023 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684079730;
        bh=yHDK0uLs9K/u1QrWAutHlng12B9gkVTRteQOCbAHcxo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NDz5D+m1Xa7f7m9Lk7lXelVcMoi1jUv0RtN5miz6nKYJVaegFmNETi366ycj60J+Z
         28RiC6uhv/om48bbxo9wJ+tU5DfyhK2/XEHF+YIxZHae+pKTUXPsd8Np4tbYGmqPBT
         KwQNfsE0HDPgKhJt1IN2YPZ8II/fFA1ZEvKNcPVnycrYtp2kl7CZ395JXsKO640YJD
         dR0GhmOyPNG3ESLqvCmAnyvIBVGZNHFcn4nijR4qMvPSSHr4UD70vgziBGLJ3a4Gqf
         KdQWeAO8TMJoN8b3kdv72LDy8Fhr3HdMQf3dkeHzkBUMGIctO4tZhbBjUenPwcERTS
         GOvpTsppK050Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 921B0E26D2A;
        Sun, 14 May 2023 15:55:30 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230514112728.GAZGDFoGTLmNPf7gW2@fat_crate.local>
References: <20230514112728.GAZGDFoGTLmNPf7gW2@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230514112728.GAZGDFoGTLmNPf7gW2@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.4_rc2
X-PR-Tracked-Commit-Id: f9d36cf445ffff0b913ba187a3eff78028f9b1fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 491459b5ec3751a3a58129db4fb9f832e474bb95
Message-Id: <168407973059.9046.465046278701076189.pr-tracker-bot@kernel.org>
Date:   Sun, 14 May 2023 15:55:30 +0000
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

The pull request you sent on Sun, 14 May 2023 13:27:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.4_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/491459b5ec3751a3a58129db4fb9f832e474bb95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
