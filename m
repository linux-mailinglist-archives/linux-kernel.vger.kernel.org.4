Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032C66DBC84
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 21:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjDHTBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 15:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDHTBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 15:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94269741;
        Sat,  8 Apr 2023 12:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AF6760C3A;
        Sat,  8 Apr 2023 19:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFF96C433EF;
        Sat,  8 Apr 2023 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680980473;
        bh=4fvu9X+TmCdVdcG57qyFwn2CmC9CtZPwXBOXhTepfZs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VD/IDLwqLbplXDNn+6MmU+izeOJuFcznICgBtKhWfX5gJ4zTdlQ2ok0Mmri5LHvUX
         edpqVt1a5KihBsYzsZDf+kBPPh+i3MGMmIruxgp4KlDTEF0O5VGzpIMRemfgaA8LBn
         F//uU1fs09umiazvCEBHglThihxv/BsVhAG1Z9EGu9a/0iCGNUdXMBTytOP6CPoLRQ
         r8OsF0KYoH5HU3kgcr02Q+nD1+lPWJIJ/z9IjmvWosrMyhiIWe5xl5zhfl1zau/zOX
         lvhXeiHsOQNWAD3K9MPA/mBe/dTRfFzkklcIy/qWlLxHs5xEO1k6yZ5lpMtgk6omqi
         5NbaaIZ5i7IEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC3AEE4D02F;
        Sat,  8 Apr 2023 19:01:12 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230407162606.d7dd8c829b53a01f7c9f16d6@linux-foundation.org>
References: <20230407162606.d7dd8c829b53a01f7c9f16d6@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230407162606.d7dd8c829b53a01f7c9f16d6@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-04-07-16-23
X-PR-Tracked-Commit-Id: c45ea315a602d45569b08b93e9ab30f6a63a38aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fda0bb806fa77c9cfe12cdcbbd8cbbe946b9c37
Message-Id: <168098047289.1995.10173706868441024676.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Apr 2023 19:01:12 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mm-commits@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Apr 2023 16:26:06 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-04-07-16-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fda0bb806fa77c9cfe12cdcbbd8cbbe946b9c37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
