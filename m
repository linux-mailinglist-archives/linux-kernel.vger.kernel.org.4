Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E975FA2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiJJRWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJJRWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:22:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EE9419B8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6943060FCE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAD9BC43470;
        Mon, 10 Oct 2022 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665422526;
        bh=ZpA/1sda8uweMUuB4aaGlxHVPhQo2N5XfntJkwSutRM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aYHctYqJMtS3nPSDmT3q/Ss+VuQXewfD+fX2zoKJF3Ngc0UTRBs1CxBay8wErTz9d
         dFd9YF/YZ2+BWQCpuQ4VoC4W+blQteAFohft2ytCRPy5C+ebw4ZlYxkPKEzOCkFQpU
         7DV9X0nxRI4+OuBtuUzevFKOMGwnfthenN9JWsEOOvpAhUZaxfPOli9pHvRqdwUW5K
         yd5Bilg+rFtv9hrvGTU27/TiYjn/Iiy/LWEJs79x7/c+UqNwJSENeAI96SPmfbo3O1
         qOP9qrAZmcKKhfKXUr87HNZP5vFHi+5uCIfxt+v3C/rzFpoN4YzieUleJvtbCC0f6y
         uVqwRVjRZkKoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF343E4D022;
        Mon, 10 Oct 2022 17:22:06 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <166497241295.125841.14779016172298611700.tglx@xen13.tec.linutronix.de>
References: <166497241171.125841.9535880258521894817.tglx@xen13.tec.linutronix.de> <166497241295.125841.14779016172298611700.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <166497241295.125841.14779016172298611700.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-10-05
X-PR-Tracked-Commit-Id: 6cb5ce13357de06d376d300778eee2009f53d8cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55be6084c8e0e0ada9278c2ab60b7a584378efda
Message-Id: <166542252671.13651.2277590085181689398.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 17:22:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  5 Oct 2022 14:21:23 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-10-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55be6084c8e0e0ada9278c2ab60b7a584378efda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
