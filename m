Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BEA740675
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjF0W1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjF0W04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAC61FFE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0209160FD9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 22:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 630B5C433CD;
        Tue, 27 Jun 2023 22:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687904804;
        bh=SwZ+4It8uIzeSJH2cokYsshj7A5gcFS0uDm41W9Slp4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XOKIaUgUloRWAqs3Xr+j3XoHApi/CfcLwKslL0VnjVk+albKlCkAgLF2XdZjPGNTs
         jM+S7qyC9tnTHs8mYCtV97sj0r8Yy3bgV1QAXJOV95PPM9C9H2yWIRgKvEPX4pn2uZ
         97DjetxeH6SXrZmVEk3Niqm9UL1uc+BHDxMNtbEGzO2xka/dNNKZlCcCteWkVde265
         bZt/5HNRBmqGvioiijglP55fBBB8IlUXdaKFmPMcKvTmwGl5z1CAigvqJpX1qOu4Yd
         sWJKQoa38XT8fBz3GGCGUwJcIJMxuKbCipumaFUMMZCobhqH/UBaiE6SjwAVsc+ZpG
         pztlyIXXU9qow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DBD3C0C40E;
        Tue, 27 Jun 2023 22:26:44 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJrKy3TzC2b/R5X1@gmail.com>
References: <ZJrKy3TzC2b/R5X1@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJrKy3TzC2b/R5X1@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2023-06-27
X-PR-Tracked-Commit-Id: 78841cd185aa74bc92d3ac2c63a870395caaa086
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d6751815b1d3057423b3feb156bd1525b7183e2
Message-Id: <168790480430.30460.5736554514470715758.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 22:26:44 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 13:40:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2023-06-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d6751815b1d3057423b3feb156bd1525b7183e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
