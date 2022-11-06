Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A573561E5FD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 21:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKFUso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 15:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiKFUsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 15:48:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5ECDF9F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 12:48:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C2FA60C79
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 20:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B038CC433B5;
        Sun,  6 Nov 2022 20:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667767718;
        bh=KwOYTqS14Nz456mCnh5vtcqSPBpwTmU5+fxmfiFp9WM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cWjosAWw+Y2+A3oE293i1xqOWTZOpSCoFnYjfG4+OUmXHkl3MdTIBr7d+yLMGxdVJ
         ilDvAmKAYND7UdYs9JXBqQDI3MeUxXxpzI8XKsCKA9xHlmrttdoEgxOx0HnEuvkUgv
         vioqSxZgGymb0GB4dMpP2r8hAsjJ87gYrwpK99Y4pfxxUdRtdRa2NvY90e0VC6MZzt
         DAp4wktM/JbPaF4O0RcEm46GguVZ9uWjnrSWflgJ20nAafmpjZ7nIpIaC2mTYHOMec
         /JeZ03IvqMiUtA8SVDwdnYtM7ZG/Yb317UGxI2Uz6i8+mN1WbfQu0XMr2OnTeKumFh
         K5o/ZOsW/cR4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95C2DC41621;
        Sun,  6 Nov 2022 20:48:38 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for 6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y2ewgoBWbyIt9oPW@zn.tnic>
References: <Y2ewgoBWbyIt9oPW@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y2ewgoBWbyIt9oPW@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc4
X-PR-Tracked-Commit-Id: 6f8faf471446844bb9c318e0340221049d5c19f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 727ea09e99b8e765388d4ca994e8a68a991f4d98
Message-Id: <166776771861.27719.1545651251314145500.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Nov 2022 20:48:38 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Nov 2022 14:02:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/727ea09e99b8e765388d4ca994e8a68a991f4d98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
