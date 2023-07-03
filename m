Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F221574618B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGCRtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjGCRtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:49:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B7AEE;
        Mon,  3 Jul 2023 10:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00BA060FF1;
        Mon,  3 Jul 2023 17:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67DF1C433C9;
        Mon,  3 Jul 2023 17:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688406538;
        bh=TpAL36SkUISE+ZqdTaKCssPkkMR6cjFHLgVGIFwDRbM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t3lcbkD5tsr/8EYgcmwgoqyjaYen7bBTUQ5DNmJWjwPk7hm/8DJAq3LHHUMfTw1go
         UK7uTyGbVCmxIoMgVJ4kHH9MXZtCXGttqCElsBlcIvTCqo9xGT86JFCdM36yLHDtIG
         LVpk39jCYMxIfQnQUk8qq9WDq1Kjspe4Y4gxZEnRZYoZezZfPvNXvn5s5cQYCiYM+4
         Y+nhBzvUaLP9TVg9LLkw6jaHftZ3t6MthJ8RnlA6ucqtLTYDEP6608UnOib8wQf971
         GIjlaxJ51BuFoECCWh9WQMBLIe4NMtd7myJSaMym/L1cu4laRFctzg5NtnQ5rvxQR/
         pxbMTv5DNbJ4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54372C64457;
        Mon,  3 Jul 2023 17:48:58 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230702221655f454af0a@mail.local>
References: <20230702221655f454af0a@mail.local>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230702221655f454af0a@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.5
X-PR-Tracked-Commit-Id: 1b733a9ebc3d8011ca66ec6ff17f55a440358794
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b349de4c91e6ad761c2beecc796615bcb64b36e6
Message-Id: <168840653833.7534.14540479065532044540.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jul 2023 17:48:58 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jul 2023 00:16:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b349de4c91e6ad761c2beecc796615bcb64b36e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
