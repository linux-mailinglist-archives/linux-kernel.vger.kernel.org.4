Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC68609513
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiJWRSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJWRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:18:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809165BC90
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3B0860F23
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 17:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DDA3C43141;
        Sun, 23 Oct 2022 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666545525;
        bh=YM45Ln0MLxbkIZ1mH5fmejgxLv/WuDQTgcrT7dOy8/4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dLy3u7nFt5Yo0e2gx59wlCvWWWSPLYTQ+OQKfUhDpfE1wlzA+IR91KuvjIseKLntG
         t28OXS0gh5s+N7Yjcd0pXinSbKwvR8koGj9WEt9/btcQtvK1sDiSV/awJdrtah/1FO
         tUxOQlpxZbkQjQsWZc57/zeO5yyOEuH0AGPCo6r0R2uZUYUc1fLX/dsRWUo+3P3ILw
         UnmGRyjgZ8ThdraBYm+0b1koPLutUPEo66vjG2j/keipV0tCAYlbqMYPog2eNZfr02
         rk64Nuy71s6c97INO7pr8LbZfyIYQTJsQRENJxBw9HgUxfZGejGl8zWFurErLbvJMJ
         iTaS9Y8q2GybQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D842E270E4;
        Sun, 23 Oct 2022 17:18:45 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y1UUSef0KUKy2RUE@zn.tnic>
References: <Y1UUSef0KUKy2RUE@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y1UUSef0KUKy2RUE@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc2
X-PR-Tracked-Commit-Id: 21da7472a040420f2dc624ffec70291a72c5d6a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a70385240892bcbc6442b054e847c74100e72f1a
Message-Id: <166654552518.1521.16350599772989575900.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Oct 2022 17:18:45 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Oct 2022 12:15:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.1_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a70385240892bcbc6442b054e847c74100e72f1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
