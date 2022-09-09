Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8755B3F46
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiIITN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIITNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:13:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD91868AA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D328620B5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 19:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3B56C433D6;
        Fri,  9 Sep 2022 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662750830;
        bh=FqLsEtmp4qNB7hsKabFO8hHLfj8X7kjPagvBhPx/4zM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GUTFSGJL5xXVvWS6klGhMMkvpv25NYNMAJDp9WfJ10E7zK9IghLnkJWKfRgDLk4Ff
         g+WDh2oQMmABVfwNEXOLSrMu6+1gmAjpoMx18JJ0qXvW1fddLrSKw1ss5OnsqCICIx
         sA7X6FceSU5zAxEmtVWqeuxyJiIcDEHlREGi01YyhwhoVHPPpMCag+H1j41+GGR1bi
         j2XjlSmSRtNDHnHIHbbEkd43ZDNlllB7DPOo1VsxCwEW37qA3fTr9Mw7DHqYiGd3O6
         SQ/TQdnhNn4HTXDmZoQ0Ni4zPXizWzrQxtHb8zz87EPsQ+bZ6p7cjADiAld4UpPKP5
         uzpLykuECTZ8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1C96E1CABD;
        Fri,  9 Sep 2022 19:13:50 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.0-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tydpsi2=fujRgT4B2CcOgY1EQ7WmVUNtcZ+1jUjoDbK9Q@mail.gmail.com>
References: <CAPM=9tydpsi2=fujRgT4B2CcOgY1EQ7WmVUNtcZ+1jUjoDbK9Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tydpsi2=fujRgT4B2CcOgY1EQ7WmVUNtcZ+1jUjoDbK9Q@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-09-10
X-PR-Tracked-Commit-Id: 2edb79a5fb303dff577d6a0c7d571c3bab1d1455
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7e00d6f55015f6995f41c60a5367f1065d37622
Message-Id: <166275083078.6812.9128951338015630364.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Sep 2022 19:13:50 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Sep 2022 01:57:22 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-09-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7e00d6f55015f6995f41c60a5367f1065d37622

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
