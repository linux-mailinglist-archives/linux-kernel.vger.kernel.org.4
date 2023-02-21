Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8369D929
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjBUDHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjBUDH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:07:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53057233F8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:07:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06E6AB80E7F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA5EDC4339B;
        Tue, 21 Feb 2023 03:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676948844;
        bh=JnmHIdEK3QmBWaGDUDPUlj2CX8WpT0zB5dSuGY5u0lM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eaY1szbat056YVEkspysFbgab5WcFLhgdqUyfIiPpH5Fn2QTpjPawNAejbi9c+Pdm
         YEgYstBbg4OukI59noY3nviDuQv1pP2qwc0AytxxNCEjwNXa/4CSlmQ+Fq8S6lizdv
         MDNY6bKIzQwOkj2gbQiWhGuHBnfQEY3n8RfW5FrqTrwV6SC3vwwzm+F1edCWmhRCmc
         rR6RPZU8GEjsENCbSnfMw2e12H8307jPy/iN0ZneLOF997hjAE9jypEIw4RYX+cptE
         DZl8phTcbZYElTyObrcYemTrgVPSaV14zhvSzCEfHXKrdgYoY3DNl2q/k0Vy9l2X7B
         xuPW/unhbImXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6865E68D22;
        Tue, 21 Feb 2023 03:07:24 +0000 (UTC)
Subject: Re: [GIT PULL] x86/boot changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/NxQfkj3P7DOBWl@gmail.com>
References: <Y/NxQfkj3P7DOBWl@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/NxQfkj3P7DOBWl@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2023-02-20
X-PR-Tracked-Commit-Id: e2869bd7af608c343988429ceb1c2fe99644a01f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35011c67c8b7ff96c4e2dd892099ba643f9ae11e
Message-Id: <167694884467.12895.8790693408234134965.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 03:07:24 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 14:10:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35011c67c8b7ff96c4e2dd892099ba643f9ae11e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
