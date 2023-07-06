Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAE77494C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 06:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjGFExI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 00:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjGFExA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 00:53:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4006E1FC1;
        Wed,  5 Jul 2023 21:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 195EB6186B;
        Thu,  6 Jul 2023 04:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CBC9C433C7;
        Thu,  6 Jul 2023 04:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688619166;
        bh=dIsGAuHx954cFHsQ4G0f7/ooHrMWRtBzRQ/SOqggOqI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qH5zMJexna9PoWMUqUieeu/t+6LCl9uhJLLPP2z13RM88C9AQQoIEcHSUjkzbvvOc
         q7S5/UzCfJmTYtp4SUk0sORxQZZhLbFKhBhAlrhN2GYKnfOywTstjTHj7lmYqCiaPG
         frJ7j2LIvBwaO7NBo3c/fPU07M5h1d08RYYLRvQDoaSwWTb4SwWRtVRSTUBy9mr2Q3
         b81DZu8jZW1HlrR/tW52utDNkjJ3Vql0Ul5AIZ/WuaVqyIsm2HOa8hguinMr44F/CH
         k+EhLPGz0+LSXGx0K/ProH622Gz+36DIELZTIL7ftrIjcMb/my8R+pfsRHzT6pNS81
         ad5Eo2tarKbxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59AB6C39563;
        Thu,  6 Jul 2023 04:52:46 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
References: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.5-tag1
X-PR-Tracked-Commit-Id: 7497840d462c8f54c4888c22ab3726a8cde4b9a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c17414a273b81fe4e34e11d69fc30cc8b1431614
Message-Id: <168861916635.502.5176483865900778985.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Jul 2023 04:52:46 +0000
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 05 Jul 2023 23:43:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.5-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c17414a273b81fe4e34e11d69fc30cc8b1431614

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
