Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA5D740673
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjF0W1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjF0W04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83321270C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE1856124B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 22:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A92EC433C0;
        Tue, 27 Jun 2023 22:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687904804;
        bh=hlzSemsgcNyl732oHw7jjk0wZ7npoo5udVom296OSRs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WzxUhsx0KW70Ul+KNrSrN4/iO6FzQXzTXWPkWbr72w5LONxa5rmgjt+rfmlENcjnK
         +9djmkARUJ3PAC33/KmZtX+W3BLJE0yB3ZUQfTaNpw4urWfsdgAKsN12gBXxLsDiJ4
         RKOK+IRrv9F9BaHG6A2uJe+lqUzRkwGmWL+eyB/Y3bOSB22TLmNGgbs+iIj2jQWR7o
         QjKnYUo4+UA1NvhZFWAKNYJj6D4muHmLxs6iNejftZDWqVSSCopJqAe22IEfmu3A7k
         1olQvj7DYRsijwT+dsXYpShovEgZ5dpFmNFMyQFe6PF/wr2UvoPTlqxkVY/6Csw+n5
         Okc+rpu4g0b2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 001F9C0C40E;
        Tue, 27 Jun 2023 22:26:44 +0000 (UTC)
Subject: Re: [GIT PULL] Locking changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJrAI6cgvy/tZSj2@gmail.com>
References: <ZJrAI6cgvy/tZSj2@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJrAI6cgvy/tZSj2@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-06-27
X-PR-Tracked-Commit-Id: b33eb50a92b0a298fa8a6ac350e741c3ec100f6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc6cb4d5bc3a44197de30784eae71d8ba28483eb
Message-Id: <168790480399.30460.9322329327475345624.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 22:26:43 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 12:55:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-06-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc6cb4d5bc3a44197de30784eae71d8ba28483eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
