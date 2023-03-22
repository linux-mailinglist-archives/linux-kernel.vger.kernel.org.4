Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE926C58D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 22:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCVVfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 17:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVVfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 17:35:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE0A12F35
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 14:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD4B3622E6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24570C433EF;
        Wed, 22 Mar 2023 21:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679520920;
        bh=/Xxbx/tJR5olAroX7Tys7AJanO/zij4HM//74jfCaac=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fMZjLmsKnFOEaKJKyBvwiuH/jFedEbD3ftFAHD0Z0UlV84558MyFulpRUwJNM5EKE
         FZ25lrcdDLx8LBl0iQbe1Oq8pCYVof8KuCEhwIRyIiGae+C3f7NQhPd2yrj3reif5j
         v9Qr9DxifLyuN60FRwteRWlAc5CNtc71ZqMgTyt5PmqHQgkL0fLfi1SbXDfWFOI4h1
         OuKMhAT9ZTED2jrZ4x3fLTSCnj6LHGwMGIr0onKY83FEr2srK1Emf6MTjaIPzkqnNR
         z6B2TMbg1Dza8gXAYwQ+PBqRL9f4koiNDK/f723KsUY1tWpHbeRo6+RAXD9aWa1jmW
         S9YJwvbMhPhVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 107ECE4F0D7;
        Wed, 22 Mar 2023 21:35:20 +0000 (UTC)
Subject: Re: [GIT PULL] bootconfig: Fixes for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230322232131.ffb3f973dea6dd9a195e9a08@kernel.org>
References: <20230322232131.ffb3f973dea6dd9a195e9a08@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230322232131.ffb3f973dea6dd9a195e9a08@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-fixes-v6.3-rc3
X-PR-Tracked-Commit-Id: caa0708a81d6a2217c942959ef40d515ec1d3108
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c13e02d335c825ffc7f4af3733329d38e695b482
Message-Id: <167952092004.8796.1498169940198022477.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Mar 2023 21:35:20 +0000
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 22 Mar 2023 23:21:31 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-fixes-v6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c13e02d335c825ffc7f4af3733329d38e695b482

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
