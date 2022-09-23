Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD805E7FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbiIWQ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiIWQ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:26:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD84121135
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6391BB82409
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:25:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25AD3C433D7;
        Fri, 23 Sep 2022 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663950358;
        bh=PYQ0r3updAVAisQqG8/x5P4WqIu5SH6tZv+x7Rv3mhA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=or8d4OqXvAijgVVcAKWrRORZ/wxb/qU5JMeKVUWgOJuql3Qxg8VVYEG5lXCtK4Jix
         vYyn13jp4j4L8h+oEiHVfv3EfHiuqLun8DO+yWLf6GTDpFqPTd+q3vjs1NMb6EL8fr
         n9T9K3I4eocant0qSZqIvZbi5AU5yoDwq+K0Fe2fV7DyqkcbIM0ffv3YEKKL1HUrt6
         bTvp+2C0kA5Xvf2jGoerm7/sm7cngX3o9kW0lrK3qV85L7JKRN+YVA6hq17xcD+Pr1
         KbiAAvWU7k0KkgdnV5SUz5IirRvuYluT9ouTqtbTOkMarNNaKavlDLQMEyuhCOPAYk
         zXzG5k+LyZPLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13643E4D03B;
        Fri, 23 Sep 2022 16:25:58 +0000 (UTC)
Subject: Re: [git pull] drm fixes for v6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twg497wBCc4cMSevtSL9B1BEE_M6MO-t-B3uiZMb9NUvg@mail.gmail.com>
References: <CAPM=9twg497wBCc4cMSevtSL9B1BEE_M6MO-t-B3uiZMb9NUvg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twg497wBCc4cMSevtSL9B1BEE_M6MO-t-B3uiZMb9NUvg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-09-23-1
X-PR-Tracked-Commit-Id: 8288206c27856f6f56d35aacf3a48ee923e1d3e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22565ae784134282e03912023456151a61db479c
Message-Id: <166395035807.8411.10782887649451640740.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Sep 2022 16:25:58 +0000
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

The pull request you sent on Fri, 23 Sep 2022 16:08:19 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-09-23-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22565ae784134282e03912023456151a61db479c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
