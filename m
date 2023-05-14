Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26A701E32
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 17:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbjENPzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 11:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbjENPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 11:55:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6335BB
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 08:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7659A61825
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 15:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD23EC433A0;
        Sun, 14 May 2023 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684079730;
        bh=p/2ORZCXUZiJGIvJxj0A1o0gkncw1E7SyEm3NHoSnM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aRoy8O3jt2nK/SMELe9I68TJoAYaAj1hERGEn7W4u7Q0cUok9lLn02lV43cf144Ha
         /lirQ+jOwa7plyT1qFEjm/1Mr+zuCYAmuECCqf54gxkg5c/tFPXkcykoveAAny8YSk
         o3CmZqaVyAMOm60XqGiJdwj1PBHS6dXzBkPp0/oRWNYmJdFZ1D007lz+AeaPxujCac
         35N6vug1Bzzcu56b8sPFaHoQKn4Z5UmUP+DKGoW6HDkGR2p7zrvXrHwDTO8n9hpApD
         jT6DTEw/xsqcnTmG4JZJkBlfYVQu+VTZYdDxwPb2h+ap6s0rPohOOf352dyfvJKjls
         82G54VyB8klBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B53A7E501FC;
        Sun, 14 May 2023 15:55:30 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230514121850.GEZGDRqgvc53SmWNDS@fat_crate.local>
References: <20230514121850.GEZGDRqgvc53SmWNDS@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230514121850.GEZGDRqgvc53SmWNDS@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.4_rc2
X-PR-Tracked-Commit-Id: b752ea0c28e3f7f0aaaad6abf84f735eebc37a60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef21831c2e4e66cb948d5107f47c1aa0a5711a56
Message-Id: <168407973073.9046.6977989304502521353.pr-tracker-bot@kernel.org>
Date:   Sun, 14 May 2023 15:55:30 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 May 2023 14:18:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.4_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef21831c2e4e66cb948d5107f47c1aa0a5711a56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
