Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C006BFC3A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 20:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjCRTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 15:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCRTBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 15:01:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2FD2C658;
        Sat, 18 Mar 2023 12:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB12960ED4;
        Sat, 18 Mar 2023 19:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FB9BC4339B;
        Sat, 18 Mar 2023 19:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679166092;
        bh=rpUXHIoYzcFRRcktup4byFqch5cBBzVjw00yJa/cQLs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GHYWfP1OAsCFh6MDzRWf7C5nPQc2MZEVC/qgWrqLWh7FmhlsPFZkRVlhqv88gLhTC
         eJ/29pAQerjjwTS3iUFpAll+s0Q/4z5tgcrXedPIYkCUL6AeJw08RmQeift0JwgfUW
         3Sna6xEUxd0ErbXix71L4nRtGWE+55WenxQJnRb59l7H29U6xYWYvw7u0QhcYB7MTo
         lGdXcYh5RiIIzOe7F3nCpNzHbmRNsnzpSMYKvFJu/OAL6AEDKqfuCUe06WCR5E3RHV
         LlhjtXgBVYI+nBzDYAQV/4RfUeJmLZmfMYTDoYQzpYvKTXbl+Pb9uAtGAOz/+v2gmu
         zSfBBHymnyt6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33AECC41671;
        Sat, 18 Mar 2023 19:01:32 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNARH1PPARMD31mECPFs86j8o1MSDTrwahdavDm-C3Dg_sA@mail.gmail.com>
References: <CAK7LNARH1PPARMD31mECPFs86j8o1MSDTrwahdavDm-C3Dg_sA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNARH1PPARMD31mECPFs86j8o1MSDTrwahdavDm-C3Dg_sA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.3
X-PR-Tracked-Commit-Id: 05e96e96a315fa49faca4da2aedd1761a218b616
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 534293368afa1a953c283310b82e4dc58309d51e
Message-Id: <167916609220.11643.13417910317795723487.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Mar 2023 19:01:32 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Mar 2023 00:45:59 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/534293368afa1a953c283310b82e4dc58309d51e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
