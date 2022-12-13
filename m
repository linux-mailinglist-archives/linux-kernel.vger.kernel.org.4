Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516F564AC86
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbiLMAgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiLMAg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:36:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A1816484
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:36:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2C32B8103F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6654BC433F0;
        Tue, 13 Dec 2022 00:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670891784;
        bh=SK9LPt8fylmP3Fq5kMqTX8yomzFyHcS65tEphfDuHT8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bDh0FZsiFQkEGd7k/d63mw4oMKowVCBti1Wm+sA2/vG1w7hrJe8NMne3Zqmr+FXb0
         oHFNd+OkhPFcnMsOssc2JMQO0Km8NhJFR0vB05oN6lG0+ZVxtHr9M+lqW/pEmmYy78
         bv0OVx+fjF4HINZe0Oq1LrPeK9uc2lGvCEYv1aj2SMFUjYbHnYDbuxZNoNQK+7miwT
         89uD6XrRGYfNPeYuxsd2ieuJf/q4T/pEot9mWHWeOLHmaiXSLOIpM/yazcZi9yppNr
         JUkHeZ5tEn9WofyBTe6CnkeFNV/hw6NQDjNFSrkWl7/60dXz06XDs2KoCyBseup210
         bRjjqVcwhvj6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 544F6C00445;
        Tue, 13 Dec 2022 00:36:24 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221210194708.675884-1-Jason@zx2c4.com>
References: <20221210194708.675884-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221210194708.675884-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.2-rc1-for-linus
X-PR-Tracked-Commit-Id: 3e6743e28b9b43d37ced234bdf8e19955d0216f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 268325bda5299836a6ad4c3952474a2be125da5f
Message-Id: <167089178434.4798.2566419967907558014.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 00:36:24 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Dec 2022 20:47:08 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.2-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/268325bda5299836a6ad4c3952474a2be125da5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
