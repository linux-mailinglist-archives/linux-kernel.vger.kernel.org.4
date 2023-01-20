Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DF6675E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjATUGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjATUGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:06:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB4EA5CD3;
        Fri, 20 Jan 2023 12:06:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59554B829FB;
        Fri, 20 Jan 2023 20:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0881FC433D2;
        Fri, 20 Jan 2023 20:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674245199;
        bh=xvFeQKlx28JrZmqEd3a9qdBhtaAnG/d6yZFcO6TRsQI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ycvq0GDop7TfOZZgSSLMb2VGWVWT24JYkCdM75iamvhFBJpzcltcAXoG7j2sJu6ux
         GS/RhmzxRG74qKkZYI9+VkCuToAZkHh5e6X3Ot6UX6Lv6tLcgjuWYZ65OVFEvj0g4q
         rnebUiqpZRfw+q8Ec9c2JVyHikSC0dyrW4Pyv9nKTYdW3+pCN2L5ghU/oYwBP385/y
         kOM/m4cZCe1HBOBL/pS2SrPBOKuSeAiGo+JjOpLUzS53Ari6h16+Ey80uhg3SxbkNa
         s0Y/2Eq4Iuhd84PazBUVRMHLX6A4ucp4lmyOatJK/JlK5T42If+dxYNHPkrLjrUSbk
         mpbrcq+g7Gfjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E7952C04E31;
        Fri, 20 Jan 2023 20:06:38 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hh=K6rAhhRn+tg-mJaY-Fm_ysJLZDhVnYc+D1B1FnzuA@mail.gmail.com>
References: <CAJZ5v0hh=K6rAhhRn+tg-mJaY-Fm_ysJLZDhVnYc+D1B1FnzuA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hh=K6rAhhRn+tg-mJaY-Fm_ysJLZDhVnYc+D1B1FnzuA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.2-rc5
X-PR-Tracked-Commit-Id: 6c54b7bc8a31ce0f7cc7f8deef05067df414f1d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc18175938e65e979b866f23dc5b93e81d649cc4
Message-Id: <167424519894.30775.7489270621163248518.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Jan 2023 20:06:38 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Jan 2023 19:05:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc18175938e65e979b866f23dc5b93e81d649cc4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
