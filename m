Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF9674C6DC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjGIRqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGIRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B599C114
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 10:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4896860C16
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 17:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E2F8C433C9;
        Sun,  9 Jul 2023 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688924794;
        bh=n6zAOY5fKphoCSxuZQAKMd07ui7N0Oe/uWhfSRSAVcs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I+tW7McqnUg60peO9YYi7zbPc+iN4T4SWWgyRBupB4M8PVfnxL9J9SvJO8l/yOcd+
         i1Wh1iMcDi2GT1G4tXk/mnC/kpM4WF4/9nGoBP+0wovjecWhA9VxtZLF2Q9fC7txwy
         M9BcuYYq3qN1RAnTTSdH4dlYyIzVAVVt/GhaR8ej8t7EXeXuw6Y3LPtheE1s0PusR9
         MRPomdBgIi/JzHudbaXVYg/qXfsr47/knhSbLSEaiFy5rqLdxYJMukzDKGUBPwtVBN
         tFngeMYop8cJYhR81p9D3JJ3aIjVCCSDHx+t7yxNbtdSGbuMeRCtistasuCHA8tZLC
         btd4jjrWxWAXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BDF9E537FC;
        Sun,  9 Jul 2023 17:46:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230709080838.GAZKprBjZs9TAzdAHk@fat_crate.local>
References: <20230709080838.GAZKprBjZs9TAzdAHk@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230709080838.GAZKprBjZs9TAzdAHk@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.5_rc1
X-PR-Tracked-Commit-Id: fe3e0a13e597c1c8617814bf9b42ab732db5c26e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51e3d7c27446c3af97e8a467ecc99bc2936d885c
Message-Id: <168892479456.9789.485394833371958714.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Jul 2023 17:46:34 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Jul 2023 10:08:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.5_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51e3d7c27446c3af97e8a467ecc99bc2936d885c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
