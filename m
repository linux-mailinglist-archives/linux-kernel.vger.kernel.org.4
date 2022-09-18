Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFFB5BBFEE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 22:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIRUro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 16:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIRUrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 16:47:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E71C13F2C;
        Sun, 18 Sep 2022 13:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0231CB810AC;
        Sun, 18 Sep 2022 20:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B49C4C433C1;
        Sun, 18 Sep 2022 20:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663534056;
        bh=6VVtHlGlyLfaxu+c9EvjzcA76bmUCg9JJY6joWZGfhw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qeMz/3P7ozkLYf02OOmrE7xUm2/s0wsWRSwwI2pcUE6XsGkDOFnfgTtpBI+gOUQCf
         X02nnNnwXbAJOnyIwiEAcYYN5gsZLshKsSxly7CDjPz5HdSNHVWvOpTc26p7AOMZCn
         e1Xi92l4Wr9rcqGkrak1MhYVjNTykOHXUwLE0VDQ3qUMfPYhlBPmhQroFlANuedJDB
         OcrJXQPAq+40986ASpGaFYhWMMOH+s+BM1dcP1l1SFxb6PXMkrkZI2l8Jpt/oKx8AM
         iXPOUtN727PEJUXsQowLNalauZHjE9CEOOc68DWVfWptgL7NWjSUgIbgtGLQkweZne
         JprVqID8g1eHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91163C73FEF;
        Sun, 18 Sep 2022 20:47:36 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes for v6.0-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yydd4mNkcfXRDK4b@p100>
References: <Yydd4mNkcfXRDK4b@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yydd4mNkcfXRDK4b@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.0-3
X-PR-Tracked-Commit-Id: 805ce8614958c925877ba6b6dc26cdf9f8800474
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c18b453ef7237bc25b7cbd425a05ac1b6fb074b
Message-Id: <166353405654.9559.709229147154883077.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Sep 2022 20:47:36 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Sep 2022 20:05:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.0-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c18b453ef7237bc25b7cbd425a05ac1b6fb074b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
