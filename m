Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658436F8A39
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjEEUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjEEUdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:33:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59EC4EC3
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F7956408A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 20:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76604C433EF;
        Fri,  5 May 2023 20:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683318797;
        bh=6k5hoZ6QAlQZeQ6ehIoKeqRN6ynIvBf62CokUZmZtFY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IBMsIt7wopuzBZhQYtUu7SHXlM4ejlrwsdPhJd9fnQB4Fwk/OJ/MmmUqZ63PRARIr
         BT4vQ2OI1kP41GN7Gt0fueRxEOgK3qC0aw80OE7miAdX5aubRJQy4Um5Z+vti9U8v/
         RrdNRNu10jdZ2jiXjuL06kw7Fif758RU4nvx+Tp84hZy3ed2d6/CJtUx1yfplWn4XZ
         FCYo6bSZTEHtul2hdRDyIIIWi48skFTIVahAhTTgMMt3kcq5dJDVNJlyR8zn0TYkEN
         kKCaWzVKkyn+2mwb2ZV0YIRkO20CMSRmpBFcH7n9sniSARJSi1/h3cmsOWjDnB+PBP
         hoqNVxPFKdPew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66169E5FFCE;
        Fri,  5 May 2023 20:33:17 +0000 (UTC)
Subject: Re: [GIT PULL, v2] locking changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZFS9x7CHvtGrmCE6@gmail.com>
References: <ZFS9x7CHvtGrmCE6@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZFS9x7CHvtGrmCE6@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-05-05
X-PR-Tracked-Commit-Id: ec570320b09f76d52819e60abdccf372658216b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b115d85a9584c98f9a7dec209d835462aa1adc09
Message-Id: <168331879741.21250.1795316664638060697.pr-tracker-bot@kernel.org>
Date:   Fri, 05 May 2023 20:33:17 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 May 2023 10:26:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-05-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b115d85a9584c98f9a7dec209d835462aa1adc09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
