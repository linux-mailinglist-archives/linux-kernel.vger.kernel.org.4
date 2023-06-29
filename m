Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA644742B59
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjF2RfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjF2Rem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:34:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA6835A6;
        Thu, 29 Jun 2023 10:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11EA5615CB;
        Thu, 29 Jun 2023 17:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77CC8C433C9;
        Thu, 29 Jun 2023 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688060080;
        bh=5VWh3fG5lbmMow2I5Zds4MSvhEzrHGNSK2fRSLf/fg4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ra3e4ERV1lJhM9vP/DRku2NgbGC7OI/xCVur1z67XwkSToyshFbMs6cO4jJRHGZe9
         O+IWwhzAdIGkLZh1sPvRSKMATt3DEPesR9wPgWRQz3ug6PYOxT0vXXfe51J/AcAGYk
         dmj1tYfrwpjwAhipBuLnyUPggtHa6ihxwlCd4n4Zj+Xc1S/xvk3zbTa9sYu+gE2RLr
         b6eYnRnolYZ3McvGO9KBthe5YJ/BusOObZo1Bkq2Xspq+Xhf18oimZSqg3AlTK8c0N
         usoxm1xtzAFcs0rl4SJYhhy72u4LwrAS2MsRS4TfiQtd1WmVI2J3Uj6nvxPnr2iL3q
         wiKhuu5J6RoOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6598FC43158;
        Thu, 29 Jun 2023 17:34:40 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627162730.117824-1-brgl@bgdev.pl>
References: <20230627162730.117824-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627162730.117824-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.5
X-PR-Tracked-Commit-Id: 0ff9f5e57c5bb45b6b807a4d466228de39d8cd2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5476f57b32621eb8eab892a908df4d0b4808835
Message-Id: <168806008040.7356.6983312532741788586.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 17:34:40 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 18:27:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5476f57b32621eb8eab892a908df4d0b4808835

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
