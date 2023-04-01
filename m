Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B276D32A1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 18:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDAQnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 12:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjDAQnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 12:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EAC1BC0;
        Sat,  1 Apr 2023 09:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7480260C42;
        Sat,  1 Apr 2023 16:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7BF0C433D2;
        Sat,  1 Apr 2023 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680367378;
        bh=LxZT3zyIU4s7v16zyGcdGAb65RaFUGFSbbruqQ5g2No=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JzpL+rqSpKMH3+jdQF/UIEdhQtu5ZCnmzuCOVhgONpfwuSHHpYl2yfGbvfXeDnONT
         vxMO9OH9rZCI5Oqh6Wm2BuQm9oQOH3FIFxy5MAfJpIz5SgnAK5HaGoXPif26ASZJSi
         MJw1414p1g1C4t9oaI7PmEq/SylVGsv6uYigYoLv66jtFYKLGCKpoWj3hYwV5W5b/F
         h+eC92P860Z7Gl2NFoWhAtHlAhIx3fjOnTh4cYwy0cBVS+wYfLT1MbMWEY6LN6Wajp
         9kSD1DE9Yog7+9Mp3NETfwU6SQ6WXbTyzU2b1KpbHUbdbQcqxLU82VilCSVji0ZEyl
         POLjntKWhcmZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3F85C395C3;
        Sat,  1 Apr 2023 16:42:58 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAQEKgqrJNeknymSTsiRBbjoJJjWQ8VJ7ViC2-9Z0Mgpyw@mail.gmail.com>
References: <CAK7LNAQEKgqrJNeknymSTsiRBbjoJJjWQ8VJ7ViC2-9Z0Mgpyw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kbuild.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAQEKgqrJNeknymSTsiRBbjoJJjWQ8VJ7ViC2-9Z0Mgpyw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.3-2
X-PR-Tracked-Commit-Id: fb27e70f6e408dee5d22b083e7a38a59e6118253
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce0c2375ff56781ee26d9ad6b4cb40d85e0a9ebd
Message-Id: <168036737872.24776.10376057964930480935.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Apr 2023 16:42:58 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Apr 2023 23:42:33 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce0c2375ff56781ee26d9ad6b4cb40d85e0a9ebd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
