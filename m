Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10969740674
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjF0W1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjF0W04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518F1FF0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D205461251
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 22:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46026C433CA;
        Tue, 27 Jun 2023 22:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687904804;
        bh=wrsYJGw0cogarQdBXpZUFa2gq9A3+EGeqgwtyFlgyJM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AWLBdadUnPa6g+FD8tQLWTfwk8l50lR2eGB44SmgHkaBJahdd6+PzaM7yJk1UKYpJ
         MohXFvCqJ3WzHHbCeWhrV2jvj92BoTiN/tvTUDX2i6tOwjNK1m9O2IPyeOSmGRiRTP
         WUuve9bUFcA4WP7w2XLGrsuJ3vx1qbypX9w+PMEEaFdTPj6V5dgzqfiSN40kls2fmt
         jXDKAlb8StOsHDJvQ9Z2npamNgBlXRAm145lv7fa5jie1GYXzzerKMgYXPC/31/YGM
         qd90Bl5i9RTtRnEJaMvOv5pSD2BaeSeKWA/DJu3QwPQ6zsEtfoW78qenmSD9rpsDZH
         VERHymOJUxPdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F0BBE5380A;
        Tue, 27 Jun 2023 22:26:44 +0000 (UTC)
Subject: Re: [GIT PULL] objtool changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJrGGfFl4MHEeftI@gmail.com>
References: <ZJrGGfFl4MHEeftI@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJrGGfFl4MHEeftI@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-06-27
X-PR-Tracked-Commit-Id: 301cf77e21317b3465c5e2bb0188df24bbf1c2e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f612579be9d0ff527ca2e517e10bfaf08cc1860
Message-Id: <168790480418.30460.14567224921686246298.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 22:26:44 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 13:20:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-06-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f612579be9d0ff527ca2e517e10bfaf08cc1860

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
