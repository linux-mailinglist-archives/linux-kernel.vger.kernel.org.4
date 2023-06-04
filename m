Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85927218B2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjFDQ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 12:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFDQ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 12:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C4CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 09:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A641601DA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 16:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96CCAC433D2;
        Sun,  4 Jun 2023 16:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685897782;
        bh=8fabvclXv2+etOPbw4TAvmu0aWCXCk6iwMnUzoHWoHU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XXOrPEB5j/usWtBC4TFil3vObt8lMQyqDkeUvvTQWLObnRIeU1EkysCiseZkZjqfa
         3MWLNt4VE5CoB2ZwkIRqdjmOS08DYxT3zC+x7rwuFBeWmKrYlCmm2JabST8ViH7lgT
         KjdNU+LOT+q+8w8ghK0iBQQKxr5Wfsww8rxgXeXZFRrGET1woxFihcfd6ESfEubruP
         COzAAami8c5m+jUZWuplk4hGxdal99Y3iyTyU0Z1qqIosmuKQxzaHhC7jRBkXYvAlv
         2Ilh31nRxY2T9kXyCif3JU8MUtuZRd/+4EEyH57ofUoRtwBNg/vcOcEHBaYZaC2Hip
         UN6QVmSKhjINA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6853AE52C02;
        Sun,  4 Jun 2023 16:56:22 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.4-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230604152943.GAZHyt59c0xJh2YtBq@fat_crate.local>
References: <20230604152943.GAZHyt59c0xJh2YtBq@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230604152943.GAZHyt59c0xJh2YtBq@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.4_rc5
X-PR-Tracked-Commit-Id: 2d5b205dfa32b5f0f357ebc9db73931d2186391e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f64a5ebe1dc64add6e1d8ed3113200909988c02
Message-Id: <168589778192.11615.14589723568245024587.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jun 2023 16:56:21 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 4 Jun 2023 17:29:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.4_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f64a5ebe1dc64add6e1d8ed3113200909988c02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
