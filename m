Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE0F70AFAF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 20:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjEUS6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 14:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjEUS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 14:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF71ABA;
        Sun, 21 May 2023 11:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6353460C94;
        Sun, 21 May 2023 18:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEE28C433EF;
        Sun, 21 May 2023 18:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684695521;
        bh=K7ZK4zHn4uirKvLOevRh5+9Q/FRdGxhkhisJHm8IzWE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MbQ0QozEK4JQiNITiDxrKayETe7O5t9WbsdPaJb+iVB+eHQKDCG4X/W0Yu/S2r/uJ
         4tB/6p6FQbZ9gWlOpQb9A/m3igfO4sqAKDaoG0yFsGYO9dUjUsZPXrK8Boiofc1J3V
         EfsedEOPb8IBko4nxRRWdrIgYO/ZXne537AcVeWSXSfjwSCbvxDY+reZ0Zeckjoyyv
         HiEtNi8XJFIk5DPDyQ1a3VB5AlPwlaO7OS1ZkE9LN5dJzCn4+zvmxDknjXq92xopfZ
         G8w6uwRRlFpxT5YLnk5jfldMN6KlOXwY02tuIOD4jt+yGs8kvodZAdBKJ2Ili/w069
         qrFdfD/dGYjGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A794EC73FE2;
        Sun, 21 May 2023 18:58:41 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes for v6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZGntkmg6v2G8Fnfn@ls3530>
References: <ZGntkmg6v2G8Fnfn@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZGntkmg6v2G8Fnfn@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.4-rc3
X-PR-Tracked-Commit-Id: d9a45969abeb641c5fb8cf3591f63f827f9932b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70e137e3840e1bc2deab32492316653c956a5c6b
Message-Id: <168469552168.22409.11989432771083785902.pr-tracker-bot@kernel.org>
Date:   Sun, 21 May 2023 18:58:41 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 May 2023 12:08:18 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70e137e3840e1bc2deab32492316653c956a5c6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
