Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886E05F5A04
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiJESm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbiJESlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:41:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6496A80F7A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96C0DB81ED1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 18:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 656BCC433C1;
        Wed,  5 Oct 2022 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664995220;
        bh=HgpKWF8vasqcuJiwBTGamknDt+lexB7aNSeSMWW4YSE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jm0g1McyuUhu0WpcP0LMLMQ49vYVN8ePm/yrwKHIgYLc2mcMMX7ugAsSqdRTeMM0W
         eRZQHIZdCJBwHkl6KJU7EvxomaBosVJgAkV135i/aT7R4rzKbY3naIv5yoP+29JYR4
         r3E5bYXKuLs2c6wagjjAscvKc4U5F4RnDtog/qchxildrfwSweslfaNLZDDduMulO1
         e8DDhIvzT6wkG1+IQ7wT/LeHsAqUsk5ugerWjtT2ofn+HxNse6vBXMXzYTvp/kq/R6
         AEOA4y+OVsn9eacy8dfhzQCqyfgBwj7q5+SvYMXKfEdeB5mv14OROr5qRhhKG5kNES
         b/vHeLQk/spmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53F03E21EC2;
        Wed,  5 Oct 2022 18:40:20 +0000 (UTC)
Subject: Re: [git pull] drm for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-10-05
X-PR-Tracked-Commit-Id: 65898687cf7392c372ea8d04a88617e2cb794465
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e6739b9336e61fe23ca4e2c8d1fda8f19f979bf
Message-Id: <166499522033.1673.14368473301311468393.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Oct 2022 18:40:20 +0000
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

The pull request you sent on Wed, 5 Oct 2022 13:41:47 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-10-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e6739b9336e61fe23ca4e2c8d1fda8f19f979bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
