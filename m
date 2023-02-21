Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28CA69D927
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjBUDHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjBUDH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:07:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F290233F8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:07:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BCC660F7D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA1C7C433AA;
        Tue, 21 Feb 2023 03:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676948845;
        bh=njA0uyoN8eWdLLdypYT9MpAhlarRiuz4OF/SJ7OL6xc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mcJFzurCu11y5uyVW6b4NcF0QdIwzXqKnDc82pPEvjkT1FKNbwPFrU7I34jSbgqAq
         3yk7BPFHs13bXBKsJgj2RKi8NhYMGg87CqCt4MK/cbcfgZ6xNJ4PlOfELls5hHVIkn
         XNR42fZZ7JexZeVNg9q7Sc6t0Q7pp2RNJizb5oyjbPTYTiWfMdHbFNXmMimjorU2N2
         DCvos90ycJqwTtB01o5k2D469cXo/JpxDh8cPDu6kQmWieFKa6UEo9u1OGANw6SN4W
         n8qEA1gCTeYAjvoR6b/bJaEbwd7JRWFuOFdaWBg6BnVuxdyww+zFtC/TOWCR4tNFHX
         6Fj5kuesGrAQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C46E7E68D20;
        Tue, 21 Feb 2023 03:07:25 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/N1q8vlYJMyrwSr@gmail.com>
References: <Y/N1q8vlYJMyrwSr@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/N1q8vlYJMyrwSr@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2023-02-20
X-PR-Tracked-Commit-Id: 7ddf0050a21fdcc025c3cb1055fe3db60df1cd97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89f5349e0673322857bd432fa23113af56673739
Message-Id: <167694884579.12895.14654556942570886256.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 03:07:25 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
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

The pull request you sent on Mon, 20 Feb 2023 14:29:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89f5349e0673322857bd432fa23113af56673739

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
