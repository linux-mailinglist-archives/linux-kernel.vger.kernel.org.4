Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC08762FEB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiKRUVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiKRUVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:21:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EF54FFBD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:21:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E234DB82522
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 20:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98C65C433D7;
        Fri, 18 Nov 2022 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668802864;
        bh=51bHW0RNhhNMzp1lL0JeKKt2IkFYFWXOqrU5Eo9kG8E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ETy8WXEPX8b8Fhnsm9qcbsF2mW2qWUeW/F0UsNELxyjM18mlTZlwjSwZIbxcRt09o
         yH4/7p3I+qxdeZb/M0x8Qz3SrzKUeExdyq+QiXNBaNicwSzdm640P2DT+61W87S9qq
         VTx7tr8/43Nq9OZuwz1Di0BQu8Ou1Pbc3Zh9bWpo8qp3J6QY257Z84IciqC8wMQBaG
         +1ztVSzJ4RxbP3DlJ5kdQdvkdoUmIP6jyE6BFbXoaYBruyin5OU3Ndr2Eznh/R3POo
         /TnVqz7CCcna442hOm7ZlHEpt/Qyk555lLs8jLyx27c01NIZCMxFdJ1dCsBWlbGiqP
         2cpAS2pleVBxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8760EE29F43;
        Fri, 18 Nov 2022 20:21:04 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3dQKg/pGJZIYc3B@kroah.com>
References: <Y3dQKg/pGJZIYc3B@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y3dQKg/pGJZIYc3B@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.1-rc6
X-PR-Tracked-Commit-Id: 65946690ed8d972fdb91a74ee75ac0f0f0d68321
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f63d1a106e98db5cd378b21a471f7ddd710d1b5
Message-Id: <166880286454.9331.8719346479988456880.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Nov 2022 20:21:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Nov 2022 10:28:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f63d1a106e98db5cd378b21a471f7ddd710d1b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
