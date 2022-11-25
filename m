Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AB8638FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiKYSXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiKYSWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:22:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DEE19C24
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 10:22:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DC46FCE2F45
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 18:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15AB1C433C1;
        Fri, 25 Nov 2022 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669400562;
        bh=6w4M3pvKm4f+OLKwdsL0n93aqF6ac5znqPkGKCtQK60=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F3EVEZjaSC4t2ZgM1cGbW4jUuyIksc5XQmseBZERcn6Q6x4sZYZML11qBva37iyKz
         +n3+mgF1jLV99lnwxsA3rq8JP0y/LEVzbgQcx/lSSdfJlnnzA2JBiiojsH0p4lN9i7
         5GAOV6X641GZKObwBACafMPcF84RbwbuYyJyMi/Eq8MOv87MdwQYEjr21JrOoFDh+j
         4lHaoSbDpNZxdQlSPvW0NIJHUDRcz3iB4W0bBPL6yAcjbuh6opd/oPW0yJ6Rd2miki
         +27XlKMZ93DfF87TIPnJXUQUQd4Kwbp56anzfgEoQDzNOAA5qYhivrs1STvwcUE79w
         UAesn+sWSxd8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 032A3C395EC;
        Fri, 25 Nov 2022 18:22:42 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw-YJEmJFE0FaOa0SvjsPj=TW4rqD1RJBgsw_JzWu1vZw@mail.gmail.com>
References: <CAPM=9tw-YJEmJFE0FaOa0SvjsPj=TW4rqD1RJBgsw_JzWu1vZw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw-YJEmJFE0FaOa0SvjsPj=TW4rqD1RJBgsw_JzWu1vZw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-11-25
X-PR-Tracked-Commit-Id: e57702069b26b8601a33fdc0c9bbe40c6bb9c72f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fe0e074e76985c7be3eaa7a8fd51401a8999cae
Message-Id: <166940056200.17840.14471258872833551269.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Nov 2022 18:22:42 +0000
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

The pull request you sent on Fri, 25 Nov 2022 13:47:02 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-11-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fe0e074e76985c7be3eaa7a8fd51401a8999cae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
