Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556F073C4F3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjFWXxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjFWXxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042812705
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91E4E61300
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 000C7C433C0;
        Fri, 23 Jun 2023 23:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687564400;
        bh=SmwX2lvlvOqVnsPOlGLSrN6eUGPiFK4K57Y8Ozrdyc0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L3Q4ynSaRiy/fKVOKx4D22zpI50bdUKvDKFRoFmuOk1qunAyhBOGHPeeGZM1f305n
         ioGFKIxALXLrkr7FtJvzVLX+WWuKGttravABCtg8QmZDxE5HLlu3wJOhJbNmV0DINk
         cCY1Eu+xnl71Kg9U9iVhpt+QpuQhvpwn4sbGJnebbXQ0ArZ9bjytCjYywiFeheG1p2
         vkso01BPF3hnqqPsfaRHP1Jzyj0RZ7tpQmp0kB/ShXGaZvFfKdWdka7kwVyLQGIl53
         ejBDL13JWWhWTMMDNNSKZnjveokt5fxM94iCafXMq5ufYn5jOyX7FPyQNUwlcp7itl
         wBB0NyfPAFkbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E130DC43143;
        Fri, 23 Jun 2023 23:53:19 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.4 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twXadK-V1qttzJV3ks8hZu7jY3Nswzw6EgGADnJZF2+fA@mail.gmail.com>
References: <CAPM=9twXadK-V1qttzJV3ks8hZu7jY3Nswzw6EgGADnJZF2+fA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twXadK-V1qttzJV3ks8hZu7jY3Nswzw6EgGADnJZF2+fA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-06-23
X-PR-Tracked-Commit-Id: 9bd9be5cbaf8a8faa175ef4fba04a5623281debe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a92b7d26c743b9dc06d520f863d624e94978a1d9
Message-Id: <168756439991.22934.17275483142069134469.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jun 2023 23:53:19 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Jun 2023 16:48:56 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-06-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a92b7d26c743b9dc06d520f863d624e94978a1d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
