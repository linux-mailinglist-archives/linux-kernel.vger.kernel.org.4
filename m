Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15AB669949
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbjAMOCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241494AbjAMOBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:01:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF7B65E2;
        Fri, 13 Jan 2023 05:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B469261DDD;
        Fri, 13 Jan 2023 13:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21CE7C433F0;
        Fri, 13 Jan 2023 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673618306;
        bh=wfXLAE4VrRnkrhC7o4++LRsw+u0kwKUWybn0kDdhI/E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WYNJEfNtTHbAG1xqFq09ckCALMj0/JMI7SIridG7qfqDPuUyVesu0qrdadx8ZUQ7/
         X6J76DQtZn3M38VVazKaR+EIkWnbWr8jsSKG/1o3+E/k9hR/xpVDkTVPRiEyOL5c2e
         L2JhEyujPbDoDpw60JFnaD9Ox4i3bRdpuRmIYnpyW2QXXMPwBS97goBBDc8LsJ4Hpz
         s73eH8fgKeMBiLL9w3CmG+4aKCrCO72h6BH4ySZqGLEMGP8Js/E4BnPpLKG7dbyZET
         EC/AzgJIJx6YgkhCdckmDs69GBU8GA+JKe6xpUIFRhbm/d5gdJKN82Tl6bdWksiIoZ
         wRKoneZs/63PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BC94C395CA;
        Fri, 13 Jan 2023 13:58:26 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j117rbXsLW5P7hGm4=YL-KM1uY7E-B3kmkt_gRaEicXQ@mail.gmail.com>
References: <CAJZ5v0j117rbXsLW5P7hGm4=YL-KM1uY7E-B3kmkt_gRaEicXQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j117rbXsLW5P7hGm4=YL-KM1uY7E-B3kmkt_gRaEicXQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.2-rc4
X-PR-Tracked-Commit-Id: 4f3085f87b51a551a0647f218d4f324796ecb703
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d863f0539b525ba714f85c15ea961b225a15dd21
Message-Id: <167361830604.16011.8393664437329275400.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Jan 2023 13:58:26 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Jan 2023 12:07:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d863f0539b525ba714f85c15ea961b225a15dd21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
