Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159F6647B46
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLIBVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLIBVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:21:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056FEA84BF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:21:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD70EB82666
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7094CC433EF;
        Fri,  9 Dec 2022 01:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670548897;
        bh=hvvz030LUj8lnPdEvrt0f17NiCOxoToxxAv2Fj/QkNs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DSAybl0z7NAMf1IXKy8nTSKcxXGMYu5/G0OTiaFA0EiVFyIO41e1kq2ncwN1zjlKq
         meXCbOquarGHwJSSz3MEasofu3eIFfXTzPaZlOI7nZ0koRTimsJMxaxsJsf3RWtJUv
         Nufsq394K/5TFkVnllW3n5ew14B3K0XzwedEXAH85WN2LfvuxehH+oAFLL3tgdnRbC
         7qwNTXYeDrPeGSIZ4ArLq66TZ11umPRlNn0Ey5Nls4y5M5ri551P7Gf4g/kSbLEvzz
         o8SsMVpr5gp1XjBt4g6hiGyrMsffq/Hqu6RT4wxnyky8ToraBq1UOaB8fo4FrIwTeH
         12cRztA1UgqiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D5D9C433D7;
        Fri,  9 Dec 2022 01:21:37 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.1 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tztpF=EZ04jLii6DFiLQdm6s0QhXvosFyggDHikfLLteg@mail.gmail.com>
References: <CAPM=9tztpF=EZ04jLii6DFiLQdm6s0QhXvosFyggDHikfLLteg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tztpF=EZ04jLii6DFiLQdm6s0QhXvosFyggDHikfLLteg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-12-09
X-PR-Tracked-Commit-Id: c4252650a8c4770b669398fe7270ed8c94fc0eba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d1409e4ff08aa4a9a254d3f723410db32aa7552
Message-Id: <167054889737.30977.17442092268066095579.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Dec 2022 01:21:37 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Dec 2022 10:51:00 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-12-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d1409e4ff08aa4a9a254d3f723410db32aa7552

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
