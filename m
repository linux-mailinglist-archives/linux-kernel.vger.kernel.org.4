Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9EC5F0EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiI3PaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiI3PaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:30:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B27CE9A8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D722623A2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F326C4347C;
        Fri, 30 Sep 2022 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664551809;
        bh=3U+zD0NogFFEBtBK6OA+s07y+MxGQredjvYdIsStyUk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G6+IXjSnbBEdEgXcqxL3VwFDZ/k+P3DlHZ/nFnqhpZlt1yj6Sm/MIT0SNr9tl+mBt
         72gBH+5C+WiDx6t3ZA3qXxzdywboHePmlPZc+z9eM/bFhBR/SyhSm3Ru3xcAYFXUnE
         /7EgPZIO9RNloKKjG8sN+nGLU+ft2ULZvfesOjTl3bq3fD4/kla3QIIarDCXTnwgHS
         IcRRYHBez4kXGxS68+qC8Sb8mdMCn5zPAnxGeC3pYejTJ7IL32qcKsNQ51uf3MRB6s
         vBi6Ejve378MNbE1x0BM4wmQDArPc6WNhvnnGoJj7OZuLzFdAX8GinjRRxN3SAGgRw
         9/zfei/eK/D4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4706BC395DA;
        Fri, 30 Sep 2022 15:30:09 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.0 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txBybqG30QMLH-fyovjw_m7eiFyE6rBr9Q-=rMb_sak3A@mail.gmail.com>
References: <CAPM=9txBybqG30QMLH-fyovjw_m7eiFyE6rBr9Q-=rMb_sak3A@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txBybqG30QMLH-fyovjw_m7eiFyE6rBr9Q-=rMb_sak3A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-09-30-1
X-PR-Tracked-Commit-Id: 6643b3836f3908c4f77883b2fae72451e85cf3ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a77386984b513ebfb2700e70dac44509fc81aa9
Message-Id: <166455180926.5414.1822419434608003632.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Sep 2022 15:30:09 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Sep 2022 10:12:45 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-09-30-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a77386984b513ebfb2700e70dac44509fc81aa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
