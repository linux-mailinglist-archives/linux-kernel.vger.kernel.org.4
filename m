Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEC573AE21
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 03:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjFWBDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 21:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjFWBDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 21:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240BD1728;
        Thu, 22 Jun 2023 18:03:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 889FD61919;
        Fri, 23 Jun 2023 01:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E92F1C433C8;
        Fri, 23 Jun 2023 01:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687482210;
        bh=eBbboiYQGsBbAqMGQtM00YWrB6NuLA8rSZ0kHuTQ2A0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FqE5lKYz4s1S5CpoJvTU0XYFZi2Lsd9E1Unhlk2IINIJ3bSK95+oyaOnyankuMDoZ
         1uwrwYJ6uAuQ1LC0YUyV3PiDFWDEQ5KLrqk+kaUcv9w9s/yhjxZHstI1jOP7uj9wBb
         nddOUELNPZmXe0Wshc/qq+KJtOWJiCE4TCoJ/Pc/yyAsQ1Ev6CjyWyKQDKC7ijlIG6
         8eA7KpOYb4Egv9WKbpyAeI1kE/L8BNr/LHbTOV9PLRHzoCPMvW0VdywERywqdbHwu0
         xKnEZtJTQQBNJLo127DsQb71BM5LmUZizz/nlgk1fU/pEKzpJHZqA07l1uZMic0XZI
         UVvUT1FT2Mi4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8C5AC395F1;
        Fri, 23 Jun 2023 01:03:30 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.4-5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <075d2f89-aa61-ce14-edb1-f56cfcc90bcf@redhat.com>
References: <075d2f89-aa61-ce14-edb1-f56cfcc90bcf@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <075d2f89-aa61-ce14-edb1-f56cfcc90bcf@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.4-5
X-PR-Tracked-Commit-Id: 146b6f6855e7656e8329910606595220c761daac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65d48989f81b976b43c8b42c050f157900f61321
Message-Id: <168748221087.12146.2357638061508768828.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jun 2023 01:03:30 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Jun 2023 10:25:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.4-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65d48989f81b976b43c8b42c050f157900f61321

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
