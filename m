Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C8F6B4E78
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjCJR02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjCJR0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:26:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64D3F2891
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:26:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 965CF61BE3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 030E9C433D2;
        Fri, 10 Mar 2023 17:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678469177;
        bh=D8hlYlQut+dgaoSQAWmBVroQdnawtQm8CJEZA1ED3Lw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UBnb0Cj6aFInMsaqi9gpVnrWKSdRG2eJAMi/ATOHeU0vysHor7y8HtoEDtF/ig+oo
         WYRXGdMM0wslCkatwtfowFe1UH9bCU8J4L1XJPNgxmvwQU1DfZnOkVtucV4SXYuihP
         2qH9FD63ABA7m27ryxAjdjQ9LOZRHw0+d1N7VUjTNGx4VFhsud5Wcu1uRfv1gumEOq
         VpPBaXkFt+0t0kaZMnC9BYsmuo8xz3AdKFF56e3XVwByQhHk7qdkHTE00GSLAtE0/q
         PJuHdB3KZlc8s15FaqknZWWtjrNkBL4KpQ9AUHUsj3mt/f4pHyJngdFQOjBCdA4gua
         8EmXnCIo4kjDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E48F8E61B66;
        Fri, 10 Mar 2023 17:26:16 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.3-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw4eFsBCha-h2FvM_ofXMcEJAEsoT_HqxZc9gWe20J+yA@mail.gmail.com>
References: <CAPM=9tw4eFsBCha-h2FvM_ofXMcEJAEsoT_HqxZc9gWe20J+yA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw4eFsBCha-h2FvM_ofXMcEJAEsoT_HqxZc9gWe20J+yA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-03-10
X-PR-Tracked-Commit-Id: 519b23310aa100073f0b58c39df120a486ed7f8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0d14d2aaf7d4b36b44f5a09955ebdf9eef4b0f8
Message-Id: <167846917693.3321.7060148506270613347.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Mar 2023 17:26:16 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Mar 2023 14:44:33 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-03-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0d14d2aaf7d4b36b44f5a09955ebdf9eef4b0f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
