Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092A96A3400
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjBZUkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjBZUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:40:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ADEBDF2;
        Sun, 26 Feb 2023 12:40:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 880A1CE0E77;
        Sun, 26 Feb 2023 20:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27B74C433A0;
        Sun, 26 Feb 2023 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677444013;
        bh=OyVMp81xeB/ldb8DuIuDuHKY41ei+KCX4Kr55dfmqtI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RyTJjmNWOxxgRXpYSEyZZb8dpAUJvc0nKS7qgFtXKIFPCDqHiQjk8JzAHN5GF0ziW
         NJTIUq+v0zpwIrEHSHOGPQ7TecrXYYft2oKQ1wdvouVbuilqTZQGyLr64q/iAHjvzd
         9niM9/jQRt2e1PAbXEN4yeLcgquzmX7qQA13ETX8ztAHpG3KIxPTa71K01fdh6wrns
         8gYYRbIP729/6mxdQJqd1lKmqdDNfvLTIj9u+E1S340V361oh0/2IQPzp6QRsdz3b7
         zbOTgUxbaAIdn0aGqoStJCHDNCoZ0v/POzWFmeKHCYbtpOD5Pp585YxXEcifNpCI4d
         O/cROth2eK37w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15A2DC41676;
        Sun, 26 Feb 2023 20:40:13 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild updates for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATJ-3JQ0QQGQ5R+R8aBJEq-tmBL8iBZrbM_4t0zeoYTaw@mail.gmail.com>
References: <CAK7LNATJ-3JQ0QQGQ5R+R8aBJEq-tmBL8iBZrbM_4t0zeoYTaw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATJ-3JQ0QQGQ5R+R8aBJEq-tmBL8iBZrbM_4t0zeoYTaw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.3
X-PR-Tracked-Commit-Id: 7adf14d8aca1ea53bf9ccf8463809c82adb8c23a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 498a1cf902c31c3af398082d65cf150b33b367e6
Message-Id: <167744401308.16333.11342698520478538667.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Feb 2023 20:40:13 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Feb 2023 01:33:25 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/498a1cf902c31c3af398082d65cf150b33b367e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
