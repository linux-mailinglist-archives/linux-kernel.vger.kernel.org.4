Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B27A5BAF28
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiIPOWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiIPOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:21:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30AFADCF1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5383662BD4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 14:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB32DC433C1;
        Fri, 16 Sep 2022 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663338098;
        bh=OkZsYIFm8r+CVjhNh4iD+n+C1mV11Nw2PVDKGEgN1A0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FDdn32YCwybr7G099m7GqVYhv2TvMIekYNh37w+D66N0U8quO49IZ/KAONSJ6e2WD
         yjhBD4LgxfC+IV1XqPKacz8l63mMh7bIKnJGQQbDoEyEUMcODVqVx0vGi+h40ql719
         qlPcPlqpT2lQBCTU1mHgMwfoNpARLm8ejVUQQTn+oecGj74dg5+x3Lidv3hhcUev42
         nF0VZjGvotCq45949/z/FObjLZ1G3DmRtlDq+kwYOlPymKIBFPl+TCMdxX/3OPLNYO
         K8GZa6MDrE5Knuq+tIyw7O9uuZG0YTushy7dUcZJ9AtcdDHOUkUTFm6uTvjhGNidqw
         bqzjOsZxOBefQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6D96C59A58;
        Fri, 16 Sep 2022 14:21:38 +0000 (UTC)
Subject: Re: [git pull] drm fixes for v6.0-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzoEUdzdhUsjh8jsuSta3Nv7zkH1-H7g4Oyi4_07zkO2w@mail.gmail.com>
References: <CAPM=9tzoEUdzdhUsjh8jsuSta3Nv7zkH1-H7g4Oyi4_07zkO2w@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzoEUdzdhUsjh8jsuSta3Nv7zkH1-H7g4Oyi4_07zkO2w@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-09-16
X-PR-Tracked-Commit-Id: 25100377a21ad40dae8be5a3ed361b87acec1479
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5763d7f29652f94bdfc9dab87888f79ba6bb6c34
Message-Id: <166333809867.10979.14401799560428594488.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Sep 2022 14:21:38 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Sep 2022 18:28:58 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-09-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5763d7f29652f94bdfc9dab87888f79ba6bb6c34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
