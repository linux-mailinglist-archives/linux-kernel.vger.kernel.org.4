Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4921E5EB3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiIZV6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIZV6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:58:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03796DDDAF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 14:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B502AB8129E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73AAAC433C1;
        Mon, 26 Sep 2022 21:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664229482;
        bh=R66UuzONZLNxYOzVmH876Rwu5D+PGQldYkTL0v4hV4s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AFowkp2uaPahpUF+QS4ZqXkR4ncTsj/LNJ+lXiuQXDeDlD5MgQf+9PsTS7XCnjPKM
         O34p0uymJgu52U6uuu+PTZ/VrT42hctBAckrLSBSBmdIzHPxicSuUiQfwfGSQHCsBI
         X/mh26WK3mt+bNOI/hF27+ZZLF35kzgdfqlMyFy6qVRO8kJRBd9thZK+KcDsnVoCTI
         O40Uc9BgZiiXye88i1JuU+VB50u0hDJ7FEULHlyx7PrroxB6bd/zXwHfN8IYN0Ooks
         3Bo28J1Vx14NBFiICOQPG47uS43jWd5cHfgjC5pE9HPFeqjCy/xtFOpv7zY9Y1IQk9
         KydlbOAY0F14g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E0E4C070C8;
        Mon, 26 Sep 2022 21:58:02 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for 6.0{,-rc8}
From:   pr-tracker-bot@kernel.org
In-Reply-To: <67154681-0e0a-69d7-d4ee-21067c9b561c@intel.com>
References: <67154681-0e0a-69d7-d4ee-21067c9b561c@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <67154681-0e0a-69d7-d4ee-21067c9b561c@intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.0-rc8
X-PR-Tracked-Commit-Id: e400ad8b7e6a1b9102123c6240289a811501f7d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1375562c0a87f0fa2eaf3e8ce15824696d4170a
Message-Id: <166422948237.31787.3528571378237338533.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Sep 2022 21:58:02 +0000
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Sep 2022 12:54:09 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.0-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1375562c0a87f0fa2eaf3e8ce15824696d4170a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
