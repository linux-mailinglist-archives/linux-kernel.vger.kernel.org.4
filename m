Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA35669D926
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjBUDHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjBUDH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:07:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E3233F9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:07:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7933360F82
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4241C4339C;
        Tue, 21 Feb 2023 03:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676948844;
        bh=+LA7eUX5Rzj0F3/ERlw8sH6lY8+0vLzbH72gNA7Hgz4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a/xsvCjZOFA/UGJskTQaBzCqqKO9T3j7SheaxvK/NGAM+/q4fsKWdxydYFrxUaNa6
         9B600lY1x57egBLXpRjSJ4nPZ8YYl+jy4DD/AtjgEj14LbBpSUJvXJeRkO0859FxSb
         E8KX1y1DWcqlZynitO5C41U4P4zeXqw3wvgYcO8MS6GWQ6hQRb71r2y1I8/rpxVhMz
         gPZ8u42LZslMsWqQdQoshzVwKKFIDI0DzwxAOj1WpgkUBCpCps329nNxFp6hum5gRf
         P47i7EgFNH2iZi9nPqxXh76juJzgcv5GUuSkAGRiW3hGK8SIBsxRqu/rch11Ytl/tb
         zA0ihftTZDVcw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA425E68D20;
        Tue, 21 Feb 2023 03:07:24 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build change for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/NyOgU2AU5paKua@gmail.com>
References: <Y/NyOgU2AU5paKua@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/NyOgU2AU5paKua@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2023-02-20
X-PR-Tracked-Commit-Id: f9bb7f6a7eb0efd282f7364115f97e652677a29b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 572640f0c0d6c681104880090dc0560b69c9d0e6
Message-Id: <167694884475.12895.1687170191812388445.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 03:07:24 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 14:14:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/572640f0c0d6c681104880090dc0560b69c9d0e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
