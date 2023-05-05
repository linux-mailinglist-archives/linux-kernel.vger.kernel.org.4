Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF036F8953
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjEETMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjEETML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:12:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F80226A6
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E4EE64004
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC288C433A1;
        Fri,  5 May 2023 19:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683313929;
        bh=K2Ty1cviSoGvbkucTdrELbYb+vY3LPDc6EGHXt7pVPw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EwJNh160qrpd5gTjYTWRtrAd1BvEOh9eHIoaCcPH2boaWBAM0ZBfXoYaNUWcBOtpe
         MBf4YWeACB0YH/yjQmXPUXqCcMnRBmfNYdzxt2Wb2LPlNlroFB7pZagqIf8BnojS6/
         Na72UCOOhxnJCqVTtNh1lG2CjnIruc6+9Nf/jDQ4r0dyt9y0L4X8HAxNjHaHPcxaVl
         y6eM9XmLl+TJswbR6fFI/Tfzo7zxH9/2S1vqlapnWKEoI8teIlXZV+DgGGNY5Ne5Wg
         5G8LCSBjHxj4qtMjJneaRMk/gp6Fa8XO+iu7Mln86w4Zl/joZ2eNT3ajY2/kWwKkVv
         MJQ6u5wEwi8Zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92369C395C8;
        Fri,  5 May 2023 19:12:09 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZFUELDT/xaxm0lmP@matsya>
References: <ZFUELDT/xaxm0lmP@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZFUELDT/xaxm0lmP@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.4-1
X-PR-Tracked-Commit-Id: 9d9ff3d2a4a567b543b71c2967d2ccc5e0ac6816
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b49178e68fc7e3333c3d9f96eb09937ca84d05fd
Message-Id: <168331392959.10509.18400093203969359314.pr-tracker-bot@kernel.org>
Date:   Fri, 05 May 2023 19:12:09 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 May 2023 18:57:08 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b49178e68fc7e3333c3d9f96eb09937ca84d05fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
