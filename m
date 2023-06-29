Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5386742BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjF2SbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjF2SaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA753AAE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA4B361600
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 18:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B8CBC433C9;
        Thu, 29 Jun 2023 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688063414;
        bh=7AMAzZkTDD0v68H78v4XpBGrzsiMSbyWZ99TYUrueYo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Oqm5mxPHai9cch1B6QhGuDO0b77K2s9WG4gLwYTo2E07/W0Me1+s2VTHJh0RvkMDB
         zj+QS4lbQlSVUqgVki7q+aYrhw5W6TrenqWpX8vjKKWBJ/gWy756mYSypJSlSCS0Rv
         uFBbsHiAm32zGhb7dlQlD2UOWv/Gk01G1k6b425V+Tij2P7/+4mw3hCeSuQtvBdftL
         E799Akp2FiDgBO3RtaSCwk3mGSbzgtg4LEwHquz0+IBG9wrLqms3QAZbj0bAUieniS
         DPPFzdalFUesE0cbVZ6+pTQOQbMskVxJIURrYJ6zkNAUZnqpS0fIMOEdBpKT4s+cxK
         86zI14rC0F4Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69574C43158;
        Thu, 29 Jun 2023 18:30:14 +0000 (UTC)
Subject: Re: [git pull] drm for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twGy8jVci0iPwdFUpePVPf6bxmyGbTT8HxwKqdsqFCjQA@mail.gmail.com>
References: <CAPM=9twGy8jVci0iPwdFUpePVPf6bxmyGbTT8HxwKqdsqFCjQA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twGy8jVci0iPwdFUpePVPf6bxmyGbTT8HxwKqdsqFCjQA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-06-29
X-PR-Tracked-Commit-Id: 5ff2977b19769fd24b0cfbe7cbe4d5114b6106af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b722407a13b7f8658d2e26917791f32805980a2
Message-Id: <168806341442.20934.10739563985655216922.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 18:30:14 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Jun 2023 11:28:02 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-06-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b722407a13b7f8658d2e26917791f32805980a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
