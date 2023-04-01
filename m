Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1116D340A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 23:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjDAVQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 17:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjDAVQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 17:16:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5B32659D;
        Sat,  1 Apr 2023 14:16:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 015F4B80D8A;
        Sat,  1 Apr 2023 21:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B78DEC433D2;
        Sat,  1 Apr 2023 21:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680383762;
        bh=ha59/LxlcV/4Y+g6hdPUMKrbWnpJegeUpZ/o2xbAsno=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uUnhXegkgSFvJkjgZLikGxV2mLSUmvf/OLBTVr+QkfAPJqt8VxUK72bqc2htRUy9q
         Xa1BkfEGgwgRpgckdEZiSC+SLA7AgQkAYc0zmH9F1OWjtn7Pbvuo+TeETCyzFoIHzu
         mfbDEiFsKekAbQ2zrjQMqUgYsfcTtiyd+NhoCzpqT7KcShNsrxjskletzQuNVz6sqn
         t6ztFlhF0O2PnVLOuZbF1VcQVZYUqonvM+m2h77LyzfSGNv0r8O/bukmhiYrWmDN3A
         rXfXBqG87Z0m/OrFuvCgjlAx/BkS4o3ekPsKtKrcWtw86G2bXbSwLYwFGGSWzkePy5
         DCNYHNNJx2dFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A5D67E21EE4;
        Sat,  1 Apr 2023 21:16:02 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZCiZArzK41q5/IDR@google.com>
References: <ZCiZArzK41q5/IDR@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZCiZArzK41q5/IDR@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.3-rc4
X-PR-Tracked-Commit-Id: cbedf1a33970c9b825ae75b81fbd3e88e224a418
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00c7b5f4ddc5b346df62b757ec73f9357bb452af
Message-Id: <168038376267.3548.12604126473845674232.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Apr 2023 21:16:02 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Apr 2023 13:50:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00c7b5f4ddc5b346df62b757ec73f9357bb452af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
